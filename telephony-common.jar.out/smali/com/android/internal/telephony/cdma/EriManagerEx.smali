.class public Lcom/android/internal/telephony/cdma/EriManagerEx;
.super Lcom/android/internal/telephony/cdma/EriManager;
.source "EriManagerEx.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/cdma/EriManagerEx$EriCrcCalculator;,
        Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;,
        Lcom/android/internal/telephony/cdma/EriManagerEx$EriPrmpt;,
        Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;
    }
.end annotation


# static fields
.field private static final DBG:Z = false

.field public static final ENCODING_ASCII:I = 0x2

.field public static final ENCODING_GSM7:I = 0x9

.field public static final ENCODING_IA5:I = 0x3

.field public static final ENCODING_IS_91:I = 0x1

.field public static final ENCODING_KOREAN:I = 0x6

.field public static final ENCODING_LATIN:I = 0x8

.field public static final ENCODING_LATIN_HEBREW:I = 0x7

.field public static final ENCODING_OCTET:I = 0x0

.field public static final ENCODING_OTHERS:I = 0xa

.field public static final ENCODING_SHIFT_JIS:I = 0x5

.field public static final ENCODING_UNICODE:I = 0x4

.field public static final LENGTH_BITS_CALL_PROMPT_AMOUNT_OF_TEXT_DATA:I = 0x8

.field public static final LENGTH_BITS_CALL_PROMPT_CALL_PROMPT_ID:I = 0x4

.field public static final LENGTH_BITS_CALL_PROMPT_CHARACTER_ENCODING_TYPE:I = 0x5

.field public static final LENGTH_BITS_CALL_PROMPT_RESERVED_BITS1:I = 0x8

.field public static final LENGTH_BITS_CALL_PROMPT_RESERVED_BITS2:I = 0x4

.field public static final LENGTH_BITS_CALL_PROMPT_RESERVED_BITS3:I = 0x3

.field public static final LENGTH_BITS_CALL_PROMPT_TEXT_DATA:I = 0x0

.field public static final LENGTH_BITS_ERI_FILE_CRC:I = 0x10

.field public static final LENGTH_BITS_ERI_TYPE:I = 0x3

.field public static final LENGTH_BITS_ICON_IMAGE_AMOUNT_OF_TEXT_DATA:I = 0x8

.field public static final LENGTH_BITS_ICON_IMAGE_ICON_FILE_NAME:I = 0x0

.field public static final LENGTH_BITS_ICON_IMAGE_IMAGE_ID:I = 0x4

.field public static final LENGTH_BITS_ICON_IMAGE_RESERVED_BITS:I = 0x4

.field public static final LENGTH_BITS_ICON_IMAGE_TYPE:I = 0x3

.field public static final LENGTH_BITS_NUMBER_OF_ERI_ENTRIES:I = 0x6

.field public static final LENGTH_BITS_NUMBER_OF_ICON_IMAGES:I = 0x4

.field public static final LENGTH_BITS_RESERVED_PAD_BITS:I = 0x8

.field public static final LENGTH_BITS_ROAMING_INDICATOR_ALERT_ID:I = 0x3

.field public static final LENGTH_BITS_ROAMING_INDICATOR_AMOUNT_OF_TEXT_DATA:I = 0x8

.field public static final LENGTH_BITS_ROAMING_INDICATOR_CALL_PROMPT_ID:I = 0x2

.field public static final LENGTH_BITS_ROAMING_INDICATOR_CHARACTER_ENCODING_TYPE:I = 0x5

.field public static final LENGTH_BITS_ROAMING_INDICATOR_ERI_TEXT:I = 0x0

.field public static final LENGTH_BITS_ROAMING_INDICATOR_ICON_INDEX:I = 0x4

.field public static final LENGTH_BITS_ROAMING_INDICATOR_ICON_MODE:I = 0x2

.field public static final LENGTH_BITS_ROAMING_INDICATOR_ROAMING_INDICATOR:I = 0x8

.field public static final LENGTH_BITS_VERSION_NUMBER:I = 0x10

.field private static final LOG_TAG:Ljava/lang/String;

.field private static final VDBG:Z


# instance fields
.field final ERI_BACKUP_FILE_NAME:Ljava/lang/String;

.field final ERI_FILE_NAME:Ljava/lang/String;

.field private indexofhomesystem:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 192
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->LOG_TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/PhoneBase;Landroid/content/Context;I)V
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/PhoneBase;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "eriFileSource"    # I

    .prologue
    .line 201
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/EriManager;-><init>()V

    .line 195
    const-string v0, "/eri/eri.bin"

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->ERI_FILE_NAME:Ljava/lang/String;

    .line 196
    const-string v0, "/system/etc/eri.bin"

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->ERI_BACKUP_FILE_NAME:Ljava/lang/String;

    .line 197
    const-string v0, ""

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->indexofhomesystem:Ljava/lang/String;

    .line 203
    iput-object p2, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    .line 204
    iput p3, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFileSource:I

    .line 205
    new-instance v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;-><init>(Lcom/android/internal/telephony/cdma/EriManagerEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    .line 206
    return-void
.end method

.method private xlateEriData([BLcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;)V
    .locals 31
    .param p1, "eri_data_ptr"    # [B
    .param p2, "eri_ptr"    # Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/util/BitwiseInputStream$AccessException;
        }
    .end annotation

    .prologue
    .line 211
    new-instance v24, Lcom/android/internal/util/BitwiseInputStream;

    move-object/from16 v0, v24

    move-object/from16 v1, p1

    invoke-direct {v0, v1}, Lcom/android/internal/util/BitwiseInputStream;-><init>([B)V

    .line 213
    .local v24, "bis":Lcom/android/internal/util/BitwiseInputStream;
    const/16 v27, 0x0

    .line 217
    .local v27, "data_pos":I
    const/16 v30, 0x0

    .line 218
    .local v30, "num_reserved_padbits":I
    const/16 v26, 0x0

    .line 221
    .local v26, "crc_calc":C
    const/16 v2, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    shl-int/lit8 v2, v2, 0x8

    const/16 v3, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v3}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v3

    or-int/2addr v2, v3

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mVersionNumber:I

    .line 223
    add-int/lit8 v27, v27, 0x10

    .line 225
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    move-object/from16 v0, p2

    iget v3, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mVersionNumber:I

    iput v3, v2, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->mVersionNumber:I

    .line 230
    const/4 v2, 0x6

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mNumberOfEriEntries:I

    .line 232
    add-int/lit8 v27, v27, 0x6

    .line 234
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    move-object/from16 v0, p2

    iget v3, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mNumberOfEriEntries:I

    iput v3, v2, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->mNumberOfEriEntries:I

    .line 236
    const/4 v2, 0x3

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mEriFileType:I

    .line 238
    add-int/lit8 v27, v27, 0x3

    .line 240
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    move-object/from16 v0, p2

    iget v3, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mEriFileType:I

    iput v3, v2, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->mEriFileType:I

    .line 242
    const/4 v2, 0x4

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mNumberOfIconImages:I

    .line 244
    add-int/lit8 v27, v27, 0x4

    .line 246
    const/4 v2, 0x3

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mIconImageType:I

    .line 248
    add-int/lit8 v27, v27, 0x3

    .line 250
    const/16 v28, 0x0

    .local v28, "i":I
    :goto_0
    const/4 v2, 0x3

    move/from16 v0, v28

    if-ge v0, v2, :cond_2

    .line 257
    const-string v10, ""

    .line 260
    .local v10, "textData":Ljava/lang/String;
    const/16 v2, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v4

    .line 262
    .local v4, "reservedBits1":I
    add-int/lit8 v27, v27, 0x8

    .line 265
    const/4 v2, 0x4

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v5

    .line 267
    .local v5, "callPromptId":I
    add-int/lit8 v27, v27, 0x4

    .line 270
    const/4 v2, 0x4

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v6

    .line 272
    .local v6, "reservedBits2":I
    add-int/lit8 v27, v27, 0x4

    .line 275
    const/4 v2, 0x3

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v7

    .line 277
    .local v7, "reservedBits3":I
    add-int/lit8 v27, v27, 0x3

    .line 280
    const/4 v2, 0x5

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v8

    .line 282
    .local v8, "characterEncodingType":I
    add-int/lit8 v27, v27, 0x5

    .line 284
    packed-switch v8, :pswitch_data_0

    .line 301
    :pswitch_0
    const/16 v25, 0x0

    .line 306
    .local v25, "char_bit_len":B
    :goto_1
    const/16 v2, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v9

    .line 308
    .local v9, "amountOfTextData":I
    add-int/lit8 v27, v27, 0x8

    .line 311
    const/16 v29, 0x0

    .local v29, "j":I
    :goto_2
    move/from16 v0, v29

    if-ge v0, v9, :cond_0

    .line 313
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {v24 .. v25}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v3

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 314
    add-int v27, v27, v25

    .line 311
    add-int/lit8 v29, v29, 0x1

    goto :goto_2

    .line 287
    .end local v9    # "amountOfTextData":I
    .end local v25    # "char_bit_len":B
    .end local v29    # "j":I
    :pswitch_1
    const/16 v25, 0x8

    .line 288
    .restart local v25    # "char_bit_len":B
    goto :goto_1

    .line 293
    .end local v25    # "char_bit_len":B
    :pswitch_2
    const/16 v25, 0x8

    .line 294
    .restart local v25    # "char_bit_len":B
    goto :goto_1

    .line 297
    .end local v25    # "char_bit_len":B
    :pswitch_3
    const/16 v25, 0x10

    .line 298
    .restart local v25    # "char_bit_len":B
    goto :goto_1

    .line 317
    .restart local v9    # "amountOfTextData":I
    .restart local v29    # "j":I
    :cond_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->getCallPrmptTable()Ljava/util/HashMap;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 318
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->getCallPrmptTable()Ljava/util/HashMap;

    move-result-object v11

    invoke-static/range {v28 .. v28}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    new-instance v2, Lcom/android/internal/telephony/cdma/EriManagerEx$EriPrmpt;

    move-object/from16 v3, p0

    invoke-direct/range {v2 .. v10}, Lcom/android/internal/telephony/cdma/EriManagerEx$EriPrmpt;-><init>(Lcom/android/internal/telephony/cdma/EriManagerEx;IIIIIILjava/lang/String;)V

    move-object/from16 v0, v16

    invoke-virtual {v11, v0, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 250
    :cond_1
    add-int/lit8 v28, v28, 0x1

    goto/16 :goto_0

    .line 328
    .end local v4    # "reservedBits1":I
    .end local v5    # "callPromptId":I
    .end local v6    # "reservedBits2":I
    .end local v7    # "reservedBits3":I
    .end local v8    # "characterEncodingType":I
    .end local v9    # "amountOfTextData":I
    .end local v10    # "textData":Ljava/lang/String;
    .end local v25    # "char_bit_len":B
    .end local v29    # "j":I
    :cond_2
    const/16 v28, 0x0

    :goto_3
    move-object/from16 v0, p2

    iget v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mNumberOfEriEntries:I

    move/from16 v0, v28

    if-ge v0, v2, :cond_4

    .line 332
    const-string v15, ""

    .line 339
    .local v15, "eriText":Ljava/lang/String;
    const/16 v2, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v12

    .line 341
    .local v12, "roamingIndicator":I
    add-int/lit8 v27, v27, 0x8

    .line 344
    const/4 v2, 0x4

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v13

    .line 346
    .local v13, "iconIndex":I
    add-int/lit8 v27, v27, 0x4

    .line 349
    const/4 v2, 0x2

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v14

    .line 351
    .local v14, "iconMode":I
    add-int/lit8 v27, v27, 0x2

    .line 354
    const/4 v2, 0x2

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v5

    .line 356
    .restart local v5    # "callPromptId":I
    add-int/lit8 v27, v27, 0x2

    .line 359
    const/4 v2, 0x3

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v17

    .line 361
    .local v17, "alertId":I
    add-int/lit8 v27, v27, 0x3

    .line 364
    const/4 v2, 0x5

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v8

    .line 366
    .restart local v8    # "characterEncodingType":I
    add-int/lit8 v27, v27, 0x5

    .line 368
    packed-switch v8, :pswitch_data_1

    .line 385
    :pswitch_4
    const/16 v25, 0x0

    .line 389
    .restart local v25    # "char_bit_len":B
    :goto_4
    const/16 v2, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v9

    .line 391
    .restart local v9    # "amountOfTextData":I
    add-int/lit8 v27, v27, 0x8

    .line 394
    const/16 v29, 0x0

    .restart local v29    # "j":I
    :goto_5
    move/from16 v0, v29

    if-ge v0, v9, :cond_3

    .line 396
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {v24 .. v25}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v3

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    .line 397
    add-int v27, v27, v25

    .line 394
    add-int/lit8 v29, v29, 0x1

    goto :goto_5

    .line 371
    .end local v9    # "amountOfTextData":I
    .end local v25    # "char_bit_len":B
    .end local v29    # "j":I
    :pswitch_5
    const/16 v25, 0x8

    .line 372
    .restart local v25    # "char_bit_len":B
    goto :goto_4

    .line 377
    .end local v25    # "char_bit_len":B
    :pswitch_6
    const/16 v25, 0x8

    .line 378
    .restart local v25    # "char_bit_len":B
    goto :goto_4

    .line 381
    .end local v25    # "char_bit_len":B
    :pswitch_7
    const/16 v25, 0x10

    .line 382
    .restart local v25    # "char_bit_len":B
    goto :goto_4

    .line 401
    .restart local v9    # "amountOfTextData":I
    .restart local v29    # "j":I
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->mRoamIndTable:Ljava/util/HashMap;

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    new-instance v11, Lcom/android/internal/telephony/cdma/EriInfo;

    move/from16 v16, v5

    invoke-direct/range {v11 .. v17}, Lcom/android/internal/telephony/cdma/EriInfo;-><init>(IIILjava/lang/String;II)V

    invoke-virtual {v2, v3, v11}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 328
    add-int/lit8 v28, v28, 0x1

    goto/16 :goto_3

    .line 410
    .end local v5    # "callPromptId":I
    .end local v8    # "characterEncodingType":I
    .end local v9    # "amountOfTextData":I
    .end local v12    # "roamingIndicator":I
    .end local v13    # "iconIndex":I
    .end local v14    # "iconMode":I
    .end local v15    # "eriText":Ljava/lang/String;
    .end local v17    # "alertId":I
    .end local v25    # "char_bit_len":B
    .end local v29    # "j":I
    :cond_4
    const/16 v28, 0x0

    :goto_6
    move-object/from16 v0, p2

    iget v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mNumberOfIconImages:I

    move/from16 v0, v28

    if-ge v0, v2, :cond_7

    .line 414
    const-string v23, ""

    .line 417
    .local v23, "iconFileName":Ljava/lang/String;
    const/4 v2, 0x4

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v20

    .line 419
    .local v20, "imageId":I
    add-int/lit8 v27, v27, 0x4

    .line 422
    const/4 v2, 0x4

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v21

    .line 424
    .local v21, "reservedBits":I
    add-int/lit8 v27, v27, 0x4

    .line 427
    const/16 v2, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v9

    .line 429
    .restart local v9    # "amountOfTextData":I
    add-int/lit8 v27, v27, 0x8

    .line 431
    const/16 v25, 0x8

    .line 434
    .restart local v25    # "char_bit_len":B
    const/16 v29, 0x0

    .restart local v29    # "j":I
    :goto_7
    move/from16 v0, v29

    if-ge v0, v9, :cond_5

    .line 436
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v23

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {v24 .. v25}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v3

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    .line 437
    add-int v27, v27, v25

    .line 434
    add-int/lit8 v29, v29, 0x1

    goto :goto_7

    .line 440
    :cond_5
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->getIconImgTable()Ljava/util/HashMap;

    move-result-object v2

    if-eqz v2, :cond_6

    .line 441
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->getIconImgTable()Ljava/util/HashMap;

    move-result-object v2

    invoke-static/range {v28 .. v28}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    new-instance v18, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;

    move-object/from16 v19, p0

    move/from16 v22, v9

    invoke-direct/range {v18 .. v23}, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;-><init>(Lcom/android/internal/telephony/cdma/EriManagerEx;IIILjava/lang/String;)V

    move-object/from16 v0, v18

    invoke-virtual {v2, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 410
    :cond_6
    add-int/lit8 v28, v28, 0x1

    goto :goto_6

    .line 448
    .end local v9    # "amountOfTextData":I
    .end local v20    # "imageId":I
    .end local v21    # "reservedBits":I
    .end local v23    # "iconFileName":Ljava/lang/String;
    .end local v25    # "char_bit_len":B
    .end local v29    # "j":I
    :cond_7
    rem-int/lit8 v2, v27, 0x8

    rsub-int/lit8 v30, v2, 0x8

    .line 449
    const/16 v2, 0x8

    move/from16 v0, v30

    if-ne v0, v2, :cond_8

    .line 450
    const/16 v30, 0x0

    .line 454
    :cond_8
    if-eqz v30, :cond_9

    .line 455
    move-object/from16 v0, v24

    move/from16 v1, v30

    invoke-virtual {v0, v1}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mReservedPadBits:I

    .line 457
    add-int v27, v27, v30

    .line 461
    :cond_9
    const/16 v2, 0x8

    :try_start_0
    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v2

    shl-int/lit8 v2, v2, 0x8

    const/16 v3, 0x8

    move-object/from16 v0, v24

    invoke-virtual {v0, v3}, Lcom/android/internal/util/BitwiseInputStream;->read(I)I

    move-result v3

    or-int/2addr v2, v3

    move-object/from16 v0, p2

    iput v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mEriFileCrc:I

    .line 465
    const/16 v26, 0x0

    .line 466
    div-int/lit8 v2, v27, 0x8

    int-to-char v2, v2

    move/from16 v0, v26

    move-object/from16 v1, p1

    invoke-static {v0, v1, v2}, Lcom/android/internal/telephony/cdma/EriManagerEx$EriCrcCalculator;->crc_16_step(C[BC)C

    move-result v26

    .line 468
    move-object/from16 v0, p2

    iget v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;->mEriFileCrc:I
    :try_end_0
    .catch Lcom/android/internal/util/BitwiseInputStream$AccessException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move/from16 v0, v26

    if-eq v0, v2, :cond_a

    .line 475
    :cond_a
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mIsEriFileLoaded:Z

    .line 477
    :goto_8
    return-void

    .line 471
    :catch_0
    move-exception v2

    .line 475
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mIsEriFileLoaded:Z

    goto :goto_8

    :catchall_0
    move-exception v2

    const/4 v3, 0x1

    move-object/from16 v0, p0

    iput-boolean v3, v0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mIsEriFileLoaded:Z

    throw v2

    .line 284
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
    .end packed-switch

    .line 368
    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_6
        :pswitch_4
        :pswitch_5
        :pswitch_5
        :pswitch_7
        :pswitch_4
        :pswitch_4
        :pswitch_6
        :pswitch_6
    .end packed-switch
.end method


# virtual methods
.method protected addEriHomeSystemForVZW()V
    .locals 2

    .prologue
    .line 896
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 897
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->indexofhomesystem:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "1"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->indexofhomesystem:Ljava/lang/String;

    .line 898
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->indexofhomesystem:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",64,65,76,77,78,79,80,81,82,83"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->indexofhomesystem:Ljava/lang/String;

    .line 900
    :cond_0
    return-void
.end method

.method public getAlertId(II)I
    .locals 4
    .param p1, "roamInd"    # I
    .param p2, "defRoamInd"    # I

    .prologue
    .line 865
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/cdma/EriManagerEx;->getEriInfo(I)Lcom/android/internal/telephony/cdma/EriInfo;

    move-result-object v0

    .line 866
    .local v0, "eriInfo":Lcom/android/internal/telephony/cdma/EriInfo;
    if-nez v0, :cond_0

    .line 867
    const/4 v1, -0x1

    .line 870
    :goto_0
    return v1

    .line 869
    :cond_0
    sget-object v1, Lcom/android/internal/telephony/cdma/EriManagerEx;->LOG_TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "eriInfo.alertId = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Lcom/android/internal/telephony/cdma/EriInfo;->alertId:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 870
    iget v1, v0, Lcom/android/internal/telephony/cdma/EriInfo;->alertId:I

    goto :goto_0
.end method

.method public getCdmaEriHomeSystems()Ljava/lang/String;
    .locals 1

    .prologue
    .line 874
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->indexofhomesystem:Ljava/lang/String;

    return-object v0
.end method

.method protected getEriIconStringByOperator(II)Ljava/lang/String;
    .locals 5
    .param p1, "roamInd"    # I
    .param p2, "defRoamInd"    # I

    .prologue
    const v4, 0x10400c2

    const v3, 0x10400c1

    const v2, 0x10400c0

    const/4 v1, 0x0

    .line 731
    const-string v0, "trf_based_vzw"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 732
    const-string v0, ""

    .line 859
    :goto_0
    return-object v0

    .line 736
    :cond_0
    packed-switch p1, :pswitch_data_0

    .line 793
    const/16 v0, 0x63

    if-ne p1, v0, :cond_a

    .line 797
    const-string v0, ""

    goto :goto_0

    .line 739
    :pswitch_0
    const-string v0, "vzw_eri"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 740
    const-string v0, ""

    goto :goto_0

    .line 745
    :cond_1
    const-string v0, "ACG"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 746
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    sget v1, Lcom/lge/internal/R$string;->sp_roaming_NORMAL:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 751
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v2}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 755
    :pswitch_1
    const-string v0, "vzw_eri"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 756
    const-string v0, ""

    goto :goto_0

    .line 761
    :cond_4
    const-string v0, "SPR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 762
    const-string v0, "ro.cdma.home.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 767
    :cond_5
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 768
    const-string v0, "gsm.sim.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 773
    :cond_6
    const-string v0, "ACG"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 774
    :cond_7
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    sget v1, Lcom/lge/internal/R$string;->sp_home_NORMAL:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 779
    :cond_8
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v3}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 783
    :pswitch_2
    const-string v0, "vzw_eri"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 784
    const-string v0, ""

    goto/16 :goto_0

    .line 789
    :cond_9
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v4}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 800
    :cond_a
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mIsEriFileLoaded:Z

    if-nez v0, :cond_b

    const/4 v0, 0x2

    if-gt p2, v0, :cond_b

    .line 801
    packed-switch p2, :pswitch_data_1

    .line 859
    :cond_b
    const-string v0, ""

    goto/16 :goto_0

    .line 804
    :pswitch_3
    const-string v0, "vzw_eri"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 805
    const-string v0, ""

    goto/16 :goto_0

    .line 810
    :cond_c
    const-string v0, "ACG"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_d

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_e

    .line 811
    :cond_d
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    sget v1, Lcom/lge/internal/R$string;->sp_roaming_NORMAL:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 816
    :cond_e
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v2}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 820
    :pswitch_4
    const-string v0, "vzw_eri"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_f

    .line 821
    const-string v0, ""

    goto/16 :goto_0

    .line 826
    :cond_f
    const-string v0, "SPR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_10

    .line 827
    const-string v0, "ro.cdma.home.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 832
    :cond_10
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    .line 833
    const-string v0, "gsm.sim.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 838
    :cond_11
    const-string v0, "ACG"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_12

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 839
    :cond_12
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    sget v1, Lcom/lge/internal/R$string;->sp_home_NORMAL:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 844
    :cond_13
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v3}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 848
    :pswitch_5
    const-string v0, "vzw_eri"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_14

    .line 849
    const-string v0, ""

    goto/16 :goto_0

    .line 854
    :cond_14
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v4}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 736
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch

    .line 801
    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method protected getFlashIconVZW()Lcom/android/internal/telephony/cdma/EriManager$EriDisplayInformation;
    .locals 5

    .prologue
    .line 884
    const/4 v0, 0x0

    .line 885
    .local v0, "ret":Lcom/android/internal/telephony/cdma/EriManager$EriDisplayInformation;
    const/4 v1, 0x0

    const-string v2, "vzw_eri"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 886
    new-instance v0, Lcom/android/internal/telephony/cdma/EriManager$EriDisplayInformation;

    .end local v0    # "ret":Lcom/android/internal/telephony/cdma/EriManager$EriDisplayInformation;
    const/4 v1, 0x2

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mContext:Landroid/content/Context;

    const v4, 0x10400c0

    invoke-virtual {v3, v4}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, p0, v1, v2, v3}, Lcom/android/internal/telephony/cdma/EriManager$EriDisplayInformation;-><init>(Lcom/android/internal/telephony/cdma/EriManager;IILjava/lang/String;)V

    .line 892
    .restart local v0    # "ret":Lcom/android/internal/telephony/cdma/EriManager$EriDisplayInformation;
    :cond_0
    return-object v0
.end method

.method protected loadEriFileFromFileSystem()V
    .locals 12

    .prologue
    .line 535
    const/4 v5, 0x0

    .line 536
    .local v5, "stream":Ljava/io/FileInputStream;
    new-instance v1, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;-><init>(Lcom/android/internal/telephony/cdma/EriManagerEx;)V

    .line 537
    .local v1, "eriFile":Lcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;
    const/4 v0, 0x0

    .line 540
    .local v0, "count":I
    :try_start_0
    new-instance v2, Ljava/io/File;

    const-string v7, "/eri/eri.bin"

    invoke-direct {v2, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 541
    .local v2, "eriFileObj":Ljava/io/File;
    new-instance v6, Ljava/io/FileInputStream;

    invoke-direct {v6, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 542
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .local v6, "stream":Ljava/io/FileInputStream;
    :try_start_1
    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v8

    const-wide/16 v10, 0x0

    cmp-long v7, v8, v10

    if-nez v7, :cond_0

    .line 546
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/EriManagerEx;->recoverEriFromFileSystem()V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_d
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 555
    :cond_0
    :try_start_2
    invoke-virtual {v6}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_6

    .line 562
    .end local v2    # "eriFileObj":Ljava/io/File;
    :goto_0
    :try_start_3
    new-instance v5, Ljava/io/FileInputStream;

    const-string v7, "/eri/eri.bin"

    invoke-direct {v5, v7}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 563
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :try_start_4
    invoke-virtual {v5}, Ljava/io/FileInputStream;->available()I

    move-result v0

    .line 564
    new-array v3, v0, [B

    .line 566
    .local v3, "eriRawData":[B
    :cond_1
    invoke-virtual {v5, v3}, Ljava/io/FileInputStream;->read([B)I
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_b
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_a
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-result v7

    const/4 v8, -0x1

    if-ne v7, v8, :cond_1

    .line 570
    :try_start_5
    invoke-direct {p0, v3, v1}, Lcom/android/internal/telephony/cdma/EriManagerEx;->xlateEriData([BLcom/android/internal/telephony/cdma/EriManagerEx$EriFileEx;)V

    .line 574
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/EriManagerEx;->addEriHomeSystemForVZW()V
    :try_end_5
    .catch Lcom/android/internal/util/BitwiseInputStream$AccessException; {:try_start_5 .. :try_end_5} :catch_c
    .catch Ljava/io/FileNotFoundException; {:try_start_5 .. :try_end_5} :catch_b
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_a
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 591
    :goto_1
    :try_start_6
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_8

    .line 599
    .end local v3    # "eriRawData":[B
    :goto_2
    return-void

    .line 548
    :catch_0
    move-exception v4

    .line 552
    .local v4, "fnfe":Ljava/io/FileNotFoundException;
    :goto_3
    :try_start_7
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/EriManagerEx;->recoverEriFromFileSystem()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 555
    :try_start_8
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_1

    move-object v6, v5

    .line 558
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    goto :goto_0

    .line 556
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :catch_1
    move-exception v7

    move-object v6, v5

    .line 559
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    goto :goto_0

    .line 554
    .end local v4    # "fnfe":Ljava/io/FileNotFoundException;
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :catchall_0
    move-exception v7

    .line 555
    :goto_4
    :try_start_9
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_7

    .line 558
    :goto_5
    throw v7

    .line 580
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    :catch_2
    move-exception v4

    move-object v5, v6

    .line 584
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v4    # "fnfe":Ljava/io/FileNotFoundException;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :goto_6
    :try_start_a
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/EriManagerEx;->loadEriFileFromXml()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 591
    :try_start_b
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_3

    goto :goto_2

    .line 592
    :catch_3
    move-exception v7

    goto :goto_2

    .line 585
    .end local v4    # "fnfe":Ljava/io/FileNotFoundException;
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    :catch_4
    move-exception v7

    move-object v5, v6

    .line 591
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :goto_7
    :try_start_c
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_5

    goto :goto_2

    .line 592
    :catch_5
    move-exception v7

    goto :goto_2

    .line 590
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    :catchall_1
    move-exception v7

    move-object v5, v6

    .line 591
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :goto_8
    :try_start_d
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_9

    .line 596
    :goto_9
    throw v7

    .line 556
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v2    # "eriFileObj":Ljava/io/File;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    :catch_6
    move-exception v7

    goto :goto_0

    .end local v2    # "eriFileObj":Ljava/io/File;
    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    :catch_7
    move-exception v8

    goto :goto_5

    .line 592
    .restart local v3    # "eriRawData":[B
    :catch_8
    move-exception v7

    goto :goto_2

    .end local v3    # "eriRawData":[B
    :catch_9
    move-exception v8

    goto :goto_9

    .line 590
    :catchall_2
    move-exception v7

    goto :goto_8

    .line 585
    :catch_a
    move-exception v7

    goto :goto_7

    .line 580
    :catch_b
    move-exception v4

    goto :goto_6

    .line 575
    .restart local v3    # "eriRawData":[B
    :catch_c
    move-exception v7

    goto :goto_1

    .line 554
    .end local v3    # "eriRawData":[B
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v2    # "eriFileObj":Ljava/io/File;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    :catchall_3
    move-exception v7

    move-object v5, v6

    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    goto :goto_4

    .line 548
    .end local v5    # "stream":Ljava/io/FileInputStream;
    .restart local v6    # "stream":Ljava/io/FileInputStream;
    :catch_d
    move-exception v4

    move-object v5, v6

    .end local v6    # "stream":Ljava/io/FileInputStream;
    .restart local v5    # "stream":Ljava/io/FileInputStream;
    goto :goto_3
.end method

.method protected recoverEriFromFileSystem()V
    .locals 7

    .prologue
    .line 480
    const/4 v1, 0x0

    .line 481
    .local v1, "fis":Ljava/io/FileInputStream;
    const/4 v3, 0x0

    .line 488
    .local v3, "fos":Ljava/io/FileOutputStream;
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    const-string v5, "/system/etc/eri.bin"

    invoke-direct {v2, v5}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_7
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 493
    .end local v1    # "fis":Ljava/io/FileInputStream;
    .local v2, "fis":Ljava/io/FileInputStream;
    :try_start_1
    new-instance v4, Ljava/io/FileOutputStream;

    const-string v5, "/eri/eri.bin"

    invoke-direct {v4, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 498
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .local v4, "fos":Ljava/io/FileOutputStream;
    const/4 v0, 0x0

    .line 499
    .local v0, "data":I
    :goto_0
    :try_start_2
    invoke-virtual {v2}, Ljava/io/FileInputStream;->read()I

    move-result v0

    const/4 v5, -0x1

    if-eq v0, v5, :cond_2

    .line 500
    invoke-virtual {v4, v0}, Ljava/io/FileOutputStream;->write(I)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_0

    .line 504
    :catch_0
    move-exception v5

    move-object v3, v4

    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    move-object v1, v2

    .line 510
    .end local v0    # "data":I
    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    :goto_1
    if-eqz v1, :cond_0

    .line 511
    :try_start_3
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .line 519
    :cond_0
    :goto_2
    if-eqz v3, :cond_1

    .line 520
    :try_start_4
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_4

    .line 528
    :cond_1
    :goto_3
    return-void

    .line 502
    .end local v1    # "fis":Ljava/io/FileInputStream;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "data":I
    .restart local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    :cond_2
    :try_start_5
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V

    .line 503
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 510
    if-eqz v2, :cond_3

    .line 511
    :try_start_6
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    .line 519
    :cond_3
    :goto_4
    if-eqz v4, :cond_4

    .line 520
    :try_start_7
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1

    :cond_4
    move-object v3, v4

    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    move-object v1, v2

    .line 526
    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    goto :goto_3

    .line 522
    .end local v1    # "fis":Ljava/io/FileInputStream;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    :catch_1
    move-exception v5

    move-object v3, v4

    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    move-object v1, v2

    .line 527
    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    goto :goto_3

    .line 509
    .end local v0    # "data":I
    :catchall_0
    move-exception v5

    .line 510
    :goto_5
    if-eqz v1, :cond_5

    .line 511
    :try_start_8
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    .line 519
    :cond_5
    :goto_6
    if-eqz v3, :cond_6

    .line 520
    :try_start_9
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_6

    .line 526
    :cond_6
    :goto_7
    throw v5

    .line 513
    .end local v1    # "fis":Ljava/io/FileInputStream;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "data":I
    .restart local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    :catch_2
    move-exception v5

    goto :goto_4

    .end local v0    # "data":I
    .end local v2    # "fis":Ljava/io/FileInputStream;
    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    :catch_3
    move-exception v5

    goto :goto_2

    .line 522
    :catch_4
    move-exception v5

    goto :goto_3

    .line 513
    :catch_5
    move-exception v6

    goto :goto_6

    .line 522
    :catch_6
    move-exception v6

    goto :goto_7

    .line 509
    .end local v1    # "fis":Ljava/io/FileInputStream;
    .restart local v2    # "fis":Ljava/io/FileInputStream;
    :catchall_1
    move-exception v5

    move-object v1, v2

    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    goto :goto_5

    .end local v1    # "fis":Ljava/io/FileInputStream;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .restart local v0    # "data":I
    .restart local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v4    # "fos":Ljava/io/FileOutputStream;
    :catchall_2
    move-exception v5

    move-object v3, v4

    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "fos":Ljava/io/FileOutputStream;
    move-object v1, v2

    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    goto :goto_5

    .line 504
    .end local v0    # "data":I
    :catch_7
    move-exception v5

    goto :goto_1

    .end local v1    # "fis":Ljava/io/FileInputStream;
    .restart local v2    # "fis":Ljava/io/FileInputStream;
    :catch_8
    move-exception v5

    move-object v1, v2

    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local v1    # "fis":Ljava/io/FileInputStream;
    goto :goto_1
.end method

.method protected setEriVersionNumberVZW(I)V
    .locals 2
    .param p1, "version"    # I

    .prologue
    .line 903
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 904
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/EriManagerEx;->mEriFile:Lcom/android/internal/telephony/cdma/EriManager$EriFile;

    iput p1, v0, Lcom/android/internal/telephony/cdma/EriManager$EriFile;->mVersionNumber:I

    .line 907
    :cond_0
    return-void
.end method