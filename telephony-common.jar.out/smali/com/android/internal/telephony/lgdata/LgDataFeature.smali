.class public Lcom/android/internal/telephony/lgdata/LgDataFeature;
.super Ljava/lang/Object;
.source "LgDataFeature.java"


# static fields
.field private static sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;


# instance fields
.field public LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 6
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "paramString"    # Ljava/lang/String;

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Z

    .line 9
    return-void
.end method

.method public static getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;
    .locals 2

    .prologue
    .line 12
    new-instance v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    const-string v1, "none"

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    .line 13
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    return-object v0
.end method
