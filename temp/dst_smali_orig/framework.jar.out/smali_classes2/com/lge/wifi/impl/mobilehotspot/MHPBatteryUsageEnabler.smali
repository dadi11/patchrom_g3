.class public Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;
.super Ljava/lang/Object;
.source "MHPBatteryUsageEnabler.java"


# static fields
.field static final SHARED_PREFERENCES_KEY_BATTERY_USE_TIME:Ljava/lang/String; = "battery_use_time_stamp"


# instance fields
.field private final TAG:Ljava/lang/String;

.field private mEndTimestamp:J

.field private final mHandler:Landroid/os/Handler;

.field private mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

.field private final mUpdateBatteryUsageTimeRunnable:Ljava/lang/Runnable;

.field private mUsageTime:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "proxy"    # Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "MHPBatteryUsageEnabler"

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->TAG:Ljava/lang/String;

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler$1;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler$1;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUpdateBatteryUsageTimeRunnable:Ljava/lang/Runnable;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mHandler:Landroid/os/Handler;

    iput-object p2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    return-void
.end method

.method static synthetic access$000(Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->updateTimerCountdownSummary()V

    return-void
.end method

.method private registBatteryUseEndTimestamp(J)V
    .locals 1
    .param p1, "time"    # J

    .prologue
    iput-wide p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mEndTimestamp:J

    return-void
.end method

.method private updateTimerCountdownSummary()V
    .locals 6

    .prologue
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .local v0, "currentTimestamp":J
    iget-wide v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mEndTimestamp:J

    cmp-long v2, v0, v2

    if-lez v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUpdateBatteryUsageTimeRunnable:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-string v2, "MHPBatteryUsageEnabler"

    const-string v3, "[MHP_GOOKY] turning off mobilehotspot by power mode"

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->disableMobileHotspot()V

    :goto_0
    return-void

    :cond_0
    const-string v2, "MHPBatteryUsageEnabler"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[MHP_GOOKY] Current Time >> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", Turn Off time >> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-wide v4, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mEndTimestamp:J

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    monitor-enter p0

    :try_start_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUpdateBatteryUsageTimeRunnable:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUpdateBatteryUsageTimeRunnable:Ljava/lang/Runnable;

    const-wide/16 v4, 0x3e8

    invoke-virtual {v2, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method


# virtual methods
.method public setUsageTime(I)V
    .locals 8
    .param p1, "time"    # I

    .prologue
    int-to-long v2, p1

    iput-wide v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUsageTime:J

    iget-wide v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUsageTime:J

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUpdateBatteryUsageTimeRunnable:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->mUsageTime:J

    const-wide/16 v6, 0x3e8

    mul-long/2addr v4, v6

    const-wide/16 v6, 0x3c

    mul-long/2addr v4, v6

    add-long v0, v2, v4

    .local v0, "endTime":J
    const-string v2, "MHPBatteryUsageEnabler"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[MHP_GOOKY] Next Turn off time >> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->registBatteryUseEndTimestamp(J)V

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->updateTimerCountdownSummary()V

    goto :goto_0
.end method
