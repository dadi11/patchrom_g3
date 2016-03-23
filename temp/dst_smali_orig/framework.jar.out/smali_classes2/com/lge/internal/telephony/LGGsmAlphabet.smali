.class public Lcom/lge/internal/telephony/LGGsmAlphabet;
.super Ljava/lang/Object;
.source "LGGsmAlphabet.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "GSM"

.field protected static final charToGsmBasicLatin:Landroid/util/SparseIntArray;

.field protected static final charToGsmCyrillic:Landroid/util/SparseIntArray;

.field protected static final charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

.field protected static final charToGsmGreekCoptic:Landroid/util/SparseIntArray;

.field protected static final charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

.field protected static final charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

.field protected static final charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

.field private static sIsSpanish:Z

.field private static sIsStrict:Z


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/16 v7, 0x6f

    const/16 v6, 0x55

    const/16 v5, 0x4f

    const/16 v4, 0x41

    const/16 v3, 0x49

    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmBasicLatin:Landroid/util/SparseIntArray;

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe1

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe2

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe3

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x101

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x103

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x105

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ce

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1df

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e1

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1fb

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x201

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x203

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x227

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x180

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x182

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x183

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x184

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x185

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    const/4 v0, 0x0

    const-string v1, "VIVO_UCS2GSM_Encoding"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe7

    const/16 v2, 0x9

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    :goto_0
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x107

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x109

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10b

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10d

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x188

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10f

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x111

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18b

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18c

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x221

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xea

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xeb

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x113

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x115

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x117

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x119

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11b

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18f

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x190

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x205

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x207

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x229

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x192

    const/16 v2, 0x66

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11d

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11f

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x121

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x123

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e5

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e7

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f5

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x125

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x127

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x195

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21f

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xed

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xee

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xef

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x129

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12b

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12f

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x131

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x196

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d0

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x209

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20b

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x135

    const/16 v2, 0x6a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f0

    const/16 v2, 0x6a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x137

    const/16 v2, 0x6b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x199

    const/16 v2, 0x6b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e9

    const/16 v2, 0x6b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13a

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13c

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13e

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x140

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x142

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19a

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19c

    const/16 v2, 0x6d

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x144

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x146

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x148

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x149

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14b

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19e

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f9

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x235

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xf3

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xf4

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xf5

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14d

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14f

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x151

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a1

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d2

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1eb

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ed

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20d

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20f

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22b

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22d

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22f

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x231

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x153

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a5

    const/16 v2, 0x70

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x155

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x157

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x159

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x211

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x213

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15b

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15d

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15f

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x161

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a8

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x219

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x163

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x165

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x167

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ab

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ad

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21b

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x236

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xfa

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xfb

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x169

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16b

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16d

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16f

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x171

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x173

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b0

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d4

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d6

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d8

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1da

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1dc

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x215

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x217

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b4

    const/16 v2, 0x76

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x175

    const/16 v2, 0x77

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xfd

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xff

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x177

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x233

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17a

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17c

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17e

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b6

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x225

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmBasicLatin:Landroid/util/SparseIntArray;

    const/16 v1, 0x60

    const/16 v2, 0x27

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc0

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc1

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc2

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc3

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x100

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x102

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x104

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1cd

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1de

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e0

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1fa

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x200

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x202

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x226

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x181

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x106

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x108

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10a

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10c

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x186

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x187

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd0

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10e

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x110

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x189

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18a

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc8

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xca

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcb

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x112

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x114

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x116

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x118

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11a

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18e

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x204

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x206

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x228

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x191

    const/16 v2, 0x46

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11c

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11e

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x120

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x122

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x193

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e4

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e6

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f4

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x124

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x126

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f6

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21e

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcc

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcd

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xce

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcf

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x128

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12a

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12c

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12e

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x130

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x197

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1cf

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x208

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20a

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x134

    const/16 v2, 0x4a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x136

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x138

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x198

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e8

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x139

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13b

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13d

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13f

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x141

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x143

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x145

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x147

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14a

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19d

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f8

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd2

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd3

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd4

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd5

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14c

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14e

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x150

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a0

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d1

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ea

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ec

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20c

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20e

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x152

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a4

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22a

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22c

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22e

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x230

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x154

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x156

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x158

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a6

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x210

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x212

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15a

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15c

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15e

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x160

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a7

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x218

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x162

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x164

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x166

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ac

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ae

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21a

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd9

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xda

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xdb

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x168

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16a

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16c

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16e

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x170

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x172

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b1

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b2

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d3

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d5

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d7

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d9

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1db

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x214

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x216

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x174

    const/16 v2, 0x57

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xdd

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x176

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x178

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b3

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x232

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x179

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17b

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17d

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b5

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x224

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x391

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x386

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b1

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ac

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x392

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b2

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x388

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x395

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b5

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ad

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x389

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x397

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b7

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ae

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x399

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38a

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3aa

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b9

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3af

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ca

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39a

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ba

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39c

    const/16 v2, 0x4d

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bc

    const/16 v2, 0x4d

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39d

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bd

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39f

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38c

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bf

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3cc

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a1

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c1

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a4

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c4

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a7

    const/16 v2, 0x58

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c7

    const/16 v2, 0x58

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a5

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38e

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ab

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c5

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3cd

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3cb

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x396

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b6

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b4

    const/16 v2, 0x10

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c6

    const/16 v2, 0x12

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b3

    const/16 v2, 0x13

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bb

    const/16 v2, 0x14

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38f

    const/16 v2, 0x15

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c9

    const/16 v2, 0x15

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ce

    const/16 v2, 0x15

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c0

    const/16 v2, 0x16

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c8

    const/16 v2, 0x17

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c3

    const/16 v2, 0x18

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c2

    const/16 v2, 0x18

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b8

    const/16 v2, 0x19

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3be

    const/16 v2, 0x1a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    const/4 v0, 0x0

    const-string v1, "gsm_strict_encoding"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    const/16 v1, 0x201c

    const/16 v2, 0x22

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    const/16 v1, 0x2026

    const/16 v2, 0x2e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xb0

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xb6

    const/16 v2, 0x20

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xb7

    const/16 v2, 0x2e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    const/16 v1, 0x413

    const/16 v2, 0x13

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    const/16 v1, 0x424

    const/16 v2, 0x12

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    const/16 v1, 0x401

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    :cond_0
    return-void

    :cond_1
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe7

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    goto/16 :goto_0
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static countGsmSeptetsLossyAuto(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 16
    .param p0, "s"    # Ljava/lang/CharSequence;
    .param p1, "use7bitOnly"    # Z

    .prologue
    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledSingleShiftTables:[I

    array-length v14, v14

    sget-object v15, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    array-length v15, v15

    add-int/2addr v14, v15

    if-nez v14, :cond_1

    invoke-static/range {p0 .. p1}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAutoWithoutNationalLangauge(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v13

    :cond_0
    :goto_0
    return-object v13

    :cond_1
    sget v8, Lcom/android/internal/telephony/GsmAlphabet;->sHighestEnabledSingleShiftCode:I

    .local v8, "maxSingleShiftCode":I
    new-instance v7, Ljava/util/ArrayList;

    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    array-length v14, v14

    add-int/lit8 v14, v14, 0x1

    invoke-direct {v7, v14}, Ljava/util/ArrayList;-><init>(I)V

    .local v7, "lpcList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;>;"
    new-instance v14, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;

    const/4 v15, 0x0

    invoke-direct {v14, v15}, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;-><init>(I)V

    invoke-interface {v7, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object v1, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    .local v1, "arr$":[I
    array-length v5, v1

    .local v5, "len$":I
    const/4 v4, 0x0

    .local v4, "i$":I
    :goto_1
    if-ge v4, v5, :cond_3

    aget v3, v1, v4

    .local v3, "i":I
    if-eqz v3, :cond_2

    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    aget-object v14, v14, v3

    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_2

    new-instance v14, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;

    invoke-direct {v14, v3}, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;-><init>(I)V

    invoke-interface {v7, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .end local v3    # "i":I
    :cond_3
    if-eqz p1, :cond_4

    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->setLossy7bitTableCondition()V

    :cond_4
    invoke-interface/range {p0 .. p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    .local v10, "sz":I
    const/4 v3, 0x0

    .end local v4    # "i$":I
    .restart local v3    # "i":I
    :goto_2
    if-ge v3, v10, :cond_d

    invoke-interface {v7}, Ljava/util/List;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_d

    move-object/from16 v0, p0

    invoke-interface {v0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    .local v2, "c":C
    const/16 v14, 0x1b

    if-ne v2, v14, :cond_6

    const-string v14, "GSM"

    const-string v15, "countGsmSeptets() string contains Escape character, ignoring!"

    invoke-static {v14, v15}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_6
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .local v4, "i$":Ljava/util/Iterator;
    :cond_7
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_5

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;

    .local v6, "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToGsmTables:[Landroid/util/SparseIntArray;

    iget v15, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    aget-object v14, v14, v15

    const/4 v15, -0x1

    invoke-virtual {v14, v2, v15}, Landroid/util/SparseIntArray;->get(II)I

    move-result v12

    .local v12, "tableIndex":I
    const/4 v14, -0x1

    if-ne v12, v14, :cond_b

    const/4 v11, 0x0

    .local v11, "table":I
    :goto_3
    if-gt v11, v8, :cond_7

    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v14, v14, v11

    const/4 v15, -0x1

    if-eq v14, v15, :cond_8

    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToShiftTables:[Landroid/util/SparseIntArray;

    aget-object v14, v14, v11

    const/4 v15, -0x1

    invoke-virtual {v14, v2, v15}, Landroid/util/SparseIntArray;->get(II)I

    move-result v9

    .local v9, "shiftTableIndex":I
    const/4 v14, -0x1

    if-ne v9, v14, :cond_a

    if-eqz p1, :cond_9

    invoke-static {v2}, Lcom/lge/internal/telephony/LGGsmAlphabet;->lookupLossy7bitTable(C)I

    move-result v14

    const/4 v15, -0x1

    if-eq v14, v15, :cond_9

    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x1

    aput v15, v14, v11

    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->unencodableCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x1

    aput v15, v14, v11

    .end local v9    # "shiftTableIndex":I
    :cond_8
    :goto_4
    add-int/lit8 v11, v11, 0x1

    goto :goto_3

    .restart local v9    # "shiftTableIndex":I
    :cond_9
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    const/4 v15, -0x1

    aput v15, v14, v11

    goto :goto_4

    :cond_a
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x2

    aput v15, v14, v11

    goto :goto_4

    .end local v9    # "shiftTableIndex":I
    .end local v11    # "table":I
    :cond_b
    const/4 v11, 0x0

    .restart local v11    # "table":I
    :goto_5
    if-gt v11, v8, :cond_7

    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v14, v14, v11

    const/4 v15, -0x1

    if-eq v14, v15, :cond_c

    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x1

    aput v15, v14, v11

    :cond_c
    add-int/lit8 v11, v11, 0x1

    goto :goto_5

    .end local v2    # "c":C
    .end local v4    # "i$":Ljava/util/Iterator;
    .end local v6    # "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    .end local v11    # "table":I
    .end local v12    # "tableIndex":I
    :cond_d
    move/from16 v0, p1

    invoke-static {v0, v8, v7}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAutoWithNationalLanguage(ZILjava/util/List;)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v13

    .local v13, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    iget v14, v13, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const v15, 0x7fffffff

    if-ne v14, v15, :cond_0

    const/4 v13, 0x0

    goto/16 :goto_0
.end method

.method public static countGsmSeptetsUsingTablesLossyAuto(Ljava/lang/CharSequence;ZII)I
    .locals 9
    .param p0, "s"    # Ljava/lang/CharSequence;
    .param p1, "use7bitOnly"    # Z
    .param p2, "languageTable"    # I
    .param p3, "languageShiftTable"    # I

    .prologue
    const/4 v6, -0x1

    const/4 v3, 0x0

    .local v3, "count":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v5

    .local v5, "sz":I
    sget-object v7, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToGsmTables:[Landroid/util/SparseIntArray;

    aget-object v1, v7, p2

    .local v1, "charToLanguageTable":Landroid/util/SparseIntArray;
    sget-object v7, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToShiftTables:[Landroid/util/SparseIntArray;

    aget-object v2, v7, p3

    .local v2, "charToShiftTable":Landroid/util/SparseIntArray;
    if-eqz p1, :cond_0

    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->setLossy7bitTableCondition()V

    :cond_0
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v5, :cond_5

    invoke-interface {p0, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    .local v0, "c":C
    const/16 v7, 0x1b

    if-ne v0, v7, :cond_1

    const-string v7, "GSM"

    const-string v8, "countGsmSeptets() string contains Escape character, skipping."

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v1, v0, v6}, Landroid/util/SparseIntArray;->get(II)I

    move-result v7

    if-eq v7, v6, :cond_2

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_2
    invoke-virtual {v2, v0, v6}, Landroid/util/SparseIntArray;->get(II)I

    move-result v7

    if-eq v7, v6, :cond_3

    add-int/lit8 v3, v3, 0x2

    goto :goto_1

    :cond_3
    if-eqz p1, :cond_6

    invoke-static {v0}, Lcom/lge/internal/telephony/LGGsmAlphabet;->lookupLossy7bitTable(C)I

    move-result v7

    if-eq v7, v6, :cond_4

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_4
    move v3, v6

    .end local v0    # "c":C
    .end local v3    # "count":I
    :cond_5
    :goto_2
    return v3

    .restart local v0    # "c":C
    .restart local v3    # "count":I
    :cond_6
    move v3, v6

    goto :goto_2
.end method

.method private static countGsmSeptetsUsingTablesLossyAutoWithNationalLanguage(ZILjava/util/List;)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 13
    .param p0, "use7bitOnly"    # Z
    .param p1, "maxSingleShiftCode"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ZI",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;",
            ">;)",
            "Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;"
        }
    .end annotation

    .prologue
    .local p2, "lpcList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;>;"
    new-instance v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v8}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .local v8, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    const v11, 0x7fffffff

    iput v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const/4 v11, 0x1

    iput v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    const v2, 0x7fffffff

    .local v2, "minUnencodableCount":I
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_b

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;

    .local v1, "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    const/4 v7, 0x0

    .local v7, "shiftTable":I
    :goto_0
    if-gt v7, p1, :cond_0

    iget-object v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v4, v11, v7

    .local v4, "septets":I
    const/4 v11, -0x1

    if-ne v4, v11, :cond_2

    :cond_1
    :goto_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_2
    iget v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    if-eqz v11, :cond_7

    if-eqz v7, :cond_7

    const/16 v9, 0x8

    .local v9, "udhLength":I
    :goto_2
    add-int v11, v4, v9

    const/16 v12, 0xa0

    if-le v11, v12, :cond_a

    if-nez v9, :cond_3

    const/4 v9, 0x1

    :cond_3
    add-int/lit8 v9, v9, 0x6

    rsub-int v5, v9, 0xa0

    .local v5, "septetsPerMessage":I
    add-int v11, v4, v5

    add-int/lit8 v11, v11, -0x1

    div-int v3, v11, v5

    .local v3, "msgCount":I
    mul-int v11, v3, v5

    sub-int v6, v11, v4

    .end local v5    # "septetsPerMessage":I
    .local v6, "septetsRemaining":I
    :goto_3
    iget-object v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->unencodableCounts:[I

    aget v10, v11, v7

    .local v10, "unencodableCount":I
    if-eqz p0, :cond_4

    if-gt v10, v2, :cond_1

    :cond_4
    if-eqz p0, :cond_5

    if-lt v10, v2, :cond_6

    :cond_5
    iget v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-lt v3, v11, :cond_6

    iget v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    if-ne v3, v11, :cond_1

    iget v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    if-le v6, v11, :cond_1

    :cond_6
    move v2, v10

    iput v3, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    iput v4, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    iput v6, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    iget v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    iput v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    iput v7, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    goto :goto_1

    .end local v3    # "msgCount":I
    .end local v6    # "septetsRemaining":I
    .end local v9    # "udhLength":I
    .end local v10    # "unencodableCount":I
    :cond_7
    iget v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    if-nez v11, :cond_8

    if-eqz v7, :cond_9

    :cond_8
    const/4 v9, 0x5

    .restart local v9    # "udhLength":I
    goto :goto_2

    .end local v9    # "udhLength":I
    :cond_9
    const/4 v9, 0x0

    .restart local v9    # "udhLength":I
    goto :goto_2

    :cond_a
    const/4 v3, 0x1

    .restart local v3    # "msgCount":I
    rsub-int v11, v9, 0xa0

    sub-int v6, v11, v4

    .restart local v6    # "septetsRemaining":I
    goto :goto_3

    .end local v1    # "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    .end local v3    # "msgCount":I
    .end local v4    # "septets":I
    .end local v6    # "septetsRemaining":I
    .end local v7    # "shiftTable":I
    .end local v9    # "udhLength":I
    :cond_b
    return-object v8
.end method

.method private static countGsmSeptetsUsingTablesLossyAutoWithoutNationalLangauge(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 4
    .param p0, "s"    # Ljava/lang/CharSequence;
    .param p1, "use7bitOnly"    # Z

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x1

    new-instance v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v1}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .local v1, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    invoke-static {p0, p1, v2, v2}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAuto(Ljava/lang/CharSequence;ZII)I

    move-result v0

    .local v0, "septets":I
    const/4 v2, -0x1

    if-ne v0, v2, :cond_0

    const/4 v1, 0x0

    .end local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_0
    return-object v1

    .restart local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    iput v3, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    iput v0, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    const/16 v2, 0xa0

    if-le v0, v2, :cond_1

    add-int/lit16 v2, v0, 0x98

    div-int/lit16 v2, v2, 0x99

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    iget v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    mul-int/lit16 v2, v2, 0x99

    sub-int/2addr v2, v0

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    :goto_1
    iput v3, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    goto :goto_0

    :cond_1
    iput v3, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    rsub-int v2, v0, 0xa0

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    goto :goto_1
.end method

.method public static getEnabledLockingShiftTablesLG()[I
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    return-object v0
.end method

.method public static getEnabledSingleShiftTablesLG()[I
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledSingleShiftTables:[I

    return-object v0
.end method

.method public static gsm7BitPackedToString([BIIIII)Ljava/lang/String;
    .locals 15
    .param p0, "pdu"    # [B
    .param p1, "offset"    # I
    .param p2, "lengthSeptets"    # I
    .param p3, "numPaddingBits"    # I
    .param p4, "languageTable"    # I
    .param p5, "shiftTable"    # I

    .prologue
    new-instance v9, Ljava/lang/StringBuilder;

    move/from16 v0, p2

    invoke-direct {v9, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v9, "ret":Ljava/lang/StringBuilder;
    if-ltz p4, :cond_0

    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    array-length v12, v12

    move/from16 v0, p4

    if-le v0, v12, :cond_1

    :cond_0
    const-string v12, "GSM"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "unknown language table "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move/from16 v0, p4

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ", using default"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/16 p4, 0x0

    :cond_1
    if-ltz p5, :cond_2

    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    array-length v12, v12

    move/from16 v0, p5

    if-le v0, v12, :cond_3

    :cond_2
    const-string v12, "GSM"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "unknown single shift table "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move/from16 v0, p5

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ", using default"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/16 p5, 0x0

    :cond_3
    const/4 v8, 0x0

    .local v8, "prevCharWasEscape":Z
    :try_start_0
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    aget-object v7, v12, p4

    .local v7, "languageTableToChar":Ljava/lang/String;
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    aget-object v11, v12, p5

    .local v11, "shiftTableToChar":Ljava/lang/String;
    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_4

    const-string v12, "GSM"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "no language table for code "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move/from16 v0, p4

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ", using default"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v7, v12, v13

    :cond_4
    invoke-virtual {v11}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_5

    const-string v12, "GSM"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "no single shift table for code "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move/from16 v0, p5

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ", using default"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v12, v13}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v11, v12, v13

    :cond_5
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    move/from16 v0, p2

    if-ge v6, v0, :cond_c

    mul-int/lit8 v12, v6, 0x7

    add-int v1, v12, p3

    .local v1, "bitOffset":I
    div-int/lit8 v2, v1, 0x8

    .local v2, "byteOffset":I
    rem-int/lit8 v10, v1, 0x8

    .local v10, "shift":I
    const/4 v5, 0x1

    .local v5, "gsmVal":I
    add-int v12, p1, v2

    array-length v13, p0

    if-ge v12, v13, :cond_6

    add-int v12, p1, v2

    aget-byte v12, p0, v12

    shr-int/2addr v12, v10

    and-int/lit8 v5, v12, 0x7f

    :cond_6
    const/4 v12, 0x1

    if-le v10, v12, :cond_7

    const/16 v12, 0x7f

    add-int/lit8 v13, v10, -0x1

    shr-int/2addr v12, v13

    and-int/2addr v5, v12

    add-int v12, p1, v2

    add-int/lit8 v12, v12, 0x1

    array-length v13, p0

    if-ge v12, v13, :cond_7

    add-int v12, p1, v2

    add-int/lit8 v12, v12, 0x1

    aget-byte v12, p0, v12

    rsub-int/lit8 v13, v10, 0x8

    shl-int/2addr v12, v13

    and-int/lit8 v12, v12, 0x7f

    or-int/2addr v5, v12

    :cond_7
    if-eqz v8, :cond_a

    const/16 v12, 0x1b

    if-ne v5, v12, :cond_8

    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_1
    const/4 v8, 0x0

    :goto_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_8
    invoke-virtual {v11, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .local v3, "c":C
    const/16 v12, 0x20

    if-ne v3, v12, :cond_9

    invoke-virtual {v7, v5}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .end local v1    # "bitOffset":I
    .end local v2    # "byteOffset":I
    .end local v3    # "c":C
    .end local v5    # "gsmVal":I
    .end local v6    # "i":I
    .end local v7    # "languageTableToChar":Ljava/lang/String;
    .end local v10    # "shift":I
    .end local v11    # "shiftTableToChar":Ljava/lang/String;
    :catch_0
    move-exception v4

    .local v4, "ex":Ljava/lang/RuntimeException;
    const-string v12, "GSM"

    const-string v13, "Error GSM 7 bit packed: "

    invoke-static {v12, v13, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v12, "It is a wrong formatted message"

    .end local v4    # "ex":Ljava/lang/RuntimeException;
    :goto_3
    return-object v12

    .restart local v1    # "bitOffset":I
    .restart local v2    # "byteOffset":I
    .restart local v3    # "c":C
    .restart local v5    # "gsmVal":I
    .restart local v6    # "i":I
    .restart local v7    # "languageTableToChar":Ljava/lang/String;
    .restart local v10    # "shift":I
    .restart local v11    # "shiftTableToChar":Ljava/lang/String;
    :cond_9
    :try_start_1
    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .end local v3    # "c":C
    :cond_a
    const/16 v12, 0x1b

    if-ne v5, v12, :cond_b

    const/4 v8, 0x1

    goto :goto_2

    :cond_b
    invoke-virtual {v7, v5}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .end local v1    # "bitOffset":I
    .end local v2    # "byteOffset":I
    .end local v5    # "gsmVal":I
    .end local v10    # "shift":I
    :cond_c
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    goto :goto_3
.end method

.method public static gsm8BitUnpackedToString([BIILjava/lang/String;)Ljava/lang/String;
    .locals 14
    .param p0, "data"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .param p3, "characterset"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    .local v5, "isMbcs":Z
    const/4 v2, 0x0

    .local v2, "charset":Ljava/nio/charset/Charset;
    const/4 v7, 0x0

    .local v7, "mbcsBuffer":Ljava/nio/ByteBuffer;
    invoke-static/range {p3 .. p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v12

    if-nez v12, :cond_0

    const-string v12, "us-ascii"

    move-object/from16 v0, p3

    invoke-virtual {v0, v12}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v12

    if-nez v12, :cond_0

    invoke-static/range {p3 .. p3}, Ljava/nio/charset/Charset;->isSupported(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_0

    const/4 v5, 0x1

    invoke-static/range {p3 .. p3}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v2

    const/4 v12, 0x2

    invoke-static {v12}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    :cond_0
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v6, v12, v13

    .local v6, "languageTableToChar":Ljava/lang/String;
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v11, v12, v13

    .local v11, "shiftTableToChar":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    move/from16 v0, p2

    invoke-direct {v9, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v9, "ret":Ljava/lang/StringBuilder;
    const/4 v8, 0x0

    .local v8, "prevWasEscape":Z
    move v3, p1

    .local v3, "i":I
    move v4, v3

    .end local v3    # "i":I
    .local v4, "i":I
    :goto_0
    add-int v12, p1, p2

    if-ge v4, v12, :cond_1

    aget-byte v12, p0, v4

    and-int/lit16 v1, v12, 0xff

    .local v1, "c":I
    const/16 v12, 0xff

    if-ne v1, v12, :cond_2

    .end local v1    # "c":I
    :cond_1
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    return-object v12

    .restart local v1    # "c":I
    :cond_2
    const/16 v12, 0x1b

    if-ne v1, v12, :cond_4

    if-eqz v8, :cond_3

    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/4 v8, 0x0

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    :goto_1
    add-int/lit8 v3, v3, 0x1

    move v4, v3

    .end local v3    # "i":I
    .restart local v4    # "i":I
    goto :goto_0

    :cond_3
    const/4 v8, 0x1

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_1

    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_4
    if-eqz v8, :cond_7

    const/16 v12, 0x80

    if-ge v1, v12, :cond_6

    invoke-virtual {v11, v1}, Ljava/lang/String;->charAt(I)C

    move-result v10

    .local v10, "shiftChar":C
    const/16 v12, 0x20

    if-ne v10, v12, :cond_5

    invoke-virtual {v6, v1}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_2
    move v3, v4

    .end local v4    # "i":I
    .end local v10    # "shiftChar":C
    .restart local v3    # "i":I
    :goto_3
    const/4 v8, 0x0

    goto :goto_1

    .end local v3    # "i":I
    .restart local v4    # "i":I
    .restart local v10    # "shiftChar":C
    :cond_5
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .end local v10    # "shiftChar":C
    :cond_6
    const-string v12, "GsmAlphabet"

    const-string v13, "[TEL-SMS] gsm8BitUnpackedToString extend GSM 7 bit default alphabet"

    invoke-static {v12, v13}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_3

    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_7
    if-eqz v5, :cond_8

    add-int/lit8 v12, v4, 0x1

    add-int v13, p1, p2

    if-lt v12, v13, :cond_a

    :cond_8
    const/16 v12, 0x80

    if-ge v1, v12, :cond_9

    invoke-virtual {v6, v1}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_3

    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_9
    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_3

    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_a
    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    add-int/lit8 v3, v4, 0x1

    .end local v4    # "i":I
    .restart local v3    # "i":I
    const/4 v12, 0x2

    invoke-virtual {v7, p0, v4, v12}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    invoke-virtual {v2, v7}, Ljava/nio/charset/Charset;->decode(Ljava/nio/ByteBuffer;)Ljava/nio/CharBuffer;

    move-result-object v12

    invoke-virtual {v12}, Ljava/nio/CharBuffer;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3
.end method

.method protected static lookupLossy7bitTable(C)I
    .locals 3
    .param p0, "c"    # C

    .prologue
    const/4 v2, -0x1

    const/4 v0, -0x1

    .local v0, "v":I
    const/16 v1, 0x80

    if-ge p0, v1, :cond_2

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmBasicLatin:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    :cond_0
    :goto_0
    sget-boolean v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    if-eqz v1, :cond_1

    if-ne v0, v2, :cond_1

    const/16 v0, 0x20

    :cond_1
    return v0

    :cond_2
    const/16 v1, 0xe7

    if-ne p0, v1, :cond_3

    sget-boolean v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    if-eqz v1, :cond_3

    const/16 v0, 0x9

    goto :goto_0

    :cond_3
    const/16 v1, 0x7f

    if-le p0, v1, :cond_4

    const/16 v1, 0x100

    if-ge p0, v1, :cond_4

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    :cond_4
    const/16 v1, 0xff

    if-le p0, v1, :cond_5

    const/16 v1, 0x180

    if-ge p0, v1, :cond_5

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    :cond_5
    const/16 v1, 0x17f

    if-le p0, v1, :cond_6

    const/16 v1, 0x250

    if-ge p0, v1, :cond_6

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    :cond_6
    const/16 v1, 0x36f

    if-le p0, v1, :cond_7

    const/16 v1, 0x400

    if-ge p0, v1, :cond_7

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    :cond_7
    const/16 v1, 0x3ff

    if-le p0, v1, :cond_8

    const/16 v1, 0x500

    if-ge p0, v1, :cond_8

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    :cond_8
    const/16 v1, 0x1fff

    if-le p0, v1, :cond_0

    const/16 v1, 0x2070

    if-ge p0, v1, :cond_0

    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0
.end method

.method private static setLossy7bitTableCondition()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v0

    .local v0, "mSIMoperator":Ljava/lang/String;
    sput-boolean v3, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    sput-boolean v3, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x5

    if-lt v1, v2, :cond_0

    const/4 v1, 0x3

    invoke-virtual {v0, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    const-string v2, "214"

    invoke-static {v1, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    sput-boolean v4, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    :cond_0
    const/4 v1, 0x0

    const-string v2, "gsm_strict_encoding"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sput-boolean v4, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    :cond_1
    return-void
.end method

.method public static stringToGsm7BitPacked(Ljava/lang/String;IZII)[B
    .locals 15
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "startingSeptetOffset"    # I
    .param p2, "throwException"    # Z
    .param p3, "languageTable"    # I
    .param p4, "languageShiftTable"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/EncodeException;
        }
    .end annotation

    .prologue
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    .local v7, "dataLen":I
    if-nez p2, :cond_0

    const/4 v13, 0x1

    :goto_0
    move/from16 v0, p3

    move/from16 v1, p4

    invoke-static {p0, v13, v0, v1}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAuto(Ljava/lang/CharSequence;ZII)I

    move-result v10

    .local v10, "septetCount":I
    const/4 v13, -0x1

    if-ne v10, v13, :cond_1

    new-instance v13, Lcom/android/internal/telephony/EncodeException;

    const-string v14, "countGsmSeptetsUsingTables(): unencodable char"

    invoke-direct {v13, v14}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v13

    .end local v10    # "septetCount":I
    :cond_0
    const/4 v13, 0x0

    goto :goto_0

    .restart local v10    # "septetCount":I
    :cond_1
    add-int v10, v10, p1

    const/16 v13, 0xff

    if-le v10, v13, :cond_2

    new-instance v13, Lcom/android/internal/telephony/EncodeException;

    const-string v14, "Payload cannot exceed 255 septets"

    invoke-direct {v13, v14}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v13

    :cond_2
    mul-int/lit8 v13, v10, 0x7

    add-int/lit8 v13, v13, 0x7

    div-int/lit8 v3, v13, 0x8

    .local v3, "byteCount":I
    add-int/lit8 v13, v3, 0x1

    new-array v9, v13, [B

    .local v9, "ret":[B
    sget-object v13, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToGsmTables:[Landroid/util/SparseIntArray;

    aget-object v5, v13, p3

    .local v5, "charToLanguageTable":Landroid/util/SparseIntArray;
    sget-object v13, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToShiftTables:[Landroid/util/SparseIntArray;

    aget-object v6, v13, p4

    .local v6, "charToShiftTable":Landroid/util/SparseIntArray;
    if-nez p2, :cond_3

    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->setLossy7bitTableCondition()V

    :cond_3
    const/4 v8, 0x0

    .local v8, "i":I
    move/from16 v11, p1

    .local v11, "septets":I
    mul-int/lit8 v2, p1, 0x7

    .local v2, "bitOffset":I
    :goto_1
    if-ge v8, v7, :cond_7

    if-ge v11, v10, :cond_7

    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .local v4, "c":C
    const/4 v13, -0x1

    invoke-virtual {v5, v4, v13}, Landroid/util/SparseIntArray;->get(II)I

    move-result v12

    .local v12, "v":I
    const/4 v13, -0x1

    if-ne v12, v13, :cond_6

    const/4 v13, -0x1

    invoke-virtual {v6, v4, v13}, Landroid/util/SparseIntArray;->get(II)I

    move-result v12

    const/4 v13, -0x1

    if-ne v12, v13, :cond_5

    if-nez p2, :cond_4

    invoke-static {v4}, Lcom/lge/internal/telephony/LGGsmAlphabet;->lookupLossy7bitTable(C)I

    move-result v12

    :cond_4
    const/4 v13, -0x1

    if-ne v12, v13, :cond_6

    new-instance v13, Lcom/android/internal/telephony/EncodeException;

    const-string v14, "stringToGsm7BitPacked(): unencodable char"

    invoke-direct {v13, v14}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v13

    :cond_5
    const/16 v13, 0x1b

    invoke-static {v9, v2, v13}, Lcom/android/internal/telephony/GsmAlphabet;->packSmsChar([BII)V

    add-int/lit8 v2, v2, 0x7

    add-int/lit8 v11, v11, 0x1

    :cond_6
    invoke-static {v9, v2, v12}, Lcom/android/internal/telephony/GsmAlphabet;->packSmsChar([BII)V

    add-int/lit8 v11, v11, 0x1

    add-int/lit8 v8, v8, 0x1

    add-int/lit8 v2, v2, 0x7

    goto :goto_1

    .end local v4    # "c":C
    .end local v12    # "v":I
    :cond_7
    const/4 v13, 0x0

    int-to-byte v14, v10

    aput-byte v14, v9, v13

    return-object v9
.end method

.method public static stringToGsm7BitPackedWithHeader(Ljava/lang/String;[BII)[B
    .locals 9
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "header"    # [B
    .param p2, "languageTable"    # I
    .param p3, "languageShiftTable"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/EncodeException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    const/4 v6, 0x0

    const-string v7, "persist.gsm.sms.forcegsm7"

    const-string v8, "1"

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "encodingType":Ljava/lang/String;
    const-string v7, "0"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_1

    move v3, v5

    .local v3, "isThrowException":Z
    :goto_0
    if-eqz p1, :cond_0

    array-length v7, p1

    if-nez v7, :cond_2

    :cond_0
    invoke-static {p0, v6, v3, p2, p3}, Lcom/lge/internal/telephony/LGGsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;IZII)[B

    move-result-object v4

    :goto_1
    return-object v4

    .end local v3    # "isThrowException":Z
    :cond_1
    move v3, v6

    goto :goto_0

    .restart local v3    # "isThrowException":Z
    :cond_2
    array-length v7, p1

    add-int/lit8 v7, v7, 0x1

    mul-int/lit8 v1, v7, 0x8

    .local v1, "headerBits":I
    add-int/lit8 v7, v1, 0x6

    div-int/lit8 v2, v7, 0x7

    .local v2, "headerSeptets":I
    invoke-static {p0, v2, v3, p2, p3}, Lcom/lge/internal/telephony/LGGsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;IZII)[B

    move-result-object v4

    .local v4, "ret":[B
    array-length v7, p1

    int-to-byte v7, v7

    aput-byte v7, v4, v5

    const/4 v5, 0x2

    array-length v7, p1

    invoke-static {p1, v6, v4, v5, v7}, Ljava/lang/System;->arraycopy([BI[BII)V

    goto :goto_1
.end method
