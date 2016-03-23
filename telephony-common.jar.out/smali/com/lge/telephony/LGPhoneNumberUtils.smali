.class public Lcom/lge/telephony/LGPhoneNumberUtils;
.super Ljava/lang/Object;
.source "LGPhoneNumberUtils.java"


# static fields
.field static final LOG_TAG:Ljava/lang/String; = "LGPhoneNumberUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static KRSMSextractNetworkPortion(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "phoneNumber"    # Ljava/lang/String;

    .prologue
    .line 54
    if-nez p0, :cond_0

    .line 55
    const/4 v5, 0x0

    .line 72
    :goto_0
    return-object v5

    .line 58
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    .line 59
    .local v3, "len":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 60
    .local v4, "ret":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .line 62
    .local v1, "firstCharAdded":Z
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v3, :cond_4

    .line 63
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 64
    .local v0, "c":C
    invoke-static {v0}, Lcom/lge/telephony/LGPhoneNumberUtils;->isKRSMSDialable(C)Z

    move-result v5

    if-eqz v5, :cond_3

    const/16 v5, 0x2b

    if-ne v0, v5, :cond_1

    if-nez v1, :cond_3

    .line 65
    :cond_1
    const/4 v1, 0x1

    .line 66
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 62
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 67
    :cond_3
    invoke-static {v0}, Landroid/telephony/PhoneNumberUtils;->isStartsPostDial(C)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 72
    .end local v0    # "c":C
    :cond_4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_0
.end method

.method private static KRsmsbcdToChar(B)C
    .locals 1
    .param p0, "b"    # B

    .prologue
    .line 182
    const/16 v0, 0xa

    if-ge p0, v0, :cond_0

    .line 183
    add-int/lit8 v0, p0, 0x30

    int-to-char v0, v0

    .line 192
    :goto_0
    return v0

    .line 185
    :cond_0
    packed-switch p0, :pswitch_data_0

    .line 192
    const/4 v0, 0x0

    goto :goto_0

    .line 186
    :pswitch_0
    const/16 v0, 0x2a

    goto :goto_0

    .line 187
    :pswitch_1
    const/16 v0, 0x23

    goto :goto_0

    .line 188
    :pswitch_2
    const/16 v0, 0x61

    goto :goto_0

    .line 189
    :pswitch_3
    const/16 v0, 0x62

    goto :goto_0

    .line 190
    :pswitch_4
    const/16 v0, 0x63

    goto :goto_0

    .line 185
    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public static KRsmscalledPartyBCDToString([BII)Ljava/lang/String;
    .locals 5
    .param p0, "bytes"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .prologue
    .line 106
    const/4 v0, 0x0

    .line 107
    .local v0, "prependPlus":Z
    new-instance v1, Ljava/lang/StringBuilder;

    mul-int/lit8 v3, p2, 0x2

    add-int/lit8 v3, v3, 0x1

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 109
    .local v1, "ret":Ljava/lang/StringBuilder;
    const/4 v3, 0x2

    if-ge p2, v3, :cond_0

    .line 110
    const-string v3, ""

    .line 132
    :goto_0
    return-object v3

    .line 113
    :cond_0
    aget-byte v3, p0, p1

    and-int/lit16 v3, v3, 0xff

    const/16 v4, 0x91

    if-ne v3, v4, :cond_1

    .line 114
    const/4 v0, 0x1

    .line 117
    :cond_1
    add-int/lit8 v3, p1, 0x1

    add-int/lit8 v4, p2, -0x1

    invoke-static {v1, p0, v3, v4}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsinternalCalledPartyBCDFragmentToString(Ljava/lang/StringBuilder;[BII)V

    .line 120
    if-eqz v0, :cond_2

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-nez v3, :cond_2

    .line 122
    const-string v3, ""

    goto :goto_0

    .line 125
    :cond_2
    if-eqz v0, :cond_3

    .line 126
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 128
    .local v2, "retString":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    .end local v1    # "ret":Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 129
    .restart local v1    # "ret":Ljava/lang/StringBuilder;
    const/16 v3, 0x2b

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 130
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 132
    .end local v2    # "retString":Ljava/lang/String;
    :cond_3
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_0
.end method

.method private static KRsmscharToBCD(C)I
    .locals 3
    .param p0, "c"    # C

    .prologue
    .line 202
    const/16 v0, 0x30

    if-lt p0, v0, :cond_0

    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    .line 203
    add-int/lit8 v0, p0, -0x30

    .line 214
    :goto_0
    return v0

    .line 205
    :cond_0
    const/16 v0, 0x2a

    if-ne p0, v0, :cond_1

    .line 206
    const/16 v0, 0xa

    goto :goto_0

    .line 207
    :cond_1
    const/16 v0, 0x23

    if-ne p0, v0, :cond_2

    .line 208
    const/16 v0, 0xb

    goto :goto_0

    .line 209
    :cond_2
    const/16 v0, 0x61

    if-ne p0, v0, :cond_3

    .line 210
    const/16 v0, 0xc

    goto :goto_0

    .line 211
    :cond_3
    const/16 v0, 0x62

    if-ne p0, v0, :cond_4

    .line 212
    const/16 v0, 0xd

    goto :goto_0

    .line 213
    :cond_4
    const/16 v0, 0x63

    if-ne p0, v0, :cond_5

    .line 214
    const/16 v0, 0xe

    goto :goto_0

    .line 216
    :cond_5
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "invalid char for BCD "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static KRsmsinternalCalledPartyBCDFragmentToString(Ljava/lang/StringBuilder;[BII)V
    .locals 5
    .param p0, "sb"    # Ljava/lang/StringBuilder;
    .param p1, "bytes"    # [B
    .param p2, "offset"    # I
    .param p3, "length"    # I

    .prologue
    .line 141
    move v2, p2

    .local v2, "i":I
    :goto_0
    add-int v3, p3, p2

    if-ge v2, v3, :cond_0

    .line 145
    aget-byte v3, p1, v2

    and-int/lit8 v3, v3, 0xf

    int-to-byte v3, v3

    invoke-static {v3}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsbcdToChar(B)C

    move-result v1

    .line 147
    .local v1, "c":C
    if-nez v1, :cond_1

    .line 172
    .end local v1    # "c":C
    :cond_0
    return-void

    .line 150
    .restart local v1    # "c":C
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 159
    aget-byte v3, p1, v2

    shr-int/lit8 v3, v3, 0x4

    and-int/lit8 v3, v3, 0xf

    int-to-byte v0, v3

    .line 161
    .local v0, "b":B
    const/16 v3, 0xf

    if-ne v0, v3, :cond_2

    add-int/lit8 v3, v2, 0x1

    add-int v4, p3, p2

    if-eq v3, v4, :cond_0

    .line 166
    :cond_2
    invoke-static {v0}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsbcdToChar(B)C

    move-result v1

    .line 167
    if-eqz v1, :cond_0

    .line 170
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 141
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public static KRsmsnetworkPortionToCalledPartyBCD(Ljava/lang/String;)[B
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    .line 236
    invoke-static {p0}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRSMSextractNetworkPortion(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsnumberToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static KRsmsnumberToCalledPartyBCD(Ljava/lang/String;)[B
    .locals 1
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    .line 255
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsnumberToCalledPartyBCDHelper(Ljava/lang/String;Z)[B

    move-result-object v0

    return-object v0
.end method

.method private static KRsmsnumberToCalledPartyBCDHelper(Ljava/lang/String;Z)[B
    .locals 4
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "includeLength"    # Z

    .prologue
    const/4 v1, 0x0

    .line 259
    if-nez p0, :cond_1

    .line 260
    const-string v2, "LGPhoneNumberUtils"

    const-string v3, "KRsmsnumberToCalledPartyBCDHelper : number is null"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 279
    :cond_0
    :goto_0
    return-object v1

    .line 264
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 268
    .local v0, "numberLenEffective":I
    const/16 v2, 0x2b

    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_2

    .line 269
    add-int/lit8 v0, v0, -0x1

    .line 272
    :cond_2
    if-eqz v0, :cond_0

    .line 277
    invoke-static {p0, p1, v0}, Lcom/lge/telephony/LGPhoneNumberUtils;->krNumberMakeBCD(Ljava/lang/String;ZI)[B

    move-result-object v1

    .line 279
    .local v1, "result":[B
    goto :goto_0
.end method

.method public static final isKRSMSDialable(C)Z
    .locals 1
    .param p0, "c"    # C

    .prologue
    .line 28
    const/16 v0, 0x30

    if-lt p0, v0, :cond_0

    const/16 v0, 0x39

    if-le p0, v0, :cond_1

    :cond_0
    const/16 v0, 0x2a

    if-eq p0, v0, :cond_1

    const/16 v0, 0x23

    if-eq p0, v0, :cond_1

    const/16 v0, 0x2b

    if-eq p0, v0, :cond_1

    const/16 v0, 0x4e

    if-eq p0, v0, :cond_1

    const/16 v0, 0x61

    if-eq p0, v0, :cond_1

    const/16 v0, 0x62

    if-eq p0, v0, :cond_1

    const/16 v0, 0x63

    if-ne p0, v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static krNumberMakeBCD(Ljava/lang/String;ZI)[B
    .locals 12
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "includeLength"    # Z
    .param p2, "numberLenEffective"    # I

    .prologue
    .line 284
    add-int/lit8 v9, p2, 0x1

    div-int/lit8 v7, v9, 0x2

    .line 285
    .local v7, "resultLen":I
    const/4 v2, 0x1

    .line 287
    .local v2, "extraBytes":I
    if-eqz p1, :cond_0

    .line 288
    add-int/lit8 v2, v2, 0x1

    .line 291
    :cond_0
    add-int/2addr v7, v2

    .line 293
    new-array v6, v7, [B

    .line 295
    .local v6, "result":[B
    const/4 v1, 0x0

    .line 297
    .local v1, "digitCount":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v9

    if-ge v3, v9, :cond_3

    .line 298
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 300
    .local v0, "c":C
    const/16 v9, 0x2b

    if-ne v0, v9, :cond_1

    .line 297
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 304
    :cond_1
    and-int/lit8 v9, v1, 0x1

    const/4 v10, 0x1

    if-ne v9, v10, :cond_2

    const/4 v8, 0x4

    .line 306
    .local v8, "shift":I
    :goto_2
    shr-int/lit8 v9, v1, 0x1

    add-int/2addr v9, v2

    aget-byte v10, v6, v9

    invoke-static {v0}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmscharToBCD(C)I

    move-result v11

    and-int/lit8 v11, v11, 0xf

    shl-int/2addr v11, v8

    int-to-byte v11, v11

    or-int/2addr v10, v11

    int-to-byte v10, v10

    aput-byte v10, v6, v9

    .line 308
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 304
    .end local v8    # "shift":I
    :cond_2
    const/4 v8, 0x0

    goto :goto_2

    .line 312
    .end local v0    # "c":C
    :cond_3
    and-int/lit8 v9, v1, 0x1

    const/4 v10, 0x1

    if-ne v9, v10, :cond_4

    .line 313
    shr-int/lit8 v9, v1, 0x1

    add-int/2addr v9, v2

    aget-byte v10, v6, v9

    or-int/lit16 v10, v10, 0xf0

    int-to-byte v10, v10

    aput-byte v10, v6, v9

    .line 316
    :cond_4
    const/4 v4, 0x0

    .line 318
    .local v4, "offset":I
    if-eqz p1, :cond_5

    .line 319
    add-int/lit8 v5, v4, 0x1

    .end local v4    # "offset":I
    .local v5, "offset":I
    add-int/lit8 v9, v7, -0x1

    int-to-byte v9, v9

    aput-byte v9, v6, v4

    move v4, v5

    .line 322
    .end local v5    # "offset":I
    .restart local v4    # "offset":I
    :cond_5
    const/16 v9, 0x2b

    invoke-virtual {p0, v9}, Ljava/lang/String;->indexOf(I)I

    move-result v9

    const/4 v10, -0x1

    if-eq v9, v10, :cond_6

    const/16 v9, 0x91

    :goto_3
    int-to-byte v9, v9

    aput-byte v9, v6, v4

    .line 324
    return-object v6

    .line 322
    :cond_6
    const/16 v9, 0x81

    goto :goto_3
.end method
