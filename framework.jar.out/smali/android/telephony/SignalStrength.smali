.class public Landroid/telephony/SignalStrength;
.super Ljava/lang/Object;
.source "SignalStrength.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Landroid/telephony/SignalStrength;",
            ">;"
        }
    .end annotation
.end field

.field private static final DBG:Z = false

.field public static final INVALID:I = 0x7fffffff

.field private static final LOG_TAG:Ljava/lang/String; = "SignalStrength"

.field public static final NUM_SIGNAL_STRENGTH_BINS:I

.field public static final SIGNAL_STRENGTH_AWESOME:I = 0x5

.field public static final SIGNAL_STRENGTH_GOOD:I = 0x3

.field public static final SIGNAL_STRENGTH_GREAT:I = 0x4

.field public static final SIGNAL_STRENGTH_MODERATE:I = 0x2

.field public static final SIGNAL_STRENGTH_NAMES:[Ljava/lang/String;

.field public static final SIGNAL_STRENGTH_NONE_OR_UNKNOWN:I = 0x0

.field public static final SIGNAL_STRENGTH_POOR:I = 0x1


# instance fields
.field private datafeature:I

.field private isGsm:Z

.field private mCdmaDbm:I

.field private mCdmaEcio:I

.field private mEvdoDbm:I

.field private mEvdoEcio:I

.field private mEvdoSnr:I

.field private mGsmBitErrorRate:I

.field private mGsmSignalStrength:I

.field private mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

.field private mLteCqi:I

.field private mLteRsrp:I

.field private mLteRsrq:I

.field private mLteRssnr:I

.field private mLteSignalStrength:I

.field private mTdScdmaRscp:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 63
    sget v0, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    sput v0, Landroid/telephony/SignalStrength;->NUM_SIGNAL_STRENGTH_BINS:I

    .line 65
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "none"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string/jumbo v2, "poor"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string/jumbo v2, "moderate"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "good"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "great"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "awesome"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "best"

    aput-object v2, v0, v1

    sput-object v0, Landroid/telephony/SignalStrength;->SIGNAL_STRENGTH_NAMES:[Ljava/lang/String;

    .line 405
    new-instance v0, Landroid/telephony/SignalStrength$1;

    invoke-direct {v0}, Landroid/telephony/SignalStrength$1;-><init>()V

    sput-object v0, Landroid/telephony/SignalStrength;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 5

    .prologue
    const/16 v4, 0x63

    const/4 v3, 0x0

    const v2, 0x7fffffff

    const/4 v1, -0x1

    .line 119
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    iput v3, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v0, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v0}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    .line 120
    iput v4, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 121
    iput v1, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 122
    iput v1, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 123
    iput v1, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 124
    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 125
    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 126
    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 127
    iput v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 128
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 129
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 130
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 131
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 132
    iput v2, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 133
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 135
    iput v3, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 137
    return-void
.end method

.method public constructor <init>(IIIIIIIIIIIIIZ)V
    .locals 15
    .param p1, "gsmSignalStrength"    # I
    .param p2, "gsmBitErrorRate"    # I
    .param p3, "cdmaDbm"    # I
    .param p4, "cdmaEcio"    # I
    .param p5, "evdoDbm"    # I
    .param p6, "evdoEcio"    # I
    .param p7, "evdoSnr"    # I
    .param p8, "lteSignalStrength"    # I
    .param p9, "lteRsrp"    # I
    .param p10, "lteRsrq"    # I
    .param p11, "lteRssnr"    # I
    .param p12, "lteCqi"    # I
    .param p13, "tdScdmaRscp"    # I
    .param p14, "gsmFlag"    # Z

    .prologue
    .line 188
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    const/4 v1, 0x0

    iput v1, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v1, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v1}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v1, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    move-object v1, p0

    move/from16 v2, p1

    move/from16 v3, p2

    move/from16 v4, p3

    move/from16 v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    move/from16 v11, p10

    move/from16 v12, p11

    move/from16 v13, p12

    move/from16 v14, p14

    .line 189
    invoke-virtual/range {v1 .. v14}, Landroid/telephony/SignalStrength;->initialize(IIIIIIIIIIIIZ)V

    .line 192
    move/from16 v0, p13

    iput v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 193
    return-void
.end method

.method public constructor <init>(IIIIIIIIIIIIZ)V
    .locals 1
    .param p1, "gsmSignalStrength"    # I
    .param p2, "gsmBitErrorRate"    # I
    .param p3, "cdmaDbm"    # I
    .param p4, "cdmaEcio"    # I
    .param p5, "evdoDbm"    # I
    .param p6, "evdoEcio"    # I
    .param p7, "evdoSnr"    # I
    .param p8, "lteSignalStrength"    # I
    .param p9, "lteRsrp"    # I
    .param p10, "lteRsrq"    # I
    .param p11, "lteRssnr"    # I
    .param p12, "lteCqi"    # I
    .param p13, "gsmFlag"    # Z

    .prologue
    .line 173
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    const/4 v0, 0x0

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v0, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v0}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    .line 174
    invoke-virtual/range {p0 .. p13}, Landroid/telephony/SignalStrength;->initialize(IIIIIIIIIIIIZ)V

    .line 177
    return-void
.end method

.method public constructor <init>(IIIIIIIZ)V
    .locals 14
    .param p1, "gsmSignalStrength"    # I
    .param p2, "gsmBitErrorRate"    # I
    .param p3, "cdmaDbm"    # I
    .param p4, "cdmaEcio"    # I
    .param p5, "evdoDbm"    # I
    .param p6, "evdoEcio"    # I
    .param p7, "evdoSnr"    # I
    .param p8, "gsmFlag"    # Z

    .prologue
    .line 203
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    const/4 v0, 0x0

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v0, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v0}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    .line 204
    const/16 v8, 0x63

    const v9, 0x7fffffff

    const v10, 0x7fffffff

    const v11, 0x7fffffff

    const v12, 0x7fffffff

    move-object v0, p0

    move v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v13, p8

    invoke-virtual/range {v0 .. v13}, Landroid/telephony/SignalStrength;->initialize(IIIIIIIIIIIIZ)V

    .line 207
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x0

    .line 315
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v1, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v1}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v1, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    .line 318
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 319
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 320
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 321
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 322
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 323
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 324
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 325
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 326
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 327
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 328
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 329
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 330
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 331
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    iput-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 333
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 336
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGSignalStrength;->readFrom(Landroid/os/Parcel;)V

    .line 338
    return-void
.end method

.method public constructor <init>(Landroid/telephony/SignalStrength;)V
    .locals 1
    .param p1, "s"    # Landroid/telephony/SignalStrength;

    .prologue
    .line 216
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    const/4 v0, 0x0

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v0, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v0}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    .line 217
    invoke-virtual {p0, p1}, Landroid/telephony/SignalStrength;->copyFrom(Landroid/telephony/SignalStrength;)V

    .line 218
    return-void
.end method

.method public constructor <init>(Z)V
    .locals 4
    .param p1, "gsmFlag"    # Z

    .prologue
    const/16 v3, 0x63

    const v2, 0x7fffffff

    const/4 v1, -0x1

    .line 147
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    const/4 v0, 0x0

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 93
    new-instance v0, Lcom/lge/telephony/LGSignalStrength;

    invoke-direct {v0}, Lcom/lge/telephony/LGSignalStrength;-><init>()V

    iput-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    .line 148
    iput v3, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 149
    iput v1, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 150
    iput v1, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 151
    iput v1, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 152
    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 153
    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 154
    iput v1, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 155
    iput v3, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 156
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 157
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 158
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 159
    iput v2, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 160
    iput v2, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 161
    iput-boolean p1, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 162
    return-void
.end method

.method private static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    .line 1178
    const-string v0, "SignalStrength"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1179
    return-void
.end method

.method public static makeSignalStrengthFromRilParcel(Landroid/os/Parcel;)Landroid/telephony/SignalStrength;
    .locals 2
    .param p0, "in"    # Landroid/os/Parcel;

    .prologue
    .line 350
    new-instance v0, Landroid/telephony/SignalStrength;

    invoke-direct {v0}, Landroid/telephony/SignalStrength;-><init>()V

    .line 351
    .local v0, "ss":Landroid/telephony/SignalStrength;
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 352
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 353
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 354
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 355
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 356
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 357
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 358
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 359
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 360
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 361
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 362
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 363
    invoke-virtual {p0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 364
    return-object v0
.end method

.method public static newFromBundle(Landroid/os/Bundle;)Landroid/telephony/SignalStrength;
    .locals 1
    .param p0, "m"    # Landroid/os/Bundle;

    .prologue
    .line 109
    new-instance v0, Landroid/telephony/SignalStrength;

    invoke-direct {v0}, Landroid/telephony/SignalStrength;-><init>()V

    .line 110
    .local v0, "ret":Landroid/telephony/SignalStrength;
    invoke-direct {v0, p0}, Landroid/telephony/SignalStrength;->setFromNotifierBundle(Landroid/os/Bundle;)V

    .line 111
    return-object v0
.end method

.method private setFromNotifierBundle(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    .line 1117
    const-string v0, "GsmSignalStrength"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 1118
    const-string v0, "GsmBitErrorRate"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 1119
    const-string v0, "CdmaDbm"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 1120
    const-string v0, "CdmaEcio"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 1121
    const-string v0, "EvdoDbm"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 1122
    const-string v0, "EvdoEcio"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 1123
    const-string v0, "EvdoSnr"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 1124
    const-string v0, "LteSignalStrength"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 1125
    const-string v0, "LteRsrp"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 1126
    const-string v0, "LteRsrq"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 1127
    const-string v0, "LteRssnr"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 1128
    const-string v0, "LteCqi"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 1129
    const-string v0, "TdScdma"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 1130
    const-string v0, "isGsm"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 1132
    const-string v0, "Dataf"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 1135
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGSignalStrength;->readFrom(Landroid/os/Bundle;)V

    .line 1137
    return-void
.end method


# virtual methods
.method protected copyFrom(Landroid/telephony/SignalStrength;)V
    .locals 2
    .param p1, "s"    # Landroid/telephony/SignalStrength;

    .prologue
    .line 288
    iget v0, p1, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 289
    iget v0, p1, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 290
    iget v0, p1, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 291
    iget v0, p1, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 292
    iget v0, p1, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 293
    iget v0, p1, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 294
    iget v0, p1, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 295
    iget v0, p1, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 296
    iget v0, p1, Landroid/telephony/SignalStrength;->mLteRsrp:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 297
    iget v0, p1, Landroid/telephony/SignalStrength;->mLteRsrq:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 298
    iget v0, p1, Landroid/telephony/SignalStrength;->mLteRssnr:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 299
    iget v0, p1, Landroid/telephony/SignalStrength;->mLteCqi:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 300
    iget v0, p1, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    iput v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 301
    iget-boolean v0, p1, Landroid/telephony/SignalStrength;->isGsm:Z

    iput-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 303
    iget v0, p1, Landroid/telephony/SignalStrength;->datafeature:I

    iput v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 306
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    iget-object v1, p1, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGSignalStrength;->copyFrom(Lcom/lge/telephony/LGSignalStrength;)V

    .line 308
    return-void
.end method

.method public describeContents()I
    .locals 1

    .prologue
    .line 397
    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 6
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    const/4 v3, 0x0

    .line 1059
    :try_start_0
    move-object v0, p1

    check-cast v0, Landroid/telephony/SignalStrength;

    move-object v2, v0
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1064
    .local v2, "s":Landroid/telephony/SignalStrength;
    if-nez p1, :cond_1

    .line 1068
    .end local v2    # "s":Landroid/telephony/SignalStrength;
    :cond_0
    :goto_0
    return v3

    .line 1060
    :catch_0
    move-exception v1

    .line 1061
    .local v1, "ex":Ljava/lang/ClassCastException;
    goto :goto_0

    .line 1068
    .end local v1    # "ex":Ljava/lang/ClassCastException;
    .restart local v2    # "s":Landroid/telephony/SignalStrength;
    :cond_1
    iget v4, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mLteRsrp:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mLteRsrq:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mLteRssnr:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mLteCqi:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    iget v5, v2, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    if-ne v4, v5, :cond_0

    iget-boolean v4, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    iget-boolean v5, v2, Landroid/telephony/SignalStrength;->isGsm:Z

    if-ne v4, v5, :cond_0

    const/4 v3, 0x1

    goto :goto_0
.end method

.method public fillInNotifierBundle(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    .line 1146
    const-string v0, "GsmSignalStrength"

    iget v1, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1147
    const-string v0, "GsmBitErrorRate"

    iget v1, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1148
    const-string v0, "CdmaDbm"

    iget v1, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1149
    const-string v0, "CdmaEcio"

    iget v1, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1150
    const-string v0, "EvdoDbm"

    iget v1, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1151
    const-string v0, "EvdoEcio"

    iget v1, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1152
    const-string v0, "EvdoSnr"

    iget v1, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1153
    const-string v0, "LteSignalStrength"

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1154
    const-string v0, "LteRsrp"

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1155
    const-string v0, "LteRsrq"

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1156
    const-string v0, "LteRssnr"

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1157
    const-string v0, "LteCqi"

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1158
    const-string v0, "TdScdma"

    iget v1, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1159
    const-string v0, "isGsm"

    iget-boolean v1, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1161
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGSignalStrength;->writeTo(Landroid/os/Bundle;)V

    .line 1163
    return-void
.end method

.method public getAlternateLteLevel()I
    .locals 3

    .prologue
    .line 871
    const/4 v0, 0x0

    .line 873
    .local v0, "rsrpIconLevel":I
    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v2, -0x2c

    if-le v1, v2, :cond_1

    const/4 v0, -0x1

    .line 880
    :cond_0
    :goto_0
    return v0

    .line 874
    :cond_1
    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v2, -0x61

    if-lt v1, v2, :cond_2

    const/4 v0, 0x4

    goto :goto_0

    .line 875
    :cond_2
    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v2, -0x69

    if-lt v1, v2, :cond_3

    const/4 v0, 0x3

    goto :goto_0

    .line 876
    :cond_3
    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v2, -0x71

    if-lt v1, v2, :cond_4

    const/4 v0, 0x2

    goto :goto_0

    .line 877
    :cond_4
    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v2, -0x78

    if-lt v1, v2, :cond_5

    const/4 v0, 0x1

    goto :goto_0

    .line 878
    :cond_5
    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v2, -0x8c

    if-lt v1, v2, :cond_0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getAsuLevel()I
    .locals 4

    .prologue
    .line 604
    const/4 v0, 0x0

    .line 605
    .local v0, "asuLevel":I
    iget-boolean v3, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    if-eqz v3, :cond_2

    .line 606
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getLteLevel()I

    move-result v3

    if-nez v3, :cond_1

    .line 607
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaLevel()I

    move-result v3

    if-nez v3, :cond_0

    .line 608
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmAsuLevel()I

    move-result v0

    .line 630
    :goto_0
    return v0

    .line 610
    :cond_0
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaAsuLevel()I

    move-result v0

    goto :goto_0

    .line 613
    :cond_1
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getLteAsuLevel()I

    move-result v0

    goto :goto_0

    .line 616
    :cond_2
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaAsuLevel()I

    move-result v1

    .line 617
    .local v1, "cdmaAsuLevel":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoAsuLevel()I

    move-result v2

    .line 618
    .local v2, "evdoAsuLevel":I
    if-nez v2, :cond_3

    .line 620
    move v0, v1

    goto :goto_0

    .line 621
    :cond_3
    if-nez v1, :cond_4

    .line 623
    move v0, v2

    goto :goto_0

    .line 626
    :cond_4
    if-ge v1, v2, :cond_5

    move v0, v1

    :goto_1
    goto :goto_0

    :cond_5
    move v0, v2

    goto :goto_1
.end method

.method public getCdmaAsuLevel()I
    .locals 8

    .prologue
    const/16 v7, -0x5a

    const/16 v6, -0x64

    .line 766
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaDbm()I

    move-result v1

    .line 767
    .local v1, "cdmaDbm":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaEcio()I

    move-result v2

    .line 771
    .local v2, "cdmaEcio":I
    const/16 v5, -0x4b

    if-lt v1, v5, :cond_0

    const/16 v0, 0x10

    .line 779
    .local v0, "cdmaAsuLevel":I
    :goto_0
    if-lt v2, v7, :cond_5

    const/16 v3, 0x10

    .line 786
    .local v3, "ecioAsuLevel":I
    :goto_1
    if-ge v0, v3, :cond_a

    move v4, v0

    .line 788
    .local v4, "level":I
    :goto_2
    return v4

    .line 772
    .end local v0    # "cdmaAsuLevel":I
    .end local v3    # "ecioAsuLevel":I
    .end local v4    # "level":I
    :cond_0
    const/16 v5, -0x52

    if-lt v1, v5, :cond_1

    const/16 v0, 0x8

    .restart local v0    # "cdmaAsuLevel":I
    goto :goto_0

    .line 773
    .end local v0    # "cdmaAsuLevel":I
    :cond_1
    if-lt v1, v7, :cond_2

    const/4 v0, 0x4

    .restart local v0    # "cdmaAsuLevel":I
    goto :goto_0

    .line 774
    .end local v0    # "cdmaAsuLevel":I
    :cond_2
    const/16 v5, -0x5f

    if-lt v1, v5, :cond_3

    const/4 v0, 0x2

    .restart local v0    # "cdmaAsuLevel":I
    goto :goto_0

    .line 775
    .end local v0    # "cdmaAsuLevel":I
    :cond_3
    if-lt v1, v6, :cond_4

    const/4 v0, 0x1

    .restart local v0    # "cdmaAsuLevel":I
    goto :goto_0

    .line 776
    .end local v0    # "cdmaAsuLevel":I
    :cond_4
    const/16 v0, 0x63

    .restart local v0    # "cdmaAsuLevel":I
    goto :goto_0

    .line 780
    :cond_5
    if-lt v2, v6, :cond_6

    const/16 v3, 0x8

    .restart local v3    # "ecioAsuLevel":I
    goto :goto_1

    .line 781
    .end local v3    # "ecioAsuLevel":I
    :cond_6
    const/16 v5, -0x73

    if-lt v2, v5, :cond_7

    const/4 v3, 0x4

    .restart local v3    # "ecioAsuLevel":I
    goto :goto_1

    .line 782
    .end local v3    # "ecioAsuLevel":I
    :cond_7
    const/16 v5, -0x82

    if-lt v2, v5, :cond_8

    const/4 v3, 0x2

    .restart local v3    # "ecioAsuLevel":I
    goto :goto_1

    .line 783
    .end local v3    # "ecioAsuLevel":I
    :cond_8
    const/16 v5, -0x96

    if-lt v2, v5, :cond_9

    const/4 v3, 0x1

    .restart local v3    # "ecioAsuLevel":I
    goto :goto_1

    .line 784
    .end local v3    # "ecioAsuLevel":I
    :cond_9
    const/16 v3, 0x63

    .restart local v3    # "ecioAsuLevel":I
    goto :goto_1

    :cond_a
    move v4, v3

    .line 786
    goto :goto_2
.end method

.method public getCdmaDbm()I
    .locals 1

    .prologue
    .line 498
    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    return v0
.end method

.method public getCdmaEcio()I
    .locals 1

    .prologue
    .line 505
    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    return v0
.end method

.method public getCdmaLevel()I
    .locals 7

    .prologue
    .line 730
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaDbm()I

    move-result v0

    .line 731
    .local v0, "cdmaDbm":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaEcio()I

    move-result v1

    .line 736
    .local v1, "cdmaEcio":I
    iget-object v6, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v6, v0, v1}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v5

    .line 737
    .local v5, "lgLevel":I
    const/4 v6, -0x1

    if-eq v5, v6, :cond_0

    .line 757
    .end local v5    # "lgLevel":I
    :goto_0
    return v5

    .line 742
    .restart local v5    # "lgLevel":I
    :cond_0
    const/16 v6, -0x4b

    if-lt v0, v6, :cond_1

    const/4 v3, 0x4

    .line 749
    .local v3, "levelDbm":I
    :goto_1
    const/16 v6, -0x5a

    if-lt v1, v6, :cond_5

    const/4 v4, 0x4

    .line 755
    .local v4, "levelEcio":I
    :goto_2
    if-ge v3, v4, :cond_9

    move v2, v3

    .local v2, "level":I
    :goto_3
    move v5, v2

    .line 757
    goto :goto_0

    .line 743
    .end local v2    # "level":I
    .end local v3    # "levelDbm":I
    .end local v4    # "levelEcio":I
    :cond_1
    const/16 v6, -0x55

    if-lt v0, v6, :cond_2

    const/4 v3, 0x3

    .restart local v3    # "levelDbm":I
    goto :goto_1

    .line 744
    .end local v3    # "levelDbm":I
    :cond_2
    const/16 v6, -0x5f

    if-lt v0, v6, :cond_3

    const/4 v3, 0x2

    .restart local v3    # "levelDbm":I
    goto :goto_1

    .line 745
    .end local v3    # "levelDbm":I
    :cond_3
    const/16 v6, -0x64

    if-lt v0, v6, :cond_4

    const/4 v3, 0x1

    .restart local v3    # "levelDbm":I
    goto :goto_1

    .line 746
    .end local v3    # "levelDbm":I
    :cond_4
    const/4 v3, 0x0

    .restart local v3    # "levelDbm":I
    goto :goto_1

    .line 750
    :cond_5
    const/16 v6, -0x6e

    if-lt v1, v6, :cond_6

    const/4 v4, 0x3

    .restart local v4    # "levelEcio":I
    goto :goto_2

    .line 751
    .end local v4    # "levelEcio":I
    :cond_6
    const/16 v6, -0x82

    if-lt v1, v6, :cond_7

    const/4 v4, 0x2

    .restart local v4    # "levelEcio":I
    goto :goto_2

    .line 752
    .end local v4    # "levelEcio":I
    :cond_7
    const/16 v6, -0x96

    if-lt v1, v6, :cond_8

    const/4 v4, 0x1

    .restart local v4    # "levelEcio":I
    goto :goto_2

    .line 753
    .end local v4    # "levelEcio":I
    :cond_8
    const/4 v4, 0x0

    .restart local v4    # "levelEcio":I
    goto :goto_2

    :cond_9
    move v2, v4

    .line 755
    goto :goto_3
.end method

.method public getDbm()I
    .locals 5

    .prologue
    const/16 v4, -0x78

    .line 639
    const v1, 0x7fffffff

    .line 641
    .local v1, "dBm":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->isGsm()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 642
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getLteDbm()I

    move-result v1

    .line 643
    const v3, 0x7fffffff

    if-ne v1, v3, :cond_0

    .line 644
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaLevel()I

    move-result v3

    if-nez v3, :cond_2

    .line 645
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmDbm()I

    move-result v1

    :cond_0
    :goto_0
    move v0, v1

    .line 658
    :cond_1
    :goto_1
    return v0

    .line 647
    :cond_2
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaDbm()I

    move-result v1

    goto :goto_0

    .line 651
    :cond_3
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaDbm()I

    move-result v0

    .line 652
    .local v0, "cdmaDbm":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoDbm()I

    move-result v2

    .line 654
    .local v2, "evdoDbm":I
    if-eq v2, v4, :cond_1

    if-ne v0, v4, :cond_4

    move v0, v2

    goto :goto_1

    :cond_4
    if-lt v0, v2, :cond_1

    move v0, v2

    goto :goto_1
.end method

.method public getEvdoAsuLevel()I
    .locals 6

    .prologue
    .line 832
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoDbm()I

    move-result v0

    .line 833
    .local v0, "evdoDbm":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoSnr()I

    move-result v1

    .line 837
    .local v1, "evdoSnr":I
    const/16 v5, -0x41

    if-lt v0, v5, :cond_0

    const/16 v3, 0x10

    .line 844
    .local v3, "levelEvdoDbm":I
    :goto_0
    const/4 v5, 0x7

    if-lt v1, v5, :cond_5

    const/16 v4, 0x10

    .line 851
    .local v4, "levelEvdoSnr":I
    :goto_1
    if-ge v3, v4, :cond_a

    move v2, v3

    .line 853
    .local v2, "level":I
    :goto_2
    return v2

    .line 838
    .end local v2    # "level":I
    .end local v3    # "levelEvdoDbm":I
    .end local v4    # "levelEvdoSnr":I
    :cond_0
    const/16 v5, -0x4b

    if-lt v0, v5, :cond_1

    const/16 v3, 0x8

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_0

    .line 839
    .end local v3    # "levelEvdoDbm":I
    :cond_1
    const/16 v5, -0x55

    if-lt v0, v5, :cond_2

    const/4 v3, 0x4

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_0

    .line 840
    .end local v3    # "levelEvdoDbm":I
    :cond_2
    const/16 v5, -0x5f

    if-lt v0, v5, :cond_3

    const/4 v3, 0x2

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_0

    .line 841
    .end local v3    # "levelEvdoDbm":I
    :cond_3
    const/16 v5, -0x69

    if-lt v0, v5, :cond_4

    const/4 v3, 0x1

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_0

    .line 842
    .end local v3    # "levelEvdoDbm":I
    :cond_4
    const/16 v3, 0x63

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_0

    .line 845
    :cond_5
    const/4 v5, 0x6

    if-lt v1, v5, :cond_6

    const/16 v4, 0x8

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_1

    .line 846
    .end local v4    # "levelEvdoSnr":I
    :cond_6
    const/4 v5, 0x5

    if-lt v1, v5, :cond_7

    const/4 v4, 0x4

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_1

    .line 847
    .end local v4    # "levelEvdoSnr":I
    :cond_7
    const/4 v5, 0x3

    if-lt v1, v5, :cond_8

    const/4 v4, 0x2

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_1

    .line 848
    .end local v4    # "levelEvdoSnr":I
    :cond_8
    const/4 v5, 0x1

    if-lt v1, v5, :cond_9

    const/4 v4, 0x1

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_1

    .line 849
    .end local v4    # "levelEvdoSnr":I
    :cond_9
    const/16 v4, 0x63

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_1

    :cond_a
    move v2, v4

    .line 851
    goto :goto_2
.end method

.method public getEvdoDbm()I
    .locals 1

    .prologue
    .line 512
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    return v0
.end method

.method public getEvdoEcio()I
    .locals 1

    .prologue
    .line 519
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    return v0
.end method

.method public getEvdoLevel()I
    .locals 7

    .prologue
    .line 797
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoDbm()I

    move-result v0

    .line 798
    .local v0, "evdoDbm":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoSnr()I

    move-result v1

    .line 803
    .local v1, "evdoSnr":I
    iget-object v6, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v6, v0, v1}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v5

    .line 804
    .local v5, "lgLevel":I
    const/4 v6, -0x1

    if-eq v5, v6, :cond_0

    .line 823
    .end local v5    # "lgLevel":I
    :goto_0
    return v5

    .line 809
    .restart local v5    # "lgLevel":I
    :cond_0
    const/16 v6, -0x41

    if-lt v0, v6, :cond_1

    const/4 v3, 0x4

    .line 815
    .local v3, "levelEvdoDbm":I
    :goto_1
    const/4 v6, 0x7

    if-lt v1, v6, :cond_5

    const/4 v4, 0x4

    .line 821
    .local v4, "levelEvdoSnr":I
    :goto_2
    if-ge v3, v4, :cond_9

    move v2, v3

    .local v2, "level":I
    :goto_3
    move v5, v2

    .line 823
    goto :goto_0

    .line 810
    .end local v2    # "level":I
    .end local v3    # "levelEvdoDbm":I
    .end local v4    # "levelEvdoSnr":I
    :cond_1
    const/16 v6, -0x4b

    if-lt v0, v6, :cond_2

    const/4 v3, 0x3

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_1

    .line 811
    .end local v3    # "levelEvdoDbm":I
    :cond_2
    const/16 v6, -0x5a

    if-lt v0, v6, :cond_3

    const/4 v3, 0x2

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_1

    .line 812
    .end local v3    # "levelEvdoDbm":I
    :cond_3
    const/16 v6, -0x69

    if-lt v0, v6, :cond_4

    const/4 v3, 0x1

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_1

    .line 813
    .end local v3    # "levelEvdoDbm":I
    :cond_4
    const/4 v3, 0x0

    .restart local v3    # "levelEvdoDbm":I
    goto :goto_1

    .line 816
    :cond_5
    const/4 v6, 0x5

    if-lt v1, v6, :cond_6

    const/4 v4, 0x3

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_2

    .line 817
    .end local v4    # "levelEvdoSnr":I
    :cond_6
    const/4 v6, 0x3

    if-lt v1, v6, :cond_7

    const/4 v4, 0x2

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_2

    .line 818
    .end local v4    # "levelEvdoSnr":I
    :cond_7
    const/4 v6, 0x1

    if-lt v1, v6, :cond_8

    const/4 v4, 0x1

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_2

    .line 819
    .end local v4    # "levelEvdoSnr":I
    :cond_8
    const/4 v4, 0x0

    .restart local v4    # "levelEvdoSnr":I
    goto :goto_2

    :cond_9
    move v2, v4

    .line 821
    goto :goto_3
.end method

.method public getEvdoSnr()I
    .locals 1

    .prologue
    .line 526
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    return v0
.end method

.method public getGsmAsuLevel()I
    .locals 1

    .prologue
    .line 719
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmSignalStrength()I

    move-result v0

    .line 721
    .local v0, "level":I
    return v0
.end method

.method public getGsmBitErrorRate()I
    .locals 1

    .prologue
    .line 491
    iget v0, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    return v0
.end method

.method public getGsmDbm()I
    .locals 5

    .prologue
    const/4 v3, -0x1

    .line 669
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmSignalStrength()I

    move-result v2

    .line 670
    .local v2, "gsmSignalStrength":I
    const/16 v4, 0x63

    if-ne v2, v4, :cond_0

    move v0, v3

    .line 671
    .local v0, "asu":I
    :goto_0
    if-eq v0, v3, :cond_1

    .line 672
    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v1, v3, -0x71

    .line 677
    .local v1, "dBm":I
    :goto_1
    return v1

    .end local v0    # "asu":I
    .end local v1    # "dBm":I
    :cond_0
    move v0, v2

    .line 670
    goto :goto_0

    .line 674
    .restart local v0    # "asu":I
    :cond_1
    const/4 v1, -0x1

    .restart local v1    # "dBm":I
    goto :goto_1
.end method

.method public getGsmLevel()I
    .locals 5

    .prologue
    .line 689
    iget-object v3, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmSignalStrength()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v2

    .line 690
    .local v2, "lgLevel":I
    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    .line 706
    .end local v2    # "lgLevel":I
    :goto_0
    return v2

    .line 699
    .restart local v2    # "lgLevel":I
    :cond_0
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmSignalStrength()I

    move-result v0

    .line 700
    .local v0, "asu":I
    const/4 v3, 0x2

    if-le v0, v3, :cond_1

    const/16 v3, 0x63

    if-ne v0, v3, :cond_2

    :cond_1
    const/4 v1, 0x0

    .local v1, "level":I
    :goto_1
    move v2, v1

    .line 706
    goto :goto_0

    .line 701
    .end local v1    # "level":I
    :cond_2
    const/16 v3, 0xc

    if-lt v0, v3, :cond_3

    const/4 v1, 0x4

    .restart local v1    # "level":I
    goto :goto_1

    .line 702
    .end local v1    # "level":I
    :cond_3
    const/16 v3, 0x8

    if-lt v0, v3, :cond_4

    const/4 v1, 0x3

    .restart local v1    # "level":I
    goto :goto_1

    .line 703
    .end local v1    # "level":I
    :cond_4
    const/4 v3, 0x5

    if-lt v0, v3, :cond_5

    const/4 v1, 0x2

    .restart local v1    # "level":I
    goto :goto_1

    .line 704
    .end local v1    # "level":I
    :cond_5
    const/4 v1, 0x1

    .restart local v1    # "level":I
    goto :goto_1
.end method

.method public getGsmSignalStrength()I
    .locals 1

    .prologue
    .line 484
    iget v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    return v0
.end method

.method public getLevel()I
    .locals 15

    .prologue
    .line 560
    const/4 v13, 0x0

    .line 563
    .local v13, "level":I
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    iget v1, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    iget v2, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    iget v3, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    iget v4, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    iget v5, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    iget v6, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    iget v7, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    iget v8, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    iget v9, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    iget-boolean v10, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    invoke-virtual/range {v0 .. v10}, Lcom/lge/telephony/LGSignalStrength;->getLevel(IIIIIIIIIZ)I

    move-result v14

    .line 566
    .local v14, "lgLevel":I
    const/4 v0, -0x1

    if-eq v14, v0, :cond_0

    .line 595
    .end local v14    # "lgLevel":I
    :goto_0
    return v14

    .line 572
    .restart local v14    # "lgLevel":I
    :cond_0
    iget-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    if-eqz v0, :cond_2

    .line 573
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getLteLevel()I

    move-result v13

    .line 574
    if-nez v13, :cond_1

    .line 575
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaLevel()I

    move-result v13

    .line 576
    if-nez v13, :cond_1

    .line 577
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getGsmLevel()I

    move-result v13

    :cond_1
    :goto_1
    move v14, v13

    .line 595
    goto :goto_0

    .line 581
    :cond_2
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getCdmaLevel()I

    move-result v11

    .line 582
    .local v11, "cdmaLevel":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getEvdoLevel()I

    move-result v12

    .line 583
    .local v12, "evdoLevel":I
    if-nez v12, :cond_3

    .line 585
    move v13, v11

    goto :goto_1

    .line 586
    :cond_3
    if-nez v11, :cond_4

    .line 588
    move v13, v12

    goto :goto_1

    .line 591
    :cond_4
    if-ge v11, v12, :cond_5

    move v13, v11

    :goto_2
    goto :goto_1

    :cond_5
    move v13, v12

    goto :goto_2
.end method

.method public getLteAsuLevel()I
    .locals 3

    .prologue
    .line 960
    const/16 v0, 0x63

    .line 961
    .local v0, "lteAsuLevel":I
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getLteDbm()I

    move-result v1

    .line 975
    .local v1, "lteDbm":I
    const v2, 0x7fffffff

    if-ne v1, v2, :cond_0

    const/16 v0, 0xff

    .line 978
    :goto_0
    return v0

    .line 976
    :cond_0
    add-int/lit16 v0, v1, 0x8c

    goto :goto_0
.end method

.method public getLteCqi()I
    .locals 1

    .prologue
    .line 551
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    return v0
.end method

.method public getLteDbm()I
    .locals 1

    .prologue
    .line 862
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    return v0
.end method

.method public getLteLevel()I
    .locals 9

    .prologue
    const/4 v8, -0x1

    .line 890
    iget-object v4, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    iget v5, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    iget v6, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    iget v7, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    invoke-virtual {v4, v5, v6, v7}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    .line 891
    .local v0, "lgLevel":I
    if-eq v0, v8, :cond_1

    move v1, v0

    .line 950
    :cond_0
    :goto_0
    return v1

    .line 902
    :cond_1
    const/4 v2, 0x0

    .local v2, "rssiIconLevel":I
    const/4 v1, -0x1

    .local v1, "rsrpIconLevel":I
    const/4 v3, -0x1

    .line 904
    .local v3, "snrIconLevel":I
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v5, -0x2c

    if-le v4, v5, :cond_4

    const/4 v1, -0x1

    .line 917
    :cond_2
    :goto_1
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v5, 0x12c

    if-le v4, v5, :cond_9

    const/4 v3, -0x1

    .line 929
    :cond_3
    :goto_2
    if-eq v3, v8, :cond_e

    if-eq v1, v8, :cond_e

    .line 935
    if-lt v1, v3, :cond_0

    move v1, v3

    goto :goto_0

    .line 905
    :cond_4
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v5, -0x55

    if-lt v4, v5, :cond_5

    const/4 v1, 0x4

    goto :goto_1

    .line 906
    :cond_5
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v5, -0x5f

    if-lt v4, v5, :cond_6

    const/4 v1, 0x3

    goto :goto_1

    .line 907
    :cond_6
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v5, -0x69

    if-lt v4, v5, :cond_7

    const/4 v1, 0x2

    goto :goto_1

    .line 908
    :cond_7
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v5, -0x73

    if-lt v4, v5, :cond_8

    const/4 v1, 0x1

    goto :goto_1

    .line 909
    :cond_8
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v5, -0x8c

    if-lt v4, v5, :cond_2

    const/4 v1, 0x0

    goto :goto_1

    .line 918
    :cond_9
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v5, 0x82

    if-lt v4, v5, :cond_a

    const/4 v3, 0x4

    goto :goto_2

    .line 919
    :cond_a
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v5, 0x2d

    if-lt v4, v5, :cond_b

    const/4 v3, 0x3

    goto :goto_2

    .line 920
    :cond_b
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v5, 0xa

    if-lt v4, v5, :cond_c

    const/4 v3, 0x2

    goto :goto_2

    .line 921
    :cond_c
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v5, -0x1e

    if-lt v4, v5, :cond_d

    const/4 v3, 0x1

    goto :goto_2

    .line 922
    :cond_d
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v5, -0xc8

    if-lt v4, v5, :cond_3

    .line 923
    const/4 v3, 0x0

    goto :goto_2

    .line 938
    :cond_e
    if-eq v3, v8, :cond_f

    move v1, v3

    goto :goto_0

    .line 940
    :cond_f
    if-ne v1, v8, :cond_0

    .line 943
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    const/16 v5, 0x3f

    if-le v4, v5, :cond_11

    const/4 v2, 0x0

    :cond_10
    :goto_3
    move v1, v2

    .line 950
    goto :goto_0

    .line 944
    :cond_11
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    const/16 v5, 0xc

    if-lt v4, v5, :cond_12

    const/4 v2, 0x4

    goto :goto_3

    .line 945
    :cond_12
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    const/16 v5, 0x8

    if-lt v4, v5, :cond_13

    const/4 v2, 0x3

    goto :goto_3

    .line 946
    :cond_13
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    const/4 v5, 0x5

    if-lt v4, v5, :cond_14

    const/4 v2, 0x2

    goto :goto_3

    .line 947
    :cond_14
    iget v4, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    if-ltz v4, :cond_10

    const/4 v2, 0x1

    goto :goto_3
.end method

.method public getLteRsrp()I
    .locals 1

    .prologue
    .line 536
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    return v0
.end method

.method public getLteRsrq()I
    .locals 1

    .prologue
    .line 541
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    return v0
.end method

.method public getLteRssnr()I
    .locals 1

    .prologue
    .line 546
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    return v0
.end method

.method public getLteSignalStrength()I
    .locals 1

    .prologue
    .line 531
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    return v0
.end method

.method public getTdScdmaAsuLevel()I
    .locals 3

    .prologue
    .line 1027
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaDbm()I

    move-result v1

    .line 1030
    .local v1, "tdScdmaDbm":I
    const v2, 0x7fffffff

    if-ne v1, v2, :cond_0

    const/16 v0, 0xff

    .line 1033
    .local v0, "tdScdmaAsuLevel":I
    :goto_0
    return v0

    .line 1031
    .end local v0    # "tdScdmaAsuLevel":I
    :cond_0
    add-int/lit8 v0, v1, 0x78

    .restart local v0    # "tdScdmaAsuLevel":I
    goto :goto_0
.end method

.method public getTdScdmaDbm()I
    .locals 1

    .prologue
    .line 994
    iget v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    return v0
.end method

.method public getTdScdmaLevel()I
    .locals 3

    .prologue
    .line 1006
    invoke-virtual {p0}, Landroid/telephony/SignalStrength;->getTdScdmaDbm()I

    move-result v1

    .line 1009
    .local v1, "tdScdmaDbm":I
    const/16 v2, -0x19

    if-gt v1, v2, :cond_0

    const v2, 0x7fffffff

    if-ne v1, v2, :cond_1

    .line 1010
    :cond_0
    const/4 v0, 0x0

    .line 1018
    .local v0, "level":I
    :goto_0
    return v0

    .line 1011
    .end local v0    # "level":I
    :cond_1
    const/16 v2, -0x31

    if-lt v1, v2, :cond_2

    const/4 v0, 0x4

    .restart local v0    # "level":I
    goto :goto_0

    .line 1012
    .end local v0    # "level":I
    :cond_2
    const/16 v2, -0x49

    if-lt v1, v2, :cond_3

    const/4 v0, 0x3

    .restart local v0    # "level":I
    goto :goto_0

    .line 1013
    .end local v0    # "level":I
    :cond_3
    const/16 v2, -0x61

    if-lt v1, v2, :cond_4

    const/4 v0, 0x2

    .restart local v0    # "level":I
    goto :goto_0

    .line 1014
    .end local v0    # "level":I
    :cond_4
    const/16 v2, -0x78

    if-lt v1, v2, :cond_5

    const/4 v0, 0x1

    .restart local v0    # "level":I
    goto :goto_0

    .line 1015
    .end local v0    # "level":I
    :cond_5
    const/4 v0, 0x0

    .restart local v0    # "level":I
    goto :goto_0
.end method

.method public hashCode()I
    .locals 3

    .prologue
    .line 1041
    const/16 v0, 0x1f

    .line 1042
    .local v0, "primeNum":I
    iget v1, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    mul-int/2addr v1, v0

    iget v2, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    mul-int/2addr v2, v0

    add-int/2addr v1, v2

    iget v2, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    mul-int/2addr v2, v0

    add-int/2addr v2, v1

    iget-boolean v1, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    add-int/2addr v1, v2

    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public initialize(IIIIIIIIIIIIZ)V
    .locals 1
    .param p1, "gsmSignalStrength"    # I
    .param p2, "gsmBitErrorRate"    # I
    .param p3, "cdmaDbm"    # I
    .param p4, "cdmaEcio"    # I
    .param p5, "evdoDbm"    # I
    .param p6, "evdoEcio"    # I
    .param p7, "evdoSnr"    # I
    .param p8, "lteSignalStrength"    # I
    .param p9, "lteRsrp"    # I
    .param p10, "lteRsrq"    # I
    .param p11, "lteRssnr"    # I
    .param p12, "lteCqi"    # I
    .param p13, "gsm"    # Z

    .prologue
    .line 267
    iput p1, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 268
    iput p2, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    .line 269
    iput p3, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 270
    iput p4, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 271
    iput p5, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 272
    iput p6, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 273
    iput p7, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 274
    iput p8, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 275
    iput p9, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 276
    iput p10, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 277
    iput p11, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 278
    iput p12, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    .line 279
    const v0, 0x7fffffff

    iput v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 280
    iput-boolean p13, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 282
    return-void
.end method

.method public initialize(IIIIIIIZ)V
    .locals 14
    .param p1, "gsmSignalStrength"    # I
    .param p2, "gsmBitErrorRate"    # I
    .param p3, "cdmaDbm"    # I
    .param p4, "cdmaEcio"    # I
    .param p5, "evdoDbm"    # I
    .param p6, "evdoEcio"    # I
    .param p7, "evdoSnr"    # I
    .param p8, "gsm"    # Z

    .prologue
    .line 238
    const/16 v8, 0x63

    const v9, 0x7fffffff

    const v10, 0x7fffffff

    const v11, 0x7fffffff

    const v12, 0x7fffffff

    move-object v0, p0

    move v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v13, p8

    invoke-virtual/range {v0 .. v13}, Landroid/telephony/SignalStrength;->initialize(IIIIIIIIIIIIZ)V

    .line 241
    return-void
.end method

.method public isGsm()Z
    .locals 1

    .prologue
    .line 985
    iget-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    return v0
.end method

.method public setDataRadioTechnology(I)V
    .locals 1
    .param p1, "dataRadioTechnology"    # I

    .prologue
    .line 1170
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/LGSignalStrength;->setDataRadioTechnology(I)V

    .line 1171
    return-void
.end method

.method public setGsm(Z)V
    .locals 0
    .param p1, "gsmFlag"    # Z

    .prologue
    .line 470
    iput-boolean p1, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    .line 471
    return-void
.end method

.method public setfeature(I)V
    .locals 0
    .param p1, "feature"    # I

    .prologue
    .line 475
    iput p1, p0, Landroid/telephony/SignalStrength;->datafeature:I

    .line 476
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1089
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SignalStrength: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    if-eqz v0, :cond_0

    const-string v0, "gsm|lte"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v1}, Lcom/lge/telephony/LGSignalStrength;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "cdma"

    goto :goto_0
.end method

.method public validateInput()V
    .locals 6

    .prologue
    const/16 v1, 0x63

    const/16 v5, 0x8

    const/16 v2, -0x78

    const/4 v3, -0x1

    const v4, 0x7fffffff

    .line 429
    iget v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    if-ltz v0, :cond_4

    iget v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    :goto_0
    iput v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    .line 432
    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    if-lez v0, :cond_5

    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    neg-int v0, v0

    :goto_1
    iput v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    .line 433
    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    if-lez v0, :cond_6

    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    neg-int v0, v0

    :goto_2
    iput v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    .line 435
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    if-lez v0, :cond_0

    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    neg-int v2, v0

    :cond_0
    iput v2, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    .line 436
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    if-ltz v0, :cond_7

    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    neg-int v0, v0

    :goto_3
    iput v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    .line 438
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 439
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    if-ltz v0, :cond_1

    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    if-gt v0, v5, :cond_1

    iget v3, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    :cond_1
    iput v3, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    .line 448
    :goto_4
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    if-ltz v0, :cond_2

    iget v1, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    :cond_2
    iput v1, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    .line 449
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v1, 0x2c

    if-lt v0, v1, :cond_a

    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    const/16 v1, 0x8c

    if-gt v0, v1, :cond_a

    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    neg-int v0, v0

    :goto_5
    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    .line 450
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    const/4 v1, 0x3

    if-lt v0, v1, :cond_b

    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    const/16 v1, 0x14

    if-gt v0, v1, :cond_b

    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    neg-int v0, v0

    :goto_6
    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    .line 451
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v1, -0xc8

    if-lt v0, v1, :cond_c

    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    const/16 v1, 0x12c

    if-gt v0, v1, :cond_c

    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    :goto_7
    iput v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    .line 454
    iget v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_3

    iget v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    const/16 v1, 0x78

    if-gt v0, v1, :cond_3

    iget v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    neg-int v4, v0

    :cond_3
    iput v4, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    .line 459
    return-void

    :cond_4
    move v0, v1

    .line 429
    goto/16 :goto_0

    :cond_5
    move v0, v2

    .line 432
    goto :goto_1

    .line 433
    :cond_6
    const/16 v0, -0xa0

    goto :goto_2

    :cond_7
    move v0, v3

    .line 436
    goto :goto_3

    .line 442
    :cond_8
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    if-lez v0, :cond_9

    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    if-gt v0, v5, :cond_9

    iget v3, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    :cond_9
    iput v3, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    goto :goto_4

    :cond_a
    move v0, v4

    .line 449
    goto :goto_5

    :cond_b
    move v0, v4

    .line 450
    goto :goto_6

    :cond_c
    move v0, v4

    .line 451
    goto :goto_7
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 371
    iget v0, p0, Landroid/telephony/SignalStrength;->mGsmSignalStrength:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 372
    iget v0, p0, Landroid/telephony/SignalStrength;->mGsmBitErrorRate:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 373
    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaDbm:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 374
    iget v0, p0, Landroid/telephony/SignalStrength;->mCdmaEcio:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 375
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoDbm:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 376
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoEcio:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 377
    iget v0, p0, Landroid/telephony/SignalStrength;->mEvdoSnr:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 378
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteSignalStrength:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 379
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrp:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 380
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRsrq:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 381
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteRssnr:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 382
    iget v0, p0, Landroid/telephony/SignalStrength;->mLteCqi:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 383
    iget v0, p0, Landroid/telephony/SignalStrength;->mTdScdmaRscp:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 384
    iget-boolean v0, p0, Landroid/telephony/SignalStrength;->isGsm:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 386
    iget v0, p0, Landroid/telephony/SignalStrength;->datafeature:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 389
    iget-object v0, p0, Landroid/telephony/SignalStrength;->mLGSignalStrength:Lcom/lge/telephony/LGSignalStrength;

    invoke-virtual {v0, p1, p2}, Lcom/lge/telephony/LGSignalStrength;->writeTo(Landroid/os/Parcel;I)V

    .line 391
    return-void

    .line 384
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
