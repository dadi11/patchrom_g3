.class public Lcom/lge/wifi/impl/offloading/WifiOffLoading;
.super Ljava/lang/Object;
.source "WifiOffLoading.java"

# interfaces
.implements Lcom/lge/wifi/extension/IWifiOffLoading;


# static fields
.field private static final TAG:Ljava/lang/String; = "WifiOffLoading"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public disableBackgroundOffloading()V
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on disableBackgroundOffloading()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->disableBackgroundOffloading()V

    goto :goto_0
.end method

.method public disableWifioffloadTimerReminder()V
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on disableWifioffloadTimerReminder()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->disableWifioffloadTimerReminder()V

    goto :goto_0
.end method

.method public getWifiOffloadingStart()I
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on getWifiOffloadingStart()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getWifiOffloadingStart()I

    move-result v0

    goto :goto_0
.end method

.method public isOffloadingAvailable(Landroid/content/Context;Landroid/content/Intent;)Z
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on isOffloadingAvailable()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->isOffloadingAvailable(Landroid/content/Context;Landroid/content/Intent;)Z

    move-result v0

    goto :goto_0
.end method

.method public isOffloadingReminder_on()I
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on isOffloadingReminder()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->isOffloadingReminder_on()I

    move-result v0

    goto :goto_0
.end method

.method public isOffloadingTimer_on()Z
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on isOffloadingTimer_on()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->isOffloadingTimer_on()Z

    move-result v0

    goto :goto_0
.end method

.method public isWifiOffloadingEnabled()I
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on isWifiOffloadingEnabled()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->isWifiOffloadingEnabled()I

    move-result v0

    goto :goto_0
.end method

.method public processingOffloading()V
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on processingOffloading()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->processingOffloading()V

    goto :goto_0
.end method

.method public resetWifioffloadTimerReminder(I)Z
    .locals 2
    .param p1, "check"    # I

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on resetWifioffloadTimerReminder()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->resetWifioffloadTimerReminder(I)Z

    move-result v0

    goto :goto_0
.end method

.method public setWifiOffloadOngoing(Z)V
    .locals 2
    .param p1, "OffloadOngoing"    # Z

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on setWifiOffloadOngoing()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->setWifiOffloadOngoing(Z)V

    goto :goto_0
.end method

.method public setWifiOffloadingStart(I)V
    .locals 2
    .param p1, "WiFiOffloadingStart"    # I

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on setWifiOffloadingStart()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->setWifiOffloadingStart(I)V

    goto :goto_0
.end method

.method public startService(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .local v1, "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    const-string v3, "WifiOffLoading"

    const-string v4, "startService"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    new-instance v2, Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;

    invoke-direct {v2, p1}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;-><init>(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    .local v2, "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    :try_start_1
    const-string v3, "wifiOffloadingService"

    invoke-static {v3, v2}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move-object v1, v2

    .end local v2    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    .restart local v1    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Throwable;
    :goto_1
    const-string v3, "WifiOffLoading"

    const-string v4, "Failure starting WiFi Offloading Service"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Throwable;
    .end local v1    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    .restart local v2    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    :catch_1
    move-exception v0

    move-object v1, v2

    .end local v2    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    .restart local v1    # "wifiOffloadingService":Lcom/lge/wifi/impl/offloading/WiFiOffloadingService;
    goto :goto_1
.end method

.method public stopWifioffloadTimer()V
    .locals 2

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "WifiOffLoading"

    const-string v1, "WiFiOffloadingManager.getInstance is null!! on stopWifioffloadTimer()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->getInstance()Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wifi/impl/offloading/WiFiOffloadingManager;->stopWifioffloadTimer()V

    goto :goto_0
.end method
