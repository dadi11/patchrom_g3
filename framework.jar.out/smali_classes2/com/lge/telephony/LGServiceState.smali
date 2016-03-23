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

    .line 44
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    .line 47
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 48
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x4a

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 49
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x7c

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 50
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x7d

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x7e

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 52
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x9d

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x9e

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 54
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0x9f

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 56
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc3

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 58
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc5

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 60
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xc6

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 61
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 62
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe5

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe6

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe7

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe8

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 66
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xe9

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 67
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xea

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 68
    sget-object v0, Lcom/lge/telephony/LGServiceState;->mRoamingType:Ljava/util/HashMap;

    const/16 v1, 0xeb

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 69
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;
    .locals 3
    .param p0, "servicestate"    # Landroid/telephony/ServiceState;

    .prologue
    .line 86
    const-class v1, Lcom/lge/telephony/LGServiceState;

    monitor-enter v1

    :try_start_0
    const-string v0, "LGServiceState"

    const-string v2, "You are using ServiceState for LG API"

    invoke-static {v0, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    sget-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;

    if-nez v0, :cond_0

    .line 89
    new-instance v0, Lcom/lge/telephony/LGServiceState;

    invoke-direct {v0}, Lcom/lge/telephony/LGServiceState;-><init>()V

    sput-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;

    .line 92
    :cond_0
    sget-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;

    invoke-virtual {v0, p0}, Lcom/lge/telephony/LGServiceState;->setServiceState(Landroid/telephony/ServiceState;)V

    .line 94
    sget-object v0, Lcom/lge/telephony/LGServiceState;->sInstance:Lcom/lge/telephony/LGServiceState;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 86
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static getRoamingType(Landroid/telephony/ServiceState;)I
    .locals 5
    .param p0, "st"    # Landroid/telephony/ServiceState;

    .prologue
    .line 267
    const/4 v2, 0x1

    .line 268
    .local v2, "rvalue":I
    invoke-virtual {p0}, Landroid/telephony/ServiceState;->getCdmaRoamingIndicator()I

    move-result v1

    .line 271
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

    .line 276
    :goto_0
    return v2

    .line 272
    :catch_0
    move-exception v0

    .line 273
    .local v0, "e":Ljava/lang/NullPointerException;
    const/4 v2, 0x3

    goto :goto_0
.end method

.method public static isCdmaFormat(I)Z
    .locals 1
    .param p0, "radioTechnology"    # I

    .prologue
    .line 289
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
    .line 254
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->isDataSearching()Z

    move-result v0

    return v0
.end method

.method public static isEhrpd(I)Z
    .locals 1
    .param p0, "radioTechnology"    # I

    .prologue
    .line 305
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
    .line 245
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
    .line 236
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataSearching(Z)V

    .line 237
    return-void
.end method

.method public static setVoiceSearching(Landroid/telephony/ServiceState;Z)V
    .locals 1
    .param p0, "ss"    # Landroid/telephony/ServiceState;
    .param p1, "isVoiceSearching"    # Z

    .prologue
    .line 227
    iget-object v0, p0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceSearching(Z)V

    .line 228
    return-void
.end method


# virtual methods
.method public changePlmnNameForMVNO(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 9
    .param p1, "SpnMvno"    # Ljava/lang/String;
    .param p2, "operator"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x3

    .line 311
    const/4 v3, 0x0

    .line 312
    .local v3, "sim_imsi":Ljava/lang/String;
    const/4 v4, 0x0

    .line 313
    .local v4, "sim_mcc":Ljava/lang/String;
    const/4 v5, 0x0

    .line 314
    .local v5, "sim_mnc":Ljava/lang/String;
    const/4 v0, 0x0

    .line 315
    .local v0, "gid":Ljava/lang/String;
    const/4 v1, 0x0

    .line 317
    .local v1, "oldSpnMvno":Ljava/lang/String;
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimInfo()Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move-result-object v2

    .line 318
    .local v2, "simInfo":Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    if-eqz v2, :cond_0

    .line 319
    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getGid()Ljava/lang/String;

    move-result-object v0

    .line 322
    :cond_0
    const-string v6, "gsm.sim.operator.numeric"

    invoke-static {v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 323
    move-object v1, p1

    .line 325
    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v6

    const/4 v7, 0x4

    if-le v6, v7, :cond_1

    .line 326
    const/4 v6, 0x0

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 327
    invoke-virtual {v3, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    .line 330
    :cond_1
    if-eqz p1, :cond_2

    if-eqz p2, :cond_2

    .line 331
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

    .line 334
    :cond_2
    if-eqz p1, :cond_25

    if-eqz p2, :cond_25

    .line 335
    const-string v6, "Virgin"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 336
    const-string v6, "20802"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    const-string v6, "20823"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 337
    :cond_3
    const-string p1, "Virgin Mobile"

    .line 338
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 341
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

    .line 342
    :cond_5
    const-string v6, "20810"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_6

    const-string v6, "20826"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 343
    :cond_6
    const-string p1, "NRJ Mobile"

    .line 344
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 347
    :cond_7
    const-string v6, "Jazztel"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 348
    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_8

    const-string v6, "21421"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 349
    :cond_8
    const-string p1, "Jazztel"

    .line 350
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 353
    :cond_9
    const-string v6, "Carrefour"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_a

    .line 354
    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_a

    .line 355
    const-string p1, "Carrefour"

    .line 356
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 359
    :cond_a
    const-string v6, "BITE"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b

    .line 360
    const-string v6, "24705"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b

    .line 361
    const-string p1, "LV BITE"

    .line 362
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 365
    :cond_b
    const-string v6, "congstar"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    .line 366
    const-string v6, "26201"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    .line 367
    const-string p1, "Telekom.de"

    .line 368
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 371
    :cond_c
    const-string v6, "mobilcom-debitel"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_d

    .line 372
    const-string v6, "26202"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_27

    .line 373
    const-string p1, "Vodafone.de"

    .line 374
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 380
    :cond_d
    :goto_0
    const-string v6, "20810"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_12

    .line 381
    const-string v6, "CORIOLIS"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_e

    .line 382
    const-string p1, "Coriolis"

    .line 383
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 385
    :cond_e
    const-string v6, "La Poste Mobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_f

    .line 386
    const-string p1, "La Poste Mobile"

    .line 387
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 389
    :cond_f
    const-string v6, "Darty"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_10

    .line 390
    const-string p1, "Darty"

    .line 391
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 393
    :cond_10
    const-string v6, "LeclercMobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_11

    .line 394
    const-string p1, "LeclercMobile"

    .line 395
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 397
    :cond_11
    const-string v6, "A MOBILE"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_12

    .line 398
    const-string p1, "A MOBILE"

    .line 399
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 402
    :cond_12
    const-string v6, "Euskaltel"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    .line 403
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

    .line 404
    const-string v6, "21401"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_28

    .line 405
    const-string p1, "Euskaltel"

    .line 406
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 421
    :cond_13
    :goto_1
    const-string v6, "21406"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_15

    .line 422
    const-string v6, "R cable"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_14

    .line 423
    const-string p1, "Coriolis"

    .line 424
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 426
    :cond_14
    const-string v6, "Telecable"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_15

    .line 427
    const-string p1, "Telecable"

    .line 428
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 431
    :cond_15
    const-string v6, "23207"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_16

    .line 432
    const-string v6, "T-Mobile A"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2b

    .line 433
    const-string p1, "Telering"

    .line 434
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 440
    :cond_16
    :goto_2
    const-string v6, "20815"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_17

    .line 441
    const-string v6, "Free"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_17

    .line 442
    const-string p1, "Free"

    .line 443
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 446
    :cond_17
    const-string v6, "23102"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_18

    .line 447
    const-string v6, "T-Mobile SK"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_18

    .line 448
    const-string p1, "Telekom SK"

    .line 449
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 452
    :cond_18
    const-string v6, "24405"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_19

    const-string v6, "24421"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1a

    .line 453
    :cond_19
    const-string v6, "T-Mobile SK"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1a

    .line 454
    const-string p1, "Saunalahti"

    .line 455
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 458
    :cond_1a
    const-string v6, "T-Mobile"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1c

    .line 459
    const-string v6, "23430"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_1b

    const-string v6, "23433"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1c

    .line 460
    :cond_1b
    const-string p1, "EE"

    .line 461
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 464
    :cond_1c
    const-string v6, "23433"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1d

    .line 465
    const-string v6, "Virgin"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2c

    .line 466
    const-string/jumbo p1, "virgin"

    .line 467
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 473
    :cond_1d
    :goto_3
    const-string v6, "23430"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1e

    .line 474
    const-string v6, "Virgin"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2d

    .line 475
    const-string p1, "Virgin"

    .line 476
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 482
    :cond_1e
    :goto_4
    const-string v6, "23212"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1f

    .line 483
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "A1"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1f

    .line 484
    const-string p1, "Yesss!"

    .line 485
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 488
    :cond_1f
    const-string v6, "21401"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_20

    .line 489
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "telecable"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2e

    .line 490
    const-string p1, "telecable"

    .line 491
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 497
    :cond_20
    :goto_5
    const-string v6, "21407"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_21

    .line 498
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "ONO"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_21

    .line 499
    const-string p1, "ONO"

    .line 500
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 503
    :cond_21
    const-string v6, "23415"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_22

    .line 504
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "TalkTalk"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2f

    .line 505
    const-string p1, "TalkTalk"

    .line 506
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 512
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

    .line 513
    :cond_23
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "Call me"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_30

    .line 514
    const-string p1, "Call me"

    .line 515
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 527
    :cond_24
    :goto_7
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "Tele2"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_25

    .line 528
    const-string v6, "24803"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_33

    .line 529
    const-string p1, "EE TELE2"

    .line 530
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 537
    :cond_25
    :goto_8
    if-eqz p1, :cond_26

    if-eqz p2, :cond_26

    .line 538
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

    .line 540
    :cond_26
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    return v6

    .line 375
    :cond_27
    const-string v6, "26203"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_d

    .line 376
    const-string p1, "E-Plus"

    .line 377
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 407
    :cond_28
    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    .line 408
    const-string p1, "Orange"

    .line 409
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 411
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

    .line 412
    const-string v6, "21401"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2a

    .line 413
    const-string p1, "Euskaltel"

    .line 414
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 415
    :cond_2a
    const-string v6, "21403"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_13

    .line 416
    const-string p1, "Orange"

    .line 417
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 435
    :cond_2b
    const-string v6, "Telering"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_16

    .line 436
    const-string p1, "Saunalahti"

    .line 437
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 468
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

    .line 469
    const-string/jumbo p1, "virgin"

    .line 470
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_3

    .line 477
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

    .line 478
    const-string p1, "Virgin"

    .line 479
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_4

    .line 492
    :cond_2e
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "mobilR"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_20

    .line 493
    const-string p1, "mobilR"

    .line 494
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_5

    .line 507
    :cond_2f
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "Talkmobile"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_22

    .line 508
    const-string p1, "Talkmobile"

    .line 509
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_6

    .line 516
    :cond_30
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "DLG Tele"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_31

    .line 517
    const-string p1, "DLG Tele"

    .line 518
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_7

    .line 519
    :cond_31
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "BiBoB"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_32

    .line 520
    const-string p1, "BiBoB"

    .line 521
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_7

    .line 522
    :cond_32
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    const-string v7, "TELIA DK"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_24

    .line 523
    const-string p1, "TELIA DK"

    .line 524
    iget-object v6, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v6, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    goto/16 :goto_7

    .line 531
    :cond_33
    const-string v6, "20416"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_25

    .line 532
    const-string p1, "Tele2"

    .line 533
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

    .line 545
    const/4 v3, 0x0

    .line 546
    .local v3, "sim_imsi":Ljava/lang/String;
    move-object v0, p1

    .line 548
    .local v0, "newOpLong":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 549
    const-string v4, "LGServiceState"

    const-string v5, "changePlmnNameForSwedish: newOpLong=null, assign empty field to newOpLong"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 550
    const-string v0, ""

    .line 554
    :cond_0
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimInfo()Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move-result-object v2

    .line 555
    .local v2, "simInfo":Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    if-eqz v2, :cond_1

    .line 556
    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getImsi()Ljava/lang/String;

    move-result-object v3

    .line 560
    :cond_1
    if-nez v3, :cond_2

    .line 561
    const-string v4, "gsm.sim.operator.numeric"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 563
    :cond_2
    if-nez v3, :cond_3

    .line 564
    const-string v4, "LGServiceState"

    const-string v5, "changePlmnNameForSwedish: sim_imsi = null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    .line 651
    .end local v0    # "newOpLong":Ljava/lang/String;
    .local v1, "newOpLong":Ljava/lang/String;
    :goto_0
    return-object v1

    .line 567
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

    .line 568
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

    .line 571
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v4, v9, :cond_6

    invoke-virtual {v3, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "24008"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 572
    const-string v4, "24008"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 573
    const-string v0, "Telenor SE"

    .line 575
    :cond_4
    const-string v4, "24004"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 576
    const-string v0, "SWEDEN"

    .line 578
    :cond_5
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 579
    const-string v0, "Sweden Mobile"

    .line 583
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

    .line 584
    const-string v4, "24002"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 585
    const-string v0, "3SE"

    .line 587
    :cond_7
    const-string v4, "24004"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 588
    const-string v0, "3SE"

    .line 592
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

    .line 593
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

    .line 601
    :cond_9
    const-string v4, "24007"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a

    .line 602
    const-string v0, "Tele2 SE"

    .line 604
    :cond_a
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 605
    const-string v0, "Tele2 SE"

    .line 607
    :cond_b
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    .line 608
    const-string v0, "Tele2 SE"

    .line 627
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

    .line 628
    const-string v4, "24001"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_d

    .line 629
    const-string v0, "Telia SE"

    .line 631
    :cond_d
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_e

    .line 632
    const-string v0, "Sweden 3G"

    .line 637
    :cond_e
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_f

    .line 638
    const-string v4, "24007"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_14

    .line 639
    const-string v0, "Tele2 SE"

    .line 649
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

    .line 651
    .end local v0    # "newOpLong":Ljava/lang/String;
    .restart local v1    # "newOpLong":Ljava/lang/String;
    goto/16 :goto_0

    .line 610
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

    .line 614
    :cond_11
    const-string v4, "24007"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_12

    .line 615
    const-string v0, "Comviq SE"

    .line 617
    :cond_12
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_13

    .line 618
    const-string v0, "Comviq SE"

    .line 620
    :cond_13
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c

    .line 621
    const-string v0, "Comviq SE"

    goto/16 :goto_1

    .line 640
    :cond_14
    const-string v4, "24005"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_15

    .line 641
    const-string v0, "Sweden 3G"

    goto :goto_2

    .line 642
    :cond_15
    const-string v4, "24024"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_16

    .line 643
    const-string v0, "Sweden Mobile"

    goto :goto_2

    .line 645
    :cond_16
    move-object v0, p2

    goto :goto_2
.end method

.method public getCheck64QAM()I
    .locals 1

    .prologue
    .line 660
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getCheck64QAM()I

    move-result v0

    return v0
.end method

.method public getDataNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 178
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getDataNetworkName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDataRoaming()Z
    .locals 1

    .prologue
    .line 136
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getDataRoaming()Z

    move-result v0

    return v0
.end method

.method public getRATDualCarrier()I
    .locals 1

    .prologue
    .line 675
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getRATDualCarrier()I

    move-result v0

    return v0
.end method

.method public getVoiceNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 168
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getVoiceNetworkName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getVoiceRoaming()Z
    .locals 1

    .prologue
    .line 126
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->getVoiceRoaming()Z

    move-result v0

    return v0
.end method

.method public isDataSearching()Z
    .locals 1

    .prologue
    .line 217
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0}, Lcom/lge/telephony/LGServiceStateImpl;->isDataSearching()Z

    move-result v0

    return v0
.end method

.method public isVoiceSearching()Z
    .locals 1

    .prologue
    .line 208
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
    .line 667
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setCheck64QAM(I)V

    .line 668
    return-void
.end method

.method public setDataNetworkName(Ljava/lang/String;)V
    .locals 1
    .param p1, "dataNetworkName"    # Ljava/lang/String;

    .prologue
    .line 158
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataNetworkName(Ljava/lang/String;)V

    .line 159
    return-void
.end method

.method public setDataRoaming(Z)V
    .locals 1
    .param p1, "dataRoaming"    # Z

    .prologue
    .line 116
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataRoaming(Z)V

    .line 117
    return-void
.end method

.method public setDataSearching(Z)V
    .locals 1
    .param p1, "isDataSearching"    # Z

    .prologue
    .line 199
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setDataSearching(Z)V

    .line 200
    return-void
.end method

.method public setRATDualCarrier(I)V
    .locals 1
    .param p1, "isRATDualCarrier"    # I

    .prologue
    .line 681
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setRATDualCarrier(I)V

    .line 682
    return-void
.end method

.method public setServiceState(Landroid/telephony/ServiceState;)V
    .locals 0
    .param p1, "servicestate"    # Landroid/telephony/ServiceState;

    .prologue
    .line 74
    iput-object p1, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    .line 75
    return-void
.end method

.method public setVoiceNetworkName(Ljava/lang/String;)V
    .locals 1
    .param p1, "voiceNetworkName"    # Ljava/lang/String;

    .prologue
    .line 148
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceNetworkName(Ljava/lang/String;)V

    .line 149
    return-void
.end method

.method public setVoiceRoaming(Z)V
    .locals 1
    .param p1, "voiceRoaming"    # Z

    .prologue
    .line 105
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceRoaming(Z)V

    .line 106
    return-void
.end method

.method public setVoiceSearching(Z)V
    .locals 1
    .param p1, "isVoiceSearching"    # Z

    .prologue
    .line 190
    iget-object v0, p0, Lcom/lge/telephony/LGServiceState;->mServiceState:Landroid/telephony/ServiceState;

    iget-object v0, v0, Landroid/telephony/ServiceState;->mLGServiceStateImpl:Lcom/lge/telephony/LGServiceStateImpl;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGServiceStateImpl;->setVoiceSearching(Z)V

    .line 191
    return-void
.end method
