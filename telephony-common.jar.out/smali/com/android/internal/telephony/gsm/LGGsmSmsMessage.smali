.class public Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;
.super Lcom/android/internal/telephony/SmsMessageBase;
.source "LGGsmSmsMessage.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;,
        Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;
    }
.end annotation


# static fields
.field public static final ENCODING_16BIT_DCS:I = 0x8

.field public static final ENCODING_7BIT_DCS:I = 0x0

.field public static final ENCODING_8BIT_DCS:I = 0x84

.field public static final ENCODING_UNKNOWN_DCS:I = -0x1

.field public static final PID_1ST_SPECIAL_SMS:I = 0x48

.field public static final PID_2ND_SPECIAL_SMS:I = 0x5f

.field public static final PID_KT_CALLBACK_URL:I = 0x4e

.field public static final PID_KT_FOTA:I = 0x7d

.field public static final PID_KT_LBS:I = 0x51

.field public static final PID_KT_PORT_ADDRESS:I = 0x53

.field public static final PID_LGT_PORT_ADDRESS:I = 0x53

.field public static final PID_LMS:I = 0x4f

.field public static final PID_NORMAL_MESSAGE:I = 0x0

.field public static final PID_SKT_CALLBACK_URL:I = 0x91

.field public static final PID_SKT_PORT_ADDRESS:I = 0xa2

.field private static final VDBG:Z = true

.field private static sEncodingType:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 135
    const/4 v0, 0x0

    sput v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 106
    invoke-direct {p0}, Lcom/android/internal/telephony/SmsMessageBase;-><init>()V

    .line 514
    return-void
.end method

.method public static calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 3
    .param p0, "msgBody"    # Ljava/lang/CharSequence;
    .param p1, "use7bitOnly"    # Z

    .prologue
    .line 1955
    invoke-static {p0, p1}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsLossyAuto(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v1

    .line 1956
    .local v1, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-nez v1, :cond_0

    .line 1957
    new-instance v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    .end local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    invoke-direct {v1}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 1958
    .restart local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    mul-int/lit8 v0, v2, 0x2

    .line 1959
    .local v0, "octets":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1960
    const/16 v2, 0x8c

    if-le v0, v2, :cond_1

    .line 1961
    add-int/lit16 v2, v0, 0x85

    div-int/lit16 v2, v2, 0x86

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 1963
    iget v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    mul-int/lit16 v2, v2, 0x86

    sub-int/2addr v2, v0

    div-int/lit8 v2, v2, 0x2

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1969
    :goto_0
    const/4 v2, 0x3

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 1971
    .end local v0    # "octets":I
    :cond_0
    return-object v1

    .line 1966
    .restart local v0    # "octets":I
    :cond_1
    const/4 v2, 0x1

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 1967
    rsub-int v2, v0, 0x8c

    div-int/lit8 v2, v2, 0x2

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    goto :goto_0
.end method

.method public static calculateLength(Ljava/lang/CharSequence;I)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 12
    .param p0, "msgBody"    # Ljava/lang/CharSequence;
    .param p1, "dataCodingScheme"    # I

    .prologue
    const/4 v9, 0x0

    .line 1595
    new-instance v1, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v1, p1, v10}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;-><init>(ILjava/lang/String;)V

    .line 1596
    .local v1, "dcs":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getEncodingType()I

    move-result v2

    .line 1598
    .local v2, "encodingType":I
    new-instance v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v6}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 1601
    .local v6, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    packed-switch v2, :pswitch_data_0

    .line 1630
    :try_start_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    mul-int/lit8 v4, v10, 0x2

    .line 1631
    .local v4, "octets":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1632
    const/16 v10, 0x8c

    const/16 v11, 0x86

    invoke-static {v6, v4, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .line 1633
    iget v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    div-int/lit8 v10, v10, 0x2

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1634
    const/4 v10, 0x3

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .end local v4    # "octets":I
    :goto_0
    move-object v9, v6

    .line 1645
    :goto_1
    return-object v9

    .line 1604
    :pswitch_0
    const/4 v10, 0x0

    invoke-static {p0, v10}, Lcom/android/internal/telephony/GsmAlphabet;->countGsmSeptets(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v7

    .line 1605
    .local v7, "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-nez v7, :cond_0

    .line 1606
    const-string v10, "calculateLength(), countGsmSeptets return is null"

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    .line 1637
    .end local v7    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :catch_0
    move-exception v3

    .line 1638
    .local v3, "ex":Ljava/io/UnsupportedEncodingException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "calculateLength(), encodingType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 1610
    .end local v3    # "ex":Ljava/io/UnsupportedEncodingException;
    .restart local v7    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    :try_start_1
    iget v5, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1612
    .local v5, "septets":I
    iput v5, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1613
    const/16 v10, 0xa0

    const/16 v11, 0x99

    invoke-static {v6, v5, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .line 1614
    const/4 v10, 0x1

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 1640
    .end local v5    # "septets":I
    .end local v7    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :catch_1
    move-exception v3

    .line 1641
    .local v3, "ex":Ljava/lang/RuntimeException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "calculateLength(), encodingType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 1620
    .end local v3    # "ex":Ljava/lang/RuntimeException;
    :pswitch_1
    :try_start_2
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "euc-kr"

    invoke-virtual {v10, v11}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v8

    .line 1621
    .local v8, "textPart":[B
    array-length v0, v8

    .line 1623
    .local v0, "byteCount":I
    iput v0, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1624
    const/16 v10, 0x8c

    const/16 v11, 0x86

    invoke-static {v6, v0, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .line 1625
    const/4 v10, 0x2

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I
    :try_end_2
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 1601
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static calculateLength(Ljava/lang/CharSequence;ZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 12
    .param p0, "msgBody"    # Ljava/lang/CharSequence;
    .param p1, "use7bitOnly"    # Z
    .param p2, "useUserInterface"    # Z

    .prologue
    .line 1504
    const/4 v10, 0x0

    const-string v11, "KREncodingScheme"

    invoke-static {v10, v11}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_5

    .line 1505
    new-instance v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v7}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 1507
    .local v7, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-nez p1, :cond_0

    const/4 v10, 0x1

    :goto_0
    :try_start_0
    invoke-static {p0, v10}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->countGsmSeptetsEx(Ljava/lang/CharSequence;Z)[I

    move-result-object v5

    .line 1508
    .local v5, "params":[I
    const/4 v10, 0x0

    aget v6, v5, v10

    .line 1511
    .local v6, "septets":I
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isCountCharIndexInsteadOfSeptets()Z

    move-result v10

    if-eqz v10, :cond_1

    .line 1512
    const/4 v10, 0x1

    aget v0, v5, v10

    .line 1513
    .local v0, "charindex":I
    sget v10, Landroid/telephony/LGSmsMessageImpl;->LIMIT_USER_DATA_SEPTETS:I

    if-le v6, v10, :cond_2

    .line 1514
    new-instance v10, Lcom/android/internal/telephony/EncodeException;

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v10
    :try_end_0
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1528
    .end local v0    # "charindex":I
    .end local v5    # "params":[I
    .end local v6    # "septets":I
    :catch_0
    move-exception v2

    .line 1529
    .local v2, "ex":Lcom/android/internal/telephony/EncodeException;
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isKSC5601Encoding()Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_3

    .line 1531
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1533
    .local v3, "message":Ljava/lang/String;
    :try_start_1
    const-string v10, "euc-kr"

    invoke-virtual {v3, v10}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v9

    .line 1551
    .local v9, "textPart":[B
    array-length v8, v9

    .line 1552
    .local v8, "textLen":I
    iput v8, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1554
    :try_start_2
    sget v10, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    sget v11, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    invoke-static {v7, v8, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_4

    move-result-object v7

    .line 1558
    :goto_1
    const/4 v10, 0x2

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 1581
    .end local v2    # "ex":Lcom/android/internal/telephony/EncodeException;
    .end local v3    # "message":Ljava/lang/String;
    .end local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v8    # "textLen":I
    .end local v9    # "textPart":[B
    :goto_2
    return-object v7

    .line 1507
    .restart local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    const/4 v10, 0x0

    goto :goto_0

    .line 1517
    .restart local v5    # "params":[I
    .restart local v6    # "septets":I
    :cond_1
    const/4 v10, 0x0

    :try_start_3
    aget v0, v5, v10

    .line 1521
    .restart local v0    # "charindex":I
    :cond_2
    iput v0, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I
    :try_end_3
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_3 .. :try_end_3} :catch_0

    .line 1524
    :try_start_4
    sget v10, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_SEPTETS_EX:I

    sget v11, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_SEPTETS_EX:I

    invoke-static {v7, v0, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_5
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_4 .. :try_end_4} :catch_0

    move-result-object v7

    .line 1527
    :goto_3
    const/4 v10, 0x1

    :try_start_5
    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I
    :try_end_5
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_5 .. :try_end_5} :catch_0

    goto :goto_2

    .line 1534
    .end local v0    # "charindex":I
    .end local v5    # "params":[I
    .end local v6    # "septets":I
    .restart local v2    # "ex":Lcom/android/internal/telephony/EncodeException;
    .restart local v3    # "message":Ljava/lang/String;
    :catch_1
    move-exception v1

    .line 1536
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    const-string v10, "calculateLength(), Implausible UnsupportedEncodingException "

    invoke-static {v10, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1537
    const/4 v10, 0x0

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 1538
    const/4 v10, 0x0

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1539
    const/4 v10, 0x0

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1540
    const/4 v10, 0x1

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    goto :goto_2

    .line 1542
    .end local v1    # "e":Ljava/io/UnsupportedEncodingException;
    :catch_2
    move-exception v1

    .line 1543
    .local v1, "e":Ljava/lang/RuntimeException;
    const-string v10, "calculateLength(), Implausible RuntimeException "

    invoke-static {v10, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1544
    const/4 v10, 0x0

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 1545
    const/4 v10, 0x0

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1546
    const/4 v10, 0x0

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1547
    const/4 v10, 0x1

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    goto :goto_2

    .line 1560
    .end local v1    # "e":Ljava/lang/RuntimeException;
    .end local v3    # "message":Ljava/lang/String;
    :cond_3
    new-instance v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    .end local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    invoke-direct {v7}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 1562
    .restart local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    const/4 v10, 0x0

    :try_start_6
    const-string v11, "countLengthBytes"

    invoke-static {v10, v11}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_4

    .line 1563
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    mul-int/lit8 v4, v10, 0x2

    .line 1564
    .local v4, "octets":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    mul-int/lit8 v10, v10, 0x2

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1565
    sget v10, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    sget v11, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    invoke-static {v7, v4, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_3

    move-result-object v7

    .line 1576
    .end local v4    # "octets":I
    :goto_4
    const/4 v10, 0x3

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    goto :goto_2

    .line 1567
    :cond_4
    :try_start_7
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    mul-int/lit8 v4, v10, 0x2

    .line 1568
    .restart local v4    # "octets":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1569
    const/16 v10, 0x8c

    sget v11, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    invoke-static {v7, v4, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v7

    .line 1570
    iget v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    div-int/lit8 v10, v10, 0x2

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I
    :try_end_7
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_3

    goto :goto_4

    .line 1572
    .end local v4    # "octets":I
    :catch_3
    move-exception v10

    goto :goto_4

    .line 1581
    .end local v2    # "ex":Lcom/android/internal/telephony/EncodeException;
    .end local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_5
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->calculateLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v7

    goto/16 :goto_2

    .line 1555
    .restart local v2    # "ex":Lcom/android/internal/telephony/EncodeException;
    .restart local v3    # "message":Ljava/lang/String;
    .restart local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .restart local v8    # "textLen":I
    .restart local v9    # "textPart":[B
    :catch_4
    move-exception v10

    goto/16 :goto_1

    .line 1525
    .end local v2    # "ex":Lcom/android/internal/telephony/EncodeException;
    .end local v3    # "message":Ljava/lang/String;
    .end local v8    # "textLen":I
    .end local v9    # "textPart":[B
    .restart local v0    # "charindex":I
    .restart local v5    # "params":[I
    .restart local v6    # "septets":I
    :catch_5
    move-exception v10

    goto :goto_3
.end method

.method public static calculateLengthHeaderEx(Ljava/lang/CharSequence;IZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 12
    .param p0, "msgBody"    # Ljava/lang/CharSequence;
    .param p1, "dataCodingScheme"    # I
    .param p2, "bReplyAddress"    # Z
    .param p3, "bSafeSMS"    # Z

    .prologue
    .line 1721
    new-instance v1, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v1, p1, v10}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;-><init>(ILjava/lang/String;)V

    .line 1722
    .local v1, "dcs":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getEncodingType()I

    move-result v3

    .line 1724
    .local v3, "encodingType":I
    new-instance v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v7}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 1727
    .local v7, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    packed-switch v3, :pswitch_data_0

    .line 1754
    :try_start_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    mul-int/lit8 v5, v10, 0x2

    .line 1755
    .local v5, "octets":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1756
    const/4 v10, 0x3

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 1757
    invoke-static {v7, v5, p2, p3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateTedForEncoding(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;IZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    .line 1758
    iget v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    div-int/lit8 v10, v10, 0x2

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1770
    .end local v5    # "octets":I
    .end local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_0
    return-object v7

    .line 1730
    .restart local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :pswitch_0
    const/4 v10, 0x0

    invoke-static {p0, v10}, Lcom/android/internal/telephony/GsmAlphabet;->countGsmSeptets(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v8

    .line 1732
    .local v8, "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-nez v8, :cond_0

    .line 1733
    const-string v10, "calculateLengthHeaderEx(), countGsmSeptets return is null"

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1734
    const/4 v7, 0x0

    goto :goto_0

    .line 1737
    :cond_0
    iget v6, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1738
    .local v6, "septets":I
    iput v6, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1739
    const/4 v10, 0x1

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 1740
    invoke-static {v7, v6, p2, p3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateTedForEncoding(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;IZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 1762
    .end local v6    # "septets":I
    .end local v8    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :catch_0
    move-exception v4

    .line 1763
    .local v4, "ex":Ljava/io/UnsupportedEncodingException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "calculateLengthHeaderEx(), encodingType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1764
    const/4 v7, 0x0

    goto :goto_0

    .line 1745
    .end local v4    # "ex":Ljava/io/UnsupportedEncodingException;
    :pswitch_1
    :try_start_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "euc-kr"

    invoke-virtual {v10, v11}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v9

    .line 1746
    .local v9, "textPart":[B
    array-length v0, v9

    .line 1747
    .local v0, "byteCount":I
    iput v0, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1748
    const/4 v10, 0x2

    iput v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 1749
    invoke-static {v7, v0, p2, p3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateTedForEncoding(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;IZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 1765
    .end local v0    # "byteCount":I
    .end local v9    # "textPart":[B
    :catch_1
    move-exception v2

    .line 1766
    .local v2, "e":Ljava/lang/RuntimeException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "calculateLengthHeaderEx(), encodingType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1767
    const/4 v7, 0x0

    goto :goto_0

    .line 1727
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static calculateLengthHeaderReplyaddressEx(Ljava/lang/CharSequence;I)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 12
    .param p0, "msgBody"    # Ljava/lang/CharSequence;
    .param p1, "dataCodingScheme"    # I

    .prologue
    const/4 v9, 0x0

    .line 1658
    new-instance v1, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v1, p1, v10}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;-><init>(ILjava/lang/String;)V

    .line 1659
    .local v1, "dcs":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getEncodingType()I

    move-result v2

    .line 1661
    .local v2, "encodingType":I
    new-instance v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v6}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 1664
    .local v6, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    packed-switch v2, :pswitch_data_0

    .line 1691
    :try_start_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    mul-int/lit8 v4, v10, 0x2

    .line 1692
    .local v4, "octets":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1693
    const/16 v10, 0x7d

    const/16 v11, 0x7d

    invoke-static {v6, v4, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .line 1694
    iget v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    div-int/lit8 v10, v10, 0x2

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1695
    const/4 v10, 0x3

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .end local v4    # "octets":I
    :goto_0
    move-object v9, v6

    .line 1707
    :goto_1
    return-object v9

    .line 1667
    :pswitch_0
    const/4 v10, 0x0

    invoke-static {p0, v10}, Lcom/android/internal/telephony/GsmAlphabet;->countGsmSeptets(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v7

    .line 1669
    .local v7, "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-nez v7, :cond_0

    .line 1670
    const-string v10, "calculateLengthHeaderReplyaddressEx(), countGsmSeptets return is null"

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    .line 1699
    .end local v7    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :catch_0
    move-exception v3

    .line 1700
    .local v3, "ex":Ljava/io/UnsupportedEncodingException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "calculateLengthHeaderReplyaddressEx(), encodingType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 1674
    .end local v3    # "ex":Ljava/io/UnsupportedEncodingException;
    .restart local v7    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    :try_start_1
    iget v5, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1676
    .local v5, "septets":I
    iput v5, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1677
    const/16 v10, 0x8e

    const/16 v11, 0x8e

    invoke-static {v6, v5, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .line 1678
    const/4 v10, 0x1

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 1702
    .end local v5    # "septets":I
    .end local v7    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :catch_1
    move-exception v3

    .line 1703
    .local v3, "ex":Ljava/lang/RuntimeException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "calculateLengthHeaderReplyaddressEx(), encodingType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 1682
    .end local v3    # "ex":Ljava/lang/RuntimeException;
    :pswitch_1
    :try_start_2
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "euc-kr"

    invoke-virtual {v10, v11}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v8

    .line 1683
    .local v8, "textPart":[B
    array-length v0, v8

    .line 1685
    .local v0, "byteCount":I
    iput v0, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 1686
    const/16 v10, 0x7d

    const/16 v11, 0x7d

    invoke-static {v6, v0, v10, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .line 1687
    const/4 v10, 0x2

    iput v10, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I
    :try_end_2
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 1664
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 2
    .param p0, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .param p1, "codeUnitCount"    # I
    .param p2, "maxUserData"    # I
    .param p3, "maxUserDataWithHeader"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/RuntimeException;
        }
    .end annotation

    .prologue
    .line 1805
    if-le p1, p2, :cond_0

    .line 1806
    :try_start_0
    div-int v1, p1, p3

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 1807
    rem-int v1, p1, p3

    sub-int v1, p3, v1

    iput v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 1816
    :goto_0
    return-object p0

    .line 1809
    :cond_0
    const/4 v1, 0x1

    iput v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 1810
    sub-int v1, p2, p1

    iput v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1813
    :catch_0
    move-exception v0

    .line 1814
    .local v0, "ex":Ljava/lang/RuntimeException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1}, Ljava/lang/RuntimeException;-><init>()V

    throw v1
.end method

.method private static calculateTedForEncoding(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;IZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 4
    .param p0, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .param p1, "size"    # I
    .param p2, "bReplyAddress"    # Z
    .param p3, "bSafeSMS"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/RuntimeException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x1

    .line 1783
    if-eqz p3, :cond_5

    .line 1784
    if-eqz p2, :cond_2

    .line 1785
    :try_start_0
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_0

    const/16 v1, 0x8b

    move v2, v1

    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_1

    const/16 v1, 0x85

    :goto_1
    invoke-static {p0, p1, v2, v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object p0

    .line 1798
    :goto_2
    return-object p0

    .line 1785
    :cond_0
    const/16 v1, 0x7a

    move v2, v1

    goto :goto_0

    :cond_1
    const/16 v1, 0x75

    goto :goto_1

    .line 1787
    :cond_2
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_3

    const/16 v1, 0x9b

    move v2, v1

    :goto_3
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_4

    const/16 v1, 0x95

    :goto_4
    invoke-static {p0, p1, v2, v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object p0

    goto :goto_2

    :cond_3
    const/16 v1, 0x88

    move v2, v1

    goto :goto_3

    :cond_4
    const/16 v1, 0x83

    goto :goto_4

    .line 1789
    :cond_5
    if-eqz p2, :cond_8

    .line 1790
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_6

    const/16 v1, 0x8e

    move v2, v1

    :goto_5
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_7

    const/16 v1, 0x89

    :goto_6
    invoke-static {p0, p1, v2, v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object p0

    goto :goto_2

    :cond_6
    const/16 v1, 0x7d

    move v2, v1

    goto :goto_5

    :cond_7
    const/16 v1, 0x78

    goto :goto_6

    .line 1792
    :cond_8
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_9

    const/16 v1, 0xa0

    move v2, v1

    :goto_7
    iget v1, p0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_a

    const/16 v1, 0x99

    :goto_8
    invoke-static {p0, p1, v2, v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateMsgCountCodeUnitsRemaining(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;III)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object p0

    goto :goto_2

    :cond_9
    sget v1, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move v2, v1

    goto :goto_7

    :cond_a
    const/16 v1, 0x86

    goto :goto_8

    .line 1794
    :catch_0
    move-exception v0

    .line 1795
    .local v0, "ex":Ljava/lang/RuntimeException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1}, Ljava/lang/RuntimeException;-><init>()V

    throw v1
.end method

.method public static cdmaIntTobcdByte(I)B
    .locals 3
    .param p0, "i"    # I

    .prologue
    .line 2091
    const/4 v0, 0x0

    .line 2094
    .local v0, "ret":B
    rem-int/lit8 v1, p0, 0xa

    div-int/lit8 v2, p0, 0xa

    shl-int/lit8 v2, v2, 0x4

    add-int/2addr v1, v2

    int-to-byte v0, v1

    .line 2096
    and-int/lit8 v1, v0, 0xf

    and-int/lit16 v2, v0, 0xf0

    or-int/2addr v1, v2

    int-to-byte v0, v1

    .line 2098
    return v0
.end method

.method public static countGsmSeptetsEx(Ljava/lang/CharSequence;Z)[I
    .locals 5
    .param p0, "s"    # Ljava/lang/CharSequence;
    .param p1, "throwsException"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/EncodeException;
        }
    .end annotation

    .prologue
    .line 1474
    const/4 v4, 0x2

    new-array v2, v4, [I

    .line 1476
    .local v2, "ret":[I
    const/4 v0, 0x0

    .line 1477
    .local v0, "charIndex":I
    const/4 v3, 0x0

    .line 1478
    .local v3, "sz":I
    const/4 v1, 0x0

    .line 1480
    .local v1, "count":I
    if-eqz p0, :cond_0

    .line 1481
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 1484
    :cond_0
    :goto_0
    if-ge v0, v3, :cond_1

    .line 1485
    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    invoke-static {v4, p1}, Lcom/android/internal/telephony/GsmAlphabet;->countGsmSeptets(CZ)I

    move-result v4

    add-int/2addr v1, v4

    .line 1486
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1488
    :cond_1
    const/4 v4, 0x0

    aput v1, v2, v4

    .line 1489
    const/4 v4, 0x1

    aput v0, v2, v4

    .line 1490
    return-object v2
.end method

.method public static createDataCodingScheme(Lcom/android/internal/telephony/SmsConstants$MessageClass;ZIIZI)B
    .locals 3
    .param p0, "messageclass"    # Lcom/android/internal/telephony/SmsConstants$MessageClass;
    .param p1, "isCompressed"    # Z
    .param p2, "encodingtype"    # I
    .param p3, "msgwatingtype"    # I
    .param p4, "msgwaitingactive"    # Z
    .param p5, "msgwaitingkind"    # I

    .prologue
    .line 896
    const/4 v1, 0x1

    if-ne p1, v1, :cond_2

    .line 897
    const/16 v0, 0x20

    .line 902
    .local v0, "data":B
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDataCodingScheme(), data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " for bit 5"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 903
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDataCodingScheme(), encodingtype = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 906
    sget-object v1, Lcom/android/internal/telephony/SmsConstants$MessageClass;->UNKNOWN:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-eq p0, v1, :cond_3

    .line 907
    or-int/lit8 v1, v0, 0x10

    int-to-byte v0, v1

    .line 912
    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDataCodingScheme(), data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " for bit 4"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 915
    if-eqz p2, :cond_0

    .line 916
    add-int/lit8 v1, p2, -0x1

    shl-int/lit8 v1, v1, 0x2

    or-int/2addr v1, v0

    int-to-byte v0, v1

    .line 919
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDataCodingScheme(), data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " for bit 3-2"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 922
    sget-object v1, Lcom/android/internal/telephony/SmsConstants$MessageClass;->CLASS_0:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-ne p0, v1, :cond_4

    .line 923
    or-int/lit8 v1, v0, 0x0

    int-to-byte v0, v1

    .line 932
    :cond_1
    :goto_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDataCodingScheme(), data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " for bit 1-0"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 934
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDataCodingScheme(), data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 936
    return v0

    .line 899
    .end local v0    # "data":B
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "data":B
    goto/16 :goto_0

    .line 909
    :cond_3
    or-int/lit8 v1, v0, 0x0

    int-to-byte v0, v1

    goto :goto_1

    .line 924
    :cond_4
    sget-object v1, Lcom/android/internal/telephony/SmsConstants$MessageClass;->CLASS_1:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-ne p0, v1, :cond_5

    .line 925
    or-int/lit8 v1, v0, 0x1

    int-to-byte v0, v1

    goto :goto_2

    .line 926
    :cond_5
    sget-object v1, Lcom/android/internal/telephony/SmsConstants$MessageClass;->CLASS_2:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-ne p0, v1, :cond_6

    .line 927
    or-int/lit8 v1, v0, 0x2

    int-to-byte v0, v1

    goto :goto_2

    .line 928
    :cond_6
    sget-object v1, Lcom/android/internal/telephony/SmsConstants$MessageClass;->CLASS_3:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-ne p0, v1, :cond_1

    .line 929
    or-int/lit8 v1, v0, 0x3

    int-to-byte v0, v1

    goto :goto_2
.end method

.method private static encodeKR(Ljava/lang/String;[B)[B
    .locals 7
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "header"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 690
    const-string v3, "euc-kr"

    invoke-virtual {p0, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    .line 693
    .local v1, "textPart":[B
    const/4 v3, 0x0

    const-string v4, "lgu_gsm_submit_encoding_type"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 694
    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "LGU"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 695
    const-string v3, "ksc5601"

    invoke-virtual {p0, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    .line 700
    :cond_0
    if-eqz p1, :cond_1

    .line 702
    array-length v3, p1

    array-length v4, v1

    add-int/2addr v3, v4

    add-int/lit8 v3, v3, 0x1

    new-array v2, v3, [B

    .line 704
    .local v2, "userData":[B
    array-length v3, p1

    int-to-byte v3, v3

    aput-byte v3, v2, v5

    .line 705
    array-length v3, p1

    invoke-static {p1, v5, v2, v6, v3}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 706
    array-length v3, p1

    add-int/lit8 v3, v3, 0x1

    array-length v4, v1

    invoke-static {v1, v5, v2, v3, v4}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 711
    :goto_0
    array-length v3, v2

    add-int/lit8 v3, v3, 0x1

    new-array v0, v3, [B

    .line 712
    .local v0, "ret":[B
    array-length v3, v2

    and-int/lit16 v3, v3, 0xff

    int-to-byte v3, v3

    aput-byte v3, v0, v5

    .line 713
    array-length v3, v2

    invoke-static {v2, v5, v0, v6, v3}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 714
    return-object v0

    .line 709
    .end local v0    # "ret":[B
    .end local v2    # "userData":[B
    :cond_1
    move-object v2, v1

    .restart local v2    # "userData":[B
    goto :goto_0
.end method

.method private static encodeUCS(Ljava/lang/String;[BLjava/io/ByteArrayOutputStream;J)Ljava/io/ByteArrayOutputStream;
    .locals 7
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "header"    # [B
    .param p2, "byteoutput"    # Ljava/io/ByteArrayOutputStream;
    .param p3, "time"    # J

    .prologue
    const/4 v3, 0x0

    const/4 v6, 0x0

    .line 1097
    :try_start_0
    const-string v4, "utf-16be"

    invoke-virtual {p0, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1103
    .local v0, "textPart":[B
    if-eqz p1, :cond_0

    .line 1104
    array-length v4, p1

    array-length v5, v0

    add-int/2addr v4, v5

    new-array v2, v4, [B

    .line 1105
    .local v2, "userData":[B
    array-length v4, p1

    invoke-static {p1, v6, v2, v6, v4}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 1106
    array-length v4, p1

    array-length v5, v0

    invoke-static {v0, v6, v2, v4, v5}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 1112
    :goto_0
    array-length v4, v2

    const/16 v5, 0x8c

    if-le v4, v5, :cond_1

    move-object p2, v3

    .line 1131
    .end local v0    # "textPart":[B
    .end local v2    # "userData":[B
    .end local p2    # "byteoutput":Ljava/io/ByteArrayOutputStream;
    :goto_1
    return-object p2

    .line 1098
    .restart local p2    # "byteoutput":Ljava/io/ByteArrayOutputStream;
    :catch_0
    move-exception v1

    .line 1099
    .local v1, "uex":Ljava/io/UnsupportedEncodingException;
    const-string v4, "getDeliverPdu(), Implausible UnsupportedEncodingException "

    invoke-static {v4, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object p2, v3

    .line 1100
    goto :goto_1

    .line 1108
    .end local v1    # "uex":Ljava/io/UnsupportedEncodingException;
    .restart local v0    # "textPart":[B
    :cond_0
    move-object v2, v0

    .restart local v2    # "userData":[B
    goto :goto_0

    .line 1118
    :cond_1
    const/16 v3, 0x8

    invoke-virtual {p2, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1121
    invoke-static {p3, p4, p2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPduSCTS(JLjava/io/ByteArrayOutputStream;)Ljava/io/ByteArrayOutputStream;

    .line 1124
    if-eqz p1, :cond_2

    .line 1125
    array-length v3, v2

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {p2, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1126
    array-length v3, p1

    invoke-virtual {p2, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1130
    :goto_2
    array-length v3, v2

    invoke-virtual {p2, v2, v6, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1

    .line 1128
    :cond_2
    array-length v3, v2

    invoke-virtual {p2, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    goto :goto_2
.end method

.method public static getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    .locals 10
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "originatorAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "time"    # J
    .param p6, "header"    # [B
    .param p7, "encodingtype"    # I

    .prologue
    .line 1023
    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move-wide v4, p4

    move-object/from16 v6, p6

    move/from16 v7, p7

    invoke-static/range {v0 .. v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BIII)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    move-result-object v0

    return-object v0
.end method

.method public static getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BIII)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    .locals 12
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "originatorAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "time"    # J
    .param p6, "header"    # [B
    .param p7, "encodingtype"    # I
    .param p8, "languageTable"    # I
    .param p9, "languageShiftTable"    # I

    .prologue
    .line 1040
    if-eqz p2, :cond_0

    if-nez p1, :cond_1

    .line 1041
    :cond_0
    const/4 v6, 0x0

    .line 1086
    :goto_0
    return-object v6

    .line 1044
    :cond_1
    new-instance v6, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    invoke-direct {v6}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;-><init>()V

    .line 1047
    .local v6, "ret":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    if-eqz p6, :cond_2

    const/16 v8, 0x40

    :goto_1
    or-int/lit8 v8, v8, 0x0

    int-to-byte v5, v8

    .line 1049
    .local v5, "mtiByte":B
    invoke-static {p0, p1, v5, p3, v6}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPduHead(Ljava/lang/String;Ljava/lang/String;BZLcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;)Ljava/io/ByteArrayOutputStream;

    move-result-object v3

    .line 1052
    .local v3, "bo":Ljava/io/ByteArrayOutputStream;
    const/4 v8, 0x1

    move/from16 v0, p7

    if-ne v0, v8, :cond_6

    .line 1055
    :try_start_0
    move-object/from16 v0, p6

    move/from16 v1, p8

    move/from16 v2, p9

    invoke-static {p2, v0, v1, v2}, Lcom/android/internal/telephony/GsmAlphabet;->stringToGsm7BitPackedWithHeader(Ljava/lang/String;[BII)[B

    move-result-object v7

    .line 1057
    .local v7, "userData":[B
    move/from16 v0, p7

    invoke-static {v0, v7}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isMessageTooLong(I[B)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 1058
    const/4 v6, 0x0

    goto :goto_0

    .line 1047
    .end local v3    # "bo":Ljava/io/ByteArrayOutputStream;
    .end local v5    # "mtiByte":B
    .end local v7    # "userData":[B
    :cond_2
    const/4 v8, 0x0

    goto :goto_1

    .line 1063
    .restart local v3    # "bo":Ljava/io/ByteArrayOutputStream;
    .restart local v5    # "mtiByte":B
    .restart local v7    # "userData":[B
    :cond_3
    const/4 v8, 0x0

    invoke-virtual {v3, v8}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1067
    const/4 v8, 0x0

    const-string v9, "dcm_copytosim_localtimezone"

    invoke-static {v8, v9}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 1068
    move-wide/from16 v0, p4

    invoke-static {v0, v1, v3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPduSCTS_TimeZone(JLjava/io/ByteArrayOutputStream;)V

    .line 1073
    :goto_2
    const/4 v8, 0x0

    array-length v9, v7

    invoke-virtual {v3, v7, v8, v9}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_0
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1085
    .end local v7    # "userData":[B
    :cond_4
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v8

    iput-object v8, v6, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;->encodedMessage:[B

    goto :goto_0

    .line 1071
    .restart local v7    # "userData":[B
    :cond_5
    :try_start_1
    move-wide/from16 v0, p4

    invoke-static {v0, v1, v3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPduSCTS(JLjava/io/ByteArrayOutputStream;)Ljava/io/ByteArrayOutputStream;
    :try_end_1
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 1074
    .end local v7    # "userData":[B
    :catch_0
    move-exception v4

    .line 1075
    .local v4, "ex":Lcom/android/internal/telephony/EncodeException;
    move-object/from16 v0, p6

    move-wide/from16 v1, p4

    invoke-static {p2, v0, v3, v1, v2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->encodeUCS(Ljava/lang/String;[BLjava/io/ByteArrayOutputStream;J)Ljava/io/ByteArrayOutputStream;

    move-result-object v8

    if-nez v8, :cond_4

    .line 1076
    const/4 v6, 0x0

    goto :goto_0

    .line 1081
    .end local v4    # "ex":Lcom/android/internal/telephony/EncodeException;
    :cond_6
    move-object/from16 v0, p6

    move-wide/from16 v1, p4

    invoke-static {p2, v0, v3, v1, v2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->encodeUCS(Ljava/lang/String;[BLjava/io/ByteArrayOutputStream;J)Ljava/io/ByteArrayOutputStream;

    move-result-object v8

    if-nez v8, :cond_4

    .line 1082
    const/4 v6, 0x0

    goto :goto_0
.end method

.method private static getDeliverPduHead(Ljava/lang/String;Ljava/lang/String;BZILcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;)Ljava/io/ByteArrayOutputStream;
    .locals 6
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "originationAddress"    # Ljava/lang/String;
    .param p2, "mtiByte"    # B
    .param p3, "statusReportRequested"    # Z
    .param p4, "protocolId"    # I
    .param p5, "ret"    # Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    .prologue
    const/4 v3, 0x0

    .line 1419
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v2, 0xb4

    invoke-direct {v0, v2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1423
    .local v0, "bo":Ljava/io/ByteArrayOutputStream;
    if-nez p0, :cond_1

    .line 1424
    const/4 v2, 0x0

    iput-object v2, p5, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;->encodedScAddress:[B

    .line 1431
    :goto_0
    if-eqz p3, :cond_0

    .line 1433
    or-int/lit8 v2, p2, 0x20

    int-to-byte p2, v2

    .line 1434
    const-string v2, "getDeliverPduHead(), SMS status report requested"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1436
    :cond_0
    invoke-virtual {v0, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1440
    invoke-static {p1}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsnetworkPortionToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v1

    .line 1442
    .local v1, "daBytes":[B
    if-nez v1, :cond_2

    .line 1443
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1444
    const/16 v2, 0x81

    invoke-virtual {v0, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1457
    :goto_1
    invoke-virtual {v0, p4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1458
    return-object v0

    .line 1426
    .end local v1    # "daBytes":[B
    :cond_1
    invoke-static {p0}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCDWithLength(Ljava/lang/String;)[B

    move-result-object v2

    iput-object v2, p5, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;->encodedScAddress:[B

    goto :goto_0

    .line 1449
    .restart local v1    # "daBytes":[B
    :cond_2
    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    mul-int/lit8 v4, v2, 0x2

    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xf0

    const/16 v5, 0xf0

    if-ne v2, v5, :cond_3

    const/4 v2, 0x1

    :goto_2
    sub-int v2, v4, v2

    invoke-virtual {v0, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1453
    array-length v2, v1

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1

    :cond_3
    move v2, v3

    .line 1449
    goto :goto_2
.end method

.method private static getDeliverPduHead(Ljava/lang/String;Ljava/lang/String;BZLcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;)Ljava/io/ByteArrayOutputStream;
    .locals 10
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "originatorAddress"    # Ljava/lang/String;
    .param p2, "mtiByte"    # B
    .param p3, "statusReportRequested"    # Z
    .param p4, "ret"    # Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    .prologue
    const/4 v5, 0x1

    const/4 v6, 0x0

    .line 1179
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v7, 0xb4

    invoke-direct {v0, v7}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1182
    .local v0, "bo":Ljava/io/ByteArrayOutputStream;
    if-nez p0, :cond_2

    .line 1183
    const/4 v7, 0x0

    iput-object v7, p4, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;->encodedScAddress:[B

    .line 1189
    :goto_0
    if-eqz p3, :cond_0

    .line 1191
    or-int/lit8 v7, p2, 0x20

    int-to-byte p2, v7

    .line 1192
    const-string v7, "getDeliverPduHead(), SMS status report requested"

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    .line 1194
    :cond_0
    invoke-virtual {v0, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1197
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v3

    .line 1200
    .local v3, "oaBytes":[B
    if-nez v3, :cond_3

    .line 1201
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 1204
    const/4 v5, 0x0

    const/4 v7, 0x0

    :try_start_0
    invoke-static {p1, v5, v7}, Lcom/android/internal/telephony/GsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;II)[B

    move-result-object v2

    .line 1206
    .local v2, "gsm7BitPackedAddress":[B
    array-length v5, v2

    add-int/lit8 v5, v5, -0x1

    new-array v4, v5, [B

    .line 1207
    .local v4, "readGsm7BitPackedAddress":[B
    const/4 v5, 0x1

    const/4 v7, 0x0

    array-length v8, v2

    add-int/lit8 v8, v8, -0x1

    invoke-static {v2, v5, v4, v7, v8}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 1209
    array-length v5, v4

    mul-int/lit8 v5, v5, 0x2

    invoke-virtual {v0, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1210
    const/16 v5, 0xd0

    invoke-virtual {v0, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1211
    const/4 v5, 0x0

    array-length v7, v4

    invoke-virtual {v0, v4, v5, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_0
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1227
    .end local v2    # "gsm7BitPackedAddress":[B
    .end local v4    # "readGsm7BitPackedAddress":[B
    :cond_1
    :goto_1
    invoke-virtual {v0, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1228
    return-object v0

    .line 1185
    .end local v3    # "oaBytes":[B
    :cond_2
    invoke-static {p0}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCDWithLength(Ljava/lang/String;)[B

    move-result-object v7

    iput-object v7, p4, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;->encodedScAddress:[B

    goto :goto_0

    .line 1212
    .restart local v3    # "oaBytes":[B
    :catch_0
    move-exception v1

    .line 1213
    .local v1, "e":Lcom/android/internal/telephony/EncodeException;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getDeliverPduHead(), "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v1}, Lcom/android/internal/telephony/EncodeException;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 1219
    .end local v1    # "e":Lcom/android/internal/telephony/EncodeException;
    :cond_3
    array-length v7, v3

    add-int/lit8 v7, v7, -0x1

    mul-int/lit8 v7, v7, 0x2

    array-length v8, v3

    add-int/lit8 v8, v8, -0x1

    aget-byte v8, v3, v8

    and-int/lit16 v8, v8, 0xf0

    const/16 v9, 0xf0

    if-ne v8, v9, :cond_4

    :goto_2
    sub-int v5, v7, v5

    invoke-virtual {v0, v5}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1223
    array-length v5, v3

    invoke-virtual {v0, v3, v6, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1

    :cond_4
    move v5, v6

    .line 1219
    goto :goto_2
.end method

.method private static getDeliverPduSCTS(JLjava/io/ByteArrayOutputStream;)Ljava/io/ByteArrayOutputStream;
    .locals 12
    .param p0, "msgtime"    # J
    .param p2, "byteoutput"    # Ljava/io/ByteArrayOutputStream;

    .prologue
    .line 1147
    new-instance v5, Landroid/text/format/Time;

    const-string v9, "UTC"

    invoke-direct {v5, v9}, Landroid/text/format/Time;-><init>(Ljava/lang/String;)V

    .line 1148
    .local v5, "sctstime":Landroid/text/format/Time;
    invoke-virtual {v5, p0, p1}, Landroid/text/format/Time;->set(J)V

    .line 1150
    iget v9, v5, Landroid/text/format/Time;->year:I

    const/16 v10, 0x7d0

    if-lt v9, v10, :cond_0

    iget v9, v5, Landroid/text/format/Time;->year:I

    add-int/lit16 v7, v9, -0x7d0

    .line 1151
    .local v7, "year":I
    :goto_0
    iget v9, v5, Landroid/text/format/Time;->month:I

    add-int/lit8 v3, v9, 0x1

    .line 1155
    .local v3, "month":I
    invoke-static {v7}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v8

    .line 1156
    .local v8, "yearByte":B
    invoke-static {v3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    .line 1157
    .local v4, "monthByte":B
    iget v9, v5, Landroid/text/format/Time;->monthDay:I

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v0

    .line 1158
    .local v0, "dayByte":B
    iget v9, v5, Landroid/text/format/Time;->hour:I

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v1

    .line 1159
    .local v1, "hourByte":B
    iget v9, v5, Landroid/text/format/Time;->minute:I

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v2

    .line 1160
    .local v2, "minuteByte":B
    iget v9, v5, Landroid/text/format/Time;->second:I

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v6

    .line 1164
    .local v6, "secondByte":B
    invoke-virtual {p2, v8}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1165
    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1166
    invoke-virtual {p2, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1167
    invoke-virtual {p2, v1}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1168
    invoke-virtual {p2, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1169
    invoke-virtual {p2, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1170
    const/4 v9, 0x0

    invoke-virtual {p2, v9}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1172
    return-object p2

    .line 1150
    .end local v0    # "dayByte":B
    .end local v1    # "hourByte":B
    .end local v2    # "minuteByte":B
    .end local v3    # "month":I
    .end local v4    # "monthByte":B
    .end local v6    # "secondByte":B
    .end local v7    # "year":I
    .end local v8    # "yearByte":B
    :cond_0
    iget v9, v5, Landroid/text/format/Time;->year:I

    add-int/lit16 v7, v9, -0x76c

    goto :goto_0
.end method

.method private static getDeliverPduSCTS_TimeZone(JLjava/io/ByteArrayOutputStream;)V
    .locals 6
    .param p0, "msgtime"    # J
    .param p2, "outStream"    # Ljava/io/ByteArrayOutputStream;

    .prologue
    .line 1382
    new-instance v2, Landroid/text/format/Time;

    invoke-direct {v2}, Landroid/text/format/Time;-><init>()V

    .line 1383
    .local v2, "sctstime":Landroid/text/format/Time;
    invoke-virtual {v2, p0, p1}, Landroid/text/format/Time;->set(J)V

    .line 1384
    iget-object v4, v2, Landroid/text/format/Time;->timezone:Ljava/lang/String;

    invoke-static {v4}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v0

    .line 1386
    .local v0, "mMyTimeZone":Ljava/util/TimeZone;
    iget v4, v2, Landroid/text/format/Time;->year:I

    const/16 v5, 0x7d0

    if-lt v4, v5, :cond_0

    iget v4, v2, Landroid/text/format/Time;->year:I

    add-int/lit16 v3, v4, -0x7d0

    .line 1388
    .local v3, "year":I
    :goto_0
    iget v4, v2, Landroid/text/format/Time;->month:I

    add-int/lit8 v1, v4, 0x1

    .line 1392
    .local v1, "month":I
    invoke-static {v3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1393
    invoke-static {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1394
    iget v4, v2, Landroid/text/format/Time;->monthDay:I

    invoke-static {v4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1395
    iget v4, v2, Landroid/text/format/Time;->hour:I

    invoke-static {v4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1396
    iget v4, v2, Landroid/text/format/Time;->minute:I

    invoke-static {v4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1397
    iget v4, v2, Landroid/text/format/Time;->second:I

    invoke-static {v4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1398
    invoke-virtual {v0}, Ljava/util/TimeZone;->getRawOffset()I

    move-result v4

    const v5, 0x36ee80

    div-int/2addr v4, v5

    mul-int/lit8 v4, v4, 0x4

    invoke-static {v4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->gsmIntTobcdByte(I)B

    move-result v4

    invoke-virtual {p2, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1399
    return-void

    .line 1386
    .end local v1    # "month":I
    .end local v3    # "year":I
    :cond_0
    iget v4, v2, Landroid/text/format/Time;->year:I

    add-int/lit16 v3, v4, -0x76c

    goto :goto_0
.end method

.method static getEncodingTypeByDataCodingScheme(II)I
    .locals 2
    .param p0, "mDataCodingScheme"    # I
    .param p1, "dataCodingScheme_byte"    # I

    .prologue
    .line 1990
    const/4 v0, 0x0

    .line 1992
    .local v0, "encodingType":I
    const/16 v1, 0x80

    if-eq p1, v1, :cond_0

    const/16 v1, 0x90

    if-ne p1, v1, :cond_2

    .line 1993
    :cond_0
    shr-int/lit8 v1, p0, 0x2

    and-int/lit8 v1, v1, 0x3

    packed-switch v1, :pswitch_data_0

    .line 2007
    :cond_1
    :goto_0
    return v0

    .line 1997
    :pswitch_0
    const/4 v0, 0x1

    .line 1998
    goto :goto_0

    .line 2000
    :pswitch_1
    const/4 v0, 0x2

    goto :goto_0

    .line 2003
    :cond_2
    const/16 v1, 0xa0

    if-eq p1, v1, :cond_3

    const/16 v1, 0xb0

    if-ne p1, v1, :cond_1

    .line 2004
    :cond_3
    const/4 v0, 0x1

    goto :goto_0

    .line 1993
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static getMessageBodyBySimInfo(Lcom/android/internal/telephony/gsm/SmsMessage$PduParser;I)Ljava/lang/String;
    .locals 6
    .param p0, "p"    # Lcom/android/internal/telephony/gsm/SmsMessage$PduParser;
    .param p1, "count"    # I

    .prologue
    const/4 v5, 0x0

    .line 2014
    const/4 v0, 0x0

    .line 2015
    .local v0, "mMessageBody":Ljava/lang/String;
    const/4 v2, 0x0

    .line 2016
    .local v2, "mccCode":Ljava/lang/String;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v1

    .line 2017
    .local v1, "mSimOperator":Ljava/lang/String;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x5

    if-lt v3, v4, :cond_0

    .line 2018
    const/4 v3, 0x0

    const/4 v4, 0x3

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 2021
    :cond_0
    if-eqz v2, :cond_2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    const-string v3, "450"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 2022
    const-string v3, "KSC5601Decoding"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 2023
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage$PduParser;->getUserDataKSC5601(I)Ljava/lang/String;

    move-result-object v0

    .line 2037
    :goto_0
    return-object v0

    .line 2025
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 2027
    :cond_2
    const-string v3, "handle8bit"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_3

    .line 2028
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage$PduParser;->getUserDataGSM8bit(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 2030
    :cond_3
    const-string v3, "KSC5601Decoding"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 2031
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage$PduParser;->getUserDataKSC5601(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 2033
    :cond_4
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static getSCAddressFromEF()Ljava/lang/String;
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v4, 0x0

    .line 720
    const-string v0, ""

    .line 722
    .local v0, "mSCAddress":Ljava/lang/String;
    const-string v5, "addSCAddress"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v8, :cond_5

    .line 723
    const/16 v5, 0x6f42

    invoke-static {v5}, Lcom/lge/uicc/LGUiccManager;->readIccRecordToString(I)Ljava/lang/String;

    move-result-object v0

    .line 725
    if-nez v0, :cond_0

    .line 726
    const-string v5, "getSCAddressFromEF(), mSCAddress = null"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move-object v0, v4

    .line 767
    :goto_0
    return-object v0

    .line 728
    :cond_0
    const-string v5, ""

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 729
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getSCAddressFromEF(), scaddr = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 732
    const-string v5, "SKT"

    const-string v6, "ril.card_operator"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 733
    invoke-static {}, Landroid/os/Binder;->clearCallingIdentity()J

    move-result-wide v2

    .line 734
    .local v2, "token":J
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v1

    .line 735
    .local v1, "msisdn":Ljava/lang/String;
    invoke-static {v2, v3}, Landroid/os/Binder;->restoreCallingIdentity(J)V

    .line 737
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getSCAddressFromEF(), msisdn = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 738
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    if-eqz v5, :cond_2

    .line 739
    const-string v4, "+"

    invoke-virtual {v1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v8, :cond_1

    .line 740
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "+82"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x2

    invoke-virtual {v1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 744
    :goto_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getSCAddressFromEF(), mSCAddress = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto/16 :goto_0

    .line 742
    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "82"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 751
    .end local v1    # "msisdn":Ljava/lang/String;
    .end local v2    # "token":J
    :cond_2
    const-string v5, "setNullSCAddress_Intel"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v8, :cond_3

    .line 752
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getSCAddressFromEF(), mSCAddress = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 753
    const-string v5, ""

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 754
    const-string v0, "+7"

    .line 755
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getSCAddressFromEF(), mSCAddress = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_3
    move-object v0, v4

    .line 761
    goto/16 :goto_0

    .line 763
    :cond_4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getSCAddressFromEF(), mSCAddress = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_5
    move-object v0, v4

    .line 767
    goto/16 :goto_0
.end method

.method public static getStaticDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJII[B)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    .locals 12
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "originatorAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "time"    # J
    .param p6, "protocolId"    # I
    .param p7, "dataCodingScheme"    # I
    .param p8, "header"    # [B

    .prologue
    .line 1315
    const-string v2, "getStaticDeliverPdu(),[getStaticDeliverPdu]"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1316
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),scAddress: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1317
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),originatorAddress: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1318
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),message: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1319
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),time: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-wide/from16 v0, p4

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1320
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),protocolId: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p6

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1321
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),header: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p8

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1323
    new-instance v9, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;

    move/from16 v0, p7

    invoke-direct {v9, v0, p2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;-><init>(ILjava/lang/String;)V

    .line 1325
    .local v9, "dcs":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;
    invoke-virtual {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getEncodingType()I

    move-result v2

    sput v2, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 1326
    invoke-virtual {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getDataCodingScheme()I

    move-result v10

    .line 1328
    .local v10, "reCalcDataCodingScheme":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),[Dcs: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1329
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),dataCodingScheme: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p7

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1330
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),sEncodingType: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget v3, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1331
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(),reCalcDataCodingScheme: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1333
    if-eqz p1, :cond_0

    const-string v2, "Unknown"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1334
    :cond_0
    const-string p1, ""

    .line 1337
    :cond_1
    if-nez p2, :cond_2

    .line 1338
    const-string p2, ""

    .line 1341
    :cond_2
    new-instance v7, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    invoke-direct {v7}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;-><init>()V

    .line 1344
    .local v7, "ret":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    if-eqz p8, :cond_3

    const/16 v2, 0x40

    :goto_0
    or-int/lit8 v2, v2, 0x0

    int-to-byte v4, v2

    .local v4, "mtiByte":B
    move-object v2, p0

    move-object v3, p1

    move v5, p3

    move/from16 v6, p6

    .line 1346
    invoke-static/range {v2 .. v7}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPduHead(Ljava/lang/String;Ljava/lang/String;BZILcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;)Ljava/io/ByteArrayOutputStream;

    move-result-object v8

    .line 1351
    .local v8, "bo":Ljava/io/ByteArrayOutputStream;
    sget v2, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    if-nez v2, :cond_4

    .line 1352
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStaticDeliverPdu(), ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget v3, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]: ENCODING_UNKNOWN"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1353
    const/4 v7, 0x0

    .line 1368
    .end local v7    # "ret":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    :goto_1
    return-object v7

    .line 1344
    .end local v4    # "mtiByte":B
    .end local v8    # "bo":Ljava/io/ByteArrayOutputStream;
    .restart local v7    # "ret":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;
    :cond_3
    const/4 v2, 0x0

    goto :goto_0

    .line 1356
    .restart local v4    # "mtiByte":B
    .restart local v8    # "bo":Ljava/io/ByteArrayOutputStream;
    :cond_4
    move-object/from16 v0, p8

    invoke-static {p2, v0}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData(Ljava/lang/String;[B)[B

    move-result-object v11

    .line 1357
    .local v11, "userData":[B
    if-eqz v11, :cond_5

    sget v2, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-static {v2, v11}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isMessageTooLong(I[B)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 1358
    :cond_5
    const/4 v7, 0x0

    goto :goto_1

    .line 1360
    :cond_6
    invoke-virtual {v8, v10}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1363
    move-wide/from16 v0, p4

    invoke-static {v0, v1, v8}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPduSCTS_TimeZone(JLjava/io/ByteArrayOutputStream;)V

    .line 1366
    const/4 v2, 0x0

    array-length v3, v11

    invoke-virtual {v8, v11, v2, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1367
    invoke-virtual {v8}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    iput-object v2, v7, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;->encodedMessage:[B

    goto :goto_1
.end method

.method public static getStaticSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BII)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    .locals 8
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "header"    # [B
    .param p5, "dataCodingScheme"    # I
    .param p6, "protocolId"    # I

    .prologue
    .line 1236
    new-instance v1, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;

    invoke-direct {v1, p5, p2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;-><init>(ILjava/lang/String;)V

    .line 1238
    .local v1, "dcs":Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getEncodingType()I

    move-result v6

    sput v6, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 1239
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->getDataCodingScheme()I

    move-result v3

    .line 1241
    .local v3, "reCalcDataCodingScheme":I
    const-string v6, "getStaticSubmitPdu(),[getStaticSubmitPdu]"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1242
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),[Dcs: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$Dcs;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1243
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),scAddress: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1244
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),destinationAddress: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1245
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),message: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1246
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),statusReportRequested: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1247
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),header: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1248
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),dataCodingScheme: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1249
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),reCalcDataCodingScheme: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1250
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),sEncodingType: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget v7, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1251
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(),protocolId: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1254
    if-nez p1, :cond_0

    .line 1255
    const/4 v4, 0x0

    .line 1287
    :goto_0
    return-object v4

    .line 1258
    :cond_0
    const-string v6, "Unknown"

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_1

    .line 1259
    const-string p1, ""

    .line 1262
    :cond_1
    if-nez p2, :cond_2

    .line 1263
    const-string p2, ""

    .line 1266
    :cond_2
    new-instance v4, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    invoke-direct {v4}, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;-><init>()V

    .line 1268
    .local v4, "ret":Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    if-eqz p4, :cond_3

    const/16 v6, 0x40

    :goto_1
    or-int/lit8 v6, v6, 0x1

    int-to-byte v2, v6

    .line 1269
    .local v2, "mtiByte":B
    invoke-static {p0, p1, v2, p3, v4}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPduHead(Ljava/lang/String;Ljava/lang/String;BZLcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;)Ljava/io/ByteArrayOutputStream;

    move-result-object v0

    .line 1273
    .local v0, "bo":Ljava/io/ByteArrayOutputStream;
    sget v6, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    if-nez v6, :cond_4

    .line 1274
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStaticSubmitPdu(), ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget v7, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]: ENCODING_UNKNOWN"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1275
    const/4 v4, 0x0

    goto :goto_0

    .line 1268
    .end local v0    # "bo":Ljava/io/ByteArrayOutputStream;
    .end local v2    # "mtiByte":B
    :cond_3
    const/4 v6, 0x0

    goto :goto_1

    .line 1278
    .restart local v0    # "bo":Ljava/io/ByteArrayOutputStream;
    .restart local v2    # "mtiByte":B
    :cond_4
    invoke-static {p2, p4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData(Ljava/lang/String;[B)[B

    move-result-object v5

    .line 1279
    .local v5, "userData":[B
    if-eqz v5, :cond_5

    sget v6, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-static {v6, v5}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isMessageTooLong(I[B)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 1280
    :cond_5
    const/4 v4, 0x0

    goto :goto_0

    .line 1283
    :cond_6
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1285
    const/4 v6, 0x0

    array-length v7, v5

    invoke-virtual {v0, v5, v6, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1286
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v6

    iput-object v6, v4, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedMessage:[B

    goto :goto_0
.end method

.method static getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[B)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    .locals 16
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "header"    # [B

    .prologue
    .line 2046
    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->getEnabledSingleShiftTablesLG()[I

    move-result-object v0

    array-length v7, v0

    .line 2049
    .local v7, "singleShiftIndex":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getSubmitPdu(), singleShiftIndex = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2052
    if-lez v7, :cond_0

    .line 2053
    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    invoke-static/range {v0 .. v7}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BIII)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v0

    .line 2057
    :goto_0
    return-object v0

    :cond_0
    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v8, p0

    move-object/from16 v9, p1

    move-object/from16 v10, p2

    move/from16 v11, p3

    move-object/from16 v12, p4

    invoke-static/range {v8 .. v15}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BIII)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v0

    goto :goto_0
.end method

.method public static getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BII)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    .locals 8
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "header"    # [B
    .param p5, "encoding"    # I
    .param p6, "protocolId"    # I

    .prologue
    .line 528
    if-nez p1, :cond_0

    .line 529
    const/4 v5, 0x0

    .line 588
    :goto_0
    return-object v5

    .line 532
    :cond_0
    const-string v0, "Unknown"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 533
    const-string p1, ""

    .line 536
    :cond_1
    if-nez p2, :cond_2

    .line 537
    const-string p2, ""

    .line 540
    :cond_2
    new-instance v5, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    invoke-direct {v5}, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;-><init>()V

    .line 542
    .local v5, "ret":Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    if-eqz p4, :cond_6

    const/16 v0, 0x40

    :goto_1
    or-int/lit8 v0, v0, 0x1

    int-to-byte v2, v0

    .local v2, "mtiByte":B
    move-object v0, p0

    move-object v1, p1

    move v3, p3

    move v4, p6

    .line 543
    invoke-static/range {v0 .. v5}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getSubmitPduHead(Ljava/lang/String;Ljava/lang/String;BZILcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;)Ljava/io/ByteArrayOutputStream;

    move-result-object v6

    .line 549
    .local v6, "bo":Ljava/io/ByteArrayOutputStream;
    sput p5, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 550
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    if-nez v0, :cond_3

    .line 552
    const/4 v0, 0x1

    sput v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 556
    :cond_3
    const/4 v0, 0x0

    const-string v1, "lgu_gsm_submit_encoding_type"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 557
    const-string v0, "ril.card_operator"

    const-string v1, ""

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "LGU"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 558
    const/4 v0, 0x2

    sput v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 563
    :cond_4
    invoke-static {p2, p4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData(Ljava/lang/String;[B)[B

    move-result-object v7

    .line 564
    .local v7, "userData":[B
    if-eqz v7, :cond_5

    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-static {v0, v7}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isMessageTooLong(I[B)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 565
    :cond_5
    const/4 v5, 0x0

    goto :goto_0

    .line 542
    .end local v2    # "mtiByte":B
    .end local v6    # "bo":Ljava/io/ByteArrayOutputStream;
    .end local v7    # "userData":[B
    :cond_6
    const/4 v0, 0x0

    goto :goto_1

    .line 568
    .restart local v2    # "mtiByte":B
    .restart local v6    # "bo":Ljava/io/ByteArrayOutputStream;
    .restart local v7    # "userData":[B
    :cond_7
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_9

    .line 569
    const/4 v0, 0x0

    invoke-virtual {v6, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 581
    :goto_2
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->vp:I

    if-lez v0, :cond_8

    .line 582
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->vp:I

    invoke-virtual {v6, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 586
    :cond_8
    const/4 v0, 0x0

    array-length v1, v7

    invoke-virtual {v6, v7, v0, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 587
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    iput-object v0, v5, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedMessage:[B

    goto :goto_0

    .line 570
    :cond_9
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_a

    .line 571
    const/16 v0, 0x84

    invoke-virtual {v6, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    goto :goto_2

    .line 575
    :cond_a
    const/16 v0, 0x8

    invoke-virtual {v6, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    goto :goto_2
.end method

.method static getSubmitPduHead(Ljava/lang/String;Ljava/lang/String;BZILcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;)Ljava/io/ByteArrayOutputStream;
    .locals 8
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "mtiByte"    # B
    .param p3, "statusReportRequested"    # Z
    .param p4, "protocolId"    # I
    .param p5, "ret"    # Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    .prologue
    const/4 v3, 0x1

    const/4 v6, 0x0

    const/4 v4, 0x0

    .line 957
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v5, 0xb4

    invoke-direct {v0, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 962
    .local v0, "bo":Ljava/io/ByteArrayOutputStream;
    if-eqz p0, :cond_0

    const-string v5, ""

    invoke-virtual {v5, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 963
    :cond_0
    const-string v5, "addSCAddress"

    invoke-static {v6, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v3, :cond_5

    .line 964
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getSCAddressFromEF()Ljava/lang/String;

    move-result-object v2

    .line 965
    .local v2, "mSCAddress":Ljava/lang/String;
    if-nez v2, :cond_4

    .line 966
    iput-object v6, p5, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedScAddress:[B

    .line 980
    .end local v2    # "mSCAddress":Ljava/lang/String;
    :goto_0
    if-eqz p3, :cond_1

    .line 982
    or-int/lit8 v5, p2, 0x20

    int-to-byte p2, v5

    .line 987
    :cond_1
    sget v5, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->vp:I

    if-lez v5, :cond_2

    .line 988
    or-int/lit8 v5, p2, 0x10

    int-to-byte p2, v5

    .line 992
    :cond_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getSubmitPduHead(), mtiByte = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 994
    invoke-virtual {v0, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 997
    invoke-virtual {v0, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1001
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v1

    .line 1003
    .local v1, "daBytes":[B
    if-eqz v1, :cond_3

    .line 1007
    array-length v5, v1

    add-int/lit8 v5, v5, -0x1

    mul-int/lit8 v5, v5, 0x2

    array-length v6, v1

    add-int/lit8 v6, v6, -0x1

    aget-byte v6, v1, v6

    and-int/lit16 v6, v6, 0xf0

    const/16 v7, 0xf0

    if-ne v6, v7, :cond_7

    :goto_1
    sub-int v3, v5, v3

    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1011
    array-length v3, v1

    invoke-virtual {v0, v1, v4, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1014
    :cond_3
    invoke-virtual {v0, p4}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 1015
    return-object v0

    .line 968
    .end local v1    # "daBytes":[B
    .restart local v2    # "mSCAddress":Ljava/lang/String;
    :cond_4
    invoke-static {v2}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCDWithLength(Ljava/lang/String;)[B

    move-result-object v5

    iput-object v5, p5, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedScAddress:[B

    goto :goto_0

    .line 971
    .end local v2    # "mSCAddress":Ljava/lang/String;
    :cond_5
    iput-object v6, p5, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedScAddress:[B

    goto :goto_0

    .line 975
    :cond_6
    invoke-static {p0}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCDWithLength(Ljava/lang/String;)[B

    move-result-object v5

    iput-object v5, p5, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedScAddress:[B

    goto :goto_0

    .restart local v1    # "daBytes":[B
    :cond_7
    move v3, v4

    .line 1007
    goto :goto_1
.end method

.method private static getSubmitPduHeadforEmailOverSms(Ljava/lang/String;Ljava/lang/String;BZLcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;)Ljava/io/ByteArrayOutputStream;
    .locals 6
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "mtiByte"    # B
    .param p3, "statusReportRequested"    # Z
    .param p4, "ret"    # Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    .prologue
    const/4 v3, 0x0

    .line 775
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v2, 0xb4

    invoke-direct {v0, v2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 779
    .local v0, "bo":Ljava/io/ByteArrayOutputStream;
    if-nez p0, :cond_3

    .line 780
    const/4 v2, 0x0

    iput-object v2, p4, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedScAddress:[B

    .line 787
    :goto_0
    if-eqz p3, :cond_0

    .line 789
    or-int/lit8 v2, p2, 0x20

    int-to-byte p2, v2

    .line 795
    :cond_0
    sget v2, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->vp:I

    if-lez v2, :cond_1

    .line 796
    or-int/lit8 v2, p2, 0x10

    int-to-byte p2, v2

    .line 800
    :cond_1
    invoke-virtual {v0, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 803
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 807
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v1

    .line 812
    .local v1, "daBytes":[B
    if-eqz v1, :cond_2

    .line 813
    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    mul-int/lit8 v4, v2, 0x2

    array-length v2, v1

    add-int/lit8 v2, v2, -0x1

    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xf0

    const/16 v5, 0xf0

    if-ne v2, v5, :cond_4

    const/4 v2, 0x1

    :goto_1
    sub-int v2, v4, v2

    invoke-virtual {v0, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 820
    const/16 v2, -0x80

    aput-byte v2, v1, v3

    .line 821
    aget-byte v2, v1, v3

    or-int/lit8 v2, v2, 0x20

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    .line 822
    aget-byte v2, v1, v3

    or-int/lit8 v2, v2, 0x1

    int-to-byte v2, v2

    aput-byte v2, v1, v3

    .line 825
    array-length v2, v1

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 829
    :cond_2
    const/16 v2, 0x32

    invoke-virtual {v0, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 831
    return-object v0

    .line 782
    .end local v1    # "daBytes":[B
    :cond_3
    invoke-static {p0}, Landroid/telephony/PhoneNumberUtils;->networkPortionToCalledPartyBCDWithLength(Ljava/lang/String;)[B

    move-result-object v2

    iput-object v2, p4, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedScAddress:[B

    goto :goto_0

    .restart local v1    # "daBytes":[B
    :cond_4
    move v2, v3

    .line 813
    goto :goto_1
.end method

.method public static getSubmitPduforEmailoverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    .locals 11
    .param p0, "scAddress"    # Ljava/lang/String;
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "statusReportRequested"    # Z
    .param p4, "header"    # [B
    .param p5, "encoding"    # I

    .prologue
    .line 839
    if-eqz p2, :cond_0

    if-nez p1, :cond_1

    .line 840
    :cond_0
    const/4 v9, 0x0

    .line 885
    :goto_0
    return-object v9

    .line 843
    :cond_1
    new-instance v9, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    invoke-direct {v9}, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;-><init>()V

    .line 845
    .local v9, "ret":Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;
    if-eqz p4, :cond_4

    const/16 v0, 0x40

    :goto_1
    or-int/lit8 v0, v0, 0x1

    int-to-byte v8, v0

    .line 847
    .local v8, "mtiByte":B
    invoke-static {p0, p1, v8, p3, v9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getSubmitPduHeadforEmailOverSms(Ljava/lang/String;Ljava/lang/String;BZLcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;)Ljava/io/ByteArrayOutputStream;

    move-result-object v6

    .line 854
    .local v6, "bo":Ljava/io/ByteArrayOutputStream;
    sput p5, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 858
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    if-nez v0, :cond_2

    .line 860
    const/4 v0, 0x1

    sput v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 862
    :cond_2
    invoke-static {p2, p4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData(Ljava/lang/String;[B)[B

    move-result-object v10

    .line 863
    .local v10, "userData":[B
    if-eqz v10, :cond_3

    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    invoke-static {v0, v10}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isMessageTooLong(I[B)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 864
    :cond_3
    const/4 v9, 0x0

    goto :goto_0

    .line 845
    .end local v6    # "bo":Ljava/io/ByteArrayOutputStream;
    .end local v8    # "mtiByte":B
    .end local v10    # "userData":[B
    :cond_4
    const/4 v0, 0x0

    goto :goto_1

    .line 867
    .restart local v6    # "bo":Ljava/io/ByteArrayOutputStream;
    .restart local v8    # "mtiByte":B
    .restart local v10    # "userData":[B
    :cond_5
    sget-object v0, Lcom/android/internal/telephony/SmsConstants$MessageClass;->UNKNOWN:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    const/4 v1, 0x0

    sget v2, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x2

    invoke-static/range {v0 .. v5}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->createDataCodingScheme(Lcom/android/internal/telephony/SmsConstants$MessageClass;ZIIZI)B

    move-result v7

    .line 870
    .local v7, "dcs":B
    invoke-virtual {v6, v7}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 872
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getSubmitPduforEmailoverSms(), DCS = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 876
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->vp:I

    if-lez v0, :cond_6

    .line 877
    sget v0, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->vp:I

    invoke-virtual {v6, v0}, Ljava/io/ByteArrayOutputStream;->write(I)V

    .line 881
    :cond_6
    const/4 v0, 0x0

    array-length v1, v10

    invoke-virtual {v6, v10, v0, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 883
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    iput-object v0, v9, Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;->encodedMessage:[B

    goto :goto_0
.end method

.method private static getUserData(Ljava/lang/String;[B)[B
    .locals 7
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "header"    # [B

    .prologue
    const/4 v3, 0x0

    const/4 v6, 0x2

    const/4 v5, 0x1

    .line 596
    :try_start_0
    sget v4, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    if-ne v4, v5, :cond_0

    .line 597
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData7bit(Ljava/lang/String;[B)[B

    move-result-object v3

    .line 623
    :goto_0
    return-object v3

    .line 599
    :cond_0
    sget v4, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    if-ne v4, v6, :cond_1

    .line 600
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData8bit(Ljava/lang/String;[B)[B

    move-result-object v3

    .local v3, "userData":[B
    goto :goto_0

    .line 603
    .end local v3    # "userData":[B
    :cond_1
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->encodeUCS2(Ljava/lang/String;[B)[B
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/android/internal/telephony/EncodeException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    .restart local v3    # "userData":[B
    goto :goto_0

    .line 605
    .end local v3    # "userData":[B
    :catch_0
    move-exception v1

    .line 606
    .local v1, "uex":Ljava/io/UnsupportedEncodingException;
    goto :goto_0

    .line 607
    .end local v1    # "uex":Ljava/io/UnsupportedEncodingException;
    :catch_1
    move-exception v0

    .line 610
    .local v0, "ex":Lcom/android/internal/telephony/EncodeException;
    :try_start_1
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isKSC5601Encoding()Z

    move-result v4

    if-ne v4, v5, :cond_2

    .line 611
    const/4 v4, 0x2

    sput v4, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 612
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getUserData8bit(Ljava/lang/String;[B)[B

    move-result-object v3

    goto :goto_0

    .line 616
    :cond_2
    const/4 v4, 0x3

    sput v4, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 617
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->encodeUCS2(Ljava/lang/String;[B)[B
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v3

    goto :goto_0

    .line 619
    :catch_2
    move-exception v2

    .line 620
    .local v2, "uex_2":Ljava/io/UnsupportedEncodingException;
    goto :goto_0
.end method

.method private static getUserData7bit(Ljava/lang/String;[B)[B
    .locals 6
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "header"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/EncodeException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    const/4 v3, 0x0

    .line 628
    if-eqz p1, :cond_0

    array-length v2, p1

    if-nez v2, :cond_2

    :cond_0
    move v4, v3

    :goto_0
    if-eqz p1, :cond_1

    array-length v2, p1

    if-nez v2, :cond_3

    :cond_1
    move v2, v3

    :goto_1
    invoke-static {p0, p1, v4, v2, v3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->stringToGsm7BitPackedWithHeader(Ljava/lang/String;[BIIZ)[B

    move-result-object v1

    .line 633
    .local v1, "userData":[B
    const/4 v2, 0x0

    const-string v3, "KREncodingScheme"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-ne v2, v5, :cond_4

    .line 634
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isCountCharIndexInsteadOfSeptets()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 635
    invoke-static {p0, v5}, Lcom/android/internal/telephony/GsmAlphabet;->countGsmSeptets(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v0

    .line 636
    .local v0, "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-eqz v0, :cond_4

    iget v2, v0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    sget v3, Landroid/telephony/LGSmsMessageImpl;->LIMIT_USER_DATA_SEPTETS:I

    if-le v2, v3, :cond_4

    .line 637
    new-instance v2, Lcom/android/internal/telephony/EncodeException;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 628
    .end local v0    # "tedGsm7bit":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v1    # "userData":[B
    :cond_2
    invoke-static {p1}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    iget v2, v2, Lcom/android/internal/telephony/SmsHeader;->languageTable:I

    move v4, v2

    goto :goto_0

    :cond_3
    invoke-static {p1}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    iget v2, v2, Lcom/android/internal/telephony/SmsHeader;->languageShiftTable:I

    goto :goto_1

    .line 641
    .restart local v1    # "userData":[B
    :cond_4
    return-object v1
.end method

.method private static getUserData8bit(Ljava/lang/String;[B)[B
    .locals 4
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "header"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .prologue
    .line 647
    :try_start_0
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->encodeKR(Ljava/lang/String;[B)[B
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 656
    :goto_0
    return-object v2

    .line 648
    :catch_0
    move-exception v1

    .line 649
    .local v1, "uex":Ljava/io/UnsupportedEncodingException;
    const/4 v3, 0x3

    sput v3, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->sEncodingType:I

    .line 651
    :try_start_1
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->encodeUCS2(Ljava/lang/String;[B)[B
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v2

    goto :goto_0

    .line 652
    :catch_1
    move-exception v0

    .line 653
    .local v0, "ucs2_uex":Ljava/io/UnsupportedEncodingException;
    new-instance v3, Ljava/io/UnsupportedEncodingException;

    invoke-direct {v3, p0}, Ljava/io/UnsupportedEncodingException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static gsmIntTobcdByte(I)B
    .locals 3
    .param p0, "i"    # I

    .prologue
    .line 2079
    const/4 v0, 0x0

    .line 2082
    .local v0, "ret":B
    rem-int/lit8 v1, p0, 0xa

    div-int/lit8 v2, p0, 0xa

    shl-int/lit8 v2, v2, 0x4

    add-int/2addr v1, v2

    int-to-byte v0, v1

    .line 2084
    and-int/lit8 v1, v0, 0xf

    shl-int/lit8 v1, v1, 0x4

    and-int/lit16 v2, v0, 0xf0

    shr-int/lit8 v2, v2, 0x4

    or-int/2addr v1, v2

    int-to-byte v0, v1

    .line 2086
    return v0
.end method

.method static includeForceGsmAlphabetLGLength(Ljava/lang/String;)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 4
    .param p0, "message"    # Ljava/lang/String;

    .prologue
    .line 1978
    const/4 v1, 0x0

    .line 1980
    .local v1, "isConvertToGsmAlphabet":Z
    const-string v2, "persist.gsm.sms.forcegsm7"

    const-string v3, "1"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1981
    .local v0, "encodingType":Ljava/lang/String;
    const-string v2, "0"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 1983
    invoke-static {p0, v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    return-object v2
.end method

.method public static isCountCharIndexInsteadOfSeptets()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 1909
    const/4 v1, 0x0

    const-string v2, "countCharIndexInsteadOfSeptets"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 1910
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isReleaseOperator()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1915
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isKSC5601Encoding()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 1894
    const/4 v1, 0x0

    const-string v2, "KSC5601Encoding"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 1895
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isReleaseOperator()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1900
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isMessageTooLong(I[B)Z
    .locals 4
    .param p0, "encodingTypeValue"    # I
    .param p1, "userData"    # [B

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 660
    if-ne p0, v0, :cond_0

    .line 661
    aget-byte v2, p1, v1

    and-int/lit16 v2, v2, 0xff

    const/16 v3, 0xa0

    if-le v2, v3, :cond_1

    .line 663
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isMessageTooLong()_7bit, ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]: Message too long("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-byte v1, p1, v1

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 681
    :goto_0
    return v0

    .line 675
    :cond_0
    aget-byte v2, p1, v1

    and-int/lit16 v2, v2, 0xff

    const/16 v3, 0x8c

    if-le v2, v3, :cond_1

    .line 677
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isMessageTooLong()_8_ucs, ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]: Message too long("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-byte v1, p1, v1

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    move v0, v1

    .line 681
    goto :goto_0
.end method

.method public static isReleaseOperator()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 1924
    const-string v4, "gsm.sim.operator.numeric"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1925
    .local v1, "numeric":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isReleaseOperator(), numeric : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1926
    if-nez v1, :cond_1

    .line 1944
    :cond_0
    :goto_0
    return v2

    .line 1930
    :cond_1
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_2

    move v2, v3

    .line 1931
    goto :goto_0

    .line 1934
    :cond_2
    const/4 v4, 0x0

    const-string v5, "releaseOperatorMccMnc"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1936
    .local v0, "mccmnc":Ljava/lang/String;
    if-nez v0, :cond_3

    move v2, v3

    .line 1937
    goto :goto_0

    .line 1940
    :cond_3
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-ne v4, v3, :cond_0

    move v2, v3

    .line 1941
    goto :goto_0
.end method

.method public static makeSafeSmsField(Landroid/content/Intent;[B)V
    .locals 4
    .param p0, "intent"    # Landroid/content/Intent;
    .param p1, "pdus"    # [B

    .prologue
    .line 2106
    const/4 v1, 0x0

    .line 2108
    .local v1, "safe_sms":B
    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isReleaseOperator()Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_0

    .line 2109
    invoke-static {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->createFromPdu([B)Lcom/android/internal/telephony/gsm/SmsMessage;

    move-result-object v0

    .line 2110
    .local v0, "msg":Lcom/android/internal/telephony/gsm/SmsMessage;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 2111
    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    iget-byte v1, v2, Lcom/android/internal/telephony/SmsHeader;->safeSMS:B

    .line 2112
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isSafeSMS : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2116
    .end local v0    # "msg":Lcom/android/internal/telephony/gsm/SmsMessage;
    :cond_0
    const-string v2, "safe_sms"

    invoke-virtual {p0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;B)Landroid/content/Intent;

    .line 2117
    return-void
.end method

.method public static makeSmsHeader(ILjava/lang/String;)[B
    .locals 11
    .param p0, "readReplyValue"    # I
    .param p1, "replyAddress"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x0

    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 1853
    new-instance v3, Lcom/android/internal/telephony/SmsHeader;

    invoke-direct {v3}, Lcom/android/internal/telephony/SmsHeader;-><init>()V

    .line 1855
    .local v3, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    const-string v5, "replyAddress"

    invoke-static {v10, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v6, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isReleaseOperator()Z

    move-result v5

    if-ne v5, v6, :cond_0

    .line 1856
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 1858
    invoke-static {p1}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsnetworkPortionToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v0

    .line 1859
    .local v0, "daBytes":[B
    new-instance v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    invoke-direct {v1}, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;-><init>()V

    .line 1860
    .local v1, "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    iput-object v0, v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    .line 1861
    if-nez v0, :cond_2

    .line 1862
    iput v7, v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->addressLength:I

    .line 1871
    .end local v0    # "daBytes":[B
    .end local v1    # "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    :cond_0
    :goto_0
    const-string v5, "confirmRead"

    invoke-static {v10, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v6, :cond_1

    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isReleaseOperator()Z

    move-result v5

    if-ne v5, v6, :cond_1

    .line 1872
    const/4 v5, -0x1

    if-le p0, v5, :cond_1

    .line 1873
    new-instance v2, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;

    invoke-direct {v2}, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;-><init>()V

    .line 1874
    .local v2, "smsConfirmRead":Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;
    iput v6, v2, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->length:I

    .line 1875
    new-array v5, v6, [B

    iput-object v5, v2, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    .line 1876
    iget-object v5, v2, Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;->confirmRead:[B

    int-to-byte v6, p0

    aput-byte v6, v5, v7

    .line 1877
    iput-object v2, v3, Lcom/android/internal/telephony/SmsHeader;->smsConfirmRead:Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;

    .line 1882
    .end local v2    # "smsConfirmRead":Lcom/android/internal/telephony/SmsHeader$SmsConfirmRead;
    :cond_1
    invoke-static {v3}, Lcom/android/internal/telephony/SmsHeader;->toByteArray(Lcom/android/internal/telephony/SmsHeader;)[B

    move-result-object v4

    .line 1883
    .local v4, "smsHeaderData":[B
    return-object v4

    .line 1864
    .end local v4    # "smsHeaderData":[B
    .restart local v0    # "daBytes":[B
    .restart local v1    # "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    :cond_2
    array-length v5, v0

    add-int/lit8 v5, v5, -0x1

    mul-int/lit8 v8, v5, 0x2

    array-length v5, v0

    add-int/lit8 v5, v5, -0x1

    aget-byte v5, v0, v5

    and-int/lit16 v5, v5, 0xf0

    const/16 v9, 0xf0

    if-ne v5, v9, :cond_3

    move v5, v6

    :goto_1
    sub-int v5, v8, v5

    iput v5, v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->addressLength:I

    .line 1865
    iput-object v1, v3, Lcom/android/internal/telephony/SmsHeader;->replyAddress:Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    goto :goto_0

    :cond_3
    move v5, v7

    .line 1864
    goto :goto_1
.end method

.method public static stringToGsm7BitPackedWithHeader(Ljava/lang/String;[BIIZ)[B
    .locals 6
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "header"    # [B
    .param p2, "languageTable"    # I
    .param p3, "languageShiftTable"    # I
    .param p4, "throwException"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/EncodeException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x0

    .line 1295
    if-eqz p1, :cond_0

    array-length v3, p1

    if-nez v3, :cond_1

    .line 1296
    :cond_0
    invoke-static {p0, v5, p4, v5, v5}, Lcom/android/internal/telephony/GsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;IZII)[B

    move-result-object v2

    .line 1307
    :goto_0
    return-object v2

    .line 1299
    :cond_1
    array-length v3, p1

    add-int/lit8 v3, v3, 0x1

    mul-int/lit8 v0, v3, 0x8

    .line 1300
    .local v0, "headerBits":I
    add-int/lit8 v3, v0, 0x6

    div-int/lit8 v1, v3, 0x7

    .line 1302
    .local v1, "headerSeptets":I
    invoke-static {p0, v1, p4, p2, p3}, Lcom/android/internal/telephony/GsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;IZII)[B

    move-result-object v2

    .line 1305
    .local v2, "ret":[B
    const/4 v3, 0x1

    array-length v4, p1

    int-to-byte v4, v4

    aput-byte v4, v2, v3

    .line 1306
    const/4 v3, 0x2

    array-length v4, p1

    invoke-static {p1, v5, v2, v3, v4}, Ljava/lang/System;->arraycopy([BI[BII)V

    goto :goto_0
.end method


# virtual methods
.method public getMessageClass()Lcom/android/internal/telephony/SmsConstants$MessageClass;
    .locals 1

    .prologue
    .line 148
    const/4 v0, 0x0

    return-object v0
.end method

.method public getNumOfVoicemails()I
    .locals 1

    .prologue
    .line 209
    const/4 v0, -0x1

    return v0
.end method

.method public getProtocolIdentifier()I
    .locals 1

    .prologue
    .line 154
    const/4 v0, -0x1

    return v0
.end method

.method public getSmsDisplayMode()I
    .locals 1

    .prologue
    .line 1841
    const/4 v0, -0x1

    return v0
.end method

.method public getStatus()I
    .locals 1

    .prologue
    .line 191
    const/4 v0, -0x1

    return v0
.end method

.method public isCphsMwiMessage()Z
    .locals 1

    .prologue
    .line 166
    const/4 v0, 0x0

    return v0
.end method

.method public isMWIClearMessage()Z
    .locals 1

    .prologue
    .line 172
    const/4 v0, 0x0

    return v0
.end method

.method public isMWISetMessage()Z
    .locals 1

    .prologue
    .line 178
    const/4 v0, 0x0

    return v0
.end method

.method public isMwiDontStore()Z
    .locals 1

    .prologue
    .line 184
    const/4 v0, 0x0

    return v0
.end method

.method public isMwiUrgentMessage()Z
    .locals 1

    .prologue
    .line 1827
    const-string v0, "isMwiUrgentMessage(), is not supported in GSM mode."

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->w(Ljava/lang/String;)I

    .line 1828
    const/4 v0, 0x0

    return v0
.end method

.method public isReplace()Z
    .locals 1

    .prologue
    .line 160
    const/4 v0, 0x0

    return v0
.end method

.method public isReplyPathPresent()Z
    .locals 1

    .prologue
    .line 203
    const/4 v0, 0x0

    return v0
.end method

.method public isStatusReportMessage()Z
    .locals 1

    .prologue
    .line 197
    const/4 v0, 0x0

    return v0
.end method
