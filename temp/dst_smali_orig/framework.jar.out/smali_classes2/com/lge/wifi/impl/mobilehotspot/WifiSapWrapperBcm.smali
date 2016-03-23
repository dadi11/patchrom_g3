.class public Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;
.super Ljava/lang/Object;
.source "WifiSapWrapperBcm.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;
    }
.end annotation


# static fields
.field private static final LOCAL_LOGD:Z = true

.field private static final TAG:Ljava/lang/String; = "WifiSapWrapperBcm"


# instance fields
.field private mAuthenticationMode:I

.field private final mBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private final mContext:Landroid/content/Context;

.field private mIsSetAuthenticationCalled:Z

.field private final mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

.field private final mWifiConfig:Landroid/net/wifi/WifiConfiguration;

.field private final mWifiManager:Landroid/net/wifi/WifiManager;

.field private mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

.field private final mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "mhpNotiReceiver"    # Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;-><init>(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    iput-boolean v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getInstance()Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    new-instance v0, Landroid/net/wifi/WifiManagerProxy;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/net/wifi/WifiManagerProxy;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    new-instance v0, Landroid/net/wifi/WifiConfiguration;

    invoke-direct {v0}, Landroid/net/wifi/WifiConfiguration;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    const-string v1, "AndroidAP"

    invoke-direct {p0, v1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v0, v2}, Ljava/util/BitSet;->set(I)V

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->registerBroadcastReceiver()V

    return-void
.end method

.method static synthetic access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    return-object v0
.end method

.method private convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private convertToWifiCfgWepKey(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .local v0, "length":I
    const/16 v1, 0xa

    if-eq v0, v1, :cond_0

    const/16 v1, 0x1a

    if-ne v0, v1, :cond_1

    :cond_0
    const-string v1, "[0-9A-Fa-f]*"

    invoke-virtual {p1, v1}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .end local p1    # "wepKey":Ljava/lang/String;
    :goto_0
    return-object p1

    .restart local p1    # "wepKey":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x5

    if-eq v0, v1, :cond_2

    const/16 v1, 0xd

    if-ne v0, v1, :cond_3

    :cond_2
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_3
    const/4 p1, 0x0

    goto :goto_0
.end method

.method private registerBroadcastReceiver()V
    .locals 3

    .prologue
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.wifi.sap.ENABLED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.wifi.sap.DISABLED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.wifi.sap.WIFI_SAP_STATION_ASSOC"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.wifi.sap.WIFI_SAP_STATION_DISASSOC"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method private setWifiCfgHidden(Z)V
    .locals 1
    .param p1, "bHidden"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-boolean p1, v0, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    return-void
.end method

.method private setWifiCfgSecurity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z
    .locals 4
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .param p2, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .param p3, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v1}, Ljava/util/BitSet;->clear()V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v0    # "i":I
    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object v2, v1, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v1, p2, :cond_2

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v1, v3}, Ljava/util/BitSet;->set(I)V

    :cond_1
    :goto_1
    return v3

    :cond_2
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v1, p2, :cond_3

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->set(I)V

    goto :goto_1

    :cond_3
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-eq v1, p2, :cond_1

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v1, p2, :cond_1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->set(I)V

    goto :goto_1
.end method

.method private setWifiCfgSsid(Ljava/lang/String;)V
    .locals 1
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    return-void
.end method

.method private setWifiCfgWepKey(ILjava/lang/String;)Z
    .locals 2
    .param p1, "index"    # I
    .param p2, "wepKey"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p2}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->convertToWifiCfgWepKey(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "convertedWepKey":Ljava/lang/String;
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    aput-object v0, v1, p1

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private setWifiCfgWepKeyIndex(I)V
    .locals 1
    .param p1, "index"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput p1, v0, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    return-void
.end method

.method private setWifiCfgWpaKey(Ljava/lang/String;)V
    .locals 1
    .param p1, "wpaKey"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    return-void
.end method

.method private unregisterBroadcastReceiver()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method


# virtual methods
.method public closeSoftAP()I
    .locals 2

    .prologue
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "closeSoftAP : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public createSoftAP()I
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v4, 0x1

    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "createSoftAP"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v2, :cond_1

    :try_start_0
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "mWifiManagerProxy is not null calling mWifiManager"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "WifiSapWrapperBcm"

    const-string v2, "error in setWifiVZWApEnabled : "

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const/4 v1, -0x1

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z

    move-result v2

    if-ne v4, v2, :cond_0

    goto :goto_0
.end method

.method public destroySoftAP()I
    .locals 5

    .prologue
    const/4 v1, 0x0

    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "destroySoftAP"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v2, :cond_2

    :try_start_0
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "mWifiManagerProxy is not null calling setWifiVZWApEnabled"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z

    :cond_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/net/wifi/WifiManager;->setWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "WifiSapWrapperBcm"

    const-string v2, "error in setWifiVZWApEnabled : "

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    const/4 v1, -0x1

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_1

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v3, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z

    move-result v3

    if-ne v2, v3, :cond_1

    goto :goto_0
.end method

.method protected finalize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->unregisterBroadcastReceiver()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    return-void

    :catchall_0
    move-exception v0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v0
.end method

.method public isEnabledSoftAp()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSoftApStatus()Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public loadP2PDriver()I
    .locals 2

    .prologue
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "loadP2PDriver : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public openSoftAP()I
    .locals 2

    .prologue
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "openSoftAP : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public p2pAddMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->addMacFilterAllowList(Ljava/lang/String;I)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pAddMacFilterDenyList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->addMacFilterDenyList(Ljava/lang/String;I)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pDeAuthMac(Ljava/lang/String;)I
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setDisassociateStation(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetAllAssocMac()[Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAllAssocMacList()[Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetAllAssocMacVZW()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/net/wifi/ScanResult;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAllAssocMacListVZW()Ljava/util/List;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetAllow11B()I
    .locals 5

    .prologue
    const/4 v1, 0x0

    .local v1, "opModeP":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;

    move-result-object v1

    :cond_0
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->getOpMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    move-result-object v0

    .local v0, "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    const-string v2, "WifiSapWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetAllow11B not supported ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :goto_0
    const/4 v2, -0x1

    :goto_1
    return v2

    .restart local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :pswitch_0
    const/4 v2, 0x0

    goto :goto_1

    :pswitch_1
    const/4 v2, 0x1

    goto :goto_1

    :pswitch_2
    const/4 v2, 0x2

    goto :goto_1

    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :cond_1
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "p2pGetAllow11B opModeP is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public p2pGetAssocListCount()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAssoStaMacListCount()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetAuthentication()I
    .locals 8

    .prologue
    const/4 v4, -0x1

    const/4 v3, 0x0

    .local v3, "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v5, :cond_0

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    move-result-object v3

    :cond_0
    if-nez v3, :cond_1

    :goto_0
    return v4

    :cond_1
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v5, v0, :cond_7

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_2

    const/4 v4, 0x4

    goto :goto_0

    :cond_2
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_3

    const/16 v4, 0x80

    goto :goto_0

    :cond_3
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_4

    const/4 v4, 0x3

    goto :goto_0

    :cond_4
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-eq v5, v2, :cond_5

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_6

    :cond_5
    const/4 v4, 0x1

    goto :goto_0

    :cond_6
    const-string v5, "WifiSapWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pGetAuthentication : unkown sec mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_7
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v5, v0, :cond_8

    const/4 v4, 0x2

    goto :goto_0

    :cond_8
    const-string v5, "WifiSapWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pGetAuthentication : unkown auth mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public p2pGetCountryCode()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    const/4 v0, 0x0

    .local v0, "countryCode":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getCountryCode()Ljava/lang/String;

    move-result-object v0

    :cond_0
    if-nez v0, :cond_2

    :cond_1
    :goto_0
    return v1

    :cond_2
    const-string v2, "US"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    const/4 v1, 0x0

    goto :goto_0

    :cond_3
    const-string v2, "FR"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v1, 0x1

    goto :goto_0
.end method

.method public p2pGetEncryption()I
    .locals 8

    .prologue
    const/4 v4, -0x1

    const/4 v3, 0x0

    .local v3, "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v5, :cond_0

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    move-result-object v3

    :cond_0
    if-nez v3, :cond_1

    :goto_0
    return v4

    :cond_1
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_2

    const/4 v4, 0x0

    goto :goto_0

    :cond_2
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_3

    const/4 v4, 0x3

    goto :goto_0

    :cond_3
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, v1, :cond_4

    const/4 v4, 0x2

    goto :goto_0

    :cond_4
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, v1, :cond_5

    const/4 v4, 0x4

    goto :goto_0

    :cond_5
    const-string v5, "WifiSapWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pGetEncryption : unkown enc mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public p2pGetHideSSID()I
    .locals 3

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .local v0, "hiddenSsid":Z
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getHiddenSsid()Z

    move-result v0

    :cond_0
    if-ne v1, v0, :cond_1

    :goto_0
    return v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public p2pGetMacFilterByIndex(I)Ljava/lang/String;
    .locals 1
    .param p1, "iIndex"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterByIndex(I)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetMacFilterCount()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterCount()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetMacFilterMode()I
    .locals 5

    .prologue
    const/4 v1, 0x0

    .local v1, "macFilterModeP":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    move-result-object v1

    :cond_0
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;->getFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v0

    .local v0, "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    const-string v2, "WifiSapWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetMacFilterMode not supported ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :goto_0
    const/4 v2, -0x1

    :goto_1
    return v2

    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_0
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->p2pGetMacFilterCount()I

    move-result v2

    if-nez v2, :cond_1

    const/4 v2, 0x0

    goto :goto_1

    :cond_1
    const/4 v2, 0x1

    goto :goto_1

    :pswitch_1
    const/4 v2, 0x2

    goto :goto_1

    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :cond_2
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "p2pGetMacFilterMode macFilterModeP is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public p2pGetMaxClients()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMaxNumOfClients()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetSSID()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSsid()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetSocialChannel()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getChannel()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetSoftapIsolation()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getPrivacySeparator()Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPIndex()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKeyIndex()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetWEPKey1()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey1()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey2()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey2()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey3()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey3()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey4()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey4()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWPAKey()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWpaKey()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetAllow11B(I)I
    .locals 5
    .param p1, "iCommand"    # I

    .prologue
    const/4 v1, -0x1

    packed-switch p1, :pswitch_data_0

    const-string v2, "WifiSapWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pSetAllow11B unknown param ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v1

    :pswitch_0
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_b:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .local v0, "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :goto_1
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    new-instance v4, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;

    invoke-direct {v4, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;)V

    invoke-virtual {v3, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setOperationMode(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;)Z

    move-result v3

    if-ne v2, v3, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :pswitch_1
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_g_only:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .restart local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    goto :goto_1

    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :pswitch_2
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_bgn:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .restart local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public p2pSetAuthentication(I)I
    .locals 3
    .param p1, "iCommand"    # I

    .prologue
    const/4 v1, 0x1

    if-eq v1, p1, :cond_0

    const/4 v0, 0x2

    if-eq v0, p1, :cond_0

    const/4 v0, 0x3

    if-eq v0, p1, :cond_0

    const/4 v0, 0x4

    if-eq v0, p1, :cond_0

    const/16 v0, 0x80

    if-ne v0, p1, :cond_1

    :cond_0
    iput-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    iput p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const-string v0, "WifiSapWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetAuthentication unknown auth mode ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetCountryCode(I)I
    .locals 4
    .param p1, "iCommand"    # I

    .prologue
    const/4 v3, 0x1

    const/4 v1, -0x1

    if-nez p1, :cond_1

    const-string v0, "US"

    .local v0, "countryCode":Ljava/lang/String;
    :goto_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setCountryCode(Ljava/lang/String;)Z

    move-result v2

    if-ne v3, v2, :cond_0

    const/4 v1, 0x0

    .end local v0    # "countryCode":Ljava/lang/String;
    :cond_0
    return v1

    :cond_1
    if-ne v3, p1, :cond_0

    const-string v0, "FR"

    .restart local v0    # "countryCode":Ljava/lang/String;
    goto :goto_0
.end method

.method public p2pSetEncryption(I)I
    .locals 9
    .param p1, "iCommand"    # I

    .prologue
    const/16 v8, 0x80

    const/4 v6, 0x4

    const/4 v4, 0x0

    const/4 v7, 0x1

    const/4 v3, -0x1

    iget-boolean v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    if-nez v5, :cond_1

    const-string v4, "WifiSapWrapperBcm"

    const-string v5, "p2pSetEncryption : call p2pSetAuthentication() first"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v3

    :cond_1
    iput-boolean v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const-string v4, "WifiSapWrapperBcm"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "p2pSetEncryption : unkown enc mode ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_1
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v7, v5, :cond_3

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    :goto_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v5, :cond_2

    invoke-direct {p0, v0, v2, v1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgSecurity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z

    :cond_2
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v5, :cond_0

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    new-instance v6, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    invoke-direct {v6, v0, v2, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    invoke-virtual {v5, v6}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;)Z

    move-result v5

    if-ne v7, v5, :cond_0

    move v3, v4

    goto :goto_0

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_3
    const-string v4, "WifiSapWrapperBcm"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] [ALGO_OFF]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_2
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v8, v5, :cond_4

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_4
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v6, v5, :cond_5

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_5
    const-string v4, "WifiSapWrapperBcm"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] [ALGO_TKIP]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :pswitch_3
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v7, v5, :cond_6

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_6
    const/4 v5, 0x2

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v5, v6, :cond_7

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_7
    const-string v4, "WifiSapWrapperBcm"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] [ALGO_WEP128]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :pswitch_4
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v8, v5, :cond_8

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_8
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v6, v5, :cond_9

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_9
    const/4 v5, 0x3

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v5, v6, :cond_a

    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP_CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_a
    const-string v4, "WifiSapWrapperBcm"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] [ALGO_AES]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method public p2pSetHideSSID(I)I
    .locals 3
    .param p1, "iCommand"    # I

    .prologue
    const/4 v2, 0x1

    if-ne v2, p1, :cond_1

    const/4 v0, 0x1

    .local v0, "hiddenSsid":Z
    :goto_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v1, :cond_0

    invoke-direct {p0, v0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgHidden(Z)V

    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setHiddenSsid(Z)Z

    move-result v1

    if-ne v2, v1, :cond_2

    const/4 v1, 0x0

    :goto_1
    return v1

    .end local v0    # "hiddenSsid":Z
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "hiddenSsid":Z
    goto :goto_0

    :cond_2
    const/4 v1, -0x1

    goto :goto_1
.end method

.method public p2pSetMacFilterByIndex(ILjava/lang/String;)I
    .locals 2
    .param p1, "iIndex"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterByIndex(ILjava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetMacFilterCount(I)I
    .locals 2
    .param p1, "iCount"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterCount(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetMacFilterMode(I)I
    .locals 6
    .param p1, "iMode"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v1, -0x1

    packed-switch p1, :pswitch_data_0

    const-string v2, "WifiSapWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pSetMacFilterMode unknown param ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v1

    :pswitch_0
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .local v0, "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    invoke-virtual {p0, v2}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->p2pSetMacFilterCount(I)I

    :goto_1
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v3, :cond_0

    const/4 v3, 0x1

    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    new-instance v5, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    invoke-direct {v5, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)V

    invoke-virtual {v4, v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;)Z

    move-result v4

    if-ne v3, v4, :cond_0

    move v1, v2

    goto :goto_0

    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_1
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    goto :goto_1

    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_2
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->DENY_UNLESS_IN_ACCEPT_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public p2pSetMaxAssoc(I)I
    .locals 2
    .param p1, "max_assoc_num"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMaxNumOfClients(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetMaxClients(I)Z
    .locals 1
    .param p1, "num"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMaxNumOfClients(I)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetSSID(Ljava/lang/String;)I
    .locals 2
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgSsid(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setSsid(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetSocialChannel(I)I
    .locals 2
    .param p1, "iCommand"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setChannel(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetSoftapIsolation(Z)Z
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setPrivacySeparator(Z)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetWEPIndex(I)I
    .locals 2
    .param p1, "iCommand"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKeyIndex(I)V

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKeyIndex(I)Z

    move-result v1

    if-ne v0, v1, :cond_1

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey1(Ljava/lang/String;)I
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v1, :cond_0

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey1(Ljava/lang/String;)Z

    move-result v2

    if-ne v1, v2, :cond_1

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey2(Ljava/lang/String;)I
    .locals 2
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    invoke-direct {p0, v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey2(Ljava/lang/String;)Z

    move-result v0

    if-ne v1, v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey3(Ljava/lang/String;)I
    .locals 2
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey3(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey4(Ljava/lang/String;)I
    .locals 2
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x3

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey4(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWPAKey(Ljava/lang/String;)I
    .locals 2
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWpaKey(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWpaKey(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public unloadP2PDriver()I
    .locals 2

    .prologue
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "unloadP2PDriver : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method
