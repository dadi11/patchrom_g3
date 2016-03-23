.class public Landroid/os/storage/StorageUtil;
.super Ljava/lang/Object;
.source "StorageUtil.java"


# static fields
.field private static final DEFAULT_THRESHOLD_MAX_BYTES:J = 0x1f400000L

.field private static final DEFAULT_THRESHOLD_PERCENTAGE:I = 0xa

.field private static final TAG:Ljava/lang/String; = "StorageUtil"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getStorageLowBytes(Ljava/io/File;)J
    .locals 10
    .param p0, "path"    # Ljava/io/File;

    .prologue
    .line 25
    const-wide/16 v2, 0xa

    .line 26
    .local v2, "lowPercent":J
    invoke-virtual {p0}, Ljava/io/File;->getTotalSpace()J

    move-result-wide v6

    const-wide/16 v8, 0xa

    mul-long/2addr v6, v8

    const-wide/16 v8, 0x64

    div-long v0, v6, v8

    .line 28
    .local v0, "lowBytes":J
    const-wide/32 v4, 0x1f400000

    .line 30
    .local v4, "maxLowBytes":J
    const-wide/32 v6, 0x1f400000

    invoke-static {v0, v1, v6, v7}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    return-wide v6
.end method
