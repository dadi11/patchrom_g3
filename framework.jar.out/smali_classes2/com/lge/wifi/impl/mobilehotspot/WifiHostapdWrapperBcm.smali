.class public Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;
.super Ljava/lang/Object;
.source "WifiHostapdWrapperBcm.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm$2;
    }
.end annotation


# static fields
.field private static final HOSTAPD_ACCEPT_MAC_FILE:Ljava/lang/String; = "/data/misc/wifi/hostapd.accept"

.field private static final HOSTAPD_DENY_MAC_FILE:Ljava/lang/String; = "/data/misc/wifi/hostapd.deny"

.field private static final LOCAL_LOGD:Z = true

.field private static final TAG:Ljava/lang/String; = "WifiHostapdWrapperBcm"


# instance fields
.field private mAuthenticationMode:I

.field private final mBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private final mContext:Landroid/content/Context;

.field private mIsSetAuthenticationCalled:Z

.field private final mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

.field private final mWifiManager:Landroid/net/wifi/WifiManager;

.field private mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

.field private final mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

.field private final mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "mhpNotiReceiver"    # Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    .prologue
    const/4 v3, 0x0

    .line 181
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    .line 70
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm$1;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm$1;-><init>(Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    .line 182
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    .line 184
    iput-object p2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    .line 185
    iput-boolean v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mIsSetAuthenticationCalled:Z

    .line 186
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getInstance()Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    .line 187
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    const-string/jumbo v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 188
    new-instance v0, Landroid/net/wifi/WifiConfiguration;

    invoke-direct {v0}, Landroid/net/wifi/WifiConfiguration;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    .line 189
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    const-string v1, "AndroidAP"

    invoke-direct {p0, v1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 190
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WifiHostapdWrapperBcm "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v2, v2, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 191
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v0, v3}, Ljava/util/BitSet;->set(I)V

    .line 192
    new-instance v0, Landroid/net/wifi/WifiManagerProxy;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/net/wifi/WifiManagerProxy;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    .line 195
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->registerBroadcastReceiver()V

    .line 196
    return-void
.end method

.method private SetEncryptionMode(Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)Z
    .locals 8
    .param p1, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .param p2, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .prologue
    .line 1338
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 1339
    .local v3, "encModeWpa":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 1341
    .local v2, "encModeRsn":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, p2, :cond_3

    .line 1342
    move-object v3, p1

    .line 1350
    :goto_0
    const/4 v4, 0x0

    .line 1351
    .local v4, "pairwise":Ljava/lang/String;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, p1, :cond_5

    .line 1352
    const-string v4, "NO_ENCRYPTION"

    .line 1360
    :goto_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "mhs_encryption"

    invoke-static {v5, v6, v4}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1362
    if-eqz v4, :cond_2

    .line 1363
    const/4 v0, 0x0

    .line 1364
    .local v0, "enc1":Ljava/lang/String;
    const/4 v1, 0x0

    .line 1365
    .local v1, "enc2":Ljava/lang/String;
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-eq v5, v3, :cond_0

    .line 1366
    const-string v0, "WPA"

    .line 1367
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "mhs_protocol"

    const-string v7, "WPA"

    invoke-static {v5, v6, v7}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1370
    :cond_0
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-eq v5, v2, :cond_1

    .line 1371
    const-string v1, "RSN"

    .line 1372
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "mhs_protocol"

    const-string v7, "RSN"

    invoke-static {v5, v6, v7}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1375
    :cond_1
    if-eqz v0, :cond_2

    if-eqz v1, :cond_2

    .line 1376
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "mhs_protocol"

    const-string v7, "WPA RSN"

    invoke-static {v5, v6, v7}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1382
    .end local v0    # "enc1":Ljava/lang/String;
    .end local v1    # "enc2":Ljava/lang/String;
    :cond_2
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "SetEncryptionMode:encModeWpa : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1383
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "SetEncryptionMode:encModeRsn : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1384
    const/4 v5, 0x1

    return v5

    .line 1343
    .end local v4    # "pairwise":Ljava/lang/String;
    :cond_3
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v5, p2, :cond_4

    .line 1344
    move-object v2, p1

    goto/16 :goto_0

    .line 1346
    :cond_4
    move-object v3, p1

    .line 1347
    move-object v2, p1

    goto/16 :goto_0

    .line 1353
    .restart local v4    # "pairwise":Ljava/lang/String;
    :cond_5
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, p1, :cond_6

    .line 1354
    const-string v4, "TKIP"

    goto/16 :goto_1

    .line 1355
    :cond_6
    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v5, p1, :cond_7

    .line 1356
    const-string v4, "CCMP"

    goto/16 :goto_1

    .line 1358
    :cond_7
    const-string v4, "TKIP CCMP"

    goto/16 :goto_1
.end method

.method static synthetic access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    return-object v0
.end method

.method private convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 207
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
    .line 211
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 213
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

    .line 220
    .end local p1    # "wepKey":Ljava/lang/String;
    :goto_0
    return-object p1

    .line 217
    .restart local p1    # "wepKey":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x5

    if-eq v0, v1, :cond_2

    const/16 v1, 0xd

    if-ne v0, v1, :cond_3

    .line 218
    :cond_2
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->convertToQuotedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 220
    :cond_3
    const/4 p1, 0x0

    goto :goto_0
.end method

.method private registerBroadcastReceiver()V
    .locals 3

    .prologue
    .line 1322
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 1324
    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.wifi.sap.ENABLED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1325
    const-string v1, "com.lge.wifi.sap.DISABLED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1326
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_STATION_ASSOC"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1327
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_STATION_DISASSOC"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1328
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1329
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_HOSTAPD_CONNECTED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1330
    const-string v1, "com.lge.wifi.sap.WIFI_SAP_MAX_REACHED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1332
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 1334
    return-void
.end method

.method private setWifiCfgHidden(Z)V
    .locals 1
    .param p1, "bHidden"    # Z

    .prologue
    .line 1388
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-boolean p1, v0, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    .line 1389
    return-void
.end method

.method private setWifiCfgSecurity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z
    .locals 3
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .param p2, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .param p3, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .prologue
    .line 1396
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v0, p2, :cond_0

    .line 1397
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_security"

    const-string v2, "OPEN"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1409
    :goto_0
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WifiSapSecurityMode secMode : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1413
    const/4 v0, 0x1

    return v0

    .line 1398
    :cond_0
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v0, p2, :cond_1

    .line 1399
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_security"

    const-string v2, "WEP"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 1400
    :cond_1
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v0, p2, :cond_2

    .line 1401
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_security"

    const-string v2, "WPA_PSK"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 1402
    :cond_2
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v0, p2, :cond_3

    .line 1403
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_security"

    const-string v2, "WPA2_PSK"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 1405
    :cond_3
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_security"

    const-string v2, "WPA_WPA2_MIXED"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0
.end method

.method private setWifiCfgSsid(Ljava/lang/String;)V
    .locals 1
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    .line 1417
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 1418
    return-void
.end method

.method private setWifiCfgWepKey(ILjava/lang/String;)Z
    .locals 2
    .param p1, "index"    # I
    .param p2, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 1421
    invoke-direct {p0, p2}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->convertToWifiCfgWepKey(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1422
    .local v0, "convertedWepKey":Ljava/lang/String;
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v1, v1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    aput-object v0, v1, p1

    .line 1423
    const/4 v1, 0x1

    return v1
.end method

.method private setWifiCfgWepKeyIndex(I)V
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 1427
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput p1, v0, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    .line 1428
    return-void
.end method

.method private setWifiCfgWpaKey(Ljava/lang/String;)V
    .locals 1
    .param p1, "wpaKey"    # Ljava/lang/String;

    .prologue
    .line 1431
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    .line 1432
    return-void
.end method

.method private unregisterBroadcastReceiver()V
    .locals 2

    .prologue
    .line 1443
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 1444
    return-void
.end method


# virtual methods
.method public WifiSapAutModeCovertToVZWConfig(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;)I
    .locals 2
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .prologue
    const/4 v0, 0x0

    .line 1449
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne p1, v1, :cond_1

    .line 1459
    :cond_0
    :goto_0
    return v0

    .line 1452
    :cond_1
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne p1, v1, :cond_2

    .line 1453
    const/4 v0, 0x1

    goto :goto_0

    .line 1455
    :cond_2
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->MIXED_MODE_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne p1, v1, :cond_0

    .line 1456
    const/4 v0, 0x2

    goto :goto_0
.end method

.method public WifiSapEncryptionModeCovertToVZWConfig(Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)I
    .locals 2
    .param p1, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .prologue
    const/4 v0, 0x0

    .line 1465
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne p1, v1, :cond_1

    .line 1478
    :cond_0
    :goto_0
    return v0

    .line 1468
    :cond_1
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne p1, v1, :cond_2

    .line 1469
    const/4 v0, 0x1

    goto :goto_0

    .line 1471
    :cond_2
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne p1, v1, :cond_3

    .line 1472
    const/4 v0, 0x2

    goto :goto_0

    .line 1474
    :cond_3
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP_CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne p1, v1, :cond_0

    .line 1475
    const/4 v0, 0x3

    goto :goto_0
.end method

.method public WifiSapSecurityModeCovertToVZWConfig(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)I
    .locals 2
    .param p1, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .prologue
    const/4 v0, 0x0

    .line 1484
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne p1, v1, :cond_1

    .line 1500
    :cond_0
    :goto_0
    return v0

    .line 1487
    :cond_1
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne p1, v1, :cond_2

    .line 1488
    const/4 v0, 0x1

    goto :goto_0

    .line 1490
    :cond_2
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne p1, v1, :cond_3

    .line 1491
    const/4 v0, 0x2

    goto :goto_0

    .line 1493
    :cond_3
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne p1, v1, :cond_4

    .line 1494
    const/4 v0, 0x3

    goto :goto_0

    .line 1496
    :cond_4
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne p1, v1, :cond_0

    .line 1497
    const/4 v0, 0x4

    goto :goto_0
.end method

.method public WifiVZWConfigCovertToSapAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .locals 4

    .prologue
    .line 1506
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 1508
    .local v1, "mSapAuthMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_authentication"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1510
    .local v0, "auth":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 1511
    const-string v2, "auth_none"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1512
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 1523
    :cond_0
    :goto_0
    return-object v1

    .line 1513
    :cond_1
    const-string v2, "auth_shared"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1514
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    goto :goto_0

    .line 1515
    :cond_2
    const-string/jumbo v2, "wpa_psk"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1516
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    goto :goto_0

    .line 1517
    :cond_3
    const-string/jumbo v2, "wpa_psk2"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 1518
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    goto :goto_0

    .line 1519
    :cond_4
    const-string/jumbo v2, "wpa_wpa2_mixed"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1520
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->MIXED_MODE_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    goto :goto_0
.end method

.method public WifiVZWConfigCovertToSapEncryptionMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .locals 4

    .prologue
    .line 1528
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 1530
    .local v1, "mSapEncryptionMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_encryption"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1532
    .local v0, "enc":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 1533
    const-string v2, "NO_ENCRYPTION"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1534
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 1545
    :cond_0
    :goto_0
    return-object v1

    .line 1535
    :cond_1
    const-string v2, "TKIP"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1536
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto :goto_0

    .line 1537
    :cond_2
    const-string v2, "CCMP"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1538
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto :goto_0

    .line 1539
    :cond_3
    const-string v2, "TKIP CCMP"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 1540
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP_CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto :goto_0

    .line 1542
    :cond_4
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto :goto_0
.end method

.method public WifiVZWConfigCovertToSapSecurityMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .locals 4

    .prologue
    .line 1550
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 1552
    .local v0, "mSapSecurityMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_security"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1554
    .local v1, "sec":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 1555
    const-string v2, "NO_SECURITY"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1556
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 1570
    :cond_0
    :goto_0
    return-object v0

    .line 1557
    :cond_1
    const-string v2, "WEP"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1558
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    goto :goto_0

    .line 1559
    :cond_2
    const-string v2, "WPA_PSK"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1560
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    goto :goto_0

    .line 1561
    :cond_3
    const-string v2, "WPA2_PSK"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 1562
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    goto :goto_0

    .line 1563
    :cond_4
    const-string v2, "WPA_WPA2_MIXED"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 1564
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    goto :goto_0

    .line 1566
    :cond_5
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    goto :goto_0
.end method

.method public closeSoftAP()I
    .locals 2

    .prologue
    .line 200
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "closeSoftAP : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    const/4 v0, 0x0

    return v0
.end method

.method public createSoftAP()I
    .locals 6

    .prologue
    const/4 v2, 0x0

    const/4 v5, 0x1

    .line 225
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "createSoftAP"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 228
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v3, :cond_1

    .line 230
    :try_start_0
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "mWifiManagerProxy is not null calling mWifiManager"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 231
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    const/4 v5, 0x1

    invoke-virtual {v3, v4, v5}, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 245
    :goto_0
    return v2

    .line 234
    :catch_0
    move-exception v0

    .line 235
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "WifiHostapdWrapperBcm"

    const-string v3, "error in setWifiVZWApEnabled : "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 245
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    :goto_1
    const/4 v2, -0x1

    goto :goto_0

    .line 236
    :catch_1
    move-exception v1

    .line 237
    .local v1, "se":Ljava/lang/SecurityException;
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SecurityException : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/SecurityException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 240
    .end local v1    # "se":Ljava/lang/SecurityException;
    :cond_1
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v3, v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z

    move-result v3

    if-ne v5, v3, :cond_0

    goto :goto_0
.end method

.method public destroySoftAP()I
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 250
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "destroySoftAP"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 253
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v3, :cond_2

    .line 255
    :try_start_0
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "mWifiManagerProxy is not null calling setWifiVZWApEnabled"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 256
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z

    .line 257
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v3, :cond_0

    .line 258
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1

    .line 273
    :cond_0
    :goto_0
    return v2

    .line 262
    :catch_0
    move-exception v0

    .line 263
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "WifiHostapdWrapperBcm"

    const-string v3, "error in setWifiVZWApEnabled : "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 273
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    :goto_1
    const/4 v2, -0x1

    goto :goto_0

    .line 264
    :catch_1
    move-exception v1

    .line 265
    .local v1, "se":Ljava/lang/SecurityException;
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SecurityException : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/SecurityException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 268
    .end local v1    # "se":Ljava/lang/SecurityException;
    :cond_2
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v3, :cond_1

    const/4 v3, 0x1

    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v4, v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->enableSoftAp(Z)Z

    move-result v4

    if-ne v3, v4, :cond_1

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
    .line 280
    :try_start_0
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->unregisterBroadcastReceiver()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 282
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 284
    return-void

    .line 282
    :catchall_0
    move-exception v0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v0
.end method

.method public isEnabledSoftAp()Z
    .locals 1

    .prologue
    .line 289
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 290
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getSoftApStatus()Z

    move-result v0

    .line 292
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public loadP2PDriver()I
    .locals 2

    .prologue
    .line 303
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "loadP2PDriver : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 306
    const/4 v0, 0x0

    return v0
.end method

.method public openSoftAP()I
    .locals 2

    .prologue
    .line 311
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "openSoftAP : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 313
    const/4 v0, 0x0

    return v0
.end method

.method public p2pAddMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    .line 317
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 318
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->addMacFilterAllowList(Ljava/lang/String;I)Z

    move-result v0

    .line 320
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
    .line 324
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 325
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->addMacFilterDenyList(Ljava/lang/String;I)Z

    move-result v0

    .line 327
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
    .line 331
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setDisassociateStation(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 333
    const/4 v0, 0x0

    .line 336
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetAllAssocMac()[Ljava/lang/String;
    .locals 1

    .prologue
    .line 340
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 341
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAllAssocMacList()[Ljava/lang/String;

    move-result-object v0

    .line 343
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
    .line 349
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 350
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAllAssocMacListVZW()Ljava/util/List;

    move-result-object v0

    .line 352
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetAllow11B()I
    .locals 6

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 357
    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "mhs_hw_mode"

    invoke-static {v4, v5}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 358
    .local v1, "sReturnVal":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "mhs_ieee_80211n"

    invoke-static {v4, v5, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 359
    .local v0, "ieee_mode":I
    const-string v4, "b"

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 369
    :goto_0
    return v2

    .line 362
    :cond_0
    const-string v2, "g"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    if-nez v0, :cond_1

    move v2, v3

    .line 363
    goto :goto_0

    .line 365
    :cond_1
    const-string v2, "g"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    if-ne v0, v3, :cond_2

    .line 366
    const/4 v2, 0x2

    goto :goto_0

    .line 369
    :cond_2
    const/4 v2, -0x1

    goto :goto_0
.end method

.method public p2pGetAssocListCount()I
    .locals 3

    .prologue
    .line 373
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 375
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pGetAssocListCount: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAssoStaMacListCount()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 377
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getAssoStaMacListCount()I

    move-result v0

    .line 379
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetAuthentication()I
    .locals 6

    .prologue
    .line 384
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->WifiVZWConfigCovertToSapAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .line 385
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->WifiVZWConfigCovertToSapSecurityMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .line 386
    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->WifiVZWConfigCovertToSapEncryptionMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .line 389
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetAuthentication authMode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 390
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetAuthentication secMode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 391
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetAuthentication encMode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 393
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v3, v0, :cond_2

    .line 394
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-eq v3, v2, :cond_0

    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v3, v2, :cond_1

    .line 399
    :cond_0
    const/4 v3, 0x1

    .line 434
    :goto_0
    return v3

    .line 401
    :cond_1
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetAuthentication : unkown sec mode ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 434
    :goto_1
    const/4 v3, -0x1

    goto :goto_0

    .line 403
    :cond_2
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v3, v0, :cond_6

    .line 407
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v3, v2, :cond_3

    .line 411
    const/4 v3, 0x4

    goto :goto_0

    .line 413
    :cond_3
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v3, v2, :cond_4

    .line 417
    const/16 v3, 0x80

    goto :goto_0

    .line 419
    :cond_4
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v3, v2, :cond_5

    .line 424
    const/4 v3, 0x2

    goto :goto_0

    .line 426
    :cond_5
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetAuthentication : unkown sec mode ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 431
    :cond_6
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetAuthentication : unkown auth mode ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public p2pGetCountryCode()I
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 439
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_country"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 441
    .local v0, "sReturnVal":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 442
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "GetCountryCode  ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 443
    const-string v2, "US"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 450
    :cond_0
    :goto_0
    return v1

    .line 446
    :cond_1
    const-string v2, "FR"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 447
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public p2pGetEncryption()I
    .locals 6

    .prologue
    .line 460
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->WifiVZWConfigCovertToSapAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .line 461
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->WifiVZWConfigCovertToSapSecurityMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .line 462
    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->WifiVZWConfigCovertToSapEncryptionMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .line 465
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetEncryption authMode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 466
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetEncryption secMode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 467
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetEncryption encMode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 469
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v3, v2, :cond_0

    .line 474
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "p2pGetEncryption WifiSapSecurityMode.NO_SECURITY:0"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 476
    const/4 v3, 0x0

    .line 507
    :goto_0
    return v3

    .line 477
    :cond_0
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    if-ne v3, v2, :cond_1

    .line 482
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "p2pGetEncryption WifiSapSecurityMode.WEP:3"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 484
    const/4 v3, 0x3

    goto :goto_0

    .line 486
    :cond_1
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v3, v1, :cond_2

    .line 491
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "p2pGetEncryption WifiSapEncryptionMode.TKIP:2"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 493
    const/4 v3, 0x2

    goto :goto_0

    .line 494
    :cond_2
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    if-ne v3, v1, :cond_3

    .line 499
    const-string v3, "WifiHostapdWrapperBcm"

    const-string v4, "p2pGetEncryption WifiSapEncryptionMode.CCMP:4"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 501
    const/4 v3, 0x4

    goto :goto_0

    .line 503
    :cond_3
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pGetEncryption : unkown enc mode ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 507
    const/4 v3, -0x1

    goto :goto_0
.end method

.method public p2pGetFrequency()I
    .locals 4

    .prologue
    .line 619
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_frequency"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 620
    .local v0, "sReturnVal":I
    return v0
.end method

.method public p2pGetHideSSID()I
    .locals 5

    .prologue
    const/4 v1, 0x1

    .line 512
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-boolean v0, v2, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    .line 514
    .local v0, "sReturnVal":Z
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetHideSSID  ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 515
    if-ne v1, v0, :cond_0

    .line 519
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public p2pGetMacFilterByIndex(I)Ljava/lang/String;
    .locals 1
    .param p1, "iIndex"    # I

    .prologue
    .line 524
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 525
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterByIndex(I)Ljava/lang/String;

    move-result-object v0

    .line 527
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetMacFilterCount()I
    .locals 1

    .prologue
    .line 531
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 532
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterCount()I

    move-result v0

    .line 534
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetMacFilterMode()I
    .locals 5

    .prologue
    .line 538
    const/4 v1, 0x0

    .line 540
    .local v1, "macFilterModeP":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_0

    .line 541
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    move-result-object v1

    .line 544
    :cond_0
    const-string v2, "WifiHostapdWrapperBcm"

    const-string v3, "p2pGetMacFilterMode ()"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 546
    if-eqz v1, :cond_2

    .line 547
    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;->getFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v0

    .line 548
    .local v0, "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetMacFilterMode ():"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 549
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 571
    const-string v2, "WifiHostapdWrapperBcm"

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

    .line 577
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :goto_0
    const-string v2, "WifiHostapdWrapperBcm"

    const-string v3, "p2pGetMacFilterMode (): return -1"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 579
    const/4 v2, -0x1

    :goto_1
    return v2

    .line 554
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_0
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->p2pGetMacFilterCount()I

    move-result v2

    if-nez v2, :cond_1

    .line 555
    const/4 v2, 0x0

    goto :goto_1

    .line 560
    :cond_1
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetMacFilterMode : ACCEPT_UNLESS_IN_DENY_LIST ["

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

    .line 562
    const/4 v2, 0x2

    goto :goto_1

    .line 567
    :pswitch_1
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetMacFilterMode : DENY_LIST ["

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

    .line 569
    const/4 v2, 0x1

    goto :goto_1

    .line 575
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :cond_2
    const-string v2, "WifiHostapdWrapperBcm"

    const-string v3, "p2pGetMacFilterMode macFilterModeP is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 549
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public p2pGetMaxClients()I
    .locals 4

    .prologue
    .line 583
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_max_client"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 585
    .local v0, "sReturnVal":I
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pGetMaxClients  ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 587
    return v0
.end method

.method public p2pGetSSID()Ljava/lang/String;
    .locals 4

    .prologue
    .line 625
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v1, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 627
    .local v0, "sReturnVal":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 628
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x20

    if-le v1, v2, :cond_1

    .line 629
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pGetSSID : not supported ssid length ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 636
    :cond_0
    const/4 v0, 0x0

    .end local v0    # "sReturnVal":Ljava/lang/String;
    :goto_0
    return-object v0

    .line 631
    .restart local v0    # "sReturnVal":Ljava/lang/String;
    :cond_1
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pGetSSID :  ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public p2pGetSocialChannel()I
    .locals 5

    .prologue
    const/4 v1, -0x1

    .line 592
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_channel"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 594
    .local v0, "sReturnVal":I
    if-eqz v0, :cond_2

    .line 595
    if-ltz v0, :cond_0

    const/16 v2, 0xe

    if-le v0, v2, :cond_1

    .line 596
    :cond_0
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetSocialChannel unsupported channel ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v1

    .line 603
    .end local v0    # "sReturnVal":I
    :goto_0
    return v0

    .line 599
    .restart local v0    # "sReturnVal":I
    :cond_1
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pGetSocialChannel  ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    move v0, v1

    .line 603
    goto :goto_0
.end method

.method public p2pGetSoftapIsolation()Z
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 607
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_isolated"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 609
    .local v0, "sReturnVal":I
    if-eqz v0, :cond_0

    .line 610
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pGetSoftapIsolation isolated ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 611
    const/4 v1, 0x1

    .line 614
    :goto_0
    return v1

    .line 613
    :cond_0
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pGetSoftapIsolation not isolated ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public p2pGetWEPIndex()I
    .locals 3

    .prologue
    .line 640
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 641
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pGetWEPIndex  ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget v2, v2, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 642
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget v0, v0, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    .line 644
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pGetWEPKey1()Ljava/lang/String;
    .locals 2

    .prologue
    .line 653
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 654
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "p2pGetWEPKey  [0]"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 655
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    .line 657
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey2()Ljava/lang/String;
    .locals 2

    .prologue
    .line 666
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 667
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "p2pGetWEPKey  [1]"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 668
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    .line 670
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey3()Ljava/lang/String;
    .locals 2

    .prologue
    .line 679
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 680
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "p2pGetWEPKey  [2]"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 681
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    .line 683
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWEPKey4()Ljava/lang/String;
    .locals 2

    .prologue
    .line 692
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 693
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "p2pGetWEPKey  [3]"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 694
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    const/4 v1, 0x3

    aget-object v0, v0, v1

    .line 696
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pGetWPAKey()Ljava/lang/String;
    .locals 3

    .prologue
    .line 701
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 702
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pGetWPAKey  ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v2, v2, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 703
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v0, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    .line 705
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pMacFilterremoveAllowedList(Ljava/lang/String;)I
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    .line 724
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pMacFilterremoveAllowedList: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 726
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->MacFilterremoveAllowedList(Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_0

    .line 728
    const/4 v0, 0x0

    .line 731
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pMacFilterremoveDeniedList(Ljava/lang/String;)I
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    .line 737
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pMacFilterremoveDeniedList: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 739
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->MacFilterremoveDeniedList(Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_0

    .line 741
    const/4 v0, 0x0

    .line 744
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pMacaddracl(I)Z
    .locals 4
    .param p1, "value"    # I

    .prologue
    const/4 v0, 0x1

    .line 710
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pMacaddracl: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 712
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_mac_acl"

    invoke-static {v1, v2, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 713
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacaddracl(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 717
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetAllow11B(I)I
    .locals 5
    .param p1, "iCommand"    # I

    .prologue
    const/4 v4, 0x1

    const/4 v0, 0x0

    .line 763
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetAllow11B: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 765
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->p2pGetFrequency()I

    move-result v1

    if-nez v1, :cond_0

    .line 766
    packed-switch p1, :pswitch_data_0

    .line 799
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetAllow11B unknown param ["

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

    .line 800
    const/4 v0, -0x1

    .line 805
    :goto_0
    return v0

    .line 772
    :pswitch_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_hw_mode"

    const-string v3, "b"

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 773
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_ieee_80211n"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0

    .line 780
    :pswitch_1
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_hw_mode"

    const-string v3, "g"

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 781
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_ieee_80211n"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0

    .line 788
    :pswitch_2
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_hw_mode"

    const-string v3, "g"

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 789
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_ieee_80211n"

    invoke-static {v1, v2, v4}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0

    .line 803
    :cond_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_hw_mode"

    const-string v3, "a"

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 804
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_ieee_80211n"

    invoke-static {v1, v2, v4}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0

    .line 766
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

    .line 825
    if-eq v1, p1, :cond_0

    const/4 v0, 0x2

    if-eq v0, p1, :cond_0

    const/4 v0, 0x4

    if-eq v0, p1, :cond_0

    const/16 v0, 0x80

    if-eq v0, p1, :cond_0

    const/4 v0, 0x3

    if-ne v0, p1, :cond_1

    .line 830
    :cond_0
    iput-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mIsSetAuthenticationCalled:Z

    .line 831
    iput p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    .line 833
    sparse-switch p1, :sswitch_data_0

    .line 849
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_authentication"

    const-string/jumbo v2, "wpa_wpa2_mixed"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 852
    :goto_0
    const/4 v0, 0x0

    .line 856
    :goto_1
    return v0

    .line 835
    :sswitch_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_authentication"

    const-string v2, "auth_none"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 838
    :sswitch_1
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_authentication"

    const-string v2, "auth_shared"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 841
    :sswitch_2
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_authentication"

    const-string/jumbo v2, "wpa_psk"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 843
    :sswitch_3
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_authentication"

    const-string/jumbo v2, "wpa_psk2"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 846
    :sswitch_4
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_authentication"

    const-string/jumbo v2, "wpa_wpa2_mixed"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    .line 854
    :cond_1
    const-string v0, "WifiHostapdWrapperBcm"

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

    .line 856
    const/4 v0, -0x1

    goto :goto_1

    .line 833
    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_1
        0x3 -> :sswitch_4
        0x4 -> :sswitch_2
        0x80 -> :sswitch_3
    .end sparse-switch
.end method

.method public p2pSetCountryCode(I)I
    .locals 4
    .param p1, "iCommand"    # I

    .prologue
    const/4 v1, -0x1

    .line 865
    if-nez p1, :cond_1

    .line 866
    const-string v0, "US"

    .line 872
    .local v0, "countryCode":Ljava/lang/String;
    :goto_0
    if-eqz v0, :cond_0

    .line 873
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_country"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 874
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetCountryCode : ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 875
    const/4 v1, 0x0

    .line 877
    .end local v0    # "countryCode":Ljava/lang/String;
    :cond_0
    return v1

    .line 867
    :cond_1
    const/4 v2, 0x1

    if-ne v2, p1, :cond_0

    .line 868
    const-string v0, "FR"

    .restart local v0    # "countryCode":Ljava/lang/String;
    goto :goto_0
.end method

.method public p2pSetEncryption(I)I
    .locals 10
    .param p1, "iCommand"    # I

    .prologue
    const/16 v9, 0x80

    const/4 v7, 0x1

    const/4 v5, 0x0

    const/4 v8, 0x4

    const/4 v4, -0x1

    .line 886
    iget-boolean v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mIsSetAuthenticationCalled:Z

    if-nez v6, :cond_1

    .line 887
    const-string v5, "WifiHostapdWrapperBcm"

    const-string v6, "p2pSetEncryption : call p2pSetAuthentication() first"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1003
    :cond_0
    :goto_0
    return v4

    .line 890
    :cond_1
    iput-boolean v5, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mIsSetAuthenticationCalled:Z

    .line 892
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 893
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 894
    .local v3, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 896
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    packed-switch p1, :pswitch_data_0

    .line 988
    :pswitch_0
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pSetEncryption : unkown enc mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 900
    :pswitch_1
    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v7, v6, :cond_3

    .line 901
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 902
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 903
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 906
    iget-object v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v6, v6, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    if-eqz v6, :cond_2

    .line 907
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v8, :cond_2

    .line 908
    iget-object v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v6, v6, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    const/4 v7, 0x0

    aput-object v7, v6, v2

    .line 907
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 911
    .end local v2    # "i":I
    :cond_2
    iget-object v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    const/4 v7, 0x0

    iput-object v7, v6, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    .line 993
    :goto_2
    const-string v6, "WifiHostapdWrapperBcm"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "p2pSetEncryption authMode : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 994
    const-string v6, "WifiHostapdWrapperBcm"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "p2pSetEncryption secMode : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 995
    const-string v6, "WifiHostapdWrapperBcm"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "p2pSetEncryption encMode : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 997
    iget-object v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v6, :cond_0

    .line 998
    invoke-direct {p0, v0, v3, v1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgSecurity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z

    .line 999
    invoke-direct {p0, v1, v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->SetEncryptionMode(Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)Z

    move v4, v5

    .line 1000
    goto/16 :goto_0

    .line 913
    :cond_3
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] [ALGO_OFF]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 921
    :pswitch_2
    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v9, v6, :cond_4

    .line 922
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 923
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 924
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 926
    :cond_4
    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v8, v6, :cond_5

    .line 927
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 928
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 929
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 931
    :cond_5
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] [ALGO_TKIP]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 939
    :pswitch_3
    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v7, v6, :cond_6

    .line 940
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 941
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 942
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 944
    :cond_6
    const/4 v6, 0x2

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v6, v7, :cond_7

    .line 945
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 946
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 947
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 949
    :cond_7
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] [ALGO_WEP128]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 957
    :pswitch_4
    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v9, v6, :cond_8

    .line 958
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 959
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 960
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 962
    :cond_8
    iget v6, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v8, v6, :cond_9

    .line 963
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 964
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 965
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 967
    :cond_9
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] [ALGO_AES]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 975
    :pswitch_5
    const/4 v6, 0x3

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    if-ne v6, v7, :cond_a

    .line 976
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 977
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_WPA2_MIXED:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 978
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP_CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    goto/16 :goto_2

    .line 981
    :cond_a
    const-string v5, "WifiHostapdWrapperBcm"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "p2pSetEncryption : unkown auth mode ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mAuthenticationMode:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] [ALGO_AES]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 896
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method public p2pSetFrequency(I)V
    .locals 3
    .param p1, "value"    # I

    .prologue
    .line 1202
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetFrequency: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1205
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_frequency"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1206
    return-void
.end method

.method public p2pSetHideSSID(I)I
    .locals 4
    .param p1, "iCommand"    # I

    .prologue
    .line 1013
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetHideSSID: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1015
    const/4 v1, 0x1

    if-ne v1, p1, :cond_0

    .line 1016
    const/4 v0, 0x1

    .line 1030
    .local v0, "hiddenSsid":Z
    :goto_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-boolean v0, v1, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    .line 1031
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetHideSSID : ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1032
    const/4 v1, 0x0

    return v1

    .line 1018
    .end local v0    # "hiddenSsid":Z
    :cond_0
    const/4 v0, 0x0

    .restart local v0    # "hiddenSsid":Z
    goto :goto_0
.end method

.method public p2pSetMacFilterByIndex(ILjava/lang/String;)I
    .locals 3
    .param p1, "iIndex"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    .line 1037
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetMacFilterByIndex: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " bssid: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1039
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterByIndex(ILjava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 1041
    const/4 v0, 0x0

    .line 1044
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetMacFilterCount(I)I
    .locals 3
    .param p1, "iCount"    # I

    .prologue
    .line 1049
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetMacFilterCount: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1051
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterCount(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 1053
    const/4 v0, 0x0

    .line 1055
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

    .line 1067
    const-string v3, "WifiHostapdWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "p2pSetMacFilterMode: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1069
    packed-switch p1, :pswitch_data_0

    .line 1111
    const-string v2, "WifiHostapdWrapperBcm"

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

    .line 1120
    :cond_0
    :goto_0
    return v1

    .line 1074
    :pswitch_0
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 1078
    .local v0, "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    invoke-virtual {p0, v2}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->p2pSetMacFilterCount(I)I

    .line 1080
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_accept_file"

    const-string v5, "/data/misc/wifi/hostapd.accept"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1081
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_deny_file"

    const-string v5, "/data/misc/wifi/hostapd.deny"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1115
    :goto_1
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v3, :cond_0

    const/4 v3, 0x1

    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    new-instance v5, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    invoke-direct {v5, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)V

    invoke-virtual {v4, v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;)Z

    move-result v4

    if-ne v3, v4, :cond_0

    move v1, v2

    .line 1117
    goto :goto_0

    .line 1087
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_1
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->DENY_UNLESS_IN_ACCEPT_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 1089
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_accept_file"

    const-string v5, "/data/misc/wifi/hostapd.accept"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1090
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_deny_file"

    const-string v5, "/data/misc/wifi/hostapd.deny"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_1

    .line 1096
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_2
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 1098
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_accept_file"

    const-string v5, "/data/misc/wifi/hostapd.accept"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1099
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_deny_file"

    const-string v5, "/data/misc/wifi/hostapd.deny"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_1

    .line 1104
    .end local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    :pswitch_3
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->NUM_OF_MAC_FILTER_MODE:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 1106
    .restart local v0    # "macFilterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_accept_file"

    const-string v5, "/data/misc/wifi/hostapd.accept"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 1107
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_deny_file"

    const-string v5, "/data/misc/wifi/hostapd.deny"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_1

    .line 1069
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public p2pSetMaxAssoc(I)I
    .locals 3
    .param p1, "max_assoc_num"    # I

    .prologue
    .line 1124
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_max_client"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1127
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetMaxAssoc: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1129
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMaxNumOfClients(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 1131
    const/4 v0, 0x0

    .line 1133
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetMaxClients(I)Z
    .locals 4
    .param p1, "num"    # I

    .prologue
    const/4 v0, 0x1

    .line 1137
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_max_client"

    invoke-static {v1, v2, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1140
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetMaxClients: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1142
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setMaxNumOfClients(I)Z

    move-result v1

    if-ne v0, v1, :cond_0

    .line 1146
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetSSID(Ljava/lang/String;)I
    .locals 4
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    const/4 v0, -0x1

    .line 1223
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetSSID: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1229
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x20

    if-le v1, v2, :cond_1

    .line 1230
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetSSID : not supported ssid length ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1240
    :cond_0
    :goto_0
    return v0

    .line 1234
    :cond_1
    if-eqz p1, :cond_0

    .line 1235
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 1236
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetSSID : ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1238
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetSocialChannel(I)I
    .locals 4
    .param p1, "iCommand"    # I

    .prologue
    const/4 v3, 0x0

    .line 1156
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetSocialChannel: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1163
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->p2pGetFrequency()I

    move-result v0

    if-nez v0, :cond_0

    .line 1164
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_channel"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1165
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetSocialChannel : ["

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

    .line 1177
    :goto_0
    return v3

    .line 1169
    :cond_0
    packed-switch p1, :pswitch_data_0

    .line 1175
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_channel"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1176
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetSocialChannel : ["

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

    goto :goto_0

    .line 1171
    :pswitch_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_channel"

    const/16 v2, 0x95

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1172
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetSocialChannel : ["

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

    goto :goto_0

    .line 1169
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method

.method public p2pSetSoftapIsolation(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 1185
    const-string v2, "WifiHostapdWrapperBcm"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pSetSoftapIsolation: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1187
    if-ne p1, v0, :cond_0

    .line 1188
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_isolated"

    invoke-static {v2, v3, v0}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1193
    :goto_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setPrivacySeparator(Z)Z

    move-result v2

    if-ne v0, v2, :cond_1

    .line 1197
    :goto_1
    return v0

    .line 1191
    :cond_0
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_isolated"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0

    :cond_1
    move v0, v1

    .line 1197
    goto :goto_1
.end method

.method public p2pSetTxPower(I)I
    .locals 3
    .param p1, "txpower"    # I

    .prologue
    .line 1210
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetTxPower: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1213
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "transmit_power_mode"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1214
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 1215
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->setTxPower(I)I

    move-result v0

    .line 1217
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public p2pSetWEPIndex(I)I
    .locals 3
    .param p1, "iCommand"    # I

    .prologue
    .line 1248
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetWEPIndex: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1250
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 1251
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgWepKeyIndex(I)V

    .line 1254
    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method public p2pSetWEPKey1(Ljava/lang/String;)I
    .locals 4
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 1259
    const-string v1, "WifiHostapdWrapperBcm"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pSetWEPKey1: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1262
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v1, :cond_0

    .line 1263
    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 1267
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey2(Ljava/lang/String;)I
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    .line 1272
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetWEPKey1: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1275
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 1276
    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 1277
    const/4 v0, 0x0

    .line 1280
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey3(Ljava/lang/String;)I
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    .line 1285
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetWEPKey1: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1288
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 1289
    const/4 v0, 0x2

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 1290
    const/4 v0, 0x0

    .line 1293
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWEPKey4(Ljava/lang/String;)I
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    .line 1298
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetWEPKey1: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1301
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 1302
    const/4 v0, 0x3

    invoke-direct {p0, v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgWepKey(ILjava/lang/String;)Z

    .line 1303
    const/4 v0, 0x0

    .line 1306
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2pSetWPAKey(Ljava/lang/String;)I
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    .line 1312
    const-string v0, "WifiHostapdWrapperBcm"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetWPAKey: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1314
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    if-eqz v0, :cond_0

    .line 1315
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->setWifiCfgWpaKey(Ljava/lang/String;)V

    .line 1316
    const/4 v0, 0x0

    .line 1318
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public p2premoveAlltheList()I
    .locals 1

    .prologue
    .line 749
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-eqz v0, :cond_0

    .line 750
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiHostapdWrapperBcm;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->removeAlltheList()I

    move-result v0

    .line 752
    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public unloadP2PDriver()I
    .locals 2

    .prologue
    .line 1436
    const-string v0, "WifiHostapdWrapperBcm"

    const-string v1, "unloadP2PDriver : nothing to do..."

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1439
    const/4 v0, 0x0

    return v0
.end method
