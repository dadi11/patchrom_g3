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

    .line 137
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    .line 55
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;-><init>(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    .line 138
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    .line 140
    iput-object p2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    .line 141
    iput-boolean v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    .line 142
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getInstance()Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    .line 143
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    const-string/jumbo v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 144
    new-instance v0, Landroid/net/wifi/WifiManagerProxy;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/net/wifi/WifiManagerProxy;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    .line 146
    new-instance v0, Landroid/net/wifi/WifiConfiguration;

    invoke-direct {v0}, Landroid/net/wifi/WifiConfiguration;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    .line 147
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    const-string v1, "AndroidAP"

    invoke-direct {p0, v1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 148
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v0, v2}, Ljava/util/BitSet;->set(I)V

    .line 150
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->registerBroadcastReceiver()V

    .line 151
    return-void
.end method

.method static synthetic access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    return-object v0
.end method

.method private convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 162
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
    .line 166
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 168
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

    .line 175
    .end local p1    # "wepKey":Ljava/lang/String;
    :goto_0
    return-object p1

    .line 172
    .restart local p1    # "wepKey":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x5

    if-eq v0, v1, :cond_2

    const/16 v1, 0xd

    if-ne v0, v1, :cond_3

    .line 173
    :cond_2
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 175
    :cond_3
    const/4 p1, 0x0

    goto :goto_0
.end method

.method private registerBroadcastReceiver()V
    .locals 3

    .prologue
    .line 1024
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 1026
    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.wifi.sap.ENABLED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1027
    const-string v1, "com.lge.wifi.sap.DISABLED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1028
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_STATION_ASSOC"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1029
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_STATION_DISASSOC"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1030
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1032
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 1034
    return-void
.end method

.method private setWifiCfgHidden(Z)V
    .locals 1
    .param p1, "bHidden"    # Z

    .prologue
    .line 1038
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-boolean p1, v0, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    .line 1039
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

    .line 1044
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v1}, Ljava/util/BitSet;->clear()V

    .line 1045
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 1046
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    .line 1047
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    aput-object v2, v1, v0

    .line 1046
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1050
    .end local v0    # "i":I
    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object v2, v1, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    .line 1052
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v1, p2, :cond_2

    .line 1053
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v1, v3}, Ljava/util/BitSet;->set(I)V

    .line 1068
    :cond_1
    :goto_1
    return v3

    .line 1054
    :cond_2
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v1, p2, :cond_3

    .line 1055
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->set(I)V

    goto :goto_1

    .line 1056
    :cond_3
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-eq v1, p2, :cond_1

    .line 1057
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v1, p2, :cond_1

    .line 1063
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
    .line 1072
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 1073
    return-void
.end method

.method private setWifiCfgWepKey(ILjava/lang/String;)Z
    .locals 2
    .param p1, "index"    # I
    .param p2, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 1076
    invoke-direct {p0, p2}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->convertToWifiCfgWepKey(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1077
    .local v0, "convertedWepKey":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 1078
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    aput-object v0, v1, p1

    .line 1082
    const/4 v1, 0x1

    :goto_0
    return v1

    .line 1080
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private setWifiCfgWepKeyIndex(I)V
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 1086
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput p1, v0, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    .line 1087
    return-void
.end method

.method private setWifiCfgWpaKey(Ljava/lang/String;)V
    .locals 1
    .param p1, "wpaKey"    # Ljava/lang/String;

    .prologue
    .line 1090
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    .line 1091
    return-void
.end method

.method private unregisterBroadcastReceiver()V
    .locals 2

    .prologue
    .line 1102
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 1103
    return-void
.end method


# virtual methods
.method public closeSoftAP()I
    .locals 2

    .prologue
    .line 155
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "closeSoftAP : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 158
    const/4 v0, 0x0

    return v0
.end method

.method public createSoftAP()I
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v4, 0x1

    .line 180
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "createSoftAP"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 183
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v2, :cond_1

    .line 185
    :try_start_0
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "mWifiManagerProxy is not null calling mWifiManager"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 186
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiConfig:Landroid/net/wifi/WifiConfiguration;

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 197
    :goto_0
    return v1

    .line 189
    :catch_0
    move-exception v0

    .line 190
    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "WifiSapWrapperBcm"

    const-string v2, "error in setWifiVZWApEnabled : "

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 197
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const/4 v1, -0x1

    goto :goto_0

    .line 193
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

    .line 202
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "destroySoftAP"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 205
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v2, :cond_2

    .line 207
    :try_start_0
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "mWifiManagerProxy is not null calling setWifiVZWApEnabled"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 208
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z

    .line 209
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    .line 210
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z

    .line 212
    :cond_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/net/wifi/WifiManager;->setWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 222
    :goto_0
    return v1

    .line 214
    :catch_0
    move-exception v0

    .line 215
    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "WifiSapWrapperBcm"

    const-string v2, "error in setWifiVZWApEnabled : "

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 222
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    const/4 v1, -0x1

    goto :goto_0

    .line 218
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
    .line 229
    :try_start_0
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->unregisterBroadcastReceiver()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 231
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 233
    return-void

    .line 231
    :catchall_0
    move-exception v0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v0
.end method

.method public isEnabledSoftAp()Z
    .locals 1

    .prologue
    .line 236
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 237
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSoftApStatus()Z

    move-result v0

    .line 239
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public loadP2PDriver()I
    .locals 2

    .prologue
    .line 250
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "loadP2PDriver : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 253
    const/4 v0, 0x0

    return v0
.end method

.method public openSoftAP()I
    .locals 2

    .prologue
    .line 258
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "openSoftAP : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 261
    const/4 v0, 0x0

    return v0
.end method

.method public p2pAddMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    .line 265
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 266
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->addMacFilterAllowList(Ljava/lang/String;I)Z

    move-result v0

    .line 268
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
    .line 272
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 273
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->addMacFilterDenyList(Ljava/lang/String;I)Z

    move-result v0

    .line 275
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
    .line 279
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setDisassociateStation(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 281
    const/4 v0, 0x0

    .line 284
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetAllAssocMac()[Ljava/lang/String;
    .locals 1

    .prologue
    .line 288
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 289
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAllAssocMacList()[Ljava/lang/String;

    move-result-object v0

    .line 291
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
    .line 295
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 296
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAllAssocMacListVZW()Ljava/util/List;

    move-result-object v0

    .line 298
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetAllow11B()I
    .locals 5

    .prologue
    .line 303
    const/4 v1, 0x0

    .line 305
    .local v1, "opModeP":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    .line 306
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;

    move-result-object v1

    .line 309
    :cond_0
    if-eqz v1, :cond_1

    .line 310
    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->getOpMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    move-result-object v0

    .line 311
    .local v0, "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 328
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

    .line 335
    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :goto_0
    const/4 v2, -0x1

    :goto_1
    return v2

    .line 316
    .restart local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :pswitch_0
    const/4 v2, 0x0

    goto :goto_1

    .line 321
    :pswitch_1
    const/4 v2, 0x1

    goto :goto_1

    .line 326
    :pswitch_2
    const/4 v2, 0x2

    goto :goto_1

    .line 332
    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :cond_1
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "p2pGetAllow11B opModeP is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 311
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
    .line 339
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 340
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAssoStaMacListCount()I

    move-result v0

    .line 342
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

    .line 346
    const/4 v3, 0x0

    .line 348
    .local v3, "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v5, :cond_0

    .line 349
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    move-result-object v3

    .line 352
    :cond_0
    if-nez v3, :cond_1

    .line 403
    :goto_0
    return v4

    .line 356
    :cond_1
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .line 357
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .line 358
    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .line 360
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v5, v0, :cond_7

    .line 361
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_2

    .line 365
    const/4 v4, 0x4

    goto :goto_0

    .line 367
    :cond_2
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_3

    .line 371
    const/16 v4, 0x80

    goto :goto_0

    .line 375
    :cond_3
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_4

    .line 379
    const/4 v4, 0x3

    goto :goto_0

    .line 383
    :cond_4
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-eq v5, v2, :cond_5

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_6

    .line 388
    :cond_5
    const/4 v4, 0x1

    goto :goto_0

    .line 391
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

    .line 393
    :cond_7
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v5, v0, :cond_8

    .line 397
    const/4 v4, 0x2

    goto :goto_0

    .line 400
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

    .line 407
    const/4 v0, 0x0

    .line 409
    .local v0, "countryCode":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    .line 410
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getCountryCode()Ljava/lang/String;

    move-result-object v0

    .line 413
    :cond_0
    if-nez v0, :cond_2

    .line 424
    :cond_1
    :goto_0
    return v1

    .line 417
    :cond_2
    const-string v2, "US"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 418
    const/4 v1, 0x0

    goto :goto_0

    .line 420
    :cond_3
    const-string v2, "FR"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 421
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public p2pGetEncryption()I
    .locals 8

    .prologue
    const/4 v4, -0x1

    .line 432
    const/4 v3, 0x0

    .line 434
    .local v3, "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v5, :cond_0

    .line 435
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    move-result-object v3

    .line 438
    :cond_0
    if-nez v3, :cond_1

    .line 476
    :goto_0
    return v4

    .line 442
    :cond_1
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .line 443
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .line 444
    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .line 446
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_2

    .line 450
    const/4 v4, 0x0

    goto :goto_0

    .line 452
    :cond_2
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, v2, :cond_3

    .line 456
    const/4 v4, 0x3

    goto :goto_0

    .line 459
    :cond_3
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, v1, :cond_4

    .line 463
    const/4 v4, 0x2

    goto :goto_0

    .line 465
    :cond_4
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, v1, :cond_5

    .line 469
    const/4 v4, 0x4

    goto :goto_0

    .line 472
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

    .line 480
    const/4 v0, 0x0

    .line 482
    .local v0, "hiddenSsid":Z
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    .line 483
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getHiddenSsid()Z

    move-result v0

    .line 486
    :cond_0
    if-ne v1, v0, :cond_1

    .line 490
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
    .line 494
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 495
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterByIndex(I)Ljava/lang/String;

    move-result-object v0

    .line 497
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetMacFilterCount()I
    .locals 1

    .prologue
    .line 501
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 502
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterCount()I

    move-result v0

    .line 504
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetMacFilterMode()I
    .locals 5

    .prologue
    .line 508
    const/4 v1, 0x0

    .line 510
    .local v1, "macFilterModeP":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    .line 511
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    move-result-object v1

    .line 514
    :cond_0
    if-eqz v1, :cond_2

    .line 515
    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;->getFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v0

    .line 516
    .local v0, "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 534
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

    .line 541
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :goto_0
    const/4 v2, -0x1

    :goto_1
    return v2

    .line 521
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_0
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->p2pGetMacFilterCount()I

    move-result v2

    if-nez v2, :cond_1

    .line 522
    const/4 v2, 0x0

    goto :goto_1

    .line 527
    :cond_1
    const/4 v2, 0x1

    goto :goto_1

    .line 532
    :pswitch_1
    const/4 v2, 0x2

    goto :goto_1

    .line 538
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :cond_2
    const-string v2, "WifiSapWrapperBcm"

    const-string v3, "p2pGetMacFilterMode macFilterModeP is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 516
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public p2pGetMaxClients()I
    .locals 1

    .prologue
    .line 545
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 546
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMaxNumOfClients()I

    move-result v0

    .line 548
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetSSID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 566
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 567
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSsid()Ljava/lang/String;

    move-result-object v0

    .line 569
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetSocialChannel()I
    .locals 1

    .prologue
    .line 552
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 553
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getChannel()I

    move-result v0

    .line 555
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetSoftapIsolation()Z
    .locals 1

    .prologue
    .line 559
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 560
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getPrivacySeparator()Z

    move-result v0

    .line 562
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPIndex()I
    .locals 1

    .prologue
    .line 573
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 574
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKeyIndex()I

    move-result v0

    .line 576
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetWEPKey1()Ljava/lang/String;
    .locals 1

    .prologue
    .line 580
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 581
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey1()Ljava/lang/String;

    move-result-object v0

    .line 583
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey2()Ljava/lang/String;
    .locals 1

    .prologue
    .line 587
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 588
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey2()Ljava/lang/String;

    move-result-object v0

    .line 590
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey3()Ljava/lang/String;
    .locals 1

    .prologue
    .line 594
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 595
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey3()Ljava/lang/String;

    move-result-object v0

    .line 597
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey4()Ljava/lang/String;
    .locals 1

    .prologue
    .line 601
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 602
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWepKey4()Ljava/lang/String;

    move-result-object v0

    .line 604
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWPAKey()Ljava/lang/String;
    .locals 1

    .prologue
    .line 609
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 610
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getWpaKey()Ljava/lang/String;

    move-result-object v0

    .line 612
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

    .line 621
    packed-switch p1, :pswitch_data_0

    .line 641
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

    .line 650
    :cond_0
    :goto_0
    return v1

    .line 626
    :pswitch_0
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_b:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .line 645
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

    .line 647
    const/4 v1, 0x0

    goto :goto_0

    .line 632
    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :pswitch_1
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_g_only:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .line 633
    .restart local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    goto :goto_1

    .line 638
    .end local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    :pswitch_2
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_bgn:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .line 639
    .restart local v0    # "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    goto :goto_1

    .line 621
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

    .line 659
    if-eq v1, p1, :cond_0

    const/4 v0, 0x2

    if-eq v0, p1, :cond_0

    const/4 v0, 0x3

    if-eq v0, p1, :cond_0

    const/4 v0, 0x4

    if-eq v0, p1, :cond_0

    const/16 v0, 0x80

    if-ne v0, p1, :cond_1

    .line 664
    :cond_0
    iput-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    .line 665
    iput p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    .line 666
    const/4 v0, 0x0

    .line 670
    :goto_0
    return v0

    .line 668
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

    .line 670
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetCountryCode(I)I
    .locals 4
    .param p1, "iCommand"    # I

    .prologue
    const/4 v3, 0x1

    const/4 v1, -0x1

    .line 679
    if-nez p1, :cond_1

    .line 680
    const-string v0, "US"

    .line 687
    .local v0, "countryCode":Ljava/lang/String;
    :goto_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setCountryCode(Ljava/lang/String;)Z

    move-result v2

    if-ne v3, v2, :cond_0

    .line 689
    const/4 v1, 0x0

    .line 691
    .end local v0    # "countryCode":Ljava/lang/String;
    :cond_0
    return v1

    .line 681
    :cond_1
    if-ne v3, p1, :cond_0

    .line 682
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

    .line 699
    iget-boolean v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    if-nez v5, :cond_1

    .line 700
    const-string v4, "WifiSapWrapperBcm"

    const-string v5, "p2pSetEncryption : call p2pSetAuthentication() first"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 822
    :cond_0
    :goto_0
    return v3

    .line 703
    :cond_1
    iput-boolean v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mIsSetAuthenticationCalled:Z

    .line 709
    packed-switch p1, :pswitch_data_0

    .line 808
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

    .line 717
    :pswitch_1
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v7, v5, :cond_3

    .line 718
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 719
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 720
    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 812
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    :goto_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v5, :cond_2

    .line 813
    invoke-direct {p0, v0, v2, v1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgSecurity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z

    .line 815
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

    .line 819
    goto :goto_0

    .line 722
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

    .line 734
    :pswitch_2
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v8, v5, :cond_4

    .line 735
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 736
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 737
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto :goto_1

    .line 741
    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_4
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v6, v5, :cond_5

    .line 742
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 743
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 744
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto :goto_1

    .line 746
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

    .line 758
    :pswitch_3
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v7, v5, :cond_6

    .line 759
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 760
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 761
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto :goto_1

    .line 765
    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_6
    const/4 v5, 0x2

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v5, v6, :cond_7

    .line 766
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 767
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 768
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .line 770
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

    .line 782
    :pswitch_4
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v8, v5, :cond_8

    .line 783
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 784
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 785
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .line 789
    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_8
    iget v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v6, v5, :cond_9

    .line 790
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 791
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 792
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .line 795
    .end local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .end local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .end local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    :cond_9
    const/4 v5, 0x3

    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mAuthenticationMode:I

    if-ne v5, v6, :cond_a

    .line 796
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 797
    .restart local v0    # "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 798
    .restart local v2    # "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP_CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .restart local v1    # "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    goto/16 :goto_1

    .line 802
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

    .line 709
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

    .line 831
    if-ne v2, p1, :cond_1

    .line 832
    const/4 v0, 0x1

    .line 837
    .local v0, "hiddenSsid":Z
    :goto_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v1, :cond_0

    .line 838
    invoke-direct {p0, v0}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgHidden(Z)V

    .line 840
    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setHiddenSsid(Z)Z

    move-result v1

    if-ne v2, v1, :cond_2

    .line 842
    const/4 v1, 0x0

    .line 845
    :goto_1
    return v1

    .line 834
    .end local v0    # "hiddenSsid":Z
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "hiddenSsid":Z
    goto :goto_0

    .line 845
    :cond_2
    const/4 v1, -0x1

    goto :goto_1
.end method

.method public p2pSetMacFilterByIndex(ILjava/lang/String;)I
    .locals 2
    .param p1, "iIndex"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    .line 849
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterByIndex(ILjava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 851
    const/4 v0, 0x0

    .line 854
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
    .line 858
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterCount(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 860
    const/4 v0, 0x0

    .line 863
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

    .line 874
    packed-switch p1, :pswitch_data_0

    .line 898
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

    .line 907
    :cond_0
    :goto_0
    return v1

    .line 879
    :pswitch_0
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 883
    .local v0, "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    invoke-virtual {p0, v2}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->p2pSetMacFilterCount(I)I

    .line 902
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

    .line 904
    goto :goto_0

    .line 889
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_1
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 890
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    goto :goto_1

    .line 895
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_2
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->DENY_UNLESS_IN_ACCEPT_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 896
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    goto :goto_1

    .line 874
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
    .line 911
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMaxNumOfClients(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 913
    const/4 v0, 0x0

    .line 915
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
    .line 919
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 920
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMaxNumOfClients(I)Z

    move-result v0

    .line 922
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
    .line 944
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 945
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgSsid(Ljava/lang/String;)V

    .line 947
    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setSsid(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    .line 949
    const/4 v0, 0x0

    .line 951
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
    .line 929
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setChannel(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 931
    const/4 v0, 0x0

    .line 933
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
    .line 937
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 938
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setPrivacySeparator(Z)Z

    move-result v0

    .line 940
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
    .line 958
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 959
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKeyIndex(I)V

    .line 961
    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKeyIndex(I)Z

    move-result v1

    if-ne v0, v1, :cond_1

    .line 963
    const/4 v0, 0x0

    .line 965
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

    .line 969
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v1, :cond_0

    .line 970
    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 972
    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey1(Ljava/lang/String;)Z

    move-result v2

    if-ne v1, v2, :cond_1

    .line 976
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

    .line 980
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 981
    invoke-direct {p0, v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 983
    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey2(Ljava/lang/String;)Z

    move-result v0

    if-ne v1, v0, :cond_1

    .line 985
    const/4 v0, 0x0

    .line 987
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
    .line 991
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 992
    const/4 v0, 0x2

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 994
    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey3(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    .line 996
    const/4 v0, 0x0

    .line 998
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
    .line 1002
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 1003
    const/4 v0, 0x3

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 1005
    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWepKey4(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    .line 1007
    const/4 v0, 0x0

    .line 1009
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
    .line 1013
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 1014
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->setWifiCfgWpaKey(Ljava/lang/String;)V

    .line 1016
    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setWpaKey(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    .line 1018
    const/4 v0, 0x0

    .line 1020
    :goto_0
    return v0

    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public unloadP2PDriver()I
    .locals 2

    .prologue
    .line 1095
    const-string v0, "WifiSapWrapperBcm"

    const-string v1, "unloadP2PDriver : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1098
    const/4 v0, 0x0

    return v0
.end method
