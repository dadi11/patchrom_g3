.class public final Lcom/lge/uicc/SmartCardWrapper;
.super Ljava/lang/Object;
.source "SmartCardWrapper.java"


# static fields
.field private static final CHANNEL_BYTES:I = 0x3

.field private static final LOG_TAG:Ljava/lang/String; = "SmartCardWrapper"

.field public static final SMARTCARD_IO_ALREADY_CONNECTED:I = -0x2

.field public static final SMARTCARD_IO_CARD_NOT_EXIST:I = -0x7

.field public static final SMARTCARD_IO_ERROR_ATR_BUFFER:I = -0x6

.field public static final SMARTCARD_IO_ERROR_NOT_CONNECT:I = -0x3

.field public static final SMARTCARD_IO_ERROR_OPEN_CHANNEL:I = -0x1

.field public static final SMARTCARD_IO_ERROR_RESPONSE_BUFFER:I = -0x5

.field public static final SMARTCARD_IO_ERROR_TRANSMIT_BUFFER:I = -0x4

.field public static final SMARTCARD_IO_ERROR_UNKNOWN:I = -0x8

.field public static final SMARTCARD_IO_SUCCESS:I

.field private static sInstance:Lcom/lge/uicc/SmartCardWrapper;


# instance fields
.field private channel:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/uicc/SmartCardWrapper;

    invoke-direct {v0}, Lcom/lge/uicc/SmartCardWrapper;-><init>()V

    sput-object v0, Lcom/lge/uicc/SmartCardWrapper;->sInstance:Lcom/lge/uicc/SmartCardWrapper;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    return-void
.end method

.method public static getInstance()Lcom/lge/uicc/SmartCardWrapper;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/SmartCardWrapper;->sInstance:Lcom/lge/uicc/SmartCardWrapper;

    return-object v0
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "SmartCardWrapper"

    invoke-static {v0, p0}, Lcom/lge/uicc/Plog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "SmartCardWrapper"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public connect()I
    .locals 7

    .prologue
    const/4 v6, 0x5

    const/4 v4, -0x1

    const-string v5, "Smartcard connect()"

    invoke-static {v5}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    new-array v0, v6, [B

    fill-array-data v0, :array_0

    .local v0, "command":[B
    const/4 v5, 0x3

    new-array v1, v5, [B

    .local v1, "response":[B
    const/4 v3, 0x0

    .local v3, "searchSW":Ljava/lang/String;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getSimState()I

    move-result v5

    if-eq v5, v6, :cond_1

    const-string v4, "[connect] Usim Card Not Inserted!!"

    invoke-static {v4}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v2, -0x7

    :cond_0
    :goto_0
    return v2

    :cond_1
    iget v5, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    if-eq v5, v4, :cond_2

    const-string v4, "[connect] Logical Channel is already open!!"

    invoke-static {v4}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v2, -0x2

    goto :goto_0

    :cond_2
    invoke-virtual {p0, v0, v1}, Lcom/lge/uicc/SmartCardWrapper;->transmit([B[B)I

    move-result v2

    .local v2, "response_length":I
    if-ltz v2, :cond_0

    invoke-static {v1}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[connect] response : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const-string v5, "6581"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "6881"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "9300"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "6B00"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "6F00"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    :cond_3
    move v2, v4

    goto :goto_0

    :cond_4
    const/4 v4, 0x0

    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    iput v4, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "open channel : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    iget v2, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    goto :goto_0

    :array_0
    .array-data 1
        0x0t
        0x70t
        0x0t
        0x0t
        0x1t
    .end array-data
.end method

.method public disconnect()I
    .locals 9

    .prologue
    const/4 v8, 0x2

    const/4 v7, -0x1

    const/4 v4, 0x0

    const-string v5, "Smartcard disconnect()"

    invoke-static {v5}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v5, 0x4

    new-array v0, v5, [B

    aput-byte v4, v0, v4

    const/4 v5, 0x1

    const/16 v6, 0x70

    aput-byte v6, v0, v5

    const/16 v5, -0x80

    aput-byte v5, v0, v8

    const/4 v5, 0x3

    iget v6, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    and-int/lit16 v6, v6, 0xff

    int-to-byte v6, v6

    aput-byte v6, v0, v5

    .local v0, "command":[B
    new-array v1, v8, [B

    .local v1, "response":[B
    const/4 v3, 0x0

    .local v3, "searchSW":Ljava/lang/String;
    iget v5, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    if-ne v5, v7, :cond_1

    const/4 v2, -0x3

    :cond_0
    :goto_0
    return v2

    :cond_1
    invoke-virtual {p0, v0, v1}, Lcom/lge/uicc/SmartCardWrapper;->transmit([B[B)I

    move-result v2

    .local v2, "response_length":I
    if-ltz v2, :cond_0

    invoke-static {v1}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[disconnect] response : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const-string v5, "6581"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    const-string v5, "9300"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    const-string v5, "6B00"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    const-string v5, "6F00"

    invoke-virtual {v3, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    :cond_2
    const/4 v2, -0x8

    goto :goto_0

    :cond_3
    iput v7, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    move v2, v4

    goto :goto_0
.end method

.method public getATR([B)I
    .locals 4
    .param p1, "atr"    # [B

    .prologue
    const/4 v3, 0x0

    const-string v1, "Smartcard getATR()"

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v0, 0x0

    .local v0, "tmpdata":[B
    const-string v1, "SMARTCARD_GET_ATR"

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/lge/uicc/LGUiccManager;->genericIO(Ljava/lang/String;[B)[B

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[getATR] tmpdata.data : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    if-nez v0, :cond_0

    const/4 v1, -0x8

    :goto_0
    return v1

    :cond_0
    array-length v1, v0

    array-length v2, p1

    if-le v1, v2, :cond_1

    const-string v1, "[getATR] SMARTCARD_IO_ERROR_ATR_BUFFER!!"

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v1, -0x6

    goto :goto_0

    :cond_1
    array-length v1, v0

    invoke-static {v0, v3, p1, v3, v1}, Ljava/lang/System;->arraycopy([BI[BII)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[getATR] atr : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    array-length v1, v0

    goto :goto_0
.end method

.method public getChannel()I
    .locals 1

    .prologue
    const-string v0, "Smartcard getChannel()"

    invoke-static {v0}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    if-gez v0, :cond_0

    const/4 v0, -0x3

    :goto_0
    return v0

    :cond_0
    iget v0, p0, Lcom/lge/uicc/SmartCardWrapper;->channel:I

    goto :goto_0
.end method

.method public transmit([B[B)I
    .locals 4
    .param p1, "command"    # [B
    .param p2, "response"    # [B

    .prologue
    const/4 v3, 0x0

    const-string v1, "Smartcard transmit()"

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v0, 0x0

    .local v0, "tmpdata":[B
    if-nez p1, :cond_0

    const/4 v1, -0x4

    :goto_0
    return v1

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[transmit] command : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const-string v1, "SMARTCARD_TRANSMIT"

    invoke-static {v1, p1}, Lcom/lge/uicc/LGUiccManager;->genericIO(Ljava/lang/String;[B)[B

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[transmit] tmpdata : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    if-nez v0, :cond_1

    const/4 v1, -0x8

    goto :goto_0

    :cond_1
    array-length v1, v0

    array-length v2, p2

    if-le v1, v2, :cond_2

    const-string v1, "[transmit] SMARTCARD_IO_ERROR_RESPONSE_BUFFER!!"

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    const/4 v1, -0x5

    goto :goto_0

    :cond_2
    array-length v1, v0

    invoke-static {v0, v3, p2, v3, v1}, Ljava/lang/System;->arraycopy([BI[BII)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[transmit] response : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p2}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/SmartCardWrapper;->logd(Ljava/lang/String;)V

    array-length v1, v0

    goto :goto_0
.end method
