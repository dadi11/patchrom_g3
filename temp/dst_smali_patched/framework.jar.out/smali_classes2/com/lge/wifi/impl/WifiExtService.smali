.class public Lcom/lge/wifi/impl/WifiExtService;
.super Lcom/lge/wifi/impl/IWifiExtManager$Stub;
.source "WifiExtService.java"


# static fields
.field private static final DBG:Z = false

.field private static final TAG:Ljava/lang/String; = "WifiExtService"

.field private static mContext:Landroid/content/Context;

.field private static mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "wifiext_jni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/IWifiExtManager$Stub;-><init>()V

    sput-object p1, Lcom/lge/wifi/impl/WifiExtService;->mContext:Landroid/content/Context;

    invoke-static {}, Lcom/lge/wifi/impl/WifiServiceExtension;->getInstance()Lcom/lge/wifi/impl/WifiServiceExtension;

    move-result-object v0

    sput-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/WifiServiceExtension;->initWifiServiceExt(Landroid/content/Context;)V

    const-string v0, "WifiExtService"

    const-string v1, "startService"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public getCallingWifiUid()I
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, -0x1

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/WifiServiceExtension;->getCallingWifiUid()I

    move-result v0

    goto :goto_0
.end method

.method public getConnectionExtInfo()Lcom/lge/wifi/impl/WifiExtInfo;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/WifiServiceExtension;->getConnectionExtInfo()Lcom/lge/wifi/impl/WifiExtInfo;

    move-result-object v0

    goto :goto_0
.end method

.method public getMacAddress()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/WifiLgeExtNative;->getMacAddress()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getP2pState()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getSecurityType()I
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/WifiServiceExtension;->getSecurityType()I

    move-result v0

    goto :goto_0
.end method

.method public getSoftApMaxScb(I)I
    .locals 2
    .param p1, "defaultMaxScb"    # I

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, -0x1

    :goto_0
    return v0

    :cond_0
    const-string v0, "WifiExtService"

    const-string v1, "getSoftApMaxScb"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/WifiServiceExtension;->getSoftApMaxScb(I)I

    move-result v0

    goto :goto_0
.end method

.method public isInternetCheckAvailable()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/WifiServiceExtension;->isInternetCheckAvailable()Z

    move-result v0

    goto :goto_0
.end method

.method public isVZWMobileHotspotEnabled()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/WifiServiceExtension;->isVZWMobileHotspotEnabled()Z

    move-result v0

    goto :goto_0
.end method

.method public setCallingWifiUid(I)V
    .locals 1
    .param p1, "uid"    # I

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/WifiServiceExtension;->setCallingWifiUid(I)V

    goto :goto_0
.end method

.method public setDlnaUsing(Z)Z
    .locals 1
    .param p1, "bEnable"    # Z

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/WifiServiceExtension;->setDlnaUsing(Z)Z

    move-result v0

    goto :goto_0
.end method

.method public setProvisioned(Z)V
    .locals 1
    .param p1, "value"    # Z

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/WifiServiceExtension;->setProvisioned(Z)V

    goto :goto_0
.end method

.method public setVZWMobileHotspot(Z)Z
    .locals 1
    .param p1, "enable"    # Z

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/WifiExtService;->mWifiServiceExt:Lcom/lge/wifi/impl/WifiServiceExtension;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/WifiServiceExtension;->setVZWMobileHotspot(Z)Z

    move-result v0

    goto :goto_0
.end method
