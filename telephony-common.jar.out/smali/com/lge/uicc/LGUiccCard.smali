.class public Lcom/lge/uicc/LGUiccCard;
.super Ljava/lang/Object;
.source "LGUiccCard.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/LGUiccCard$PinState;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "LGUiccCard"


# instance fields
.field private mSlotId:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    .line 35
    return-void
.end method

.method public constructor <init>(I)V
    .locals 0
    .param p1, "slot"    # I

    .prologue
    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput p1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    .line 44
    return-void
.end method

.method private getPinData(Ljava/lang/String;)[Ljava/lang/String;
    .locals 4
    .param p1, "pintype"    # Ljava/lang/String;

    .prologue
    .line 135
    const-string v1, "proxy.app_type"

    iget v2, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const-string v3, "USIM"

    invoke-static {v1, v2, v3}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 136
    .local v0, "app":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const-string v3, ""

    invoke-static {v1, v2, v3}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public getFdnRecordCount()I
    .locals 3

    .prologue
    .line 145
    const-string v0, "fdn_rec_num"

    iget v1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const-string v2, "0"

    invoke-static {v0, v1, v2}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getFdnRecordSize()I
    .locals 3

    .prologue
    .line 154
    const-string v0, "fdn_name_max"

    iget v1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const-string v2, "0"

    invoke-static {v0, v1, v2}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getGid1()Ljava/lang/String;
    .locals 3

    .prologue
    .line 179
    const-string v0, "gid1"

    iget v1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getImsiM()Ljava/lang/String;
    .locals 3

    .prologue
    .line 171
    const-string v0, "imsi_m"

    iget v1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMdn()Ljava/lang/String;
    .locals 3

    .prologue
    .line 162
    const-string v0, "mdn"

    iget v1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPin1RetryCount()I
    .locals 4

    .prologue
    const/4 v1, 0x3

    .line 52
    const-string v2, "pin1"

    invoke-direct {p0, v2}, Lcom/lge/uicc/LGUiccCard;->getPinData(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 53
    .local v0, "pinData":[Ljava/lang/String;
    if-eqz v0, :cond_0

    array-length v2, v0

    if-ne v2, v1, :cond_0

    .line 54
    const/4 v1, 0x1

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 57
    :goto_0
    return v1

    .line 56
    :cond_0
    const-string v2, "LGUiccCard"

    const-string v3, "getPin1RetryCount: use dummy"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getPin1State()Lcom/lge/uicc/LGUiccCard$PinState;
    .locals 5

    .prologue
    .line 109
    :try_start_0
    const-string v2, "pin1"

    invoke-direct {p0, v2}, Lcom/lge/uicc/LGUiccCard;->getPinData(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 110
    .local v1, "pinData":[Ljava/lang/String;
    const/4 v2, 0x0

    aget-object v2, v1, v2

    invoke-static {v2}, Lcom/lge/uicc/LGUiccCard$PinState;->valueOf(Ljava/lang/String;)Lcom/lge/uicc/LGUiccCard$PinState;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 114
    .end local v1    # "pinData":[Ljava/lang/String;
    :goto_0
    return-object v2

    .line 111
    :catch_0
    move-exception v0

    .line 112
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "LGUiccCard"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPin1State: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 114
    sget-object v2, Lcom/lge/uicc/LGUiccCard$PinState;->UNKNOWN:Lcom/lge/uicc/LGUiccCard$PinState;

    goto :goto_0
.end method

.method public getPin2RetryCount()I
    .locals 4

    .prologue
    const/4 v1, 0x3

    .line 66
    const-string v2, "pin2"

    invoke-direct {p0, v2}, Lcom/lge/uicc/LGUiccCard;->getPinData(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 67
    .local v0, "pinData":[Ljava/lang/String;
    if-eqz v0, :cond_0

    array-length v2, v0

    if-ne v2, v1, :cond_0

    .line 68
    const/4 v1, 0x1

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 71
    :goto_0
    return v1

    .line 70
    :cond_0
    const-string v2, "LGUiccCard"

    const-string v3, "getPin2RetryCount: use dummy"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getPin2State()Lcom/lge/uicc/LGUiccCard$PinState;
    .locals 5

    .prologue
    .line 124
    :try_start_0
    const-string v2, "pin2"

    invoke-direct {p0, v2}, Lcom/lge/uicc/LGUiccCard;->getPinData(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 125
    .local v1, "pinData":[Ljava/lang/String;
    const/4 v2, 0x0

    aget-object v2, v1, v2

    invoke-static {v2}, Lcom/lge/uicc/LGUiccCard$PinState;->valueOf(Ljava/lang/String;)Lcom/lge/uicc/LGUiccCard$PinState;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 129
    .end local v1    # "pinData":[Ljava/lang/String;
    :goto_0
    return-object v2

    .line 126
    :catch_0
    move-exception v0

    .line 127
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "LGUiccCard"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPin2State: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 129
    sget-object v2, Lcom/lge/uicc/LGUiccCard$PinState;->UNKNOWN:Lcom/lge/uicc/LGUiccCard$PinState;

    goto :goto_0
.end method

.method public getPuk1RetryCount()I
    .locals 3

    .prologue
    .line 80
    const-string v1, "pin1"

    invoke-direct {p0, v1}, Lcom/lge/uicc/LGUiccCard;->getPinData(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 81
    .local v0, "pinData":[Ljava/lang/String;
    if-eqz v0, :cond_0

    array-length v1, v0

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    .line 82
    const/4 v1, 0x2

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 85
    :goto_0
    return v1

    .line 84
    :cond_0
    const-string v1, "LGUiccCard"

    const-string v2, "getPuk1RetryCount: use dummy"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 85
    const/16 v1, 0xa

    goto :goto_0
.end method

.method public getPuk2RetryCount()I
    .locals 3

    .prologue
    .line 94
    const-string v1, "pin2"

    invoke-direct {p0, v1}, Lcom/lge/uicc/LGUiccCard;->getPinData(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 95
    .local v0, "pinData":[Ljava/lang/String;
    if-eqz v0, :cond_0

    array-length v1, v0

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    .line 96
    const/4 v1, 0x2

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 99
    :goto_0
    return v1

    .line 98
    :cond_0
    const-string v1, "LGUiccCard"

    const-string v2, "getPuk2RetryCount: use dummy"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 99
    const/16 v1, 0xa

    goto :goto_0
.end method

.method public showSimPinView()V
    .locals 3

    .prologue
    .line 219
    const-string v0, "show_sim_pin_view"

    iget v1, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    const-string v2, "true"

    invoke-static {v0, v1, v2}, Lcom/lge/uicc/LGUiccManager;->setProperty(Ljava/lang/String;ILjava/lang/String;)Z

    .line 220
    return-void
.end method

.method public supplyPin(Ljava/lang/String;)Z
    .locals 1
    .param p1, "pin"    # Ljava/lang/String;

    .prologue
    .line 189
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/lge/uicc/LGUiccCard;->supplyPuk(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public supplyPuk(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5
    .param p1, "puk"    # Ljava/lang/String;
    .param p2, "pin"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 199
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 201
    .local v0, "p":Landroid/os/Parcel;
    iget v3, p0, Lcom/lge/uicc/LGUiccCard;->mSlotId:I

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->writeInt(I)V

    .line 202
    invoke-virtual {v0, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 203
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 205
    const-string v3, "SUPPLY_PINPUK"

    invoke-virtual {v0}, Landroid/os/Parcel;->marshall()[B

    move-result-object v4

    invoke-static {v3, v4}, Lcom/lge/uicc/LGUiccManager;->genericIO(Ljava/lang/String;[B)[B

    move-result-object v1

    .line 206
    .local v1, "result":[B
    if-eqz v1, :cond_0

    aget-byte v3, v1, v2

    if-nez v3, :cond_1

    .line 207
    :cond_0
    const-string v3, "LGUiccCard"

    const-string v4, "supplyPinPuk: PIN incorrect or fail"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 211
    :goto_0
    return v2

    .line 210
    :cond_1
    const-string v2, "LGUiccCard"

    const-string v3, "supplyPinPuk: OK"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 211
    const/4 v2, 0x1

    goto :goto_0
.end method
