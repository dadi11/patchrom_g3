.class public Lcom/android/internal/telephony/LGSmsHeader;
.super Ljava/lang/Object;
.source "LGSmsHeader.java"


# static fields
.field public static final ELT_ID_CONFIRMREAD_ELEMENT:I = 0x44

.field public static final PORT_KTAPPMANAGER:I = 0xc216

.field public static final PORT_KTKAFAPPLICATION:I = 0xc221

.field public static final PORT_KTKAM:I = 0xc210

.field public static final PORT_KTSHOWMEMORY:I = 0xc212

.field public static final PORT_KTSHOWMESSENGER:I = 0xc215

.field public static final PORT_KTSHOWNAVIGATION:I = 0xc213

.field public static final PORT_KTSHOWOPENMAIL:I = 0xc211

.field public static final PORT_KTSHOWVIEDIO:I = 0xc214

.field public static final PORT_LGTMMSNOTIMESSAGE:I = 0xc015

.field public static final PORT_LGTOMAMMSNOTI:I = 0x1004

.field public static final PORT_SKT_COMMON_PUSH:I = 0x425c

.field public static final PORT_SKT_ISSUE_MENU:I = 0xf17f

.field public static final PORT_SKT_PORT_URL:I = 0x4261

.field public static final PORT_SKT_REMOTE_CONSULT:I = 0xf180


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method protected static getReplyAddress(Ljava/io/ByteArrayInputStream;Lcom/android/internal/telephony/SmsHeader;I)V
    .locals 4
    .param p0, "inStream"    # Ljava/io/ByteArrayInputStream;
    .param p1, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p2, "length"    # I

    .prologue
    const/4 v3, 0x0

    new-instance v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    invoke-direct {v0}, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;-><init>()V

    .local v0, "localReplyAddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    new-array v1, p2, [B

    iput-object v1, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    const/4 v1, -0x1

    iget-object v2, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    invoke-virtual {p0, v2, v3, p2}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v2

    if-ne v1, v2, :cond_0

    iput v3, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->addressLength:I

    :goto_0
    iput-object v0, p1, Lcom/android/internal/telephony/SmsHeader;->replyAddress:Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    return-void

    :cond_0
    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    aget-byte v1, v1, v3

    and-int/lit16 v1, v1, 0xff

    iput v1, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->addressLength:I

    goto :goto_0
.end method

.method protected static getSafeSms(Ljava/io/ByteArrayInputStream;Lcom/android/internal/telephony/SmsHeader;I)V
    .locals 6
    .param p0, "inStream"    # Ljava/io/ByteArrayInputStream;
    .param p1, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p2, "length"    # I

    .prologue
    const/4 v5, 0x0

    const/4 v0, 0x0

    .local v0, "safeSmsField":B
    const-string v2, "KT"

    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    new-array v1, p2, [B

    .local v1, "serviceBitMaps":[B
    invoke-virtual {p0, v1, v5, p2}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v2

    if-lez v2, :cond_0

    aget-byte v0, v1, v5

    .end local v1    # "serviceBitMaps":[B
    :cond_0
    :goto_0
    iput-byte v0, p1, Lcom/android/internal/telephony/SmsHeader;->safeSMS:B

    return-void

    :cond_1
    const-string v2, "SKT"

    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Ljava/io/ByteArrayInputStream;->read()I

    move-result v2

    int-to-byte v0, v2

    goto :goto_0
.end method

.method protected static getSmsConfirmRead(Ljava/io/ByteArrayInputStream;Lcom/android/internal/telephony/SmsHeader;I)V
    .locals 4
    .param p0, "inStream"    # Ljava/io/ByteArrayInputStream;
    .param p1, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p2, "length"    # I

    .prologue
    new-instance v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;

    invoke-direct {v0}, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;-><init>()V

    .local v0, "localSmsRead":Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;
    iput p2, v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->length:I

    if-lez p2, :cond_1

    new-array v1, p2, [B

    iput-object v1, v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    const/4 v1, -0x1

    iget-object v2, v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3, p2}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v2

    if-ne v1, v2, :cond_0

    const-string v1, "SmsHeader.fromByteArray(), localSmsRead.confirmRead: The end of the stream has been reached"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_0
    iput-object v0, p1, Lcom/android/internal/telephony/SmsHeader;->smsConfirmRead:Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;

    :goto_0
    return-void

    :cond_1
    const-string v1, "SmsHeader.fromByteArray(), Confirm read length is invalid"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected static writeConfirmReadonOutStream(Lcom/android/internal/telephony/SmsHeader;Ljava/io/ByteArrayOutputStream;)V
    .locals 4
    .param p0, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p1, "outStream"    # Ljava/io/ByteArrayOutputStream;

    .prologue
    const/4 v3, 0x1

    iget-object v0, p0, Lcom/android/internal/telephony/SmsHeader;->smsConfirmRead:Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;

    .local v0, "smsread":Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;
    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    if-eqz v1, :cond_0

    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    array-length v1, v1

    if-eqz v1, :cond_0

    const/16 v1, 0x44

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {p1, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    const/4 v2, 0x0

    invoke-virtual {p1, v1, v2, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    :cond_0
    return-void
.end method

.method protected static writeReplyAddressonOutStream(Lcom/android/internal/telephony/SmsHeader;Ljava/io/ByteArrayOutputStream;)V
    .locals 2
    .param p0, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p1, "outStream"    # Ljava/io/ByteArrayOutputStream;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SmsHeader;->replyAddress:Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    .local v0, "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    if-eqz v0, :cond_0

    const/16 v1, 0x22

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    array-length v1, v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    iget v1, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->addressLength:I

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    :try_start_0
    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected static writeSafeSmsonOutStream(Lcom/android/internal/telephony/SmsHeader;Ljava/io/ByteArrayOutputStream;)V
    .locals 2
    .param p0, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p1, "outStream"    # Ljava/io/ByteArrayOutputStream;

    .prologue
    iget-byte v0, p0, Lcom/android/internal/telephony/SmsHeader;->safeSMS:B

    .local v0, "safeSmsField":B
    if-eqz v0, :cond_0

    const/16 v1, 0xc0

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    invoke-virtual {p1, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    :cond_0
    return-void
.end method
