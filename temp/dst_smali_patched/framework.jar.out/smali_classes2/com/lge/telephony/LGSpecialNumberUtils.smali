.class public Lcom/lge/telephony/LGSpecialNumberUtils;
.super Ljava/lang/Object;
.source "LGSpecialNumberUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;,
        Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;
    }
.end annotation


# static fields
.field private static final BOOST:Ljava/lang/String; = "311870"

.field private static final DBG:Z = false

.field public static final FORMAT_KOREA:I = 0x3

.field public static final JP_SPECIALNUMBER:[Ljava/lang/String;

.field static final LOG_TAG:Ljava/lang/String; = "LGSpecialNumberUtils"

.field private static final NetworkCode:Ljava/lang/String;

.field private static final PRIVITE_DBG:Z

.field private static final SPRINT:Ljava/lang/String; = "310120"

.field private static final SPRINT_PREPAID:Ljava/lang/String; = "312530"

.field private static final VIRGIN:Ljava/lang/String; = "311490"

.field private static final sVZWNetworkOperatorList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

.field private static specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

.field private static specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;


# direct methods
.method static constructor <clinit>()V
    .locals 11

    .prologue
    const/4 v10, 0x4

    const/4 v9, 0x3

    const/4 v8, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    const/16 v0, 0x10

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isLogBlocked(I)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    const-string v0, "ro.cdma.home.operator.numeric"

    const-string v3, "310000"

    invoke-static {v0, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const/16 v0, 0xa

    new-array v0, v0, [Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "*2"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_2_sprint_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v1

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "*4"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_4_sprint_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v2

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "0"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_0_sprint_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v8

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "211"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_211_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v9

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "311"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_311_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v10

    const/4 v3, 0x5

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "411"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_411_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    const/4 v3, 0x6

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "511"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_511_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    const/4 v3, 0x7

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "611"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_611_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    const/16 v3, 0x8

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "711"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_711_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    const/16 v3, 0x9

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "811"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_811_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    sput-object v0, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const/4 v0, 0x7

    new-array v0, v0, [Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "211"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_211_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v1

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "311"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_311_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v2

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "411"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_411_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v8

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "511"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_511_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v9

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v4, "611"

    sget v5, Lcom/lge/internal/R$string;->sp_dialer_611_NORMAL:I

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v3, v0, v10

    const/4 v3, 0x5

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "711"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_711_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    const/4 v3, 0x6

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const-string v5, "811"

    sget v6, Lcom/lge/internal/R$string;->sp_dialer_811_NORMAL:I

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;-><init>(Ljava/lang/String;I)V

    aput-object v4, v0, v3

    sput-object v0, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    const/16 v0, 0x12

    new-array v0, v0, [Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v4, "adc.n11.first.number"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "adc.n11.first.name"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v0, v1

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v4, "adc.n11.second.number"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "adc.n11.second.name"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v0, v2

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v4, "adc.n11.third.number"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "adc.n11.third.name"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v0, v8

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v4, "adc.n11.forth.number"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "adc.n11.forth.name"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v0, v9

    new-instance v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v4, "adc.n11.fifth.number"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "adc.n11.fifth.name"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v3, v0, v10

    const/4 v3, 0x5

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.sixth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.sixth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/4 v3, 0x6

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.seventh.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.seventh.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/4 v3, 0x7

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.eighth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.eighth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0x8

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.ninth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.ninth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0x9

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.tenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.tenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0xa

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.elevnth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.elevnth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0xb

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.twelfth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.twelfth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0xc

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.thirteenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.thirteenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0xd

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.fourteenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.fourteenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0xe

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.fifteenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.fifteenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0xf

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.sixteenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.sixteenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0x10

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.seventeenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.seventeenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    const/16 v3, 0x11

    new-instance v4, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    const-string v5, "adc.n11.eighteenth.number"

    const-string v6, ""

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "adc.n11.eighteenth.name"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v4, v0, v3

    sput-object v0, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    new-array v0, v8, [Ljava/lang/String;

    const-string v3, "184"

    aput-object v3, v0, v1

    const-string v3, "186"

    aput-object v3, v0, v2

    sput-object v0, Lcom/lge/telephony/LGSpecialNumberUtils;->JP_SPECIALNUMBER:[Ljava/lang/String;

    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const-string v3, "310"

    aput-object v3, v0, v1

    const-string v1, "311"

    aput-object v1, v0, v2

    const-string v1, "312"

    aput-object v1, v0, v8

    const-string v1, "313"

    aput-object v1, v0, v9

    const-string v1, "315"

    aput-object v1, v0, v10

    const/4 v1, 0x5

    const-string v2, "316"

    aput-object v2, v0, v1

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/lge/telephony/LGSpecialNumberUtils;->sVZWNetworkOperatorList:Ljava/util/List;

    return-void

    :cond_0
    move v0, v2

    goto/16 :goto_0
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static convertInternational611Number(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x1

    invoke-static {}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialCurrentCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v4

    .local v4, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    move-object v2, p0

    .local v2, "convertNumber":Ljava/lang/String;
    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v0

    .local v0, "IddNumber":Ljava/lang/String;
    const-string v1, "19085594899"

    .local v1, "International611Number":Ljava/lang/String;
    sget-boolean v5, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    if-eqz v5, :cond_0

    const-string v5, "LGSpecialNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "convertInternational611Number()...\tbefore number = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    if-nez v4, :cond_1

    move-object v3, v2

    .end local v2    # "convertNumber":Ljava/lang/String;
    .local v3, "convertNumber":Ljava/lang/String;
    :goto_0
    return-object v3

    .end local v3    # "convertNumber":Ljava/lang/String;
    .restart local v2    # "convertNumber":Ljava/lang/String;
    :cond_1
    sget-boolean v5, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    if-eqz v5, :cond_2

    const-string v5, "LGSpecialNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "IddNumber() = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v5

    const/4 v6, 0x2

    if-ne v5, v6, :cond_7

    invoke-static {}, Lcom/lge/telephony/LGSpecialNumberUtils;->isVZWCDMANetwork()Z

    move-result v5

    if-nez v5, :cond_3

    if-eqz v4, :cond_5

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v5

    const-string v6, "1"

    invoke-static {v5, v6}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v5

    if-ne v5, v8, :cond_5

    move-object v2, v1

    :cond_3
    :goto_1
    sget-boolean v5, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    if-eqz v5, :cond_4

    const-string v5, "LGSpecialNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "convertInternational611Number()... after number = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    move-object v3, v2

    .end local v2    # "convertNumber":Ljava/lang/String;
    .restart local v3    # "convertNumber":Ljava/lang/String;
    goto :goto_0

    .end local v3    # "convertNumber":Ljava/lang/String;
    .restart local v2    # "convertNumber":Ljava/lang/String;
    :cond_5
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_6

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_6
    move-object v2, v1

    goto :goto_1

    :cond_7
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v5

    if-ne v5, v8, :cond_3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_1
.end method

.method public static convertInternationalVoiceMailNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x1

    invoke-static {}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialCurrentCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v3

    .local v3, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    move-object v1, p0

    .local v1, "convertNumber":Ljava/lang/String;
    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v0

    .local v0, "IddNumber":Ljava/lang/String;
    sget-boolean v4, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    if-eqz v4, :cond_0

    const-string v4, "LGSpecialNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "convertInternationalVoiceMailNumber()...\tbefore number = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    if-nez v3, :cond_1

    move-object v2, v1

    .end local v1    # "convertNumber":Ljava/lang/String;
    .local v2, "convertNumber":Ljava/lang/String;
    :goto_0
    return-object v2

    .end local v2    # "convertNumber":Ljava/lang/String;
    .restart local v1    # "convertNumber":Ljava/lang/String;
    :cond_1
    sget-boolean v4, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    if-eqz v4, :cond_2

    const-string v4, "LGSpecialNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "IddNumber() = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "LGSpecialNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getLine1Number() = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v6

    invoke-virtual {v6}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v4

    const/4 v5, 0x2

    if-ne v4, v5, :cond_7

    invoke-static {}, Lcom/lge/telephony/LGSpecialNumberUtils;->isVZWCDMANetwork()Z

    move-result v4

    if-nez v4, :cond_3

    if-eqz v3, :cond_5

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v4

    const-string v5, "1"

    invoke-static {v4, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-ne v4, v7, :cond_5

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "1"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_3
    :goto_1
    sget-boolean v4, Lcom/lge/telephony/LGSpecialNumberUtils;->PRIVITE_DBG:Z

    if-eqz v4, :cond_4

    const-string v4, "LGSpecialNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "convertInternationalVoiceMailNumber()... after number = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    move-object v2, v1

    .end local v1    # "convertNumber":Ljava/lang/String;
    .restart local v2    # "convertNumber":Ljava/lang/String;
    goto/16 :goto_0

    .end local v2    # "convertNumber":Ljava/lang/String;
    .restart local v1    # "convertNumber":Ljava/lang/String;
    :cond_5
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_6

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "1"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_6
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "1"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_7
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v4

    if-ne v4, v7, :cond_3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "+1"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto/16 :goto_1
.end method

.method public static extractNetworkPortionAltJP(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "SBM"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-static {p0}, Lcom/lge/telephony/LGSpecialNumberUtils;->extractSpecialNumberPortion(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    :cond_1
    return-object p0
.end method

.method public static extractSpecialNumberPortion(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    :goto_0
    return-object p0

    :cond_1
    sget-object v2, Lcom/lge/telephony/LGSpecialNumberUtils;->JP_SPECIALNUMBER:[Ljava/lang/String;

    array-length v1, v2

    .local v1, "max":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    if-ge v0, v1, :cond_0

    sget-object v2, Lcom/lge/telephony/LGSpecialNumberUtils;->JP_SPECIALNUMBER:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {p0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    sget-object v2, Lcom/lge/telephony/LGSpecialNumberUtils;->JP_SPECIALNUMBER:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method public static formatKoreanNumber(Landroid/text/Editable;)V
    .locals 0
    .param p0, "text"    # Landroid/text/Editable;

    .prologue
    invoke-static {p0}, Lcom/lge/telephony/LGKoreanPhoneNumberFormatter;->format(Landroid/text/Editable;)V

    return-void
.end method

.method public static formatNumber(Landroid/text/Editable;I)V
    .locals 0
    .param p0, "edit"    # Landroid/text/Editable;
    .param p1, "formatType"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    :goto_0
    return-void

    :pswitch_0
    invoke-static {p0}, Lcom/lge/telephony/LGSpecialNumberUtils;->formatKoreanNumber(Landroid/text/Editable;)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_0
    .end packed-switch
.end method

.method public static getInternationalVoiceMailNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getLocaleInfo()Ljava/util/Locale;
    .locals 3

    .prologue
    const-string v1, "KR"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "gsm.operator.iso-country"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "currIso":Ljava/lang/String;
    const-string v1, "KR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Ljava/util/Locale;->KOREA:Ljava/util/Locale;

    :goto_0
    return-object v1

    :cond_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    goto :goto_0
.end method

.method public static getN11OrSpecialNumberString(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x1

    const/4 v1, 0x0

    .local v1, "resString":Ljava/lang/String;
    if-nez p1, :cond_0

    move-object v2, v1

    .end local v1    # "resString":Ljava/lang/String;
    .local v2, "resString":Ljava/lang/String;
    :goto_0
    return-object v2

    .end local v2    # "resString":Ljava/lang/String;
    .restart local v1    # "resString":Ljava/lang/String;
    :cond_0
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->extractNetworkPortionAlt(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const-string v4, "311870"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const-string v4, "311490"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const-string v4, "312530"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    :cond_1
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    array-length v3, v3

    if-ge v0, v3, :cond_5

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;->number:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-ne v3, v5, :cond_2

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;->resIDOfNums:I

    invoke-virtual {p0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .end local v0    # "i":I
    :cond_3
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    array-length v3, v3

    if-ge v0, v3, :cond_5

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;->number:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-ne v3, v5, :cond_4

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    aget-object v3, v3, v0

    iget v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;->resIDOfNums:I

    invoke-virtual {p0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_5
    const/4 v0, 0x0

    :goto_3
    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    array-length v3, v3

    if-ge v0, v3, :cond_7

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;->number:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-ne v3, v5, :cond_6

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    aget-object v3, v3, v0

    iget-object v1, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;->resString:Ljava/lang/String;

    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    :cond_7
    move-object v2, v1

    .end local v1    # "resString":Ljava/lang/String;
    .restart local v2    # "resString":Ljava/lang/String;
    goto :goto_0
.end method

.method public static getValidMdnForVZW(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "mdnNumber"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    .local v3, "validMdn":Ljava/lang/String;
    move-object v3, p0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .local v2, "mdnNumberLength":I
    :goto_0
    const/16 v5, 0xa

    if-lt v2, v5, :cond_1

    add-int/lit8 v5, v2, -0xa

    invoke-virtual {p0, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    .local v0, "chArr":[C
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v1, v5, :cond_3

    aget-char v5, v0, v1

    invoke-static {v5}, Landroid/telephony/PhoneNumberUtils;->isISODigit(C)Z

    move-result v5

    if-nez v5, :cond_2

    const-string v5, "LGSpecialNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "chArr["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-char v7, v0, v1

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "chArr":[C
    .end local v1    # "i":I
    :goto_2
    return-object v4

    .end local v2    # "mdnNumberLength":I
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .restart local v2    # "mdnNumberLength":I
    :cond_1
    const-string v5, "LGSpecialNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "MDN length is "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", so return null"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .restart local v0    # "chArr":[C
    .restart local v1    # "i":I
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_3
    const-string v5, "0000000000"

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    const-string v5, "LGSpecialNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "validMdn = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    :cond_4
    move-object v4, v3

    goto :goto_2
.end method

.method public static is611DialNumber(Ljava/lang/String;)Z
    .locals 2
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const-string v0, "*611"

    .local v0, "is611Check":Ljava/lang/String;
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0, v0}, Landroid/telephony/PhoneNumberUtils;->compare(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static isKoreaEmergencyNumber(Ljava/lang/String;Z)Z
    .locals 10
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "useExactMatch"    # Z

    .prologue
    const/4 v6, 0x1

    const-string v7, "ril.ecclist"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "numbers":Ljava/lang/String;
    const-string v7, "LGSpecialNumberUtils"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "isKoreaEmergencyNumber number="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ", useExactMatch="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ", numbers="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, 0x0

    .local v5, "retB":Z
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_3

    const-string v7, ","

    invoke-virtual {v4, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_3

    aget-object v1, v0, v2

    .local v1, "emergencyNum":Ljava/lang/String;
    if-eqz p1, :cond_1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "emergencyNum":Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    :cond_0
    :goto_1
    return v6

    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v1    # "emergencyNum":Ljava/lang/String;
    .restart local v2    # "i$":I
    .restart local v3    # "len$":I
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_0

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "emergencyNum":Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    :cond_3
    const-string v6, "KR"

    const-string v7, "SKT"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-static {p0, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->isKoreaSKTEmergencyNumber(Ljava/lang/String;Z)Z

    move-result v5

    :cond_4
    :goto_2
    move v6, v5

    goto :goto_1

    :cond_5
    const-string v6, "KR"

    const-string v7, "KT"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-static {p0, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->isKoreaKTEmergencyNumber(Ljava/lang/String;Z)Z

    move-result v5

    goto :goto_2

    :cond_6
    const-string v6, "KR"

    const-string v7, "LGU"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-static {p0, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->isKoreaLGUEmergencyNumber(Ljava/lang/String;Z)Z

    move-result v5

    goto :goto_2
.end method

.method private static isKoreaKTEmergencyNumber(Ljava/lang/String;Z)Z
    .locals 9
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "useExactMatch"    # Z

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    const/4 v4, 0x0

    .local v4, "numbers":Ljava/lang/String;
    const/4 v7, 0x0

    const-string v8, "domestic_ecclist"

    invoke-static {v7, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_2

    const-string v7, ","

    invoke-virtual {v4, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_0

    aget-object v1, v0, v2

    .local v1, "emergencyNum":Ljava/lang/String;
    invoke-static {p0, v1, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v7

    if-eqz v7, :cond_1

    move v5, v6

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "emergencyNum":Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    :cond_0
    :goto_1
    return v5

    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v1    # "emergencyNum":Ljava/lang/String;
    .restart local v2    # "i$":I
    .restart local v3    # "len$":I
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "emergencyNum":Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    :cond_2
    const-string v7, "112"

    invoke-static {p0, v7, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v7

    if-nez v7, :cond_3

    const-string v7, "911"

    invoke-static {p0, v7, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v7

    if-eqz v7, :cond_0

    :cond_3
    move v5, v6

    goto :goto_1
.end method

.method private static isKoreaLGUEmergencyNumber(Ljava/lang/String;Z)Z
    .locals 13
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "useExactMatch"    # Z

    .prologue
    const/4 v12, 0x3

    const/4 v8, 0x1

    const/4 v11, 0x0

    const/4 v7, 0x0

    const/4 v5, 0x0

    .local v5, "numbers":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "IsUsimRoaming":Z
    const-string v9, "persist.radio.camped_mccmnc"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .local v6, "usimMccMnc":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "number="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v7}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "usimMccMnc="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v7}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_0

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_0

    invoke-virtual {v6, v7, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    const-string v10, "450"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_0

    invoke-virtual {v6, v7, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    const-string v10, "001"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_0

    const/4 v0, 0x1

    :cond_0
    const-string v9, "true"

    const-string v10, "gsm.operator.isroaming"

    invoke-static {v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_1

    if-eqz v0, :cond_3

    :cond_1
    const-string v9, "LGU_roaming_ecclist"

    invoke-static {v11, v9}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    :goto_0
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "LG U+ ecclist : numbers="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v7}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_6

    const-string v9, ","

    invoke-virtual {v5, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .local v1, "arr$":[Ljava/lang/String;
    array-length v4, v1

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_1
    if-ge v3, v4, :cond_2

    aget-object v2, v1, v3

    .local v2, "emergencyNum":Ljava/lang/String;
    invoke-static {p0, v2, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v9

    if-eqz v9, :cond_5

    move v7, v8

    .end local v1    # "arr$":[Ljava/lang/String;
    .end local v2    # "emergencyNum":Ljava/lang/String;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :cond_2
    :goto_2
    return v7

    :cond_3
    const-string v9, "ril.card_operator"

    const-string v10, ""

    invoke-static {v9, v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "LGU"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v9

    invoke-virtual {v9}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v9

    const/4 v10, 0x2

    if-ne v9, v10, :cond_4

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "LGU_ecclist"

    invoke-static {v11, v10}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ",114"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    goto :goto_0

    :cond_4
    const-string v9, "LGU_ecclist"

    invoke-static {v11, v9}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_0

    .restart local v1    # "arr$":[Ljava/lang/String;
    .restart local v2    # "emergencyNum":Ljava/lang/String;
    .restart local v3    # "i$":I
    .restart local v4    # "len$":I
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .end local v1    # "arr$":[Ljava/lang/String;
    .end local v2    # "emergencyNum":Ljava/lang/String;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :cond_6
    const-string v9, "112"

    invoke-static {p0, v9, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v9

    if-nez v9, :cond_7

    const-string v9, "911"

    invoke-static {p0, v9, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v9

    if-eqz v9, :cond_2

    :cond_7
    move v7, v8

    goto :goto_2
.end method

.method private static isKoreaSKTEmergencyNumber(Ljava/lang/String;Z)Z
    .locals 12
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "useExactMatch"    # Z

    .prologue
    const/4 v6, 0x0

    .local v6, "numbers":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "IsUsimRoaming":Z
    const-string v9, "persist.radio.camped_mccmnc"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .local v8, "usimMccMnc":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "number="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    invoke-static {v9, v10}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "usimMccMnc="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    invoke-static {v9, v10}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_0

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_0

    const/4 v9, 0x0

    const/4 v10, 0x3

    invoke-virtual {v8, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    const-string v10, "450"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_0

    const/4 v9, 0x0

    const/4 v10, 0x3

    invoke-virtual {v8, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    const-string v10, "001"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_0

    const/4 v0, 0x1

    :cond_0
    const-string v9, "true"

    const-string v10, "gsm.operator.isroaming"

    invoke-static {v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_1

    if-eqz v0, :cond_5

    :cond_1
    const-string v9, "gsm.operator.numeric"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .local v7, "numeric":Ljava/lang/String;
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_3

    const-string v5, ""

    .local v5, "mcc":Ljava/lang/String;
    :goto_0
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "mcc="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    invoke-static {v9, v10}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    const-string v9, "202"

    invoke-virtual {v5, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_2

    const-string v9, "206"

    invoke-virtual {v5, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_2

    const-string v9, "222"

    invoke-virtual {v5, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_2

    const-string v9, "505"

    invoke-virtual {v5, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    :cond_2
    const/4 v9, 0x0

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "roaming"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "_ecclist"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .end local v5    # "mcc":Ljava/lang/String;
    .end local v7    # "numeric":Ljava/lang/String;
    :goto_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "SKT ecclist : numbers = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    invoke-static {v9, v10}, Lcom/lge/telephony/LGSpecialNumberUtils;->log(Ljava/lang/String;Z)V

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_8

    const-string v9, ","

    invoke-virtual {v6, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .local v1, "arr$":[Ljava/lang/String;
    array-length v4, v1

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_2
    if-ge v3, v4, :cond_7

    aget-object v2, v1, v3

    .local v2, "emergencyNum":Ljava/lang/String;
    invoke-static {p0, v2, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v9

    if-eqz v9, :cond_6

    const/4 v9, 0x1

    .end local v1    # "arr$":[Ljava/lang/String;
    .end local v2    # "emergencyNum":Ljava/lang/String;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :goto_3
    return v9

    .restart local v7    # "numeric":Ljava/lang/String;
    :cond_3
    const/4 v9, 0x0

    const/4 v10, 0x3

    invoke-virtual {v7, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    goto/16 :goto_0

    .restart local v5    # "mcc":Ljava/lang/String;
    :cond_4
    const/4 v9, 0x0

    const-string v10, "roaming_ecclist"

    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_1

    .end local v5    # "mcc":Ljava/lang/String;
    .end local v7    # "numeric":Ljava/lang/String;
    :cond_5
    const/4 v9, 0x0

    const-string v10, "domestic_ecclist"

    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_1

    .restart local v1    # "arr$":[Ljava/lang/String;
    .restart local v2    # "emergencyNum":Ljava/lang/String;
    .restart local v3    # "i$":I
    .restart local v4    # "len$":I
    :cond_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .end local v2    # "emergencyNum":Ljava/lang/String;
    :cond_7
    const/4 v9, 0x0

    goto :goto_3

    .end local v1    # "arr$":[Ljava/lang/String;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :cond_8
    const-string v9, "112"

    invoke-static {p0, v9, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v9

    if-nez v9, :cond_9

    const-string v9, "911"

    invoke-static {p0, v9, p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->match(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v9

    if-eqz v9, :cond_a

    :cond_9
    const/4 v9, 0x1

    goto :goto_3

    :cond_a
    const/4 v9, 0x0

    goto :goto_3
.end method

.method public static isN11orSpecialNumber(Ljava/lang/String;)Z
    .locals 5
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    const/4 v3, 0x0

    const-string v4, "support_sprint_n11"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {p0}, Landroid/telephony/PhoneNumberUtils;->extractNetworkPortionAlt(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const-string v4, "311870"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const-string v4, "311490"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->NetworkCode:Ljava/lang/String;

    const-string v4, "312530"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    :cond_2
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    array-length v3, v3

    if-ge v0, v3, :cond_6

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersPrepaid:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;->number:Ljava/lang/String;

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-ne v3, v2, :cond_3

    move v1, v2

    goto :goto_0

    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .end local v0    # "i":I
    :cond_4
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    array-length v3, v3

    if-ge v0, v3, :cond_6

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbers:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbers;->number:Ljava/lang/String;

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-ne v3, v2, :cond_5

    move v1, v2

    goto :goto_0

    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_6
    const/4 v0, 0x0

    :goto_3
    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    array-length v3, v3

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/lge/telephony/LGSpecialNumberUtils;->specialNumbersAddon:[Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;

    aget-object v3, v3, v0

    iget-object v3, v3, Lcom/lge/telephony/LGSpecialNumberUtils$SpecialNumbersAddon;->number:Ljava/lang/String;

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-ne v3, v2, :cond_7

    move v1, v2

    goto :goto_0

    :cond_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_3
.end method

.method private static isVZWCDMANetwork()Z
    .locals 4

    .prologue
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getNetworkOperator()Ljava/lang/String;

    move-result-object v0

    .local v0, "networkOperator":Ljava/lang/String;
    sget-object v1, Lcom/lge/telephony/LGSpecialNumberUtils;->sVZWNetworkOperatorList:Ljava/util/List;

    const/4 v2, 0x0

    const/4 v3, 0x3

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method private static log(Ljava/lang/String;Z)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "enforce"    # Z

    .prologue
    return-void
.end method

.method private static match(Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 1
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "target"    # Ljava/lang/String;
    .param p2, "useExactMatch"    # Z

    .prologue
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0

    :cond_2
    invoke-virtual {p0, p1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method
