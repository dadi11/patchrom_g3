.class public Lcom/lge/uicc/framework/LGWFCInfo;
.super Ljava/lang/Object;
.source "LGWFCInfo.java"


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsGbaSupported:Z

    sput-object v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mRand:[B

    sput-object v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mBtid:Ljava/lang/String;

    sput-object v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mKeyLifetime:Ljava/lang/String;

    return-void
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LGWFCInfo] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LGWFCInfo] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method private static logp(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LGWFCInfo] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logp(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public getIsimBtid()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mBtid:Ljava/lang/String;

    return-object v0
.end method

.method public getIsimKeyLifetime()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mKeyLifetime:Ljava/lang/String;

    return-object v0
.end method

.method public getIsimRand()[B
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mRand:[B

    return-object v0
.end method

.method public isGbaSupported()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsGbaSupported:Z

    return v0
.end method

.method public setIsimBtid(Ljava/lang/String;)V
    .locals 0
    .param p1, "btid"    # Ljava/lang/String;

    .prologue
    sput-object p1, Lcom/lge/uicc/framework/IsimRecordLoader;->mBtid:Ljava/lang/String;

    return-void
.end method

.method public setIsimKeyLifetime(Ljava/lang/String;)V
    .locals 0
    .param p1, "keylifetime"    # Ljava/lang/String;

    .prologue
    sput-object p1, Lcom/lge/uicc/framework/IsimRecordLoader;->mKeyLifetime:Ljava/lang/String;

    return-void
.end method

.method public setIsimRand([B)V
    .locals 0
    .param p1, "rand"    # [B

    .prologue
    sput-object p1, Lcom/lge/uicc/framework/IsimRecordLoader;->mRand:[B

    return-void
.end method
