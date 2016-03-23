.class public Lcom/lge/telephony/LGServiceState;
.super Ljava/lang/Object;
.source "LGServiceState.java"


# static fields
.field public static final DOMESTIC_ROAMING:I = 0x3

.field public static final HOME:I = 0x1

.field public static final INTERNATIONAL_ROAMING:I = 0x2

.field static final LOG_TAG:Ljava/lang/String; = "LGServiceState"

.field private static mRoamingType:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static sInstance:Lcom/lge/telephony/LGServiceState;


# instance fields
.field private mServiceState:Landroid/telephony/ServiceState;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x2

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x4a

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x7c

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x7d

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x7e

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x9d

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x9e

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x9f

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc3

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc5

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc6

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe5

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe6

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe7

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe8

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe9

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xea

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xeb

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;
    .locals 3
    .param p0, "servicestate"    # Landroid/telephony/ServiceState;

    .prologue
    const-class v1, Lcom/lge/telephony/LGServiceState;

    monitor-enter v1

    :try_start_0
    const-string v0, "LGServiceState"

    const-string v2, "You are using ServiceState for LG API"

    invoke-static {v0, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/telephony/LGServiceState;

    invoke-direct {v0}, Lcom/lge/telephony/LGServiceState;-><init>()V

    sput-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;

    :cond_0
    sget-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;

    invoke-virtual {v0, p0}, Lcom/lge/telephony/LGServiceState;->setServiceState(Landroid/telephony/ServiceState;)V

    sget-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static getRoamingType(Landroid/telephony/ServiceState;)I
    .locals 5
    .param p0, "st"    # Landroid/telephony/ServiceState;

    .prologue
    const/4 v2, 0x1

    .local v2, "rvalue":I
    invoke-virtual {p0}, Landroid/telephony/ServiceState;->getCdmaRoamingIndicator()I

    move-result v1

    .local v1, "roamingIndcation":I
    :try_start_0
    sget-object v3, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const/4 v2, 0x3

    goto :goto_0
.end method

.method public static isCdmaFormat(I)Z
    .locals 1
    .param p0, "radioTechnology"    # I

    .prologue
    const/4 v0, 0x4

    if-eq p0, v0, :cond_0

    const/4 v0, 0x5

    if-eq p0, v0, :cond_0

    const/4 v0, 0x7

    if-eq p0, v0, :cond_0

    const/16 v0, 0x8

    if-eq p0, v0, :cond_0

    const/16 v0, 0xc

    if-eq p0, v0, :cond_0

    const/4 v0, 0x6

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isDataSearching(Landroid/telephony/ServiceState;)Z
    .locals 1
    .param p0, "ss"    # Landroid/telephony/ServiceState;

    .prologue
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->isDataSearching()Z

    move-result v0

    return v0
.end method

.method public static isEhrpd(I)Z
    .locals 1
    .param p0, "radioTechnology"    # I

    .prologue
    const/16 v0, 0xd

    if-ne p0, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isVoiceSearching(Landroid/telephony/ServiceState;)Z
    .locals 1
    .param p0, "ss"    # Landroid/telephony/ServiceState;

    .prologue
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->isVoiceSearching()Z

    move-result v0

    return v0
.end method

.method public static setDataSearching(Landroid/telephony/ServiceState;Z)V
    .locals 1
    .param p0, "ss"    # Landroid/telephony/ServiceState;
    .param p1, "isDataSearching"    # Z

    .prologue
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataSearching(Z)V

    return-void
.end method

.method public static setVoiceSearching(Landroid/telephony/ServiceState;Z)V
    .locals 1
    .param p0, "ss"    # Landroid/telephony/ServiceState;
    .param p1, "isVoiceSearching"    # Z

    .prologue
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceSearching(Z)V

    return-void
.end method


# virtual methods
.method public changePlmnNameForMVNO(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 9
    .param p1, "SpnMvno"    # Ljava/lang/String;
    .param p2, "operator"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x3

    const/4 v3, 0x0

    .local v3, "sim_imsi":Ljava/lang/String;
    const/4 v4, 0x0

    .local v4, "sim_mcc":Ljava/lang/String;
    const/4 v5, 0x0

    .local v5, "sim_mnc":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "gid":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "oldSpnMvno":Ljava/lang/String;
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimInfo()Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move-result-object v2

    .local v2, "simInfo":Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getGid()Ljava/lang/String;

    move-result-object v0

    :cond_0
    const-string v6, "gsm.sim.operator.numeric"

    invoke-static {v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move-object v1, p1

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v6

    const/4 v7, 0x4

    if-le v6, v7, :cond_1

    const/4 v6, 0x0

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    :cond_1
    if-eqz p1, :cond_2

    if-eqz p2, :cond_2

    const-string v6, "LGServiceState"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "grandblue SpnMvno = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " operator = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " sim_mcc = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " sim_mnc = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    if-eqz p1, :cond_25

    if-eqz p2, :cond_25

    const-string v6, "Virgin"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    const-string v6, "20802"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    const-string v6, "20823"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    :cond_3
    const-string p1, "Virgin Mobile"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_4
    const-string v6, "NRJ Mobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_5

    const-string v6, "EI Telecom"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_5

    const-string v6, "C le mobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    :cond_5
    const-string v6, "20810"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_6

    const-string v6, "20826"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    :cond_6
    const-string p1, "NRJ Mobile"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_7
    const-string v6, "Jazztel"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_9

    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_8

    const-string v6, "21421"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_9

    :cond_8
    const-string p1, "Jazztel"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_9
    const-string v6, "Carrefour"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_a

    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_a

    const-string p1, "Carrefour"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_a
    const-string v6, "BITE"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b

    const-string v6, "24705"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b

    const-string p1, "LV BITE"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_b
    const-string v6, "congstar"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    const-string v6, "26201"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    const-string p1, "Telekom.de"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_c
    const-string v6, "mobilcom-debitel"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_d

    const-string v6, "26202"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_27

    const-string p1, "Vodafone.de"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_d
    :goto_0
    const-string v6, "20810"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_12

    const-string v6, "CORIOLIS"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_e

    const-string p1, "Coriolis"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_e
    const-string v6, "La Poste Mobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_f

    const-string p1, "La Poste Mobile"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_f
    const-string v6, "Darty"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_10

    const-string p1, "Darty"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_10
    const-string v6, "LeclercMobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_11

    const-string p1, "LeclercMobile"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_11
    const-string v6, "A MOBILE"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_12

    const-string p1, "A MOBILE"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_12
    const-string v6, "Euskaltel"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    const-string v6, "214"

    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_29

    const-string v6, "06"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_29

    if-eqz v0, :cond_29

    const-string v6, "0008"

    invoke-virtual {v0, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_29

    const-string v6, "21401"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_28

    const-string p1, "Euskaltel"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_13
    :goto_1
    const-string v6, "21406"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_15

    const-string v6, "R cable"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_14

    const-string p1, "Coriolis"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_14
    const-string v6, "Telecable"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_15

    const-string p1, "Telecable"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_15
    const-string v6, "23207"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_16

    const-string v6, "T-Mobile A"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2b

    const-string p1, "Telering"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_16
    :goto_2
    const-string v6, "20815"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_17

    const-string v6, "Free"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_17

    const-string p1, "Free"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_17
    const-string v6, "23102"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_18

    const-string v6, "T-Mobile SK"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_18

    const-string p1, "Telekom SK"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_18
    const-string v6, "24405"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_19

    const-string v6, "24421"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1a

    :cond_19
    const-string v6, "T-Mobile SK"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1a

    const-string p1, "Saunalahti"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_1a
    const-string v6, "T-Mobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1c

    const-string v6, "23430"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_1b

    const-string v6, "23433"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1c

    :cond_1b
    const-string p1, "EE"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_1c
    const-string v6, "23433"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1d

    const-string v6, "Virgin"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2c

    const-string p1, "virgin"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_1d
    :goto_3
    const-string v6, "23430"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1e

    const-string v6, "Virgin"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2d

    const-string p1, "Virgin"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_1e
    :goto_4
    const-string v6, "23212"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1f

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "A1"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1f

    const-string p1, "Yesss!"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_1f
    const-string v6, "21401"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_20

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "telecable"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2e

    const-string p1, "telecable"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_20
    :goto_5
    const-string v6, "21407"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_21

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "ONO"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_21

    const-string p1, "ONO"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_21
    const-string v6, "23415"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_22

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "TalkTalk"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2f

    const-string p1, "TalkTalk"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_22
    :goto_6
    const-string v6, "23820"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_23

    const-string v6, "23866"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_24

    :cond_23
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "Call me"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_30

    const-string p1, "Call me"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_24
    :goto_7
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "Tele2"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_25

    const-string v6, "24803"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_33

    const-string p1, "EE TELE2"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    :cond_25
    :goto_8
    if-eqz p1, :cond_26

    if-eqz p2, :cond_26

    const-string v6, "LGServiceState"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "grandblue after SpnMvno = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " operator = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " sim_mcc = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " sim_mnc = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_26
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    return v6

    :cond_27
    const-string v6, "26203"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_d

    const-string p1, "E-Plus"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_28
    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    const-string p1, "Orange"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_29
    const-string v6, "214"

    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    const-string v6, "08"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    if-eqz v0, :cond_13

    const-string v6, "0008"

    invoke-virtual {v0, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_13

    const-string v6, "21401"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2a

    const-string p1, "Euskaltel"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_2a
    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    const-string p1, "Orange"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_2b
    const-string v6, "Telering"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_16

    const-string p1, "Saunalahti"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_2

    :cond_2c
    const-string v6, "EE"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1d

    if-eqz v0, :cond_1d

    const-string v6, "28000000"

    invoke-virtual {v0, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1d

    const-string p1, "virgin"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_3

    :cond_2d
    const-string v6, "EE"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1e

    if-eqz v0, :cond_1e

    const-string v6, "28000000"

    invoke-virtual {v0, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1e

    const-string p1, "Virgin"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_4

    :cond_2e
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "mobilR"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_20

    const-string p1, "mobilR"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_2f
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "Talkmobile"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_22

    const-string p1, "Talkmobile"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_6

    :cond_30
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "DLG Tele"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_31

    const-string p1, "DLG Tele"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_7

    :cond_31
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "BiBoB"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_32

    const-string p1, "BiBoB"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_7

    :cond_32
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "TELIA DK"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_24

    const-string p1, "TELIA DK"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_7

    :cond_33
    const-string v6, "20416"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_25

    const-string p1, "Tele2"

    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_8
.end method

.method public changePlmnNameForSwedish(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "opLong"    # Ljava/lang/String;
    .param p2, "opShort"    # Ljava/lang/String;
    .param p3, "opNumeric"    # Ljava/lang/String;

    .prologue
    const/4 v9, 0x5

    const/4 v8, 0x6

    const/4 v7, 0x0

    const/4 v3, 0x0

    .local v3, "sim_imsi":Ljava/lang/String;
    move-object v0, p1

    .local v0, "newOpLong":Ljava/lang/String;
    if-nez v0, :cond_0

    const-string v4, "LGServiceState"

    const-string v5, "changePlmnNameForSwedish: newOpLong=null, assign empty field to newOpLong"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, ""

    :cond_0
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimInfo()Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move-result-object v2

    .local v2, "simInfo":Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getImsi()Ljava/lang/String;

    move-result-object v3

    :cond_1
    if-nez v3, :cond_2

    const-string v4, "gsm.sim.operator.numeric"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :cond_2
    if-nez v3, :cond_3

    const-string v4, "LGServiceState"

    const-string v5, "changePlmnNameForSwedish: sim_imsi = null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    .end local v0    # "newOpLong":Ljava/lang/String;
    .local v1, "newOpLong":Ljava/lang/String;
    :goto_0
    return-object v1

    .end local v1    # "newOpLong":Ljava/lang/String;
    .restart local v0    # "newOpLong":Ljava/lang/String;
    :cond_3
    const-string v4, "LGServiceState"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "changePlmnNameForSwedish sim_imsi "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "LGServiceState"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "changePlmnNameForSwedish: Before OpLong="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v9, :cond_6

    invoke-virtual {v3, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "24008"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    const-string v4, "24008"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    const-string v0, "Telenor SE"

    :cond_4
    const-string v4, "24004"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    const-string v0, "SWEDEN"

    :cond_5
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    const-string v0, "Sweden Mobile"

    :cond_6
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v9, :cond_8

    invoke-virtual {v3, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "24002"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    const-string v4, "24002"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    const-string v0, "3SE"

    :cond_7
    const-string v4, "24004"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    const-string v0, "3SE"

    :cond_8
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v9, :cond_c

    invoke-virtual {v3, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "24007"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v8, :cond_10

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240070"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240071"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240072"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240073"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240074"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240075"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240076"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_10

    :cond_9
    const-string v4, "24007"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a

    const-string v0, "Tele2 SE"

    :cond_a
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_b

    const-string v0, "Tele2 SE"

    :cond_b
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    const-string v0, "Tele2 SE"

    :cond_c
    :goto_1
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v9, :cond_e

    invoke-virtual {v3, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "24001"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_e

    const-string v4, "24001"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_d

    const-string v0, "Telia SE"

    :cond_d
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_e

    const-string v0, "Sweden 3G"

    :cond_e
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_f

    const-string v4, "24007"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_14

    const-string v0, "Tele2 SE"

    :cond_f
    :goto_2
    const-string v4, "LGServiceState"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "changePlmnNameForSwedish: newOpLong = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    .end local v0    # "newOpLong":Ljava/lang/String;
    .restart local v1    # "newOpLong":Ljava/lang/String;
    goto/16 :goto_0

    .end local v1    # "newOpLong":Ljava/lang/String;
    .restart local v0    # "newOpLong":Ljava/lang/String;
    :cond_10
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v8, :cond_c

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240077"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_11

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240078"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_11

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "240079"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    :cond_11
    const-string v4, "24007"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_12

    const-string v0, "Comviq SE"

    :cond_12
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_13

    const-string v0, "Comviq SE"

    :cond_13
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    const-string v0, "Comviq SE"

    goto/16 :goto_1

    :cond_14
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_15

    const-string v0, "Sweden 3G"

    goto :goto_2

    :cond_15
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_16

    const-string v0, "Sweden Mobile"

    goto :goto_2

    :cond_16
    move-object v0, p2

    goto :goto_2
.end method

.method public getCheck64QAM()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getCheck64QAM()I

    move-result v0

    return v0
.end method

.method public getDataNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getDataNetworkName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDataRoaming()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getDataRoaming()Z

    move-result v0

    return v0
.end method

.method public getRATDualCarrier()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getRATDualCarrier()I

    move-result v0

    return v0
.end method

.method public getVoiceNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getVoiceNetworkName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getVoiceRoaming()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getVoiceRoaming()Z

    move-result v0

    return v0
.end method

.method public isDataSearching()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->isDataSearching()Z

    move-result v0

    return v0
.end method

.method public isVoiceSearching()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->isVoiceSearching()Z

    move-result v0

    return v0
.end method

.method public setCheck64QAM(I)V
    .locals 1
    .param p1, "Check64QAM"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setCheck64QAM(I)V

    return-void
.end method

.method public setDataNetworkName(Ljava/lang/String;)V
    .locals 1
    .param p1, "dataNetworkName"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataNetworkName(Ljava/lang/String;)V

    return-void
.end method

.method public setDataRoaming(Z)V
    .locals 1
    .param p1, "dataRoaming"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataRoaming(Z)V

    return-void
.end method

.method public setDataSearching(Z)V
    .locals 1
    .param p1, "isDataSearching"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataSearching(Z)V

    return-void
.end method

.method public setRATDualCarrier(I)V
    .locals 1
    .param p1, "isRATDualCarrier"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setRATDualCarrier(I)V

    return-void
.end method

.method public setServiceState(Landroid/telephony/ServiceState;)V
    .locals 0
    .param p1, "servicestate"    # Landroid/telephony/ServiceState;

    .prologue
    iput-object p1, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    return-void
.end method

.method public setVoiceNetworkName(Ljava/lang/String;)V
    .locals 1
    .param p1, "voiceNetworkName"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceNetworkName(Ljava/lang/String;)V

    return-void
.end method

.method public setVoiceRoaming(Z)V
    .locals 1
    .param p1, "voiceRoaming"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceRoaming(Z)V

    return-void
.end method

.method public setVoiceSearching(Z)V
    .locals 1
    .param p1, "isVoiceSearching"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceSearching(Z)V

    return-void
.end method
