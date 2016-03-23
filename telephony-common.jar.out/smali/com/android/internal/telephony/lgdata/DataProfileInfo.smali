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

    .line 33
    const/4 v0, 0x0

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PDP_TYPE_IPV4:I

    .line 34
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PDP_TYPE_IPV6:I

    .line 35
    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PDP_TYPE_IPV4V6:I

    .line 37
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    .line 38
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    .line 39
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DEFAULT:I

    .line 40
    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_FOTA:I

    .line 41
    const/4 v0, 0x4

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DUN:I

    .line 42
    const/4 v0, 0x6

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    .line 55
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    .line 56
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    .line 57
    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    .line 59
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_DEFAULT:I

    .line 60
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_IMS:I

    .line 67
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_DEFAULT:I

    .line 68
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_IMS:I

    .line 69
    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_EMERGENCY:I

    .line 71
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_DEFAULT:I

    .line 72
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_IMS:I

    .line 73
    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_USCAPP:I

    .line 75
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_DEFAULT:I

    .line 76
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_IMS:I

    .line 79
    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_DEFAULT:I

    .line 80
    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_IMS:I

    return-void
.end method

.method public constructor <init>()V
    .locals 12

    .prologue
    const/4 v1, 0x1

    const/4 v4, 0x0

    .line 101
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

    .line 91
    const-string v0, "lte-roaming.sktelecom.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    .line 92
    const-string v0, "ims"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    .line 93
    const-string v0, "ims.ktfwing.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    .line 94
    const-string v0, "imsv6.lguplus.co.kr"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    .line 102
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    .line 104
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
    .line 110
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

    .line 91
    const-string v1, "lte-roaming.sktelecom.com"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    .line 92
    const-string v1, "ims"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    .line 93
    const-string v1, "ims.ktfwing.com"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    .line 94
    const-string v1, "imsv6.lguplus.co.kr"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    .line 111
    move/from16 v0, p12

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    .line 113
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v1

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    .line 114
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needEhrpdProfileUpdate()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    iput v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    .line 116
    move/from16 v0, p7

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    .line 117
    move/from16 v0, p8

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    .line 119
    move/from16 v0, p9

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->emergencyPDN:Z

    .line 120
    move/from16 v0, p10

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    .line 121
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->getEhrpdProfileID()I

    move-result v1

    iput v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    .line 123
    return-void

    .line 114
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

    .line 128
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

    .line 91
    const-string v0, "lte-roaming.sktelecom.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    .line 92
    const-string v0, "ims"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    .line 93
    const-string v0, "ims.ktfwing.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    .line 94
    const-string v0, "imsv6.lguplus.co.kr"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    .line 131
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    .line 132
    iput-boolean p2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    .line 135
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needEhrpdProfileUpdate()Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v12

    :goto_2
    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    .line 137
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needPcscfAddrRequest()Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    .line 140
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 141
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    if-nez v0, :cond_1

    .line 142
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

    .line 143
    :cond_0
    iput-boolean v7, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    .line 148
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needTriggerEsmInfoRequest()Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    .line 149
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

    .line 152
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->getInactivityTimer(Lcom/android/internal/telephony/dataconnection/ApnSetting;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    .line 154
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_INACTIVETIEMR_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 155
    iget v0, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->inactivityTimer:I

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    .line 158
    :cond_4
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->getEhrpdProfileID()I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    .line 161
    return-void

    .line 128
    :cond_5
    iget-object v3, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->protocol:Ljava/lang/String;

    goto/16 :goto_0

    :cond_6
    iget v4, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->authType:I

    goto/16 :goto_1

    :cond_7
    move v0, v7

    .line 135
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

    .line 323
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

    .line 325
    :cond_0
    if-ne p0, v4, :cond_2

    .line 498
    :cond_1
    :goto_0
    return v0

    .line 328
    :cond_2
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto :goto_0

    .line 330
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

    .line 332
    if-ne p0, v4, :cond_9

    .line 333
    const-string v4, "default"

    invoke-static {p1, v4}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 336
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 337
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    goto :goto_0

    .line 339
    :cond_4
    const-string v0, "admin"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    move v0, v1

    .line 340
    goto :goto_0

    .line 342
    :cond_5
    const-string v0, "vzwapp"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    move v0, v2

    .line 343
    goto :goto_0

    .line 345
    :cond_6
    const-string v0, "vzw800"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 346
    const/4 v0, 0x5

    goto :goto_0

    .line 348
    :cond_7
    const-string v0, "emergency"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 349
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    goto :goto_0

    :cond_8
    move v0, v3

    .line 352
    goto :goto_0

    .line 355
    :cond_9
    const/16 v5, 0x9

    if-ne p0, v5, :cond_e

    .line 356
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 357
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto :goto_0

    .line 359
    :cond_a
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 360
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    goto/16 :goto_0

    .line 362
    :cond_b
    const-string v0, "fota"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 363
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    goto/16 :goto_0

    .line 365
    :cond_c
    const-string v0, "dun"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_d

    .line 366
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    goto/16 :goto_0

    :cond_d
    move v0, v3

    .line 369
    goto/16 :goto_0

    .line 372
    :cond_e
    const/16 v5, 0xb

    if-ne p0, v5, :cond_12

    .line 373
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f

    .line 374
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 376
    :cond_f
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_10

    .line 377
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_DEFAULT:I

    goto/16 :goto_0

    .line 379
    :cond_10
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    .line 380
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_IMS:I

    goto/16 :goto_0

    :cond_11
    move v0, v3

    .line 383
    goto/16 :goto_0

    .line 386
    :cond_12
    const/16 v5, 0x8

    if-ne p0, v5, :cond_17

    .line 387
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

    .line 389
    goto/16 :goto_0

    .line 390
    :cond_14
    const-string v4, "admin"

    invoke-static {p1, v4}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_15

    move v0, v1

    .line 391
    goto/16 :goto_0

    .line 393
    :cond_15
    const-string v1, "ims"

    invoke-static {p1, v1}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 395
    const-string v0, "dun"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    move v0, v2

    .line 396
    goto/16 :goto_0

    :cond_16
    move v0, v3

    .line 398
    goto/16 :goto_0

    .line 401
    :cond_17
    if-ne p0, v2, :cond_1c

    .line 402
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_18

    .line 403
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 405
    :cond_18
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_19

    .line 406
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_DEFAULT:I

    goto/16 :goto_0

    .line 408
    :cond_19
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1a

    .line 409
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_IMS:I

    goto/16 :goto_0

    .line 411
    :cond_1a
    const-string v0, "emergency"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1b

    .line 412
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_EMERGENCY:I

    goto/16 :goto_0

    :cond_1b
    move v0, v3

    .line 415
    goto/16 :goto_0

    .line 418
    :cond_1c
    const/16 v0, 0x1c

    if-ne p0, v0, :cond_22

    .line 419
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1d

    .line 420
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 422
    :cond_1d
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1e

    const-string v0, "*"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1f

    .line 424
    :cond_1e
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_DEFAULT:I

    goto/16 :goto_0

    .line 426
    :cond_1f
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_20

    .line 427
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_IMS:I

    goto/16 :goto_0

    .line 429
    :cond_20
    const-string v0, "usccapp"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_21

    .line 430
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_USCAPP:I

    goto/16 :goto_0

    :cond_21
    move v0, v3

    .line 433
    goto/16 :goto_0

    .line 436
    :cond_22
    const/16 v0, 0x1b

    if-ne p0, v0, :cond_26

    .line 437
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_23

    .line 438
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 440
    :cond_23
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_24

    .line 441
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_DEFAULT:I

    goto/16 :goto_0

    .line 443
    :cond_24
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_25

    .line 444
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_IMS:I

    goto/16 :goto_0

    :cond_25
    move v0, v3

    .line 447
    goto/16 :goto_0

    .line 450
    :cond_26
    const/16 v0, 0x1a

    if-ne p0, v0, :cond_29

    .line 451
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

    .line 454
    :cond_27
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_28
    move v0, v3

    .line 457
    goto/16 :goto_0

    .line 460
    :cond_29
    const/16 v0, 0xf

    if-ne p0, v0, :cond_2e

    .line 461
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2a

    .line 462
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 464
    :cond_2a
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2b

    const-string v0, "*"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2c

    .line 466
    :cond_2b
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_DEFAULT:I

    goto/16 :goto_0

    .line 468
    :cond_2c
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2d

    .line 469
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_IMS:I

    goto/16 :goto_0

    :cond_2d
    move v0, v3

    .line 472
    goto/16 :goto_0

    .line 476
    :cond_2e
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2f

    .line 477
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 479
    :cond_2f
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_30

    .line 480
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    goto/16 :goto_0

    .line 482
    :cond_30
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_33

    .line 483
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v0

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    if-eqz v0, :cond_31

    const/16 v0, 0x8

    if-ne p0, v0, :cond_32

    .line 485
    :cond_31
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    .line 488
    :cond_32
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DEFAULT:I

    goto/16 :goto_0

    .line 491
    :cond_33
    const-string v0, "fota"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_34

    .line 492
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_FOTA:I

    goto/16 :goto_0

    .line 494
    :cond_34
    const-string v0, "emergency"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_35

    .line 495
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    goto/16 :goto_0

    .line 498
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

    .line 564
    if-nez p0, :cond_1

    .line 565
    const/4 p0, 0x0

    .line 590
    .end local p0    # "pc":Landroid/os/Parcel;
    :cond_0
    return-object p0

    .line 568
    .restart local p0    # "pc":Landroid/os/Parcel;
    :cond_1
    array-length v1, p1

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 569
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_0

    .line 570
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 571
    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 572
    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->protocol:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 573
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->authType:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 574
    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->user:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 575
    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->password:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 576
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 577
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->maxConnsTime:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 578
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->maxConns:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 579
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->waitTime:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 580
    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->enabled:Z

    if-eqz v1, :cond_2

    move v1, v2

    :goto_1
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 582
    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    if-eqz v1, :cond_3

    move v1, v2

    :goto_2
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 583
    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    if-eqz v1, :cond_4

    move v1, v2

    :goto_3
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 584
    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->emergencyPDN:Z

    if-eqz v1, :cond_5

    move v1, v2

    :goto_4
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 585
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 586
    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 569
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    :cond_2
    move v1, v3

    .line 580
    goto :goto_1

    :cond_3
    move v1, v3

    .line 582
    goto :goto_2

    :cond_4
    move v1, v3

    .line 583
    goto :goto_3

    :cond_5
    move v1, v3

    .line 584
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

    .line 506
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v3, v5, :cond_5

    .line 507
    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    if-ne v3, v4, :cond_1

    .line 560
    :cond_0
    :goto_0
    return v0

    .line 509
    :cond_1
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    if-ne v0, v6, :cond_2

    move v0, v1

    .line 510
    goto :goto_0

    .line 511
    :cond_2
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_3

    move v0, v2

    .line 512
    goto :goto_0

    .line 513
    :cond_3
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_4

    .line 514
    const/16 v0, 0x65

    goto :goto_0

    .line 515
    :cond_4
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_f

    .line 516
    const/16 v0, 0x69

    goto :goto_0

    .line 518
    :cond_5
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v4, 0x9

    if-ne v3, v4, :cond_c

    .line 519
    const-string v3, "ro.product.board"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "msm8994"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 520
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    if-ne v0, v1, :cond_6

    .line 521
    const/16 v0, 0xa

    goto :goto_0

    .line 523
    :cond_6
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    if-ne v0, v1, :cond_7

    .line 524
    const/16 v0, 0xa

    goto :goto_0

    .line 526
    :cond_7
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    if-ne v0, v1, :cond_8

    .line 527
    const/16 v0, 0xb

    goto :goto_0

    .line 529
    :cond_8
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    if-ne v0, v1, :cond_9

    .line 530
    const/16 v0, 0xc

    goto :goto_0

    .line 533
    :cond_9
    const/16 v0, 0x9

    goto :goto_0

    .line 536
    :cond_a
    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    if-eq v3, v4, :cond_0

    .line 539
    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    if-eq v3, v4, :cond_0

    .line 542
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    if-ne v0, v3, :cond_b

    move v0, v2

    .line 543
    goto :goto_0

    .line 545
    :cond_b
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    if-ne v0, v2, :cond_f

    move v0, v1

    .line 546
    goto :goto_0

    .line 550
    :cond_c
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v4, 0x8

    if-ne v3, v4, :cond_f

    .line 551
    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    if-eq v3, v5, :cond_0

    .line 553
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    if-ne v0, v6, :cond_d

    move v0, v1

    .line 554
    goto/16 :goto_0

    .line 555
    :cond_d
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_e

    move v0, v2

    .line 556
    goto/16 :goto_0

    .line 557
    :cond_e
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_f

    .line 558
    const/16 v0, 0x65

    goto/16 :goto_0

    .line 560
    :cond_f
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    add-int/lit8 v0, v0, 0x64

    goto/16 :goto_0
.end method

.method public getInactivityTimer(Lcom/android/internal/telephony/dataconnection/ApnSetting;)I
    .locals 3
    .param p1, "profile"    # Lcom/android/internal/telephony/dataconnection/ApnSetting;

    .prologue
    .line 290
    const/4 v0, 0x0

    .line 292
    .local v0, "inactivityTimer":I
    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    packed-switch v1, :pswitch_data_0

    .line 317
    :goto_0
    :pswitch_0
    return v0

    .line 294
    :pswitch_1
    const/16 v0, 0x59f

    .line 295
    goto :goto_0

    .line 297
    :pswitch_2
    const/16 v0, 0xd98

    .line 298
    goto :goto_0

    .line 301
    :pswitch_3
    iget v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    if-ne v1, v2, :cond_0

    .line 302
    const/16 v0, 0xf

    goto :goto_0

    .line 304
    :cond_0
    iget v0, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->inactivityTimer:I

    .line 307
    goto :goto_0

    .line 309
    :pswitch_4
    iget v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_1

    .line 310
    const/4 v0, 0x0

    goto :goto_0

    .line 312
    :cond_1
    const/16 v0, 0x3c

    goto :goto_0

    .line 292
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

    .line 273
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v2, v1, :cond_2

    .line 274
    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_1

    .line 286
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 277
    goto :goto_0

    .line 279
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

    .line 283
    goto :goto_0
.end method

.method public needPcscfAddrRequest()Z
    .locals 5

    .prologue
    const/16 v4, 0x8

    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 166
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x9

    if-ne v2, v3, :cond_1

    .line 207
    :cond_0
    :goto_0
    return v0

    .line 169
    :cond_1
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_3

    .line 171
    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_IMS:I

    if-eq v2, v3, :cond_2

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_0

    :cond_2
    move v0, v1

    goto :goto_0

    .line 174
    :cond_3
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/4 v3, 0x4

    if-ne v2, v3, :cond_5

    .line 176
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

    .line 177
    goto :goto_0

    .line 180
    :cond_5
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v2, v4, :cond_6

    .line 181
    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_0

    move v0, v1

    .line 182
    goto :goto_0

    .line 186
    :cond_6
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x1b

    if-ne v2, v3, :cond_8

    .line 188
    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_IMS:I

    if-eq v2, v3, :cond_7

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_0

    :cond_7
    move v0, v1

    goto :goto_0

    .line 191
    :cond_8
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0xf

    if-ne v2, v3, :cond_c

    .line 192
    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_IMS:I

    if-eq v2, v3, :cond_9

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_a

    :cond_9
    move v0, v1

    goto :goto_0

    .line 195
    :cond_a
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE_FOR_IA_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 196
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

    .line 201
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

    .line 204
    goto/16 :goto_0
.end method

.method public needTriggerEsmInfoRequest()Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 211
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_DEFAULT:I

    if-ne v3, v4, :cond_1

    .line 268
    :cond_0
    :goto_0
    return v1

    .line 215
    :cond_1
    sget-object v3, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v3}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v3

    if-eqz v3, :cond_8

    .line 217
    const/4 v2, 0x0

    .line 218
    .local v2, "triggerEsmInfoRequestForMobility":I
    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 219
    .local v0, "networkOperator":Ljava/lang/String;
    const/4 v1, 0x0

    .line 221
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

    .line 224
    const-string v3, "SKT"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 225
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

    .line 227
    :cond_2
    const-string v3, "[LGE_DATA] "

    const-string v4, "[USIM Mobility] [Domestic region]"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 228
    const/4 v1, 0x0

    goto :goto_0

    .line 231
    :cond_3
    const-string v3, "[LGE_DATA] "

    const-string v4, "[USIM Mobility] Other cases, return true"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 232
    const/4 v1, 0x1

    goto :goto_0

    .line 236
    :cond_4
    const-string v3, "KT"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 238
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    iget-boolean v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    if-nez v3, :cond_5

    .line 239
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

    .line 240
    const/4 v1, 0x0

    goto/16 :goto_0

    .line 243
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

    .line 244
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 248
    :cond_6
    const-string v3, "LGU"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 250
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_7

    iget-boolean v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    if-nez v3, :cond_7

    .line 251
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

    .line 252
    const/4 v1, 0x0

    goto/16 :goto_0

    .line 255
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

    .line 256
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 263
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

    .line 268
    :cond_9
    const/4 v1, 0x1

    goto/16 :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    .line 594
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 596
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

    .line 614
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
