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

    .line 46
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    .line 47
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    .line 759
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmBasicLatin:Landroid/util/SparseIntArray;

    .line 760
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    .line 761
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    .line 762
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    .line 763
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    .line 764
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    .line 765
    new-instance v0, Landroid/util/SparseIntArray;

    invoke-direct {v0}, Landroid/util/SparseIntArray;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    .line 768
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe1

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 769
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe2

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 770
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe3

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 771
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x101

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 772
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x103

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 773
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x105

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 774
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ce

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 775
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1df

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 776
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e1

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 777
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1fb

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 778
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x201

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 779
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x203

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 780
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x227

    const/16 v2, 0x61

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 781
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x180

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 782
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x182

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 783
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x183

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 784
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x184

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 785
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x185

    const/16 v2, 0x62

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 787
    const/4 v0, 0x0

    const-string v1, "VIVO_UCS2GSM_Encoding"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 788
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xe7

    const/16 v2, 0x9

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 793
    :goto_0
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x107

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 794
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x109

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 795
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10b

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 796
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10d

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 797
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x188

    const/16 v2, 0x63

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 798
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10f

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 799
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x111

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 800
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18b

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 801
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18c

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 802
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x221

    const/16 v2, 0x64

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 803
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xea

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 804
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xeb

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 805
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x113

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 806
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x115

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 807
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x117

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 808
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x119

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 809
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11b

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 810
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18f

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 811
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x190

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 812
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x205

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 813
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x207

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 814
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x229

    const/16 v2, 0x65

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 815
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x192

    const/16 v2, 0x66

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 816
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11d

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 817
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11f

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 818
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x121

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 819
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x123

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 820
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e5

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 821
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e7

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 822
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f5

    const/16 v2, 0x67

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 823
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x125

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 824
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x127

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 825
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x195

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 826
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21f

    const/16 v2, 0x68

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 827
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xed

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 828
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xee

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 829
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xef

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 830
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x129

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 831
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12b

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 832
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12f

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 833
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x131

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 834
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x196

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 835
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d0

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 836
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x209

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 837
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20b

    const/16 v2, 0x69

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 838
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x135

    const/16 v2, 0x6a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 839
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f0

    const/16 v2, 0x6a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 840
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x137

    const/16 v2, 0x6b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 841
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x199

    const/16 v2, 0x6b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 842
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e9

    const/16 v2, 0x6b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 843
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13a

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 844
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13c

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 845
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13e

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 846
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x140

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 847
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x142

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 848
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19a

    const/16 v2, 0x6c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 849
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19c

    const/16 v2, 0x6d

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 850
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x144

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 851
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x146

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 852
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x148

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 853
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x149

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 854
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14b

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 855
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19e

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 856
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f9

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 857
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x235

    const/16 v2, 0x6e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 858
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xf3

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 859
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xf4

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 860
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xf5

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 861
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14d

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 862
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14f

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 863
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x151

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 864
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a1

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 865
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d2

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 866
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1eb

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 867
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ed

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 868
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20d

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 869
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20f

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 870
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22b

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 871
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22d

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 872
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22f

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 873
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x231

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 874
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x153

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 875
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a5

    const/16 v2, 0x70

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 876
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x155

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 877
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x157

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 878
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x159

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 879
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x211

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 880
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x213

    const/16 v2, 0x72

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 881
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15b

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 882
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15d

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 883
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15f

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 884
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x161

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 885
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a8

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 886
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x219

    const/16 v2, 0x73

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 887
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x163

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 888
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x165

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 889
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x167

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 890
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ab

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 891
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ad

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 892
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21b

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 893
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x236

    const/16 v2, 0x74

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 894
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xfa

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 895
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xfb

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 896
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x169

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 897
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16b

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 898
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16d

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 899
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16f

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 900
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x171

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 901
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x173

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 902
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b0

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 903
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d4

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 904
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d6

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 905
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d8

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 906
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1da

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 907
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1dc

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 908
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x215

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 909
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x217

    const/16 v2, 0x75

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 910
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b4

    const/16 v2, 0x76

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 911
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x175

    const/16 v2, 0x77

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 912
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xfd

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 913
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xff

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 914
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x177

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 915
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x233

    const/16 v2, 0x79

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 916
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17a

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 917
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17c

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 918
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17e

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 919
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b6

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 920
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x225

    const/16 v2, 0x7a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 921
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmBasicLatin:Landroid/util/SparseIntArray;

    const/16 v1, 0x60

    const/16 v2, 0x27

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 922
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc0

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 923
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc1

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 924
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc2

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 925
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc3

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 926
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x100

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 927
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x102

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 928
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x104

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 929
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1cd

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 930
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1de

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 931
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e0

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 932
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1fa

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 933
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x200

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 934
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x202

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 935
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x226

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 936
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x181

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 937
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x106

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 938
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x108

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 939
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10a

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 940
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10c

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 941
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x186

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 942
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x187

    const/16 v2, 0x43

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 943
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd0

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 944
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x10e

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 945
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x110

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 946
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x189

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 947
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18a

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 948
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xc8

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 949
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xca

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 950
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcb

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 951
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x112

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 952
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x114

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 953
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x116

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 954
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x118

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 955
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11a

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 956
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x18e

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 957
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x204

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 958
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x206

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 959
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x228

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 960
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x191

    const/16 v2, 0x46

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 961
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11c

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 962
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x11e

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 963
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x120

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 964
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x122

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 965
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x193

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 966
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e4

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 967
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e6

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 968
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f4

    const/16 v2, 0x47

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 969
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x124

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 970
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x126

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 971
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f6

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 972
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21e

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 973
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcc

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 974
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcd

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 975
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xce

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 976
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xcf

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 977
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x128

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 978
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12a

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 979
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12c

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 980
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x12e

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 981
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x130

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 982
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x197

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 983
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1cf

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 984
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x208

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 985
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20a

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 986
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x134

    const/16 v2, 0x4a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 987
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x136

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 988
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x138

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 989
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x198

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 990
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1e8

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 991
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x139

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 992
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13b

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 993
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13d

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 994
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x13f

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 995
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x141

    const/16 v2, 0x4c

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 996
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x143

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 997
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x145

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 998
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x147

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 999
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14a

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1000
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x19d

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1001
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1f8

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1002
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd2

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1003
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd3

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1004
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd4

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1005
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd5

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1006
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14c

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1007
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x14e

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1008
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x150

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1009
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a0

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1010
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d1

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1011
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ea

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1012
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ec

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1013
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20c

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1014
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x20e

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1015
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x152

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1016
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a4

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1017
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22a

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1018
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22c

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1019
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x22e

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1020
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x230

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1021
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x154

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1022
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x156

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1023
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x158

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1024
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a6

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1025
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x210

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1026
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x212

    const/16 v2, 0x52

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1027
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15a

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1028
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15c

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1029
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x15e

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1030
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x160

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1031
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1a7

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1032
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x218

    const/16 v2, 0x53

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1033
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x162

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1034
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x164

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1035
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x166

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1036
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ac

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1037
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1ae

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1038
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x21a

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1039
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xd9

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1040
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xda

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1041
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xdb

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1042
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x168

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1043
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16a

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1044
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16c

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1045
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x16e

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1046
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x170

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1047
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x172

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1048
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b1

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1049
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b2

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1050
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d3

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1051
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d5

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1052
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d7

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1053
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1d9

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1054
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1db

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1055
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x214

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1056
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x216

    invoke-virtual {v0, v1, v6}, Landroid/util/SparseIntArray;->put(II)V

    .line 1057
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x174

    const/16 v2, 0x57

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1058
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xdd

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1059
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x176

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1060
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x178

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1061
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b3

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1062
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x232

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1063
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x179

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1064
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17b

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1065
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    const/16 v1, 0x17d

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1066
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x1b5

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1067
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    const/16 v1, 0x224

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1068
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x391

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 1069
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x386

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 1070
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b1

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 1071
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ac

    invoke-virtual {v0, v1, v4}, Landroid/util/SparseIntArray;->put(II)V

    .line 1072
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x392

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1073
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b2

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1074
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x388

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1075
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x395

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1076
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b5

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1077
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ad

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1078
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x389

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1079
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x397

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1080
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b7

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1081
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ae

    const/16 v2, 0x48

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1082
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x399

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 1083
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38a

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 1084
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3aa

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 1085
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b9

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 1086
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3af

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 1087
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ca

    invoke-virtual {v0, v1, v3}, Landroid/util/SparseIntArray;->put(II)V

    .line 1088
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39a

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1089
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ba

    const/16 v2, 0x4b

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1090
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39c

    const/16 v2, 0x4d

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1091
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bc

    const/16 v2, 0x4d

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1092
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39d

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1093
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bd

    const/16 v2, 0x4e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1094
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x39f

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1095
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38c

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1096
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bf

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1097
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3cc

    invoke-virtual {v0, v1, v5}, Landroid/util/SparseIntArray;->put(II)V

    .line 1098
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a1

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1099
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c1

    const/16 v2, 0x50

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1100
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a4

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1101
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c4

    const/16 v2, 0x54

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1102
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a7

    const/16 v2, 0x58

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1103
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c7

    const/16 v2, 0x58

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1104
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3a5

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1105
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38e

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1106
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ab

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1107
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c5

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1108
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3cd

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1109
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3cb

    const/16 v2, 0x59

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1110
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x396

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1111
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b6

    const/16 v2, 0x5a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1112
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b4

    const/16 v2, 0x10

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1113
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c6

    const/16 v2, 0x12

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1114
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b3

    const/16 v2, 0x13

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1115
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3bb

    const/16 v2, 0x14

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1116
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x38f

    const/16 v2, 0x15

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1117
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c9

    const/16 v2, 0x15

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1118
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3ce

    const/16 v2, 0x15

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1119
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c0

    const/16 v2, 0x16

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1120
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c8

    const/16 v2, 0x17

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1121
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c3

    const/16 v2, 0x18

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1122
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3c2

    const/16 v2, 0x18

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1123
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3b8

    const/16 v2, 0x19

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1124
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    const/16 v1, 0x3be

    const/16 v2, 0x1a

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1126
    const/4 v0, 0x0

    const-string v1, "gsm_strict_encoding"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1127
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    const/16 v1, 0x201c

    const/16 v2, 0x22

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1128
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGeneralPunctuation:Landroid/util/SparseIntArray;

    const/16 v1, 0x2026

    const/16 v2, 0x2e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1129
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xb0

    invoke-virtual {v0, v1, v7}, Landroid/util/SparseIntArray;->put(II)V

    .line 1130
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xb6

    const/16 v2, 0x20

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1131
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    const/16 v1, 0xb7

    const/16 v2, 0x2e

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1132
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    const/16 v1, 0x413

    const/16 v2, 0x13

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1133
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    const/16 v1, 0x424

    const/16 v2, 0x12

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1134
    sget-object v0, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    const/16 v1, 0x401

    const/16 v2, 0x45

    invoke-virtual {v0, v1, v2}, Landroid/util/SparseIntArray;->put(II)V

    .line 1136
    :cond_0
    return-void

    .line 791
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
    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static countGsmSeptetsLossyAuto(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .locals 16
    .param p0, "s"    # Ljava/lang/CharSequence;
    .param p1, "use7bitOnly"    # Z

    .prologue
    .line 126
    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledSingleShiftTables:[I

    array-length v14, v14

    sget-object v15, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    array-length v15, v15

    add-int/2addr v14, v15

    if-nez v14, :cond_1

    .line 127
    invoke-static/range {p0 .. p1}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAutoWithoutNationalLangauge(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v13

    .line 194
    :cond_0
    :goto_0
    return-object v13

    .line 130
    :cond_1
    sget v8, Lcom/android/internal/telephony/GsmAlphabet;->sHighestEnabledSingleShiftCode:I

    .line 131
    .local v8, "maxSingleShiftCode":I
    new-instance v7, Ljava/util/ArrayList;

    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    array-length v14, v14

    add-int/lit8 v14, v14, 0x1

    invoke-direct {v7, v14}, Ljava/util/ArrayList;-><init>(I)V

    .line 135
    .local v7, "lpcList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;>;"
    new-instance v14, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;

    const/4 v15, 0x0

    invoke-direct {v14, v15}, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;-><init>(I)V

    invoke-interface {v7, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 136
    sget-object v1, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    .local v1, "arr$":[I
    array-length v5, v1

    .local v5, "len$":I
    const/4 v4, 0x0

    .local v4, "i$":I
    :goto_1
    if-ge v4, v5, :cond_3

    aget v3, v1, v4

    .line 138
    .local v3, "i":I
    if-eqz v3, :cond_2

    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    aget-object v14, v14, v3

    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_2

    .line 139
    new-instance v14, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;

    invoke-direct {v14, v3}, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;-><init>(I)V

    invoke-interface {v7, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 136
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 143
    .end local v3    # "i":I
    :cond_3
    if-eqz p1, :cond_4

    .line 144
    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->setLossy7bitTableCondition()V

    .line 147
    :cond_4
    invoke-interface/range {p0 .. p0}, Ljava/lang/CharSequence;->length()I

    move-result v10

    .line 149
    .local v10, "sz":I
    const/4 v3, 0x0

    .end local v4    # "i$":I
    .restart local v3    # "i":I
    :goto_2
    if-ge v3, v10, :cond_d

    invoke-interface {v7}, Ljava/util/List;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_d

    .line 150
    move-object/from16 v0, p0

    invoke-interface {v0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    .line 151
    .local v2, "c":C
    const/16 v14, 0x1b

    if-ne v2, v14, :cond_6

    .line 152
    const-string v14, "GSM"

    const-string v15, "countGsmSeptets() string contains Escape character, ignoring!"

    invoke-static {v14, v15}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 149
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 156
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

    .line 157
    .local v6, "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToGsmTables:[Landroid/util/SparseIntArray;

    iget v15, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    aget-object v14, v14, v15

    const/4 v15, -0x1

    invoke-virtual {v14, v2, v15}, Landroid/util/SparseIntArray;->get(II)I

    move-result v12

    .line 158
    .local v12, "tableIndex":I
    const/4 v14, -0x1

    if-ne v12, v14, :cond_b

    .line 160
    const/4 v11, 0x0

    .local v11, "table":I
    :goto_3
    if-gt v11, v8, :cond_7

    .line 161
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v14, v14, v11

    const/4 v15, -0x1

    if-eq v14, v15, :cond_8

    .line 162
    sget-object v14, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToShiftTables:[Landroid/util/SparseIntArray;

    aget-object v14, v14, v11

    const/4 v15, -0x1

    invoke-virtual {v14, v2, v15}, Landroid/util/SparseIntArray;->get(II)I

    move-result v9

    .line 163
    .local v9, "shiftTableIndex":I
    const/4 v14, -0x1

    if-ne v9, v14, :cond_a

    .line 164
    if-eqz p1, :cond_9

    invoke-static {v2}, Lcom/lge/internal/telephony/LGGsmAlphabet;->lookupLossy7bitTable(C)I

    move-result v14

    const/4 v15, -0x1

    if-eq v14, v15, :cond_9

    .line 165
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x1

    aput v15, v14, v11

    .line 166
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->unencodableCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x1

    aput v15, v14, v11

    .line 160
    .end local v9    # "shiftTableIndex":I
    :cond_8
    :goto_4
    add-int/lit8 v11, v11, 0x1

    goto :goto_3

    .line 169
    .restart local v9    # "shiftTableIndex":I
    :cond_9
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    const/4 v15, -0x1

    aput v15, v14, v11

    goto :goto_4

    .line 173
    :cond_a
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x2

    aput v15, v14, v11

    goto :goto_4

    .line 179
    .end local v9    # "shiftTableIndex":I
    .end local v11    # "table":I
    :cond_b
    const/4 v11, 0x0

    .restart local v11    # "table":I
    :goto_5
    if-gt v11, v8, :cond_7

    .line 180
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v14, v14, v11

    const/4 v15, -0x1

    if-eq v14, v15, :cond_c

    .line 181
    iget-object v14, v6, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v15, v14, v11

    add-int/lit8 v15, v15, 0x1

    aput v15, v14, v11

    .line 179
    :cond_c
    add-int/lit8 v11, v11, 0x1

    goto :goto_5

    .line 188
    .end local v2    # "c":C
    .end local v4    # "i$":Ljava/util/Iterator;
    .end local v6    # "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    .end local v11    # "table":I
    .end local v12    # "tableIndex":I
    :cond_d
    move/from16 v0, p1

    invoke-static {v0, v8, v7}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAutoWithNationalLanguage(ZILjava/util/List;)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v13

    .line 190
    .local v13, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    iget v14, v13, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    const v15, 0x7fffffff

    if-ne v14, v15, :cond_0

    .line 191
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

    .line 69
    const/4 v3, 0x0

    .line 70
    .local v3, "count":I
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v5

    .line 72
    .local v5, "sz":I
    sget-object v7, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToGsmTables:[Landroid/util/SparseIntArray;

    aget-object v1, v7, p2

    .line 73
    .local v1, "charToLanguageTable":Landroid/util/SparseIntArray;
    sget-object v7, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToShiftTables:[Landroid/util/SparseIntArray;

    aget-object v2, v7, p3

    .line 75
    .local v2, "charToShiftTable":Landroid/util/SparseIntArray;
    if-eqz p1, :cond_0

    .line 76
    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->setLossy7bitTableCondition()V

    .line 79
    :cond_0
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v5, :cond_5

    .line 80
    invoke-interface {p0, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    .line 81
    .local v0, "c":C
    const/16 v7, 0x1b

    if-ne v0, v7, :cond_1

    .line 82
    const-string v7, "GSM"

    const-string v8, "countGsmSeptets() string contains Escape character, skipping."

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 79
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 86
    :cond_1
    invoke-virtual {v1, v0, v6}, Landroid/util/SparseIntArray;->get(II)I

    move-result v7

    if-eq v7, v6, :cond_2

    .line 87
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 88
    :cond_2
    invoke-virtual {v2, v0, v6}, Landroid/util/SparseIntArray;->get(II)I

    move-result v7

    if-eq v7, v6, :cond_3

    .line 89
    add-int/lit8 v3, v3, 0x2

    goto :goto_1

    .line 90
    :cond_3
    if-eqz p1, :cond_6

    .line 91
    invoke-static {v0}, Lcom/lge/internal/telephony/LGGsmAlphabet;->lookupLossy7bitTable(C)I

    move-result v7

    if-eq v7, v6, :cond_4

    .line 92
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_4
    move v3, v6

    .line 100
    .end local v0    # "c":C
    .end local v3    # "count":I
    :cond_5
    :goto_2
    return v3

    .restart local v0    # "c":C
    .restart local v3    # "count":I
    :cond_6
    move v3, v6

    .line 97
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
    .line 207
    .local p2, "lpcList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;>;"
    new-instance v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v8}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 208
    .local v8, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    const v11, 0x7fffffff

    iput v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 209
    const/4 v11, 0x1

    iput v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 210
    const v2, 0x7fffffff

    .line 212
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

    .line 213
    .local v1, "lpc":Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;
    const/4 v7, 0x0

    .local v7, "shiftTable":I
    :goto_0
    if-gt v7, p1, :cond_0

    .line 215
    iget-object v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->septetCounts:[I

    aget v4, v11, v7

    .line 217
    .local v4, "septets":I
    const/4 v11, -0x1

    if-ne v4, v11, :cond_2

    .line 213
    :cond_1
    :goto_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 223
    :cond_2
    iget v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    if-eqz v11, :cond_7

    if-eqz v7, :cond_7

    .line 224
    const/16 v9, 0x8

    .line 234
    .local v9, "udhLength":I
    :goto_2
    add-int v11, v4, v9

    const/16 v12, 0xa0

    if-le v11, v12, :cond_a

    .line 235
    if-nez v9, :cond_3

    .line 236
    const/4 v9, 0x1

    .line 239
    :cond_3
    add-int/lit8 v9, v9, 0x6

    .line 241
    rsub-int v5, v9, 0xa0

    .line 243
    .local v5, "septetsPerMessage":I
    add-int v11, v4, v5

    add-int/lit8 v11, v11, -0x1

    div-int v3, v11, v5

    .line 245
    .local v3, "msgCount":I
    mul-int v11, v3, v5

    sub-int v6, v11, v4

    .line 252
    .end local v5    # "septetsPerMessage":I
    .local v6, "septetsRemaining":I
    :goto_3
    iget-object v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->unencodableCounts:[I

    aget v10, v11, v7

    .line 254
    .local v10, "unencodableCount":I
    if-eqz p0, :cond_4

    if-gt v10, v2, :cond_1

    .line 258
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

    .line 261
    :cond_6
    move v2, v10

    .line 262
    iput v3, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 263
    iput v4, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 264
    iput v6, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 265
    iget v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    iput v11, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    .line 266
    iput v7, v8, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    goto :goto_1

    .line 225
    .end local v3    # "msgCount":I
    .end local v6    # "septetsRemaining":I
    .end local v9    # "udhLength":I
    .end local v10    # "unencodableCount":I
    :cond_7
    iget v11, v1, Lcom/android/internal/telephony/GsmAlphabet$LanguagePairCount;->languageCode:I

    if-nez v11, :cond_8

    if-eqz v7, :cond_9

    .line 226
    :cond_8
    const/4 v9, 0x5

    .restart local v9    # "udhLength":I
    goto :goto_2

    .line 228
    .end local v9    # "udhLength":I
    :cond_9
    const/4 v9, 0x0

    .restart local v9    # "udhLength":I
    goto :goto_2

    .line 247
    :cond_a
    const/4 v3, 0x1

    .line 248
    .restart local v3    # "msgCount":I
    rsub-int v11, v9, 0xa0

    sub-int v6, v11, v4

    .restart local v6    # "septetsRemaining":I
    goto :goto_3

    .line 271
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

    .line 287
    new-instance v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    invoke-direct {v1}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;-><init>()V

    .line 288
    .local v1, "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    invoke-static {p0, p1, v2, v2}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAuto(Ljava/lang/CharSequence;ZII)I

    move-result v0

    .line 290
    .local v0, "septets":I
    const/4 v2, -0x1

    if-ne v0, v2, :cond_0

    .line 291
    const/4 v1, 0x0

    .line 309
    .end local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_0
    return-object v1

    .line 294
    .restart local v1    # "ted":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_0
    iput v3, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 295
    iput v0, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitCount:I

    .line 297
    const/16 v2, 0xa0

    if-le v0, v2, :cond_1

    .line 298
    add-int/lit16 v2, v0, 0x98

    div-int/lit16 v2, v2, 0x99

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 300
    iget v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    mul-int/lit16 v2, v2, 0x99

    sub-int/2addr v2, v0

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    .line 307
    :goto_1
    iput v3, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    goto :goto_0

    .line 303
    :cond_1
    iput v3, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->msgCount:I

    .line 304
    rsub-int v2, v0, 0xa0

    iput v2, v1, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitsRemaining:I

    goto :goto_1
.end method

.method public static getEnabledLockingShiftTablesLG()[I
    .locals 1

    .prologue
    .line 333
    sget-object v0, Lcom/android/internal/telephony/GsmAlphabet;->sEnabledLockingShiftTables:[I

    return-object v0
.end method

.method public static getEnabledSingleShiftTablesLG()[I
    .locals 1

    .prologue
    .line 321
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
    .line 576
    new-instance v9, Ljava/lang/StringBuilder;

    move/from16 v0, p2

    invoke-direct {v9, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 578
    .local v9, "ret":Ljava/lang/StringBuilder;
    if-ltz p4, :cond_0

    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    array-length v12, v12

    move/from16 v0, p4

    if-le v0, v12, :cond_1

    .line 579
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

    .line 580
    const/16 p4, 0x0

    .line 582
    :cond_1
    if-ltz p5, :cond_2

    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    array-length v12, v12

    move/from16 v0, p5

    if-le v0, v12, :cond_3

    .line 583
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

    .line 584
    const/16 p5, 0x0

    .line 588
    :cond_3
    const/4 v8, 0x0

    .line 589
    .local v8, "prevCharWasEscape":Z
    :try_start_0
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    aget-object v7, v12, p4

    .line 590
    .local v7, "languageTableToChar":Ljava/lang/String;
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    aget-object v11, v12, p5

    .line 592
    .local v11, "shiftTableToChar":Ljava/lang/String;
    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_4

    .line 593
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

    .line 594
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v7, v12, v13

    .line 596
    :cond_4
    invoke-virtual {v11}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_5

    .line 597
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

    .line 598
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v11, v12, v13

    .line 601
    :cond_5
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    move/from16 v0, p2

    if-ge v6, v0, :cond_c

    .line 602
    mul-int/lit8 v12, v6, 0x7

    add-int v1, v12, p3

    .line 604
    .local v1, "bitOffset":I
    div-int/lit8 v2, v1, 0x8

    .line 605
    .local v2, "byteOffset":I
    rem-int/lit8 v10, v1, 0x8

    .line 606
    .local v10, "shift":I
    const/4 v5, 0x1

    .line 608
    .local v5, "gsmVal":I
    add-int v12, p1, v2

    array-length v13, p0

    if-ge v12, v13, :cond_6

    .line 609
    add-int v12, p1, v2

    aget-byte v12, p0, v12

    shr-int/2addr v12, v10

    and-int/lit8 v5, v12, 0x7f

    .line 614
    :cond_6
    const/4 v12, 0x1

    if-le v10, v12, :cond_7

    .line 616
    const/16 v12, 0x7f

    add-int/lit8 v13, v10, -0x1

    shr-int/2addr v12, v13

    and-int/2addr v5, v12

    .line 618
    add-int v12, p1, v2

    add-int/lit8 v12, v12, 0x1

    array-length v13, p0

    if-ge v12, v13, :cond_7

    .line 619
    add-int v12, p1, v2

    add-int/lit8 v12, v12, 0x1

    aget-byte v12, p0, v12

    rsub-int/lit8 v13, v10, 0x8

    shl-int/2addr v12, v13

    and-int/lit8 v12, v12, 0x7f

    or-int/2addr v5, v12

    .line 624
    :cond_7
    if-eqz v8, :cond_a

    .line 625
    const/16 v12, 0x1b

    if-ne v5, v12, :cond_8

    .line 626
    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 635
    :goto_1
    const/4 v8, 0x0

    .line 601
    :goto_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 628
    :cond_8
    invoke-virtual {v11, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 629
    .local v3, "c":C
    const/16 v12, 0x20

    if-ne v3, v12, :cond_9

    .line 630
    invoke-virtual {v7, v5}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 642
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

    .line 643
    .local v4, "ex":Ljava/lang/RuntimeException;
    const-string v12, "GSM"

    const-string v13, "Error GSM 7 bit packed: "

    invoke-static {v12, v13, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 646
    const-string v12, "It is a wrong formatted message"

    .line 650
    .end local v4    # "ex":Ljava/lang/RuntimeException;
    :goto_3
    return-object v12

    .line 632
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

    .line 636
    .end local v3    # "c":C
    :cond_a
    const/16 v12, 0x1b

    if-ne v5, v12, :cond_b

    .line 637
    const/4 v8, 0x1

    goto :goto_2

    .line 639
    :cond_b
    invoke-virtual {v7, v5}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 650
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
    .line 673
    const/4 v5, 0x0

    .line 674
    .local v5, "isMbcs":Z
    const/4 v2, 0x0

    .line 675
    .local v2, "charset":Ljava/nio/charset/Charset;
    const/4 v7, 0x0

    .line 677
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

    .line 680
    const/4 v5, 0x1

    .line 681
    invoke-static/range {p3 .. p3}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v2

    .line 682
    const/4 v12, 0x2

    invoke-static {v12}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    .line 686
    :cond_0
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v6, v12, v13

    .line 687
    .local v6, "languageTableToChar":Ljava/lang/String;
    sget-object v12, Lcom/android/internal/telephony/GsmAlphabet;->sLanguageShiftTables:[Ljava/lang/String;

    const/4 v13, 0x0

    aget-object v11, v12, v13

    .line 689
    .local v11, "shiftTableToChar":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    move/from16 v0, p2

    invoke-direct {v9, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 690
    .local v9, "ret":Ljava/lang/StringBuilder;
    const/4 v8, 0x0

    .line 691
    .local v8, "prevWasEscape":Z
    move v3, p1

    .local v3, "i":I
    move v4, v3

    .end local v3    # "i":I
    .local v4, "i":I
    :goto_0
    add-int v12, p1, p2

    if-ge v4, v12, :cond_1

    .line 694
    aget-byte v12, p0, v4

    and-int/lit16 v1, v12, 0xff

    .line 696
    .local v1, "c":I
    const/16 v12, 0xff

    if-ne v1, v12, :cond_2

    .line 756
    .end local v1    # "c":I
    :cond_1
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    return-object v12

    .line 698
    .restart local v1    # "c":I
    :cond_2
    const/16 v12, 0x1b

    if-ne v1, v12, :cond_4

    .line 699
    if-eqz v8, :cond_3

    .line 703
    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 704
    const/4 v8, 0x0

    move v3, v4

    .line 691
    .end local v4    # "i":I
    .restart local v3    # "i":I
    :goto_1
    add-int/lit8 v3, v3, 0x1

    move v4, v3

    .end local v3    # "i":I
    .restart local v4    # "i":I
    goto :goto_0

    .line 706
    :cond_3
    const/4 v8, 0x1

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_1

    .line 723
    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_4
    if-eqz v8, :cond_7

    .line 724
    const/16 v12, 0x80

    if-ge v1, v12, :cond_6

    .line 725
    invoke-virtual {v11, v1}, Ljava/lang/String;->charAt(I)C

    move-result v10

    .line 726
    .local v10, "shiftChar":C
    const/16 v12, 0x20

    if-ne v10, v12, :cond_5

    .line 728
    invoke-virtual {v6, v1}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_2
    move v3, v4

    .line 752
    .end local v4    # "i":I
    .end local v10    # "shiftChar":C
    .restart local v3    # "i":I
    :goto_3
    const/4 v8, 0x0

    goto :goto_1

    .line 730
    .end local v3    # "i":I
    .restart local v4    # "i":I
    .restart local v10    # "shiftChar":C
    :cond_5
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 733
    .end local v10    # "shiftChar":C
    :cond_6
    const-string v12, "GsmAlphabet"

    const-string v13, "[TEL-SMS] gsm8BitUnpackedToString extend GSM 7 bit default alphabet"

    invoke-static {v12, v13}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 734
    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_3

    .line 737
    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_7
    if-eqz v5, :cond_8

    add-int/lit8 v12, v4, 0x1

    add-int v13, p1, p2

    if-lt v12, v13, :cond_a

    .line 738
    :cond_8
    const/16 v12, 0x80

    if-ge v1, v12, :cond_9

    .line 739
    invoke-virtual {v6, v1}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_3

    .line 741
    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_9
    const/16 v12, 0x20

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v3, v4

    .end local v4    # "i":I
    .restart local v3    # "i":I
    goto :goto_3

    .line 746
    .end local v3    # "i":I
    .restart local v4    # "i":I
    :cond_a
    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 747
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "i":I
    .restart local v3    # "i":I
    const/4 v12, 0x2

    invoke-virtual {v7, p0, v4, v12}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    .line 748
    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 749
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

    .line 346
    const/4 v0, -0x1

    .line 348
    .local v0, "v":I
    const/16 v1, 0x80

    if-ge p0, v1, :cond_2

    .line 349
    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmBasicLatin:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    .line 369
    :cond_0
    :goto_0
    sget-boolean v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    if-eqz v1, :cond_1

    .line 370
    if-ne v0, v2, :cond_1

    .line 372
    const/16 v0, 0x20

    .line 377
    :cond_1
    return v0

    .line 350
    :cond_2
    const/16 v1, 0xe7

    if-ne p0, v1, :cond_3

    sget-boolean v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    if-eqz v1, :cond_3

    .line 351
    const/16 v0, 0x9

    goto :goto_0

    .line 352
    :cond_3
    const/16 v1, 0x7f

    if-le p0, v1, :cond_4

    const/16 v1, 0x100

    if-ge p0, v1, :cond_4

    .line 353
    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatin1Supplement:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    .line 354
    :cond_4
    const/16 v1, 0xff

    if-le p0, v1, :cond_5

    const/16 v1, 0x180

    if-ge p0, v1, :cond_5

    .line 355
    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedA:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    .line 356
    :cond_5
    const/16 v1, 0x17f

    if-le p0, v1, :cond_6

    const/16 v1, 0x250

    if-ge p0, v1, :cond_6

    .line 357
    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmLatinExtendedB:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    .line 358
    :cond_6
    const/16 v1, 0x36f

    if-le p0, v1, :cond_7

    const/16 v1, 0x400

    if-ge p0, v1, :cond_7

    .line 359
    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmGreekCoptic:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    .line 360
    :cond_7
    const/16 v1, 0x3ff

    if-le p0, v1, :cond_8

    const/16 v1, 0x500

    if-ge p0, v1, :cond_8

    .line 361
    sget-object v1, Lcom/lge/internal/telephony/LGGsmAlphabet;->charToGsmCyrillic:Landroid/util/SparseIntArray;

    invoke-virtual {v1, p0, v2}, Landroid/util/SparseIntArray;->get(II)I

    move-result v0

    goto :goto_0

    .line 362
    :cond_8
    const/16 v1, 0x1fff

    if-le p0, v1, :cond_0

    const/16 v1, 0x2070

    if-ge p0, v1, :cond_0

    .line 363
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

    .line 388
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v0

    .line 390
    .local v0, "mSIMoperator":Ljava/lang/String;
    sput-boolean v3, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    .line 391
    sput-boolean v3, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    .line 392
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x5

    if-lt v1, v2, :cond_0

    .line 393
    const/4 v1, 0x3

    invoke-virtual {v0, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    const-string v2, "214"

    invoke-static {v1, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 395
    sput-boolean v4, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsSpanish:Z

    .line 399
    :cond_0
    const/4 v1, 0x0

    const-string v2, "gsm_strict_encoding"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 400
    sput-boolean v4, Lcom/lge/internal/telephony/LGGsmAlphabet;->sIsStrict:Z

    .line 403
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
    .line 489
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    .line 496
    .local v7, "dataLen":I
    if-nez p2, :cond_0

    const/4 v13, 0x1

    :goto_0
    move/from16 v0, p3

    move/from16 v1, p4

    invoke-static {p0, v13, v0, v1}, Lcom/lge/internal/telephony/LGGsmAlphabet;->countGsmSeptetsUsingTablesLossyAuto(Ljava/lang/CharSequence;ZII)I

    move-result v10

    .line 500
    .local v10, "septetCount":I
    const/4 v13, -0x1

    if-ne v10, v13, :cond_1

    .line 501
    new-instance v13, Lcom/android/internal/telephony/EncodeException;

    const-string v14, "countGsmSeptetsUsingTables(): unencodable char"

    invoke-direct {v13, v14}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 496
    .end local v10    # "septetCount":I
    :cond_0
    const/4 v13, 0x0

    goto :goto_0

    .line 503
    .restart local v10    # "septetCount":I
    :cond_1
    add-int v10, v10, p1

    .line 504
    const/16 v13, 0xff

    if-le v10, v13, :cond_2

    .line 505
    new-instance v13, Lcom/android/internal/telephony/EncodeException;

    const-string v14, "Payload cannot exceed 255 septets"

    invoke-direct {v13, v14}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 507
    :cond_2
    mul-int/lit8 v13, v10, 0x7

    add-int/lit8 v13, v13, 0x7

    div-int/lit8 v3, v13, 0x8

    .line 508
    .local v3, "byteCount":I
    add-int/lit8 v13, v3, 0x1

    new-array v9, v13, [B

    .line 509
    .local v9, "ret":[B
    sget-object v13, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToGsmTables:[Landroid/util/SparseIntArray;

    aget-object v5, v13, p3

    .line 510
    .local v5, "charToLanguageTable":Landroid/util/SparseIntArray;
    sget-object v13, Lcom/android/internal/telephony/GsmAlphabet;->sCharsToShiftTables:[Landroid/util/SparseIntArray;

    aget-object v6, v13, p4

    .line 512
    .local v6, "charToShiftTable":Landroid/util/SparseIntArray;
    if-nez p2, :cond_3

    .line 513
    invoke-static {}, Lcom/lge/internal/telephony/LGGsmAlphabet;->setLossy7bitTableCondition()V

    .line 516
    :cond_3
    const/4 v8, 0x0

    .local v8, "i":I
    move/from16 v11, p1

    .local v11, "septets":I
    mul-int/lit8 v2, p1, 0x7

    .line 517
    .local v2, "bitOffset":I
    :goto_1
    if-ge v8, v7, :cond_7

    if-ge v11, v10, :cond_7

    .line 519
    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 520
    .local v4, "c":C
    const/4 v13, -0x1

    invoke-virtual {v5, v4, v13}, Landroid/util/SparseIntArray;->get(II)I

    move-result v12

    .line 521
    .local v12, "v":I
    const/4 v13, -0x1

    if-ne v12, v13, :cond_6

    .line 522
    const/4 v13, -0x1

    invoke-virtual {v6, v4, v13}, Landroid/util/SparseIntArray;->get(II)I

    move-result v12

    .line 523
    const/4 v13, -0x1

    if-ne v12, v13, :cond_5

    .line 532
    if-nez p2, :cond_4

    .line 534
    invoke-static {v4}, Lcom/lge/internal/telephony/LGGsmAlphabet;->lookupLossy7bitTable(C)I

    move-result v12

    .line 537
    :cond_4
    const/4 v13, -0x1

    if-ne v12, v13, :cond_6

    .line 538
    new-instance v13, Lcom/android/internal/telephony/EncodeException;

    const-string v14, "stringToGsm7BitPacked(): unencodable char"

    invoke-direct {v13, v14}, Lcom/android/internal/telephony/EncodeException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 542
    :cond_5
    const/16 v13, 0x1b

    invoke-static {v9, v2, v13}, Lcom/android/internal/telephony/GsmAlphabet;->packSmsChar([BII)V

    .line 543
    add-int/lit8 v2, v2, 0x7

    .line 544
    add-int/lit8 v11, v11, 0x1

    .line 547
    :cond_6
    invoke-static {v9, v2, v12}, Lcom/android/internal/telephony/GsmAlphabet;->packSmsChar([BII)V

    .line 548
    add-int/lit8 v11, v11, 0x1

    .line 518
    add-int/lit8 v8, v8, 0x1

    add-int/lit8 v2, v2, 0x7

    goto :goto_1

    .line 550
    .end local v4    # "c":C
    .end local v12    # "v":I
    :cond_7
    const/4 v13, 0x0

    int-to-byte v14, v10

    aput-byte v14, v9, v13

    .line 551
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

    .line 439
    const-string v7, "persist.gsm.sms.forcegsm7"

    const-string v8, "1"

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 440
    .local v0, "encodingType":Ljava/lang/String;
    const-string v7, "0"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_1

    move v3, v5

    .line 441
    .local v3, "isThrowException":Z
    :goto_0
    if-eqz p1, :cond_0

    array-length v7, p1

    if-nez v7, :cond_2

    .line 442
    :cond_0
    invoke-static {p0, v6, v3, p2, p3}, Lcom/lge/internal/telephony/LGGsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;IZII)[B

    move-result-object v4

    .line 460
    :goto_1
    return-object v4

    .end local v3    # "isThrowException":Z
    :cond_1
    move v3, v6

    .line 440
    goto :goto_0

    .line 446
    .restart local v3    # "isThrowException":Z
    :cond_2
    array-length v7, p1

    add-int/lit8 v7, v7, 0x1

    mul-int/lit8 v1, v7, 0x8

    .line 447
    .local v1, "headerBits":I
    add-int/lit8 v7, v1, 0x6

    div-int/lit8 v2, v7, 0x7

    .line 454
    .local v2, "headerSeptets":I
    invoke-static {p0, v2, v3, p2, p3}, Lcom/lge/internal/telephony/LGGsmAlphabet;->stringToGsm7BitPacked(Ljava/lang/String;IZII)[B

    move-result-object v4

    .line 458
    .local v4, "ret":[B
    array-length v7, p1

    int-to-byte v7, v7

    aput-byte v7, v4, v5

    .line 459
    const/4 v5, 0x2

    array-length v7, p1

    invoke-static {p1, v6, v4, v5, v7}, Ljava/lang/System;->arraycopy([BI[BII)V

    goto :goto_1
.end method
