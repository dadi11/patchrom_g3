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
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->DBG:Z

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->VDBG:Z

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->VDBG:Z

    const-string v0, "/system/etc/networkNameMod.xml"

    sput-object v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->IS_AVAILABLE:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->IS_AVAILABLE:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->parseXml()V

    :goto_0
    return-void

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
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;-><init>()V

    iput-wide p1, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSubId:J

    return-void
.end method

.method private getCurrentSystemData()V
    .locals 6

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "serviceState"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "operatorNumeric"

    const-string v2, "gsm.sim.operator.numeric"

    iget-wide v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSubId:J

    const-string v3, ""

    invoke-static {v2, v4, v5, v3}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "networkOperator"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "roaming"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "showPlmn"

    iget-boolean v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowPlmn:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "plmn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mPlmn:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "showSpn"

    iget-boolean v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowSpn:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "spn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSpn:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v1, "emergencyOnly"

    iget-boolean v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mEmergencyOnly:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private getCurrentSystemDataForTest()V
    .locals 18

    .prologue
    const-string v14, "persist.nwnametest.country"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "countryTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.operator"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .local v6, "operatorTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.region"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .local v8, "regionTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.ss"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .local v10, "serviceStateTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.opnumeric"

    move-object/from16 v0, p0

    iget-wide v0, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSubId:J

    move-wide/from16 v16, v0

    const-string v15, ""

    move-wide/from16 v0, v16

    invoke-static {v14, v0, v1, v15}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .local v5, "operatorNumericTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.nwoperator"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "networkOperatorTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.roaming"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .local v9, "roamingTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.showplmn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .local v11, "showPlmnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.plmn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .local v7, "plmnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.showspn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .local v12, "showSpnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.spn"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .local v13, "spnTest":Ljava/lang/String;
    const-string v14, "persist.nwnametest.emergonly"

    invoke-static {v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "emergencyOnlyTest":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "country"

    invoke-virtual {v14, v15, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "operator"

    invoke-virtual {v14, v15, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "region"

    invoke-virtual {v14, v15, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "serviceState"

    invoke-virtual {v14, v15, v10}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "operatorNumeric"

    invoke-virtual {v14, v15, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "networkOperator"

    invoke-virtual {v14, v15, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "roaming"

    invoke-virtual {v14, v15, v9}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "showPlmn"

    invoke-virtual {v14, v15, v11}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "plmn"

    invoke-virtual {v14, v15, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "showSpn"

    invoke-virtual {v14, v15, v12}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "spn"

    invoke-virtual {v14, v15, v13}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    const-string v15, "emergencyOnly"

    invoke-virtual {v14, v15, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private getSystemData()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->IS_TEST_MODE:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getCurrentSystemDataForTest()V

    :goto_0
    return-void

    :cond_0
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getCurrentSystemData()V

    goto :goto_0
.end method

.method private isNetworkNameDataModified()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mIsDataModified:Z

    return v0
.end method

.method private modifyData()V
    .locals 13

    .prologue
    const/4 v5, 0x0

    .local v5, "isModified":Z
    const/4 v4, 0x0

    .local v4, "index":I
    :goto_0
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-ge v4, v10, :cond_7

    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v10, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/HashMap;

    .local v1, "condition":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v7, 0x0

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

    .local v6, "key":Ljava/lang/String;
    invoke-virtual {v1, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .local v0, "condVal":Ljava/lang/String;
    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v10, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .local v8, "sysVal":Ljava/lang/String;
    invoke-static {v6, v8, v0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameUtils;->matchData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    sget-boolean v10, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    if-eqz v10, :cond_1

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

    :cond_1
    const/4 v7, 0x1

    .end local v0    # "condVal":Ljava/lang/String;
    .end local v6    # "key":Ljava/lang/String;
    .end local v8    # "sysVal":Ljava/lang/String;
    :cond_2
    if-nez v7, :cond_6

    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mCorrections:Ljava/util/ArrayList;

    invoke-virtual {v10, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/HashMap;

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

    .restart local v6    # "key":Ljava/lang/String;
    invoke-virtual {v2, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .local v9, "value":Ljava/lang/String;
    const-string v10, "plmn"

    invoke-virtual {v6, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    const-string v10, "LONG_NAME"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v9

    :cond_3
    :goto_2
    const/4 v5, 0x1

    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    invoke-virtual {v10, v6, v9}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_4
    const-string v10, "SHORT_NAME"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    iget-object v10, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v9

    goto :goto_2

    .end local v6    # "key":Ljava/lang/String;
    .end local v9    # "value":Ljava/lang/String;
    :cond_5
    sget-boolean v10, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    if-eqz v10, :cond_6

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

    .end local v2    # "correction":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_6
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    .end local v1    # "condition":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v3    # "i$":Ljava/util/Iterator;
    .end local v7    # "skipCorrection":Z
    :cond_7
    iput-boolean v5, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mIsDataModified:Z

    return-void
.end method

.method private parseXml()V
    .locals 10

    .prologue
    invoke-static {}, Ljavax/xml/parsers/SAXParserFactory;->newInstance()Ljavax/xml/parsers/SAXParserFactory;

    move-result-object v1

    .local v1, "factory":Ljavax/xml/parsers/SAXParserFactory;
    new-instance v2, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;

    sget-boolean v6, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->IS_TEST_MODE:Z

    invoke-direct {v2, v6}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;-><init>(Z)V

    .local v2, "handler":Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .local v4, "startTime":J
    invoke-virtual {v1}, Ljavax/xml/parsers/SAXParserFactory;->newSAXParser()Ljavax/xml/parsers/SAXParser;

    move-result-object v3

    .local v3, "parser":Ljavax/xml/parsers/SAXParser;
    new-instance v6, Ljava/io/File;

    sget-object v7, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->sXmlPath:Ljava/lang/String;

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v6, v2}, Ljavax/xml/parsers/SAXParser;->parse(Ljava/io/File;Lorg/xml/sax/helpers/DefaultHandler;)V

    sget-boolean v6, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->DBG:Z

    if-eqz v6, :cond_0

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

    .end local v3    # "parser":Ljavax/xml/parsers/SAXParser;
    .end local v4    # "startTime":J
    :cond_0
    :goto_0
    invoke-virtual {v2}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->getConditions()Ljava/util/ArrayList;

    move-result-object v6

    iput-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v2}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->getCorrections()Ljava/util/ArrayList;

    move-result-object v6

    iput-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mCorrections:Ljava/util/ArrayList;

    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljavax/xml/parsers/ParserConfigurationException;
    const-string v6, "LgeNetworkNameManager"

    const-string v7, "ParserConfigurationException"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Ljavax/xml/parsers/ParserConfigurationException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Ljavax/xml/parsers/ParserConfigurationException;
    :catch_1
    move-exception v0

    .local v0, "e":Lorg/xml/sax/SAXException;
    const-string v6, "LgeNetworkNameManager"

    const-string v7, "SAXException"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Lorg/xml/sax/SAXException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Lorg/xml/sax/SAXException;
    :catch_2
    move-exception v0

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
    .local p1, "data":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->VDBG:Z

    if-eqz v4, :cond_1

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

    .local v1, "key":Ljava/lang/String;
    const-string v4, " "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

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

    .end local v1    # "key":Ljava/lang/String;
    .end local v3    # "value":Ljava/lang/String;
    :cond_0
    const-string v4, "LgeNetworkNameManager"

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "msg":Ljava/lang/StringBuilder;
    :cond_1
    return-void
.end method

.method private setDataBeforeMod()V
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "showPlmn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "showPlmn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "plmn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "plmn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "showSpn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "showSpn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v1, "spn"

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v3, "spn"

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

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
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    return-object v0
.end method

.method public getPlmn()Ljava/lang/String;
    .locals 2

    .prologue
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
    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->IS_AVAILABLE:Z

    if-nez v4, :cond_0

    const/4 v4, 0x0

    :goto_0
    return v4

    :cond_0
    iput-object p1, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mServiceState:Landroid/telephony/ServiceState;

    iput-boolean p2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowPlmn:Z

    iput-object p3, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mPlmn:Ljava/lang/String;

    iput-boolean p4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mShowSpn:Z

    iput-object p5, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSpn:Ljava/lang/String;

    iput-boolean p6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mEmergencyOnly:Z

    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->getSystemData()V

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

    .local v2, "key":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v4, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .local v3, "prevValue":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v4, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .local v0, "currentValue":Ljava/lang/String;
    invoke-static {v3, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->clear()V

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    iget-object v5, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mTempSystemData:Ljava/util/HashMap;

    invoke-virtual {v4, v5}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mSystemData:Ljava/util/HashMap;

    const-string v5, "System Data"

    invoke-direct {p0, v4, v5}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->printData(Ljava/util/HashMap;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->setDataBeforeMod()V

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v5, "Before Mod"

    invoke-direct {p0, v4, v5}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->printData(Ljava/util/HashMap;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->modifyData()V

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->mModifiedData:Ljava/util/HashMap;

    const-string v5, "After Mod"

    invoke-direct {p0, v4, v5}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->printData(Ljava/util/HashMap;Ljava/lang/String;)V

    .end local v0    # "currentValue":Ljava/lang/String;
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "prevValue":Ljava/lang/String;
    :cond_2
    invoke-direct {p0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameManager;->isNetworkNameDataModified()Z

    move-result v4

    goto :goto_0
.end method
