.class public Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;
.super Ljava/lang/Object;
.source "LgeNetworkNameManager.java"


# static fields
.field protected static final DBG:Z

.field protected static final IS_AVAILABLE:Z

.field protected static final LOG_TAG:Ljava/lang/String; = "LgeNetworkNameManager"

.field protected static final VDBG:Z

.field protected static sXmlPath:Ljava/lang/String;


# instance fields
.field protected mConditions:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field protected mCorrections:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field protected mEmergencyOnly:Z

.field protected mIsDataModified:Z

.field protected mModifiedData:Ljava/util/HashMap;
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

.field protected mPlmn:Ljava/lang/String;

.field protected mServiceState:Landroid/telephony/ServiceState;

.field protected mShowPlmn:Z

.field protected mShowSpn:Z

.field protected mSpn:Ljava/lang/String;

.field protected mSubId:J

.field protected mSystemData:Ljava/util/HashMap;
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

.field protected mTempSystemData:Ljava/util/HashMap;
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
    .locals 2

    .prologue
    .line 38
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->DBG:Z

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    .line 43
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->VDBG:Z

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->VDBG:Z

    .line 121
    const-string v0, "/system/etc/networkNameMod.xml"

    sput-object v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    .line 124
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->IS_AVAILABLE:Z

    .line 125
    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 130
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 131
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->IS_AVAILABLE:Z

    if-eqz v0, :cond_0

    .line 132
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    .line 133
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    .line 134
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    .line 136
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->parseXml()V

    .line 140
    :goto_0
    return-void

    .line 138
    :cond_0
    const-string v0, "LgeNetworkNameManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "xml file is not exist - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>(J)V
    .locals 1
    .param p1, "subId"    # J

    .prologue
    .line 146
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;-><init>()V

    .line 147
    iput-wide p1, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSubId:J

    .line 148
    return-void
.end method

.method private getCurrentSystemData()V
    .locals 6

    .prologue
    .line 205
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "serviceState"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 207
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "operatorNumeric"

    const-string v2, "gsm.sim.operator.numeric"

    iget-wide v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSubId:J

    const-string v3, ""

    invoke-static {v2, v4, v5, v3}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 209
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "networkOperator"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 210
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "roaming"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 211
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "showPlmn"

    iget-boolean v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowPlmn:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 212
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "plmn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mPlmn:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 213
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "showSpn"

    iget-boolean v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowSpn:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 214
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "spn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSpn:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 215
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "emergencyOnly"

    iget-boolean v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mEmergencyOnly:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 216
    return-void
.end method

.method private getCurrentSystemDataForTest()V
    .locals 18

    .prologue
    .line 224
    const-string v14, "persist.nwnametest.country"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 225
    .local v2, "countryTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.operator"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 226
    .local v6, "operatorTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.region"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 228
    .local v8, "regionTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.ss"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 229
    .local v10, "serviceStateTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.opnumeric"

    move-object/from16 v0, p0

    iget-wide v0, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSubId:J

    move-wide/from16 v16, v0

    const-string v15, ""

    move-wide/from16 v0, v16

    invoke-static {v14, v0, v1, v15}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 230
    .local v5, "operatorNumericTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.nwoperator"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 231
    .local v4, "networkOperatorTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.roaming"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 232
    .local v9, "roamingTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.showplmn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 233
    .local v11, "showPlmnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.plmn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 234
    .local v7, "plmnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.showspn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 235
    .local v12, "showSpnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.spn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 236
    .local v13, "spnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.emergonly"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 239
    .local v3, "emergencyOnlyTest":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "country"

    invoke-virtual {v14, v15, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 240
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "operator"

    invoke-virtual {v14, v15, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 241
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "region"

    invoke-virtual {v14, v15, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 243
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "serviceState"

    invoke-virtual {v14, v15, v10}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 244
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "operatorNumeric"

    invoke-virtual {v14, v15, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 245
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "networkOperator"

    invoke-virtual {v14, v15, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 246
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "roaming"

    invoke-virtual {v14, v15, v9}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 247
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "showPlmn"

    invoke-virtual {v14, v15, v11}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 248
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "plmn"

    invoke-virtual {v14, v15, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 249
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "showSpn"

    invoke-virtual {v14, v15, v12}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 250
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "spn"

    invoke-virtual {v14, v15, v13}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 251
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "emergencyOnly"

    invoke-virtual {v14, v15, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 252
    return-void
.end method

.method private getSystemData()V
    .locals 1

    .prologue
    .line 191
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 193
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->IS_TEST_MODE:Z

    if-eqz v0, :cond_0

    .line 194
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getCurrentSystemDataForTest()V

    .line 198
    :goto_0
    return-void

    .line 196
    :cond_0
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getCurrentSystemData()V

    goto :goto_0
.end method

.method private isNetworkNameDataModified()Z
    .locals 1

    .prologue
    .line 433
    iget-boolean v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mIsDataModified:Z

    return v0
.end method

.method private modifyData()V
    .locals 13

    .prologue
    .line 319
    const/4 v5, 0x0

    .line 321
    .local v5, "isModified":Z
    const/4 v4, 0x0

    .local v4, "index":I
    :goto_0
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-ge v4, v10, :cond_7

    .line 322
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v10, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/HashMap;

    .line 323
    .local v1, "condition":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v7, 0x0

    .line 325
    .local v7, "skipCorrection":Z
    invoke-virtual {v1}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v10

    invoke-interface {v10}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 326
    .local v6, "key":Ljava/lang/String;
    invoke-virtual {v1, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 327
    .local v0, "condVal":Ljava/lang/String;
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v10, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 329
    .local v8, "sysVal":Ljava/lang/String;
    invoke-static {v6, v8, v0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameUtils;->matchData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    .line 330
    sget-boolean v10, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    if-eqz v10, :cond_1

    .line 331
    const-string v10, "LgeNetworkNameManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "condition doesn\'t match, skip this requirement - ["

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "] System value : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", Xml Value : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", modifiedData : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 333
    const-string v10, "LgeNetworkNameManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "key : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", systemData : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "\n"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 335
    :cond_1
    const/4 v7, 0x1

    .line 340
    .end local v0    # "condVal":Ljava/lang/String;
    .end local v6    # "key":Ljava/lang/String;
    .end local v8    # "sysVal":Ljava/lang/String;
    :cond_2
    if-nez v7, :cond_6

    .line 341
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mCorrections:Ljava/util/ArrayList;

    invoke-virtual {v10, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/HashMap;

    .line 343
    .local v2, "correction":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {v2}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v10

    invoke-interface {v10}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 344
    .restart local v6    # "key":Ljava/lang/String;
    invoke-virtual {v2, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 346
    .local v9, "value":Ljava/lang/String;
    const-string v10, "plmn"

    invoke-virtual {v6, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 347
    const-string v10, "LONG_NAME"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 348
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v9

    .line 353
    :cond_3
    :goto_2
    const/4 v5, 0x1

    .line 354
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    invoke-virtual {v10, v6, v9}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 349
    :cond_4
    const-string v10, "SHORT_NAME"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 350
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v9

    goto :goto_2

    .line 357
    .end local v6    # "key":Ljava/lang/String;
    .end local v9    # "value":Ljava/lang/String;
    :cond_5
    sget-boolean v10, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    if-eqz v10, :cond_6

    .line 358
    const-string v10, "LgeNetworkNameManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "condition matches - "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", apply correction - "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 321
    .end local v2    # "correction":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_6
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    .line 367
    .end local v1    # "condition":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v3    # "i$":Ljava/util/Iterator;
    .end local v7    # "skipCorrection":Z
    :cond_7
    iput-boolean v5, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mIsDataModified:Z

    .line 368
    return-void
.end method

.method private parseXml()V
    .locals 10

    .prologue
    .line 154
    invoke-static {}, Ljavax/xml/parsers/SAXParserFactory;->newInstance()Ljavax/xml/parsers/SAXParserFactory;

    move-result-object v1

    .line 157
    .local v1, "factory":Ljavax/xml/parsers/SAXParserFactory;
    new-instance v2, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;

    sget-boolean v6, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->IS_TEST_MODE:Z

    invoke-direct {v2, v6}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;-><init>(Z)V

    .line 160
    .local v2, "handler":Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 162
    .local v4, "startTime":J
    invoke-virtual {v1}, Ljavax/xml/parsers/SAXParserFactory;->newSAXParser()Ljavax/xml/parsers/SAXParser;

    move-result-object v3

    .line 163
    .local v3, "parser":Ljavax/xml/parsers/SAXParser;
    new-instance v6, Ljava/io/File;

    sget-object v7, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v6, v2}, Ljavax/xml/parsers/SAXParser;->parse(Ljava/io/File;Lorg/xml/sax/helpers/DefaultHandler;)V

    .line 165
    sget-boolean v6, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    if-eqz v6, :cond_0

    .line 166
    const-string v6, "LgeNetworkNameManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[ parsed file ] : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", elapsed time : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    sub-long/2addr v8, v4

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "ms\n"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljavax/xml/parsers/ParserConfigurationException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lorg/xml/sax/SAXException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    .line 181
    .end local v3    # "parser":Ljavax/xml/parsers/SAXParser;
    .end local v4    # "startTime":J
    :cond_0
    :goto_0
    invoke-virtual {v2}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->getConditions()Ljava/util/ArrayList;

    move-result-object v6

    iput-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mConditions:Ljava/util/ArrayList;

    .line 182
    invoke-virtual {v2}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->getCorrections()Ljava/util/ArrayList;

    move-result-object v6

    iput-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mCorrections:Ljava/util/ArrayList;

    .line 183
    return-void

    .line 171
    :catch_0
    move-exception v0

    .line 172
    .local v0, "e":Ljavax/xml/parsers/ParserConfigurationException;
    const-string v6, "LgeNetworkNameManager"

    const-string v7, "ParserConfigurationException"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    invoke-virtual {v0}, Ljavax/xml/parsers/ParserConfigurationException;->printStackTrace()V

    goto :goto_0

    .line 174
    .end local v0    # "e":Ljavax/xml/parsers/ParserConfigurationException;
    :catch_1
    move-exception v0

    .line 175
    .local v0, "e":Lorg/xml/sax/SAXException;
    const-string v6, "LgeNetworkNameManager"

    const-string v7, "SAXException"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    invoke-virtual {v0}, Lorg/xml/sax/SAXException;->printStackTrace()V

    goto :goto_0

    .line 177
    .end local v0    # "e":Lorg/xml/sax/SAXException;
    :catch_2
    move-exception v0

    .line 178
    .local v0, "e":Ljava/io/IOException;
    const-string v6, "LgeNetworkNameManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "xml file does not exist - "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private printData(Ljava/util/HashMap;Ljava/lang/String;)V
    .locals 6
    .param p2, "header"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 445
    .local p1, "data":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->VDBG:Z

    if-eqz v4, :cond_1

    .line 446
    new-instance v2, Ljava/lang/StringBuilder;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " -"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 447
    .local v2, "msg":Ljava/lang/StringBuilder;
    invoke-virtual {p1}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 448
    .local v1, "key":Ljava/lang/String;
    const-string v4, " "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 450
    invoke-virtual {p1, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 452
    .local v3, "value":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ":"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 455
    .end local v1    # "key":Ljava/lang/String;
    .end local v3    # "value":Ljava/lang/String;
    :cond_0
    const-string v4, "LgeNetworkNameManager"

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 457
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "msg":Ljava/lang/StringBuilder;
    :cond_1
    return-void
.end method

.method private setDataBeforeMod()V
    .locals 4

    .prologue
    .line 309
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "showPlmn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "showPlmn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 310
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "plmn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "plmn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 311
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "showSpn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "showSpn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 312
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "spn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "spn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 313
    return-void
.end method


# virtual methods
.method protected getModifiedData()Ljava/util/HashMap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 378
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    return-object v0
.end method

.method public getPlmn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 400
    invoke-virtual {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getModifiedData()Ljava/util/HashMap;

    move-result-object v0

    const-string v1, "plmn"

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getSpn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 422
    invoke-virtual {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getModifiedData()Ljava/util/HashMap;

    move-result-object v0

    const-string v1, "spn"

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public isShowPlmn()Z
    .locals 2

    .prologue
    .line 389
    invoke-virtual {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getModifiedData()Ljava/util/HashMap;

    move-result-object v0

    const-string v1, "showPlmn"

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public isShowSpn()Z
    .locals 2

    .prologue
    .line 411
    invoke-virtual {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getModifiedData()Ljava/util/HashMap;

    move-result-object v0

    const-string v1, "showSpn"

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public modifyNetworkName(Landroid/telephony/ServiceState;ZLjava/lang/String;ZLjava/lang/String;Z)Z
    .locals 6
    .param p1, "ss"    # Landroid/telephony/ServiceState;
    .param p2, "showPlmn"    # Z
    .param p3, "plmn"    # Ljava/lang/String;
    .param p4, "showSpn"    # Z
    .param p5, "spn"    # Ljava/lang/String;
    .param p6, "emergencyOnly"    # Z

    .prologue
    .line 269
    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->IS_AVAILABLE:Z

    if-nez v4, :cond_0

    .line 270
    const/4 v4, 0x0

    .line 302
    :goto_0
    return v4

    .line 274
    :cond_0
    iput-object p1, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    .line 275
    iput-boolean p2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowPlmn:Z

    .line 276
    iput-object p3, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mPlmn:Ljava/lang/String;

    .line 277
    iput-boolean p4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowSpn:Z

    .line 278
    iput-object p5, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSpn:Ljava/lang/String;

    .line 279
    iput-boolean p6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mEmergencyOnly:Z

    .line 281
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getSystemData()V

    .line 283
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 284
    .local v2, "key":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v4, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 285
    .local v3, "prevValue":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v4, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 287
    .local v0, "currentValue":Ljava/lang/String;
    invoke-static {v3, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 289
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->clear()V

    .line 290
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    iget-object v5, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v4, v5}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V

    .line 292
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v5, "System Data"

    invoke-direct {p0, v4, v5}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->printData(Ljava/util/HashMap;Ljava/lang/String;)V

    .line 293
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->setDataBeforeMod()V

    .line 294
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v5, "Before Mod"

    invoke-direct {p0, v4, v5}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->printData(Ljava/util/HashMap;Ljava/lang/String;)V

    .line 295
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->modifyData()V

    .line 296
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v5, "After Mod"

    invoke-direct {p0, v4, v5}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->printData(Ljava/util/HashMap;Ljava/lang/String;)V

    .line 302
    .end local v0    # "currentValue":Ljava/lang/String;
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "prevValue":Ljava/lang/String;
    :cond_2
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->isNetworkNameDataModified()Z

    move-result v4

    goto :goto_0
.end method
