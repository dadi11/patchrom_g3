.class public Landroid/telephony/LGSmsMessageImpl;
.super Ljava/lang/Object;
.source "LGSmsMessageImpl.java"

# interfaces
.implements Landroid/telephony/ILGSmsMessage;


# static fields
.field public static final LIMIT_USER_DATA_SEPTETS:I

.field public static final MAX_USER_DATA_BYTES_EX:I

.field public static final MAX_USER_DATA_BYTES_WITH_HEADER_REPLYADDRESS:I = 0x7d

.field public static final MAX_USER_DATA_BYTES_WITH_HEADER_REPLYADDRESS_CONCAT:I = 0x78

.field public static final MAX_USER_DATA_BYTES_WITH_HEADER_SF:I = 0x88

.field public static final MAX_USER_DATA_BYTES_WITH_HEADER_SF_CONCAT:I = 0x83

.field public static final MAX_USER_DATA_BYTES_WITH_HEADER_SF_REPLYADDRESS:I = 0x7a

.field public static final MAX_USER_DATA_BYTES_WITH_HEADER_SF_REPLYADDRESS_CONCAT:I = 0x75

.field public static final MAX_USER_DATA_SEPTETS_EX:I

.field public static final MAX_USER_DATA_SEPTETS_WITH_HEADER_REPLYADDRESS:I = 0x8e

.field public static final MAX_USER_DATA_SEPTETS_WITH_HEADER_REPLYADDRESS_CONCAT:I = 0x89

.field public static final MAX_USER_DATA_SEPTETS_WITH_HEADER_SF:I = 0x9b

.field public static final MAX_USER_DATA_SEPTETS_WITH_HEADER_SF_CONCAT:I = 0x95

.field public static final MAX_USER_DATA_SEPTETS_WITH_HEADER_SF_REPLYADDRESS:I = 0x8b

.field public static final MAX_USER_DATA_SEPTETS_WITH_HEADER_SF_REPLYADDRESS_CONCAT:I = 0x85


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/16 v1, 0xa0

    const/4 v3, 0x0

    const-string v0, "max_user_data_bytes_ex"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0x8c

    :goto_0
    sput v0, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    const-string v0, "max_user_data_septets_ex"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    sput v0, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_SEPTETS_EX:I

    const-string v0, "limit_user_data_septets"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :goto_2
    sput v1, Landroid/telephony/LGSmsMessageImpl;->LIMIT_USER_DATA_SEPTETS:I

    return-void

    :cond_0
    const-string v0, "max_user_data_bytes_ex"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    :cond_1
    const-string v0, "max_user_data_septets_ex"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_1

    :cond_2
    const-string v0, "limit_user_data_septets"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    goto :goto_2
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private calcTextLimit(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;)I
    .locals 4
    .param p1, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    .prologue
    const/4 v3, 0x1

    const/4 v1, 0x0

    const-string v2, "KREncodingScheme"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v3, :cond_5

    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isCountCharIndexInsteadOfSeptets()Z

    move-result v1

    if-eqz v1, :cond_1

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_0

    sget v0, Landroid/telephony/LGSmsMessageImpl;->LIMIT_USER_DATA_SEPTETS:I

    .local v0, "limit":I
    :goto_0
    return v0

    .end local v0    # "limit":I
    :cond_0
    sget v0, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    goto :goto_0

    :cond_1
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v3, :cond_3

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_2

    sget v1, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_SEPTETS_EX:I

    add-int/lit8 v0, v1, -0x7

    .restart local v0    # "limit":I
    :goto_1
    goto :goto_0

    .end local v0    # "limit":I
    :cond_2
    sget v1, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    add-int/lit8 v0, v1, -0x6

    goto :goto_1

    :cond_3
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_4

    sget v0, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_SEPTETS_EX:I

    .restart local v0    # "limit":I
    :goto_2
    goto :goto_0

    .end local v0    # "limit":I
    :cond_4
    sget v0, Landroid/telephony/LGSmsMessageImpl;->MAX_USER_DATA_BYTES_EX:I

    goto :goto_2

    :cond_5
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v3, :cond_7

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_6

    const/16 v0, 0x99

    .restart local v0    # "limit":I
    :goto_3
    goto :goto_0

    .end local v0    # "limit":I
    :cond_6
    const/16 v0, 0x86

    goto :goto_3

    :cond_7
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v1, v3, :cond_8

    const/16 v0, 0xa0

    .restart local v0    # "limit":I
    :goto_4
    goto :goto_0

    .end local v0    # "limit":I
    :cond_8
    const/16 v0, 0x8c

    goto :goto_4
.end method

.method private calcTextLimitWithKRHeader(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;ZZ)I
    .locals 3
    .param p1, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .param p2, "bReplyAddress"    # Z
    .param p3, "bSafeSMS"    # Z

    .prologue
    const/4 v2, 0x1

    const/4 v0, 0x0

    .local v0, "limit":I
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    packed-switch v1, :pswitch_data_0

    if-eqz p3, :cond_a

    if-eqz p2, :cond_8

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_7

    const/16 v0, 0x75

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fragmentTextEx(), ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " limit: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    return v0

    :pswitch_0
    if-eqz p3, :cond_3

    if-eqz p2, :cond_1

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_0

    const/16 v0, 0x85

    :goto_1
    goto :goto_0

    :cond_0
    const/16 v0, 0x8b

    goto :goto_1

    :cond_1
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_2

    const/16 v0, 0x95

    :goto_2
    goto :goto_0

    :cond_2
    const/16 v0, 0x9b

    goto :goto_2

    :cond_3
    if-eqz p2, :cond_5

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_4

    const/16 v0, 0x89

    :goto_3
    goto :goto_0

    :cond_4
    const/16 v0, 0x8e

    goto :goto_3

    :cond_5
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_6

    const/16 v0, 0x99

    :goto_4
    goto :goto_0

    :cond_6
    const/16 v0, 0xa0

    goto :goto_4

    :cond_7
    const/16 v0, 0x7a

    goto :goto_0

    :cond_8
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_9

    const/16 v0, 0x83

    :goto_5
    goto :goto_0

    :cond_9
    const/16 v0, 0x88

    goto :goto_5

    :cond_a
    if-eqz p2, :cond_c

    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_b

    const/16 v0, 0x78

    :goto_6
    goto :goto_0

    :cond_b
    const/16 v0, 0x7d

    goto :goto_6

    :cond_c
    iget v1, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v1, v2, :cond_d

    const/16 v0, 0x86

    :goto_7
    goto :goto_0

    :cond_d
    const/16 v0, 0x8c

    goto :goto_7

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method private calcTextPos(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;Ljava/lang/String;II)Ljava/util/ArrayList;
    .locals 9
    .param p1, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .param p2, "text"    # Ljava/lang/String;
    .param p3, "activePhone"    # I
    .param p4, "limit"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;",
            "Ljava/lang/String;",
            "II)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v8, 0x0

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v1, 0x0

    .local v1, "pos":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v3

    .local v3, "textLen":I
    new-instance v2, Ljava/util/ArrayList;

    iget v4, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-direct {v2, v4}, Ljava/util/ArrayList;-><init>(I)V

    .local v2, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :goto_0
    if-ge v1, v3, :cond_2

    const/4 v0, 0x0

    .local v0, "nextPos":I
    iget v4, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v4, v6, :cond_4

    if-ne p3, v7, :cond_3

    iget v4, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-ne v4, v6, :cond_3

    sub-int v4, v3, v1

    invoke-static {p4, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int v0, v1, v4

    :goto_1
    const-string v4, "support_emoji_in_concat_message"

    invoke-static {v8, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v6, :cond_0

    iget v4, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v4, v6, :cond_0

    add-int/lit8 v4, v0, -0x1

    invoke-virtual {p2, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v4

    if-eqz v4, :cond_0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "fragmentTextEx(), isHighSurrogate, ted.msgCount = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " nextPos = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    add-int/lit8 v0, v0, -0x1

    :cond_0
    if-le v0, v1, :cond_1

    if-le v0, v3, :cond_7

    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "fragmentTextEx(), fragmentText failed ("

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " >= "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " or "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " >= "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .end local v0    # "nextPos":I
    :cond_2
    return-object v2

    .restart local v0    # "nextPos":I
    :cond_3
    iget v4, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    iget v5, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    invoke-static {p2, v1, p4, v4, v5}, Lcom/android/internal/telephony/GsmAlphabet;->findGsmSeptetLimitIndex(Ljava/lang/String;IIII)I

    move-result v0

    goto/16 :goto_1

    :cond_4
    const-string v4, "KSC5601Encoding"

    invoke-static {v8, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v6, :cond_6

    iget v4, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v4, v7, :cond_5

    invoke-virtual {p0, p2, v1, p4}, Landroid/telephony/LGSmsMessageImpl;->findKSC5601LimitIndex(Ljava/lang/String;II)I

    move-result v0

    goto/16 :goto_1

    :cond_5
    div-int/lit8 v4, p4, 0x2

    sub-int v5, v3, v1

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int v0, v1, v4

    goto/16 :goto_1

    :cond_6
    div-int/lit8 v4, p4, 0x2

    sub-int v5, v3, v1

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int v0, v1, v4

    goto/16 :goto_1

    :cond_7
    invoke-virtual {p2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v1, v0

    goto/16 :goto_0
.end method

.method private calcTextPosWithKRHeader(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;Ljava/lang/String;I)Ljava/util/ArrayList;
    .locals 9
    .param p1, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .param p2, "text"    # Ljava/lang/String;
    .param p3, "limit"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;",
            "Ljava/lang/String;",
            "I)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v8, 0x1

    const/4 v3, 0x0

    .local v3, "pos":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v5

    .local v5, "textLen":I
    new-instance v4, Ljava/util/ArrayList;

    iget v6, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-direct {v4, v6}, Ljava/util/ArrayList;-><init>(I)V

    .local v4, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :goto_0
    if-ge v3, v5, :cond_2

    const/4 v1, 0x0

    .local v1, "nextPos":I
    iget v6, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v6, v8, :cond_3

    iget v6, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    iget v7, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    invoke-static {p2, v3, p3, v6, v7}, Lcom/android/internal/telephony/GsmAlphabet;->findGsmSeptetLimitIndex(Ljava/lang/String;IIII)I

    move-result v1

    :cond_0
    :goto_1
    if-le v1, v3, :cond_1

    if-le v1, v5, :cond_5

    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "fragmentTextEx(), fragmentText failed ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " >= "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " or "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " >= "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .end local v1    # "nextPos":I
    :cond_2
    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .local v2, "part":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "fragmentTextEx(), PART["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ","

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    goto :goto_2

    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "part":Ljava/lang/String;
    .restart local v1    # "nextPos":I
    :cond_3
    iget v6, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    const/4 v7, 0x2

    if-ne v6, v7, :cond_4

    invoke-virtual {p0, p2, v3, p3}, Landroid/telephony/LGSmsMessageImpl;->findKSC5601LimitIndex(Ljava/lang/String;II)I

    move-result v1

    goto/16 :goto_1

    :cond_4
    div-int/lit8 v6, p3, 0x2

    sub-int v7, v5, v3

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v6

    add-int v1, v3, v6

    const/4 v6, 0x0

    const-string v7, "support_emoji_in_concat_message"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-ne v6, v8, :cond_0

    iget v6, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v6, v8, :cond_0

    add-int/lit8 v6, v1, -0x1

    invoke-virtual {p2, v6}, Ljava/lang/String;->charAt(I)C

    move-result v6

    invoke-static {v6}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v6

    if-eqz v6, :cond_0

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "calcTextPosWithReplyAddr(), isHighSurrogate, ted.msgCount = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    add-int/lit8 v1, v1, -0x1

    goto/16 :goto_1

    :cond_5
    invoke-virtual {p2, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v3, v1

    goto/16 :goto_0

    .end local v1    # "nextPos":I
    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_6
    return-object v4
.end method

.method private setTextEncodingDetails(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;)I
    .locals 4
    .param p1, "ted"    # Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .local v0, "limit":I
    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-ne v2, v3, :cond_5

    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    if-eqz v2, :cond_2

    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    if-eqz v2, :cond_2

    const/4 v1, 0x7

    .local v1, "udhLength":I
    :goto_0
    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v2, v3, :cond_0

    add-int/lit8 v1, v1, 0x6

    :cond_0
    if-eqz v1, :cond_1

    add-int/lit8 v1, v1, 0x1

    :cond_1
    rsub-int v0, v1, 0xa0

    .end local v1    # "udhLength":I
    :goto_1
    return v0

    :cond_2
    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    if-nez v2, :cond_3

    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    if-eqz v2, :cond_4

    :cond_3
    const/4 v1, 0x4

    .restart local v1    # "udhLength":I
    goto :goto_0

    .end local v1    # "udhLength":I
    :cond_4
    const/4 v1, 0x0

    .restart local v1    # "udhLength":I
    goto :goto_0

    .end local v1    # "udhLength":I
    :cond_5
    iget v2, p1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-le v2, v3, :cond_6

    const/16 v0, 0x86

    goto :goto_1

    :cond_6
    const/16 v0, 0x8c

    goto :goto_1
.end method


# virtual methods
.method public calculateEmojiLength(Ljava/lang/String;Z)[I
    .locals 10
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "use7bitOnly"    # Z

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v8

    invoke-virtual {v8}, Landroid/telephony/TelephonyManager;->getCurrentPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v8, 0x2

    if-ne v8, v0, :cond_0

    const/4 v8, 0x0

    invoke-static {p1, v8}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    .local v6, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_0
    const/4 v8, 0x4

    new-array v5, v8, [I

    .local v5, "ret":[I
    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    const/4 v9, 0x1

    if-ne v8, v9, :cond_1

    const/4 v8, 0x0

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    aput v9, v5, v8

    const/4 v8, 0x1

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    aput v9, v5, v8

    const/4 v8, 0x2

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    aput v9, v5, v8

    const/4 v8, 0x3

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    aput v9, v5, v8

    :goto_1
    return-object v5

    .end local v5    # "ret":[I
    .end local v6    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    invoke-static {p1, p2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v6

    goto :goto_0

    .restart local v5    # "ret":[I
    .restart local v6    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_1
    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v9, 0x1

    if-le v8, v9, :cond_5

    const/16 v1, 0x86

    .local v1, "limit":I
    :goto_2
    const/4 v3, 0x0

    .local v3, "pos":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    .local v7, "textLen":I
    new-instance v4, Ljava/util/ArrayList;

    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-direct {v4, v8}, Ljava/util/ArrayList;-><init>(I)V

    .local v4, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :goto_3
    if-ge v3, v7, :cond_3

    const/4 v2, 0x0

    .local v2, "nextPos":I
    div-int/lit8 v8, v1, 0x2

    sub-int v9, v7, v3

    invoke-static {v8, v9}, Ljava/lang/Math;->min(II)I

    move-result v8

    add-int v2, v3, v8

    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v9, 0x1

    if-le v8, v9, :cond_2

    add-int/lit8 v8, v2, -0x1

    invoke-virtual {p1, v8}, Ljava/lang/String;->charAt(I)C

    move-result v8

    invoke-static {v8}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v8

    if-eqz v8, :cond_2

    add-int/lit8 v2, v2, -0x1

    :cond_2
    if-le v2, v3, :cond_3

    if-le v2, v7, :cond_6

    .end local v2    # "nextPos":I
    :cond_3
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v8

    iput v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v9, 0x1

    if-le v8, v9, :cond_4

    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    add-int/lit8 v8, v8, -0x1

    mul-int/lit16 v8, v8, 0x86

    div-int/lit8 v9, v8, 0x2

    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    add-int/lit8 v8, v8, -0x1

    invoke-virtual {v4, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v8

    add-int/2addr v8, v9

    iput v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    iget v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    add-int/lit8 v8, v8, -0x1

    invoke-virtual {v4, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v8

    rsub-int/lit8 v8, v8, 0x43

    iput v8, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    :cond_4
    const/4 v8, 0x0

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    aput v9, v5, v8

    const/4 v8, 0x1

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    aput v9, v5, v8

    const/4 v8, 0x2

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    aput v9, v5, v8

    const/4 v8, 0x3

    iget v9, v6, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    aput v9, v5, v8

    goto/16 :goto_1

    .end local v1    # "limit":I
    .end local v3    # "pos":I
    .end local v4    # "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v7    # "textLen":I
    :cond_5
    const/16 v1, 0x8c

    .restart local v1    # "limit":I
    goto :goto_2

    .restart local v2    # "nextPos":I
    .restart local v3    # "pos":I
    .restart local v4    # "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .restart local v7    # "textLen":I
    :cond_6
    invoke-virtual {p1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v3, v2

    goto :goto_3
.end method

.method public calculateLGLength(Ljava/lang/CharSequence;Z)[I
    .locals 6
    .param p1, "msgBody"    # Ljava/lang/CharSequence;
    .param p2, "use7bitOnly"    # Z

    .prologue
    const/4 v5, 0x2

    const/4 v3, 0x0

    const-string v4, "support_emoji_in_concat_message"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3, p2}, Landroid/telephony/LGSmsMessageImpl;->calculateEmojiLength(Ljava/lang/String;Z)[I

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getCurrentPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    if-ne v5, v0, :cond_1

    invoke-static {p1, p2}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    .local v2, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_1
    const/4 v3, 0x4

    new-array v1, v3, [I

    .local v1, "ret":[I
    const/4 v3, 0x0

    iget v4, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    aput v4, v1, v3

    const/4 v3, 0x1

    iget v4, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    aput v4, v1, v3

    iget v3, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    aput v3, v1, v5

    const/4 v3, 0x3

    iget v4, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    aput v4, v1, v3

    goto :goto_0

    .end local v1    # "ret":[I
    .end local v2    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_1
    invoke-static {p1, p2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    goto :goto_1
.end method

.method public calculateLGLengthAuto(Ljava/lang/String;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 5
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "useCdmaFormat"    # Z

    .prologue
    const-string v3, "persist.gsm.sms.forcegsm7"

    const-string v4, "1"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "encodingType":Ljava/lang/String;
    const-string v3, "0"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .local v1, "forceGsm7bit":Z
    if-eqz p2, :cond_0

    const/4 v3, 0x0

    invoke-static {p1, v3}, Lcom/android/internal/telephony/cdma/SmsMessage;->calculateLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    .local v2, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_0
    return-object v2

    .end local v2    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    invoke-static {p1, v1}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    goto :goto_0
.end method

.method public calculateLength(Ljava/lang/CharSequence;ZZ)[I
    .locals 6
    .param p1, "msgBody"    # Ljava/lang/CharSequence;
    .param p2, "use7bitOnly"    # Z
    .param p3, "userInterface"    # Z

    .prologue
    const/4 v5, 0x2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v2, 0x0

    .local v2, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    if-ne v5, v0, :cond_0

    invoke-static {p1, p2}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->calculateLengthEx(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    :goto_0
    const/4 v3, 0x4

    new-array v1, v3, [I

    .local v1, "ret":[I
    const/4 v3, 0x0

    iget v4, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    aput v4, v1, v3

    const/4 v3, 0x1

    iget v4, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    aput v4, v1, v3

    iget v3, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    aput v3, v1, v5

    const/4 v3, 0x3

    iget v4, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    aput v4, v1, v3

    return-object v1

    .end local v1    # "ret":[I
    :cond_0
    invoke-static {p1, p2, p3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLength(Ljava/lang/CharSequence;ZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v2

    goto :goto_0
.end method

.method public createDataCodingScheme(Landroid/telephony/SmsMessage$MessageClass;ZIIZI)B
    .locals 2
    .param p1, "messageclass"    # Landroid/telephony/SmsMessage$MessageClass;
    .param p2, "isCompressed"    # Z
    .param p3, "encodingtype"    # I
    .param p4, "msgwatingtype"    # I
    .param p5, "msgwaitingactive"    # Z
    .param p6, "msgwaitingkind"    # I

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v1, 0x2

    if-eq v1, v0, :cond_0

    :cond_0
    const/4 v1, -0x1

    return v1
.end method

.method public findKSC5601LimitIndex(Ljava/lang/String;II)I
    .locals 8
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "start"    # I
    .param p3, "limit"    # I

    .prologue
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    .local v4, "size":I
    :try_start_0
    invoke-virtual {p1, p2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    const-string v7, "euc-kr"

    invoke-virtual {v6, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .local v5, "text":[B
    array-length v1, v5

    .local v1, "byte_size":I
    const/4 v3, 0x0

    .local v3, "i":I
    const/4 v0, 0x0

    .local v0, "accumulator":I
    :goto_0
    if-ge v0, v1, :cond_0

    aget-byte v6, v5, v0

    and-int/lit16 v6, v6, 0xff

    const/16 v7, 0xa0

    if-lt v6, v7, :cond_1

    add-int/lit8 v0, v0, 0x2

    :goto_1
    if-le v0, p3, :cond_5

    add-int v4, p2, v3

    .end local v0    # "accumulator":I
    .end local v1    # "byte_size":I
    .end local v3    # "i":I
    .end local v4    # "size":I
    .end local v5    # "text":[B
    :cond_0
    :goto_2
    return v4

    .restart local v4    # "size":I
    :catch_0
    move-exception v2

    .local v2, "e":Ljava/io/UnsupportedEncodingException;
    goto :goto_2

    .end local v2    # "e":Ljava/io/UnsupportedEncodingException;
    .restart local v0    # "accumulator":I
    .restart local v1    # "byte_size":I
    .restart local v3    # "i":I
    .restart local v5    # "text":[B
    :cond_1
    aget-byte v6, v5, v0

    and-int/lit16 v6, v6, 0xff

    const/16 v7, 0x81

    if-lt v6, v7, :cond_4

    aget-byte v6, v5, v0

    and-int/lit16 v6, v6, 0xff

    const/16 v7, 0xc6

    if-gt v6, v7, :cond_4

    add-int/lit8 v6, v0, 0x1

    if-ge v6, v1, :cond_3

    add-int/lit8 v6, v0, 0x1

    aget-byte v6, v5, v6

    and-int/lit16 v6, v6, 0xff

    const/16 v7, 0x41

    if-lt v6, v7, :cond_2

    add-int/lit8 v6, v0, 0x1

    aget-byte v6, v5, v6

    and-int/lit16 v6, v6, 0xff

    const/16 v7, 0xfe

    if-gt v6, v7, :cond_2

    add-int/lit8 v0, v0, 0x2

    goto :goto_1

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method public fragmentText(Ljava/lang/String;Z)Ljava/util/ArrayList;
    .locals 11
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "isSimCopy"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const-string v9, "persist.gsm.sms.forcegsm7"

    const-string v10, "1"

    invoke-static {v9, v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "encodingType":Ljava/lang/String;
    const-string v9, "0"

    invoke-virtual {v1, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    if-nez p2, :cond_4

    const/4 v2, 0x1

    .local v2, "forceGsm7bit":Z
    :goto_0
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v9

    invoke-virtual {v9}, Landroid/telephony/TelephonyManager;->getCurrentPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v9, 0x2

    if-ne v9, v0, :cond_5

    const/4 v9, 0x0

    invoke-static {p1, v9}, Lcom/android/internal/telephony/cdma/SmsMessage;->calculateLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v7

    .local v7, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_1
    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    sput v9, Landroid/telephony/SmsMessage;->mEncodingtype:I

    invoke-direct {p0, v7}, Landroid/telephony/LGSmsMessageImpl;->setTextEncodingDetails(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;)I

    move-result v3

    .local v3, "limit":I
    const/4 v5, 0x0

    .local v5, "pos":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .local v8, "textLen":I
    new-instance v6, Ljava/util/ArrayList;

    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-direct {v6, v9}, Ljava/util/ArrayList;-><init>(I)V

    .local v6, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v9, 0x0

    const-string v10, "allow_sending_empty_sms"

    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_0

    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v10, 0x1

    if-ne v9, v10, :cond_0

    if-nez v8, :cond_0

    const-string v9, ""

    invoke-virtual {v6, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    :goto_2
    if-ge v5, v8, :cond_3

    const/4 v4, 0x0

    .local v4, "nextPos":I
    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    const/4 v10, 0x1

    if-ne v9, v10, :cond_7

    const/4 v9, 0x2

    if-ne v0, v9, :cond_6

    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v10, 0x1

    if-ne v9, v10, :cond_6

    sub-int v9, v8, v5

    invoke-static {v3, v9}, Ljava/lang/Math;->min(II)I

    move-result v9

    add-int v4, v5, v9

    :cond_1
    :goto_3
    if-le v4, v5, :cond_2

    if-le v4, v8, :cond_8

    :cond_2
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "fragmentText(), fragmentText failed ("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " >= "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " or "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " >= "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .end local v4    # "nextPos":I
    :cond_3
    return-object v6

    .end local v0    # "activePhone":I
    .end local v2    # "forceGsm7bit":Z
    .end local v3    # "limit":I
    .end local v5    # "pos":I
    .end local v6    # "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v8    # "textLen":I
    :cond_4
    const/4 v2, 0x0

    goto/16 :goto_0

    .restart local v0    # "activePhone":I
    .restart local v2    # "forceGsm7bit":Z
    :cond_5
    invoke-static {p1, v2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLGLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v7

    goto/16 :goto_1

    .restart local v3    # "limit":I
    .restart local v4    # "nextPos":I
    .restart local v5    # "pos":I
    .restart local v6    # "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .restart local v7    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .restart local v8    # "textLen":I
    :cond_6
    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    iget v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    invoke-static {p1, v5, v3, v9, v10}, Lcom/android/internal/telephony/GsmAlphabet;->findGsmSeptetLimitIndex(Ljava/lang/String;IIII)I

    move-result v4

    goto :goto_3

    :cond_7
    div-int/lit8 v9, v3, 0x2

    sub-int v10, v8, v5

    invoke-static {v9, v10}, Ljava/lang/Math;->min(II)I

    move-result v9

    add-int v4, v5, v9

    const/4 v9, 0x0

    const-string v10, "support_emoji_in_concat_message"

    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v9

    const/4 v10, 0x1

    if-ne v9, v10, :cond_1

    iget v9, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v10, 0x1

    if-le v9, v10, :cond_1

    add-int/lit8 v9, v4, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v9

    if-eqz v9, :cond_1

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "fragmentText()_CopyToSim, isHighSurrogate, ted.msgCount = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget v10, v7, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    add-int/lit8 v4, v4, -0x1

    goto/16 :goto_3

    :cond_8
    invoke-virtual {p1, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v5, v4

    goto/16 :goto_2
.end method

.method public fragmentTextEx(Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 4
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v2, 0x2

    if-ne v2, v0, :cond_0

    invoke-static {p1, v3}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->calculateLengthEx(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v1

    .local v1, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_0
    if-nez v1, :cond_1

    const-string v2, "fragmentTextEx(), fragmentTextEx failed : ted is null"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    const/4 v2, 0x0

    :goto_1
    return-object v2

    .end local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    invoke-static {p1, v3, v3}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLength(Ljava/lang/CharSequence;ZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v1

    goto :goto_0

    .restart local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_1
    invoke-direct {p0, v1}, Landroid/telephony/LGSmsMessageImpl;->calcTextLimit(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;)I

    move-result v2

    invoke-direct {p0, v1, p1, v0, v2}, Landroid/telephony/LGSmsMessageImpl;->calcTextPos(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;Ljava/lang/String;II)Ljava/util/ArrayList;

    move-result-object v2

    goto :goto_1
.end method

.method public fragmentTextEx(Ljava/lang/String;IZZ)Ljava/util/ArrayList;
    .locals 4
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "dataCodingScheme"    # I
    .param p3, "bReplyAddress"    # Z
    .param p4, "bSafeSMS"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "IZZ)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v1, 0x0

    .local v1, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    const/4 v3, 0x2

    if-ne v3, v0, :cond_0

    const-string v3, "save_usim_3gpp_in_cdma"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "Not supported!"

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    invoke-static {p1, p2, p3, p4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLengthHeaderEx(Ljava/lang/CharSequence;IZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v1

    if-nez v1, :cond_1

    :goto_0
    return-object v2

    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "fragmentTextEx(), "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    invoke-direct {p0, v1, p3, p4}, Landroid/telephony/LGSmsMessageImpl;->calcTextLimitWithKRHeader(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;ZZ)I

    move-result v2

    invoke-direct {p0, v1, p1, v2}, Landroid/telephony/LGSmsMessageImpl;->calcTextPosWithKRHeader(Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;Ljava/lang/String;I)Ljava/util/ArrayList;

    move-result-object v2

    goto :goto_0
.end method

.method public getBearerData(Lcom/android/internal/telephony/SmsMessageBase;)Lcom/android/internal/telephony/cdma/sms/BearerData;
    .locals 3
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v1, p1, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v1, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/cdma/SmsMessage;

    .local v0, "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/SmsMessage;->getBearerData()Lcom/android/internal/telephony/cdma/sms/BearerData;

    move-result-object v1

    return-object v1

    .end local v0    # "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    :cond_0
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "[getBearerData] GSM Not supported!"

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public getConfirmReadInfo(Lcom/android/internal/telephony/SmsMessageBase;)Landroid/os/Bundle;
    .locals 2
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v1, p1, Lcom/android/internal/telephony/gsm/SmsMessage;

    if-eqz v1, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/gsm/SmsMessage;

    .local v0, "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/SmsMessage;->getConfirmReadInfo()Landroid/os/Bundle;

    move-result-object v1

    .end local v0    # "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDataCodingScheme(Lcom/android/internal/telephony/SmsMessageBase;)I
    .locals 2
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v1, p1, Lcom/android/internal/telephony/gsm/SmsMessage;

    if-eqz v1, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/gsm/SmsMessage;

    .local v0, "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/SmsMessage;->getDataCodingScheme()I

    move-result v1

    .end local v0    # "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)Landroid/telephony/SmsMessage$DeliverPdu;
    .locals 5
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "originatorAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "time"    # J
    .param p7, "header"    # [B
    .param p8, "encodingtype"    # I

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v2, 0x2

    if-ne v2, v0, :cond_0

    const/4 v2, 0x0

    const-string v3, "save_usim_3gpp_in_cdma"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v1, 0x0

    .local v1, "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    :goto_0
    if-nez v1, :cond_1

    new-instance v2, Landroid/telephony/SmsMessage$DeliverPdu;

    invoke-direct {v2}, Landroid/telephony/SmsMessage$DeliverPdu;-><init>()V

    :goto_1
    return-object v2

    .end local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    :cond_0
    invoke-static/range {p1 .. p8}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    move-result-object v1

    .restart local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    goto :goto_0

    :cond_1
    new-instance v2, Landroid/telephony/SmsMessage$DeliverPdu;

    invoke-direct {v2, v1}, Landroid/telephony/SmsMessage$DeliverPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;)V

    goto :goto_1
.end method

.method public getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BII)Landroid/telephony/SmsMessage$DeliverPdu;
    .locals 11
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "originatorAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "time"    # J
    .param p7, "header"    # [B
    .param p8, "encodingtype"    # I
    .param p9, "smsformat"    # I

    .prologue
    const/4 v2, 0x2

    .local v2, "SMS_FORMAT_CSIM":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeliverPdu(), scAddress = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeliverPdu(), originatorAddress = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeliverPdu(), message = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getDeliverPdu(), smsformat = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, p9

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v3, 0x2

    move/from16 v0, p9

    if-ne v3, v0, :cond_1

    if-eqz p7, :cond_0

    invoke-static/range {p7 .. p7}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v7

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move v6, p4

    move-wide/from16 v8, p5

    invoke-static/range {v3 .. v9}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->ruimGetDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;J)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    move-result-object v10

    .local v10, "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    :goto_0
    if-nez v10, :cond_2

    new-instance v3, Landroid/telephony/SmsMessage$DeliverPdu;

    invoke-direct {v3}, Landroid/telephony/SmsMessage$DeliverPdu;-><init>()V

    :goto_1
    return-object v3

    .end local v10    # "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    :cond_0
    const/4 v7, 0x0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move v6, p4

    move-wide/from16 v8, p5

    invoke-static/range {v3 .. v9}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->ruimGetDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;J)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    move-result-object v10

    .restart local v10    # "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    goto :goto_0

    .end local v10    # "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    :cond_1
    invoke-static/range {p1 .. p8}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    move-result-object v10

    .restart local v10    # "spb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    goto :goto_0

    :cond_2
    new-instance v3, Landroid/telephony/SmsMessage$DeliverPdu;

    invoke-direct {v3, v10}, Landroid/telephony/SmsMessage$DeliverPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;)V

    goto :goto_1
.end method

.method public getNextPosForEmojiConcatMessage(CII)I
    .locals 2
    .param p1, "charValue"    # C
    .param p2, "msgCount"    # I
    .param p3, "nextPos"    # I

    .prologue
    const/4 v0, 0x1

    if-le p2, v0, :cond_0

    invoke-static {p1}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "fragmentText(), isHighSurrogate, ted.msgCount = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    add-int/lit8 p3, p3, -0x1

    .end local p3    # "nextPos":I
    :cond_0
    return p3
.end method

.method public getOriginalAddress(Lcom/android/internal/telephony/SmsMessageBase;)Ljava/lang/String;
    .locals 3
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v2, p1, Lcom/android/internal/telephony/gsm/SmsMessage;

    if-eqz v2, :cond_0

    move-object v1, p1

    check-cast v1, Lcom/android/internal/telephony/gsm/SmsMessage;

    .local v1, "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getOriginalAddress()Ljava/lang/String;

    move-result-object v2

    .end local v1    # "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    :goto_0
    return-object v2

    :cond_0
    instance-of v2, p1, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v2, :cond_1

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/cdma/SmsMessage;

    .local v0, "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/SmsMessage;->getOriginalAddress()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .end local v0    # "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public getReplyAddress(Lcom/android/internal/telephony/SmsMessageBase;)Ljava/lang/String;
    .locals 3
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v2, p1, Lcom/android/internal/telephony/gsm/SmsMessage;

    if-eqz v2, :cond_0

    move-object v1, p1

    check-cast v1, Lcom/android/internal/telephony/gsm/SmsMessage;

    .local v1, "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getreplyAddress()Ljava/lang/String;

    move-result-object v2

    .end local v1    # "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    :goto_0
    return-object v2

    :cond_0
    instance-of v2, p1, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v2, :cond_1

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/cdma/SmsMessage;

    .local v0, "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .end local v0    # "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public getSmsFormatForLGU(I)Ljava/lang/String;
    .locals 3
    .param p1, "activePhone"    # I

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createFromPdu(), format = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/telephony/SmsManager;->getDefault()Landroid/telephony/SmsManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/SmsManager;->getImsSmsFormat()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    invoke-static {}, Landroid/telephony/SmsManager;->getDefault()Landroid/telephony/SmsManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/SmsManager;->getImsSmsFormat()Ljava/lang/String;

    move-result-object v0

    .local v0, "format":Ljava/lang/String;
    const-string v1, "unknown"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x2

    if-ne v1, p1, :cond_1

    const-string v0, "3gpp2"

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    const-string v0, "3gpp"

    goto :goto_0
.end method

.method public getSpecialMessageInfo(Lcom/android/internal/telephony/SmsMessageBase;)Landroid/os/Bundle;
    .locals 2
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v1, p1, Lcom/android/internal/telephony/gsm/SmsMessage;

    if-eqz v1, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/gsm/SmsMessage;

    .local v0, "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSpecialMessageInfo()Landroid/os/Bundle;

    move-result-object v1

    .end local v0    # "gsmWrappedSmsMessage":Lcom/android/internal/telephony/gsm/SmsMessage;
    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getStaticDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJII[B)Landroid/telephony/SmsMessage$DeliverPdu;
    .locals 7
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "originatorAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "time"    # J
    .param p7, "protocolId"    # I
    .param p8, "dataCodingScheme"    # I
    .param p9, "header"    # [B

    .prologue
    const/4 v3, 0x0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v4, 0x2

    if-ne v4, v0, :cond_0

    const-string v4, "save_usim_3gpp_in_cdma"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    new-instance v3, Ljava/lang/RuntimeException;

    const-string v4, "Not supported!"

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_0
    invoke-static/range {p1 .. p9}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getStaticDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJII[B)Lcom/android/internal/telephony/gsm/LGGsmSmsMessage$DeliverPdu;

    move-result-object v1

    .local v1, "dpb":Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;
    if-nez v1, :cond_1

    const-string v4, "getStaticDeliverPdu(), dpb is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    :goto_0
    return-object v3

    :cond_1
    :try_start_0
    new-instance v4, Landroid/telephony/SmsMessage$DeliverPdu;

    invoke-direct {v4, v1}, Landroid/telephony/SmsMessage$DeliverPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$DeliverPduBase;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, v4

    goto :goto_0

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/RuntimeException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getStaticDeliverPdu(), "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getStaticSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZII[B)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 10
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "protocolId"    # I
    .param p6, "dataCodingSchene"    # I
    .param p7, "header"    # [B

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v7

    .local v7, "activePhone":I
    const/4 v0, 0x2

    if-ne v0, v7, :cond_0

    const/4 v0, 0x0

    const-string v1, "save_usim_3gpp_in_cdma"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Not supported!"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    move-object v0, p1

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move-object/from16 v4, p7

    move/from16 v5, p6

    move v6, p5

    invoke-static/range {v0 .. v6}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getStaticSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BII)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v9

    .local v9, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    if-nez v9, :cond_1

    :try_start_0
    const-string v0, "getStaticSubmitPdu(), spb null! encoding == ENCODING_UNKNOWN "

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0, v9}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v8

    .local v8, "e":Ljava/lang/RuntimeException;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getStaticSubmitPdu(), "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 7
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "cbAddress"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Landroid/telephony/SmsMessage;->useCdmaFormatForMoSms()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v4, 0x0

    move-object v0, p1

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;Ljava/lang/String;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v6

    .local v6, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v6, :cond_1

    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v0

    .end local v6    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    invoke-static {p1, p2, p3, p4}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v6

    .restart local v6    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0, v6}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[B)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 3
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "header"    # [B

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getCurrentPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v2, 0x2

    if-ne v2, v0, :cond_0

    invoke-static {p5}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    invoke-static {p1, p2, p3, p4, v2}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v1

    .local v1, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v1, :cond_1

    new-instance v2, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v2}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v2

    .end local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    invoke-static {p1, p2, p3, p4, p5}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[B)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v1

    .restart local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v2, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v2, v1}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 10
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "header"    # [B
    .param p6, "encodingtype"    # I

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v8

    .local v8, "activePhone":I
    const/4 v0, 0x2

    if-ne v0, v8, :cond_0

    invoke-static {p5}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    invoke-static {p1, p2, p3, p4, v0}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v9

    .local v9, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v9, :cond_1

    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v0

    .end local v9    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p1

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move-object v4, p5

    move/from16 v5, p6

    invoke-static/range {v0 .. v7}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BIII)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v9

    .restart local v9    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0, v9}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BLjava/lang/String;)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 7
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "header"    # [B
    .param p6, "cbAddress"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Landroid/telephony/SmsMessage;->useCdmaFormatForMoSms()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p5}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v4

    move-object v0, p1

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move-object v5, p6

    invoke-static/range {v0 .. v5}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;Ljava/lang/String;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v6

    .local v6, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v6, :cond_1

    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v0

    .end local v6    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    invoke-static {p1, p2, p3, p4, p5}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[B)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v6

    .restart local v6    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0, v6}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getSubmitPdu(Ljava/lang/String;Ljava/lang/String;S[BZLjava/lang/String;)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 2
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "destinationPort"    # S
    .param p4, "data"    # [B
    .param p5, "statusReportRequested"    # Z
    .param p6, "cbAddress"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Landroid/telephony/SmsMessage;->useCdmaFormatForMoSms()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static/range {p1 .. p6}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;I[BZLjava/lang/String;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v0

    .local v0, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v0, :cond_1

    new-instance v1, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v1}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v1

    .end local v0    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    invoke-static {p1, p2, p3, p4, p5}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;I[BZ)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v0

    .restart local v0    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v1, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v1, v0}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getSubmitPduforEmailOverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 7
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z

    .prologue
    const/4 v4, 0x0

    invoke-static {}, Landroid/telephony/SmsMessage;->useCdmaFormatForMoSms()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1, p2, p3, p4, v4}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v6

    .local v6, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v6, :cond_1

    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v0

    .end local v6    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    const/4 v5, 0x0

    move-object v0, p1

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    invoke-static/range {v0 .. v5}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getSubmitPduforEmailoverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v6

    .restart local v6    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v0, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v0, v6}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getSubmitPduforEmailOverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 2
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "header"    # [B
    .param p6, "encodingtype"    # I

    .prologue
    invoke-static {}, Landroid/telephony/SmsMessage;->useCdmaFormatForMoSms()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p5}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v1

    invoke-static {p1, p2, p3, p4, v1}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v0

    .local v0, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v0, :cond_1

    new-instance v1, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v1}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v1

    .end local v0    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    invoke-static/range {p1 .. p6}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->getSubmitPduforEmailoverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v0

    .restart local v0    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_1
    new-instance v1, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v1, v0}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method

.method public getTeleServiceId(Lcom/android/internal/telephony/SmsMessageBase;)I
    .locals 3
    .param p1, "mWrappedSmsMessage"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    instance-of v1, p1, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v1, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/android/internal/telephony/cdma/SmsMessage;

    .local v0, "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/SmsMessage;->getTeleServiceId()I

    move-result v1

    return v1

    .end local v0    # "cdmaWrappedSmsMessage":Lcom/android/internal/telephony/cdma/SmsMessage;
    :cond_0
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "[getTeleService] GSM Not supported!"

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public makeSmsHeader(ILjava/lang/String;)[B
    .locals 2
    .param p1, "readReplyValue"    # I
    .param p2, "replyAddress"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v1, 0x2

    if-ne v1, v0, :cond_1

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0

    :cond_1
    invoke-static {p1, p2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->makeSmsHeader(ILjava/lang/String;)[B

    move-result-object v1

    goto :goto_0
.end method

.method public setValidityPeriod(I)V
    .locals 2
    .param p1, "validityperiod"    # I

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "activePhone":I
    const/4 v1, 0x2

    if-eq v1, v0, :cond_0

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->setValidityPeriod(I)V

    :cond_0
    return-void
.end method

.method public uiccGetSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Landroid/telephony/SmsMessage$SubmitPdu;
    .locals 4
    .param p1, "scAddress"    # Ljava/lang/String;
    .param p2, "destinationAddress"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "statusReportRequested"    # Z
    .param p5, "smsHeader"    # [B
    .param p6, "smsformat"    # I

    .prologue
    const/4 v0, 0x1

    .local v0, "SMS_FORMAT_USIM":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "uiccGetSubmitPdu(), scAddress = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "uiccGetSubmitPdu(), destinationAddress = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "uiccGetSubmitPdu(), message = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "uiccGetSubmitPdu(), statusReportRequested = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "uiccGetSubmitPdu(), smsformat = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v2, 0x1

    if-ne p6, v2, :cond_1

    if-eqz p5, :cond_0

    invoke-static {p1, p2, p3, p4, p5}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[B)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v1

    .local v1, "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :goto_0
    if-nez v1, :cond_3

    new-instance v2, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v2}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>()V

    :goto_1
    return-object v2

    .end local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_0
    invoke-static {p1, p2, p3, p4}, Lcom/android/internal/telephony/gsm/SmsMessage;->getSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Lcom/android/internal/telephony/gsm/SmsMessage$SubmitPdu;

    move-result-object v1

    .restart local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    .end local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_1
    if-eqz p5, :cond_2

    invoke-static {p5}, Lcom/android/internal/telephony/SmsHeader;->fromByteArray([B)Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    invoke-static {p1, p2, p3, p4, v2}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->ruimGetSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v1

    .restart local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    .end local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    :cond_2
    const/4 v2, 0x0

    invoke-static {p1, p2, p3, p4, v2}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->ruimGetSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v1

    .restart local v1    # "spb":Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    goto :goto_0

    :cond_3
    new-instance v2, Landroid/telephony/SmsMessage$SubmitPdu;

    invoke-direct {v2, v1}, Landroid/telephony/SmsMessage$SubmitPdu;-><init>(Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)V

    goto :goto_1
.end method
