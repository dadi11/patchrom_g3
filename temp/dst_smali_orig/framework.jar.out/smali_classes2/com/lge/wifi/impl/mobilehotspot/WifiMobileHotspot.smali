.class public Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;
.super Ljava/lang/Object;
.source "WifiMobileHotspot.java"

# interfaces
.implements Lcom/lge/wifi/extension/IWifiMobileHotspot;


# static fields
.field private static final TAG:Ljava/lang/String; = "WifiMobileHotspot"

.field private static mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

.field private static mWifiMHPIface:Lcom/lge/wifi/extension/IWifiMobileHotspot;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mWifiMHPIface:Lcom/lge/wifi/extension/IWifiMobileHotspot;

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public disableMobileHotspot()Z
    .locals 1

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getMobileHotspotServiceProxy()Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    move-result-object v0

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->disableMobileHotspot()V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public enableMobileHotspot(Z)Z
    .locals 1
    .param p1, "on"    # Z

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getMobileHotspotServiceProxy()Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    move-result-object v0

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->enableMobileHotspot(Z)Z

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getMobileHotspotServiceProxy()Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    move-result-object v0

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getName()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public isMHPEnabled()Z
    .locals 1

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getMobileHotspotServiceProxy()Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    move-result-object v0

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiMobileHotspot;->mMHPProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->isMHPEnabled()Z

    move-result v0

    goto :goto_0
.end method

.method public startService(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .local v1, "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    const-string v3, "WifiMobileHotspot"

    const-string v4, "startService"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    new-instance v2, Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    invoke-direct {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;-><init>(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .local v2, "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    :try_start_1
    const-string v3, "mobilehotspot"

    invoke-static {v3, v2}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    invoke-virtual {v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->init()Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move-object v1, v2

    .end local v2    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .restart local v1    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Throwable;
    :goto_1
    const-string v3, "WifiMobileHotspot"

    const-string v4, "Failure starting MHP Service"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Throwable;
    .end local v1    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .restart local v2    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    :catch_1
    move-exception v0

    move-object v1, v2

    .end local v2    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .restart local v1    # "mMHPService":Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    goto :goto_1
.end method
