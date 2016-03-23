.class public Lcom/lge/telephony/LGSignalStrength;
.super Ljava/lang/Object;
.source "LGSignalStrength.java"


# static fields
.field private static final DBG:Z = false

.field private static final INVALID:I = 0x7fffffff

.field public static final INVALID_LEVEL:I = -0x1

.field private static final LG_SIGNAL_STRENGTH_NONE_OR_UNKNOWN:I = 0x0

.field private static final LOG_TAG:Ljava/lang/String; = "LGSignalStrength"

.field private static final NUM_LG_SIGNAL_STRENGTH_AWESOME:I = 0x5

.field private static final NUM_LG_SIGNAL_STRENGTH_BEST:I = 0x6

.field public static final NUM_LG_SIGNAL_STRENGTH_BINS:I

.field private static final NUM_LG_SIGNAL_STRENGTH_GREAT:I = 0x4

.field private static lastLevelIndex:I

.field private static lastLevels:[I

.field private static mLGRssiData:Lcom/lge/telephony/LGRssiData;


# instance fields
.field private LGE_GSM_ASU_VALUE:[I

.field private LGE_LTE_RSRP_VALUE:[I

.field private LGE_UMTS_ASU_VALUE:[I

.field private mDataRadioTechnology:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getNumSignalStrength()I

    move-result v0

    sput v0, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    const/4 v0, 0x5

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/lge/telephony/LGSignalStrength;->lastLevels:[I

    const/4 v0, 0x0

    sput v0, Lcom/lge/telephony/LGSignalStrength;->lastLevelIndex:I

    return-void

    :array_0
    .array-data 4
        0x5
        0x5
        0x5
        0x5
        0x5
    .end array-data
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v2, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    new-array v0, v1, [I

    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/lge/telephony/LGSignalStrength;->LGE_LTE_RSRP_VALUE:[I

    new-array v0, v1, [I

    fill-array-data v0, :array_1

    iput-object v0, p0, Lcom/lge/telephony/LGSignalStrength;->LGE_GSM_ASU_VALUE:[I

    new-array v0, v1, [I

    fill-array-data v0, :array_2

    iput-object v0, p0, Lcom/lge/telephony/LGSignalStrength;->LGE_UMTS_ASU_VALUE:[I

    iput v2, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    return-void

    nop

    :array_0
    .array-data 4
        -0x54
        -0x5e
        -0x68
        -0x72
        -0x7f
    .end array-data

    :array_1
    .array-data 4
        0xc
        0x9
        0x8
        0x6
        0x5
    .end array-data

    :array_2
    .array-data 4
        0xd
        0xa
        0x7
        0x5
        0x2
    .end array-data
.end method

.method private averageOfRecentLevels(I)I
    .locals 6
    .param p1, "level"    # I

    .prologue
    const/4 v2, 0x0

    .local v2, "sum":I
    const/4 v0, 0x0

    .local v0, "avr":I
    sget-object v3, Lcom/lge/telephony/LGSignalStrength;->lastLevels:[I

    sget v4, Lcom/lge/telephony/LGSignalStrength;->lastLevelIndex:I

    add-int/lit8 v5, v4, 0x1

    sput v5, Lcom/lge/telephony/LGSignalStrength;->lastLevelIndex:I

    aput p1, v3, v4

    sget v3, Lcom/lge/telephony/LGSignalStrength;->lastLevelIndex:I

    sget-object v4, Lcom/lge/telephony/LGSignalStrength;->lastLevels:[I

    array-length v4, v4

    if-ne v3, v4, :cond_0

    const/4 v3, 0x0

    sput v3, Lcom/lge/telephony/LGSignalStrength;->lastLevelIndex:I

    :cond_0
    const/4 v1, 0x0

    .local v1, "kk":I
    :goto_0
    sget-object v3, Lcom/lge/telephony/LGSignalStrength;->lastLevels:[I

    array-length v3, v3

    if-ge v1, v3, :cond_1

    sget-object v3, Lcom/lge/telephony/LGSignalStrength;->lastLevels:[I

    aget v3, v3, v1

    add-int/2addr v2, v3

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    sget-object v3, Lcom/lge/telephony/LGSignalStrength;->lastLevels:[I

    array-length v3, v3

    div-int v0, v2, v3

    if-le p1, v0, :cond_2

    :goto_1
    return p1

    :cond_2
    move p1, v0

    goto :goto_1
.end method

.method private getAxgpLevel(III)I
    .locals 8
    .param p1, "mLteSignalStrength"    # I
    .param p2, "mLteRsrp"    # I
    .param p3, "mLteRssnr"    # I

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v7, -0x1

    const/16 v6, 0x63

    if-ne p1, v6, :cond_1

    move v2, v4

    :cond_0
    :goto_0
    return v2

    :cond_1
    const/4 v2, -0x1

    .local v2, "rsrpIconLevel":I
    const/4 v3, -0x1

    .local v3, "snrIconLevel":I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v6

    invoke-virtual {v6}, Lcom/lge/telephony/LGRssiData;->getAxgpRsrpValue()[I

    move-result-object v0

    .local v0, "mAxgpRsrpValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v6

    invoke-virtual {v6}, Lcom/lge/telephony/LGRssiData;->getAxgpRssnrValue()[I

    move-result-object v1

    .local v1, "mAxgpRssnrValue":[I
    if-nez v0, :cond_2

    if-nez v1, :cond_2

    move v2, v4

    goto :goto_0

    :cond_2
    const/16 v6, -0x2c

    invoke-virtual {p0, p2, v6, v0}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v2

    const/16 v6, 0x12c

    invoke-virtual {p0, p3, v6, v1}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v3

    if-eq v2, v5, :cond_3

    if-ne v3, v5, :cond_4

    :cond_3
    move v2, v5

    goto :goto_0

    :cond_4
    if-eq v3, v7, :cond_5

    if-eq v2, v7, :cond_5

    if-lt v2, v3, :cond_0

    move v2, v3

    goto :goto_0

    :cond_5
    if-eq v3, v7, :cond_6

    move v2, v3

    goto :goto_0

    :cond_6
    if-ne v2, v7, :cond_0

    move v2, v4

    goto :goto_0
.end method

.method private static getLGRssiData()Lcom/lge/telephony/LGRssiData;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/LGSignalStrength;->mLGRssiData:Lcom/lge/telephony/LGRssiData;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/lge/telephony/LGRssiData;->getInstance()Lcom/lge/telephony/LGRssiData;

    move-result-object v0

    sput-object v0, Lcom/lge/telephony/LGSignalStrength;->mLGRssiData:Lcom/lge/telephony/LGRssiData;

    sget-object v0, Lcom/lge/telephony/LGSignalStrength;->mLGRssiData:Lcom/lge/telephony/LGRssiData;

    invoke-virtual {v0}, Lcom/lge/telephony/LGRssiData;->init()V

    :cond_0
    sget-object v0, Lcom/lge/telephony/LGSignalStrength;->mLGRssiData:Lcom/lge/telephony/LGRssiData;

    return-object v0
.end method

.method private getLevelACG(IIIIIIIIZ)I
    .locals 1
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    invoke-direct/range {p0 .. p9}, Lcom/lge/telephony/LGSignalStrength;->getLevelUSC(IIIIIIIIZ)I

    move-result v0

    return v0
.end method

.method private getLevelCT(IIIIIIIIZ)I
    .locals 5
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    const/4 v2, 0x0

    .local v2, "level":I
    if-eqz p9, :cond_1

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v2

    :cond_0
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getLevelCT="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    return v2

    :cond_1
    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    .local v0, "cdmaLevel":I
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v1

    .local v1, "evdoLevel":I
    if-nez v1, :cond_2

    move v2, v0

    goto :goto_0

    :cond_2
    if-nez v0, :cond_3

    move v2, v1

    goto :goto_0

    :cond_3
    if-ge v0, v1, :cond_4

    move v2, v0

    :goto_1
    goto :goto_0

    :cond_4
    move v2, v1

    goto :goto_1
.end method

.method private getLevelH3G(IIIIIIZ)I
    .locals 2
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mLteSignalStrength"    # I
    .param p5, "mLteRsrp"    # I
    .param p6, "mLteRssnr"    # I
    .param p7, "isGsm"    # Z

    .prologue
    const/4 v0, 0x0

    .local v0, "level":I
    if-eqz p7, :cond_0

    invoke-virtual {p0, p4, p5, p6}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    if-nez v0, :cond_0

    const/16 v1, 0x63

    if-eq p1, v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/telephony/LGSignalStrength;->getDataRadioTechnology()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    const v1, -0x37849

    if-ne p3, v1, :cond_1

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v0

    :cond_0
    :goto_0
    return v0

    :pswitch_1
    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v0

    goto :goto_0

    :pswitch_2
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private getLevelKDDI(IIIIIIIIZ)I
    .locals 5
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    const/4 v2, 0x0

    .local v2, "level":I
    if-eqz p9, :cond_2

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v2

    :cond_0
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v3

    if-eqz v3, :cond_1

    const/16 v3, -0x78

    if-eq p2, v3, :cond_1

    const/16 v3, -0xa0

    if-eq p3, v3, :cond_1

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v3

    const/4 v4, 0x2

    if-ne v3, v4, :cond_1

    const-string v3, "KDDI signalstrength When in call"

    invoke-static {v3}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v2

    :cond_1
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getLevelKDDI="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    return v2

    :cond_2
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    .local v0, "cdmaLevel":I
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v1

    .local v1, "evdoLevel":I
    if-nez v1, :cond_3

    move v2, v0

    :goto_1
    if-nez v2, :cond_1

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CDMALEVEL is Unknown , getLteLevel: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-nez v0, :cond_4

    move v2, v1

    goto :goto_1

    :cond_4
    if-ge v0, v1, :cond_5

    move v2, v0

    :goto_2
    goto :goto_1

    :cond_5
    move v2, v1

    goto :goto_2
.end method

.method private getLevelKR(IIIIIIIIIZ)I
    .locals 4
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "mLteRsrq"    # I
    .param p10, "isGsm"    # Z

    .prologue
    if-eqz p10, :cond_3

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    .local v0, "level":I
    const-string v1, "LGU"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/16 v1, -0x10

    if-lt v1, p9, :cond_0

    if-lez v0, :cond_0

    add-int/lit8 v0, v0, -0x1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mLteRsrq="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", fixed level="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    :cond_0
    if-nez v0, :cond_1

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v0

    :cond_1
    :goto_0
    const/4 v1, -0x1

    if-ne v0, v1, :cond_2

    const/4 v0, 0x0

    .end local v0    # "level":I
    :cond_2
    return v0

    :cond_3
    const/4 v1, 0x0

    const-string v2, "support_svlte"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    const-string v1, "1"

    const-string v2, "net.ims.ims_indicator"

    const-string v3, "2"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    .restart local v0    # "level":I
    goto :goto_0

    .end local v0    # "level":I
    :cond_4
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    .restart local v0    # "level":I
    goto :goto_0
.end method

.method private getLevelSBM(IIIIIIIIZ)I
    .locals 3
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    const/16 v2, -0x78

    const/4 v0, 0x0

    .local v0, "level":I
    if-eqz p9, :cond_4

    invoke-direct {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getAxgpLevel(III)I

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    :cond_0
    if-nez v0, :cond_2

    if-ne p2, v2, :cond_1

    const/16 v1, -0xa0

    if-eq p3, v1, :cond_2

    :cond_1
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    :cond_2
    if-nez v0, :cond_3

    if-eq p4, v2, :cond_3

    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v0

    :cond_3
    if-nez v0, :cond_4

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SBM tech="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/telephony/LGSignalStrength;->getDataRadioTechnology()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    const/4 v0, 0x1

    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getLevelSBM="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    return v0
.end method

.method private getLevelSPR(IIIIIIIIZ)I
    .locals 4
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    const/4 v0, 0x0

    .local v0, "level":I
    const/4 v2, 0x0

    const-string v3, "data_only_device"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    :goto_0
    return v2

    :cond_0
    if-eqz p9, :cond_2

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v0

    :cond_1
    :goto_1
    move v2, v0

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lcom/lge/telephony/LGSignalStrength;->getDataRadioTechnology()I

    move-result v1

    .local v1, "rat":I
    packed-switch v1, :pswitch_data_0

    :pswitch_0
    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    goto :goto_1

    :pswitch_1
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    goto :goto_1

    :pswitch_2
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v0

    goto :goto_1

    :pswitch_3
    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    goto :goto_1

    :pswitch_data_0
    .packed-switch 0x4
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private getLevelUSC(IIIIIIIIZ)I
    .locals 1
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    const/4 v0, 0x0

    .local v0, "level":I
    if-eqz p9, :cond_0

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v0

    :goto_0
    return v0

    :cond_0
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    goto :goto_0
.end method

.method private getLevelUsGsm(IIIIIIIIZ)I
    .locals 2
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    const/4 v0, 0x0

    .local v0, "level":I
    if-eqz p9, :cond_0

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v0

    if-nez v0, :cond_0

    const v1, -0x37849

    if-eq p3, v1, :cond_1

    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v0

    goto :goto_0
.end method

.method private getLevelVZW(IIIIIIIIZ)I
    .locals 5
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "isGsm"    # Z

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/LGSignalStrength;->getDataRadioTechnology()I

    move-result v3

    .local v3, "rat":I
    if-eqz p9, :cond_2

    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    .local v2, "level":I
    if-nez v2, :cond_1

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGSignalStrength;->getGsmLevel(I)I

    move-result v2

    if-nez v2, :cond_1

    const/4 v4, 0x7

    if-eq v3, v4, :cond_0

    const/16 v4, 0x8

    if-eq v3, v4, :cond_0

    const/16 v4, 0xc

    if-eq v3, v4, :cond_0

    const/16 v4, 0xd

    if-ne v3, v4, :cond_1

    :cond_0
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v2

    :cond_1
    :goto_0
    return v2

    .end local v2    # "level":I
    :cond_2
    invoke-virtual {p0, p6, p7, p8}, Lcom/lge/telephony/LGSignalStrength;->getLteLevel(III)I

    move-result v2

    .restart local v2    # "level":I
    if-nez v2, :cond_1

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v0

    .local v0, "cdmaLevel":I
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v1

    .local v1, "evdoLevel":I
    if-lt v0, v1, :cond_3

    move v2, v0

    :goto_1
    goto :goto_0

    .end local v0    # "cdmaLevel":I
    .end local v1    # "evdoLevel":I
    :pswitch_1
    invoke-virtual {p0, p2, p3}, Lcom/lge/telephony/LGSignalStrength;->getCdmaLevel(II)I

    move-result v2

    goto :goto_0

    :pswitch_2
    invoke-virtual {p0, p4, p5}, Lcom/lge/telephony/LGSignalStrength;->getEvdoLevel(II)I

    move-result v2

    goto :goto_0

    .restart local v0    # "cdmaLevel":I
    .restart local v1    # "evdoLevel":I
    :cond_3
    move v2, v1

    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x4
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method protected static getNumSignalStrength()I
    .locals 2

    .prologue
    const-string v0, "BM"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "SPR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x7

    :goto_0
    return v0

    :cond_1
    const-string v0, "DCM"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x5

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getNumSignalStrength: mRssiLevel = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    sget v1, Lcom/lge/telephony/LGRssiData;->mRssiLevel:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    sget v0, Lcom/lge/telephony/LGRssiData;->mRssiLevel:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_3

    const/4 v0, 0x6

    goto :goto_0

    :cond_3
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    sget v0, Lcom/lge/telephony/LGRssiData;->mRssiLevel:I

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGSignalStrength"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public copyFrom(Lcom/lge/telephony/LGSignalStrength;)V
    .locals 1
    .param p1, "s"    # Lcom/lge/telephony/LGSignalStrength;

    .prologue
    iget v0, p1, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    iput v0, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    return-void
.end method

.method public getCdmaLevel(II)I
    .locals 7
    .param p1, "cdmaDbm"    # I
    .param p2, "cdmaEcio"    # I

    .prologue
    const/4 v6, -0x1

    const/4 v0, -0x1

    .local v0, "level":I
    const/4 v1, 0x0

    .local v1, "levelDbm":I
    const/4 v2, 0x0

    .local v2, "levelEcio":I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getCdmaDbmValue()[I

    move-result-object v3

    .local v3, "mDbmValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getEcioValue()[I

    move-result-object v4

    .local v4, "mEcioValue":[I
    if-nez v3, :cond_0

    if-eqz v4, :cond_2

    :cond_0
    invoke-virtual {p0, p1, v3}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(I[I)I

    move-result v1

    invoke-virtual {p0, p2, v4}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(I[I)I

    move-result v2

    const-string v5, "ATT"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-direct {p0, v2}, Lcom/lge/telephony/LGSignalStrength;->averageOfRecentLevels(I)I

    move-result v2

    :cond_1
    if-eq v1, v6, :cond_4

    if-eq v2, v6, :cond_4

    if-ge v1, v2, :cond_3

    move v5, v1

    :goto_0
    move v0, v5

    .end local v0    # "level":I
    :cond_2
    :goto_1
    return v0

    .restart local v0    # "level":I
    :cond_3
    move v5, v2

    goto :goto_0

    :cond_4
    if-eq v1, v6, :cond_5

    move v0, v1

    goto :goto_1

    :cond_5
    if-eq v2, v6, :cond_6

    move v0, v2

    goto :goto_1

    :cond_6
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public getDataRadioTechnology()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    return v0
.end method

.method public getEvdoLevel(II)I
    .locals 7
    .param p1, "evdoDbm"    # I
    .param p2, "evdoSnr"    # I

    .prologue
    const/4 v6, -0x1

    const/4 v0, -0x1

    .local v0, "level":I
    const/4 v1, 0x0

    .local v1, "levelEvdoDbm":I
    const/4 v2, 0x0

    .local v2, "levelEvdoSnr":I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getEvdoDbmValue()[I

    move-result-object v3

    .local v3, "mEvdoDbmValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getEvdoSnrValue()[I

    move-result-object v4

    .local v4, "mEvdoSnrValue":[I
    if-nez v3, :cond_0

    if-eqz v4, :cond_1

    :cond_0
    invoke-virtual {p0, p1, v3}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(I[I)I

    move-result v1

    invoke-virtual {p0, p2, v4}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(I[I)I

    move-result v2

    if-eq v1, v6, :cond_3

    if-eq v2, v6, :cond_3

    if-ge v1, v2, :cond_2

    move v5, v1

    :goto_0
    move v0, v5

    .end local v0    # "level":I
    :cond_1
    :goto_1
    return v0

    .restart local v0    # "level":I
    :cond_2
    move v5, v2

    goto :goto_0

    :cond_3
    if-eq v1, v6, :cond_4

    move v0, v1

    goto :goto_1

    :cond_4
    if-eq v2, v6, :cond_5

    move v0, v2

    goto :goto_1

    :cond_5
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public getGsmLevel(I)I
    .locals 9
    .param p1, "asu"    # I

    .prologue
    const/4 v4, 0x0

    const/4 v8, -0x1

    const/16 v7, 0x63

    const/4 v0, -0x1

    .local v0, "level":I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getAsuGsmValue()[I

    move-result-object v2

    .local v2, "mAsuGsmValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getAsuUmtsValue()[I

    move-result-object v3

    .local v3, "mAsuUmtsValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/telephony/LGRssiData;->getAsuEtcValue()[I

    move-result-object v1

    .local v1, "mAsuEtcValue":[I
    if-nez v2, :cond_2

    if-nez v3, :cond_2

    sget v5, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    const/4 v6, 0x6

    if-ne v5, v6, :cond_2

    invoke-virtual {p0}, Lcom/lge/telephony/LGSignalStrength;->getDataRadioTechnology()I

    move-result v5

    sparse-switch v5, :sswitch_data_0

    iget-object v5, p0, Lcom/lge/telephony/LGSignalStrength;->LGE_UMTS_ASU_VALUE:[I

    invoke-virtual {p0, p1, v7, v5}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v0

    :goto_0
    if-ne v0, v8, :cond_1

    :cond_0
    :goto_1
    return v4

    :sswitch_0
    iget-object v5, p0, Lcom/lge/telephony/LGSignalStrength;->LGE_GSM_ASU_VALUE:[I

    invoke-virtual {p0, p1, v7, v5}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v0

    goto :goto_0

    :cond_1
    move v4, v0

    goto :goto_1

    :cond_2
    if-nez v2, :cond_3

    if-eqz v3, :cond_6

    :cond_3
    invoke-virtual {p0}, Lcom/lge/telephony/LGSignalStrength;->getDataRadioTechnology()I

    move-result v5

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    const-string v5, "VZW"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_4

    const-string v5, "LRA"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    :cond_4
    invoke-virtual {p0, p1, v7, v3}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v0

    :goto_2
    if-eq v0, v8, :cond_0

    move v4, v0

    goto :goto_1

    :pswitch_1
    invoke-virtual {p0, p1, v7, v2}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v0

    goto :goto_2

    :pswitch_2
    invoke-virtual {p0, p1, v7, v3}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v0

    goto :goto_2

    :cond_5
    invoke-virtual {p0, p1, v7, v2}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v0

    goto :goto_2

    :cond_6
    move v4, v0

    goto :goto_1

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x1 -> :sswitch_0
        0x2 -> :sswitch_0
        0x10 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public getItemLevel(II[I)I
    .locals 4
    .param p1, "value"    # I
    .param p2, "valid"    # I
    .param p3, "range"    # [I

    .prologue
    const v3, 0x7fffffff

    const/16 v2, 0x63

    const/4 v1, 0x0

    .local v1, "level":I
    if-nez p3, :cond_0

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    if-ne p2, v2, :cond_1

    if-eq p1, v2, :cond_3

    :cond_1
    if-ne p2, v3, :cond_2

    if-eq p1, v3, :cond_3

    :cond_2
    if-le p1, p2, :cond_4

    :cond_3
    const/4 v2, 0x0

    goto :goto_0

    :cond_4
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    array-length v2, p3

    if-ge v0, v2, :cond_5

    aget v2, p3, v0

    if-lt p1, v2, :cond_6

    :cond_5
    sget v2, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    add-int/lit8 v3, v0, 0x1

    sub-int v1, v2, v3

    move v2, v1

    goto :goto_0

    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public getItemLevel(I[I)I
    .locals 4
    .param p1, "value"    # I
    .param p2, "range"    # [I

    .prologue
    const/4 v1, 0x0

    .local v1, "level":I
    if-nez p2, :cond_0

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    array-length v2, p2

    if-ge v0, v2, :cond_1

    aget v2, p2, v0

    if-lt p1, v2, :cond_2

    :cond_1
    sget v2, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    add-int/lit8 v3, v0, 0x1

    sub-int v1, v2, v3

    move v2, v1

    goto :goto_0

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public getLevel(IIIIIIIIIZ)I
    .locals 11
    .param p1, "mGsmSignalStrength"    # I
    .param p2, "mCdmaDbm"    # I
    .param p3, "mCdmaEcio"    # I
    .param p4, "mEvdoDbm"    # I
    .param p5, "mEvdoSnr"    # I
    .param p6, "mLteSignalStrength"    # I
    .param p7, "mLteRsrp"    # I
    .param p8, "mLteRssnr"    # I
    .param p9, "mLteRsrq"    # I
    .param p10, "isGsm"    # Z

    .prologue
    const/4 v10, -0x1

    .local v10, "level":I
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct/range {p0 .. p10}, Lcom/lge/telephony/LGSignalStrength;->getLevelKR(IIIIIIIIIZ)I

    move-result v10

    .end local v10    # "level":I
    :cond_0
    :goto_0
    return v10

    .restart local v10    # "level":I
    :cond_1
    const-string v0, "SPR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelSPR(IIIIIIIIZ)I

    move-result v10

    goto :goto_0

    :cond_2
    const-string v0, "VZW"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    const/4 v0, 0x0

    const-string v1, "trf_based_vzw"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelVZW(IIIIIIIIZ)I

    move-result v10

    goto :goto_0

    :cond_4
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelKDDI(IIIIIIIIZ)I

    move-result v10

    goto :goto_0

    :cond_5
    const-string v0, "CTC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelCT(IIIIIIIIZ)I

    move-result v10

    goto/16 :goto_0

    :cond_6
    const-string v0, "USC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelUSC(IIIIIIIIZ)I

    move-result v10

    goto/16 :goto_0

    :cond_7
    const-string v0, "ACG"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelACG(IIIIIIIIZ)I

    move-result v10

    goto/16 :goto_0

    :cond_8
    const-string v0, "US"

    const-string v1, "TMO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    const-string v0, "US"

    const-string v1, "MPCS"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    const-string v0, "US"

    const-string v1, "AIO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    const-string v0, "ATT"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    :cond_9
    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelUsGsm(IIIIIIIIZ)I

    move-result v10

    goto/16 :goto_0

    :cond_a
    const-string v0, "SBM"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p10

    invoke-direct/range {v0 .. v9}, Lcom/lge/telephony/LGSignalStrength;->getLevelSBM(IIIIIIIIZ)I

    move-result v10

    goto/16 :goto_0

    :cond_b
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v0

    const-string v1, "H3G"

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGRssiData;->checkOperatorbaseonIMSI(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    const-string v0, "H3G"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :cond_c
    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move/from16 v4, p6

    move/from16 v5, p7

    move/from16 v6, p8

    move/from16 v7, p10

    invoke-direct/range {v0 .. v7}, Lcom/lge/telephony/LGSignalStrength;->getLevelH3G(IIIIIIZ)I

    move-result v10

    goto/16 :goto_0
.end method

.method public getLteLevel(III)I
    .locals 10
    .param p1, "mLteSignalStrength"    # I
    .param p2, "mLteRsrp"    # I
    .param p3, "mLteRssnr"    # I

    .prologue
    const/4 v7, 0x1

    const/4 v6, -0x1

    const/4 v4, 0x0

    .local v4, "rssiIconLevel":I
    const/4 v3, -0x1

    .local v3, "rsrpIconLevel":I
    const/4 v5, -0x1

    .local v5, "snrIconLevel":I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v8

    invoke-virtual {v8}, Lcom/lge/telephony/LGRssiData;->getRsrpValue()[I

    move-result-object v0

    .local v0, "mLteRsrpValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v8

    invoke-virtual {v8}, Lcom/lge/telephony/LGRssiData;->getRssnrValue()[I

    move-result-object v1

    .local v1, "mLteRssnrValue":[I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v8

    invoke-virtual {v8}, Lcom/lge/telephony/LGRssiData;->getLteSignalValue()[I

    move-result-object v2

    .local v2, "mLteSignalValue":[I
    if-nez v0, :cond_1

    if-nez v1, :cond_1

    if-nez v2, :cond_1

    sget v8, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    const/4 v9, 0x6

    if-ne v8, v9, :cond_1

    const v6, 0x7fffffff

    iget-object v7, p0, Lcom/lge/telephony/LGSignalStrength;->LGE_LTE_RSRP_VALUE:[I

    invoke-virtual {p0, p2, v6, v7}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v6

    :cond_0
    :goto_0
    return v6

    :cond_1
    if-nez v0, :cond_2

    if-nez v1, :cond_2

    if-eqz v2, :cond_0

    :cond_2
    const/16 v8, -0x2c

    invoke-virtual {p0, p2, v8, v0}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v3

    const/16 v8, 0x12c

    invoke-virtual {p0, p3, v8, v1}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v5

    const-string v8, "SBM"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    if-eq v3, v7, :cond_3

    if-ne v5, v7, :cond_4

    :cond_3
    move v6, v7

    goto :goto_0

    :cond_4
    if-eq v5, v6, :cond_6

    if-eq v3, v6, :cond_6

    if-ge v3, v5, :cond_5

    move v6, v3

    goto :goto_0

    :cond_5
    move v6, v5

    goto :goto_0

    :cond_6
    if-eq v5, v6, :cond_7

    move v6, v5

    goto :goto_0

    :cond_7
    if-eq v3, v6, :cond_8

    move v6, v3

    goto :goto_0

    :cond_8
    const/16 v7, 0x3f

    invoke-virtual {p0, p1, v7, v2}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(II[I)I

    move-result v4

    if-ne v4, v6, :cond_9

    const/4 v6, 0x0

    goto :goto_0

    :cond_9
    move v6, v4

    goto :goto_0
.end method

.method public getTdScdmaLevel(I)I
    .locals 5
    .param p1, "tdScdmaDbm"    # I

    .prologue
    const/4 v0, -0x1

    .local v0, "level":I
    invoke-static {}, Lcom/lge/telephony/LGSignalStrength;->getLGRssiData()Lcom/lge/telephony/LGRssiData;

    move-result-object v3

    invoke-virtual {v3}, Lcom/lge/telephony/LGRssiData;->getTdscdmaDbmValue()[I

    move-result-object v2

    .local v2, "mTdscdmaDbmValue":[I
    if-nez v2, :cond_0

    sget v3, Lcom/lge/telephony/LGSignalStrength;->NUM_LG_SIGNAL_STRENGTH_BINS:I

    const/4 v4, 0x6

    if-ne v3, v4, :cond_0

    move v1, v0

    .end local v0    # "level":I
    .local v1, "level":I
    :goto_0
    return v1

    .end local v1    # "level":I
    .restart local v0    # "level":I
    :cond_0
    if-eqz v2, :cond_3

    const/16 v3, -0x19

    if-gt p1, v3, :cond_1

    const v3, 0x7fffffff

    if-ne p1, v3, :cond_2

    :cond_1
    const/4 v0, 0x0

    :goto_1
    move v1, v0

    .end local v0    # "level":I
    .restart local v1    # "level":I
    goto :goto_0

    .end local v1    # "level":I
    .restart local v0    # "level":I
    :cond_2
    invoke-virtual {p0, p1, v2}, Lcom/lge/telephony/LGSignalStrength;->getItemLevel(I[I)I

    move-result v0

    goto :goto_1

    :cond_3
    move v1, v0

    .end local v0    # "level":I
    .restart local v1    # "level":I
    goto :goto_0
.end method

.method public readFrom(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    const-string v0, "mDataRadioTechnology"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    return-void
.end method

.method public readFrom(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    return-void
.end method

.method public setDataRadioTechnology(I)V
    .locals 2
    .param p1, "dataRadioTechnology"    # I

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "setDataRadioTechnology: dataRadioTechnology = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/telephony/LGSignalStrength;->log(Ljava/lang/String;)V

    iput p1, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    const-string v0, "mDataRadioTechnology"

    iget v1, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method public writeTo(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/telephony/LGSignalStrength;->mDataRadioTechnology:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method
