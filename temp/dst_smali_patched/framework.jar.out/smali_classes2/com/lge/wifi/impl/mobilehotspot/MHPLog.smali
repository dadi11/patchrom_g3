.class public Lcom/lge/wifi/impl/mobilehotspot/MHPLog;
.super Ljava/lang/Object;
.source "MHPLog.java"


# static fields
.field public static mIsLoging:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "TAG"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->isLogging()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public static e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "TAG"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->isLogging()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method private static isLogging()Z
    .locals 1

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public static setLogging(Z)V
    .locals 0
    .param p0, "log"    # Z

    .prologue
    sput-boolean p0, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->mIsLoging:Z

    return-void
.end method

.method public static w(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "TAG"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->isLogging()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method
