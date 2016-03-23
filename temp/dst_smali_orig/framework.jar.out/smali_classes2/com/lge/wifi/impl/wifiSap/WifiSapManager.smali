.class public Lcom/lge/wifi/impl/wifiSap/WifiSapManager;
.super Ljava/lang/Object;
.source "WifiSapManager.java"


# static fields
.field public static final SERVICE_NAME:Ljava/lang/String; = "wifiSapService"

.field public static final WIFI_SAP_DHCP_INFO_CHANGED_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

.field public static final WIFI_SAP_DISABLED_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.DISABLED"

.field public static final WIFI_SAP_ENABLED_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.ENABLED"

.field public static final WIFI_SAP_HOSTAPD_CONNECTED_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_HOSTAPD_CONNECTED"

.field public static final WIFI_SAP_HUNG_EVENT:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_DRIVER_HUNG_EVENT"

.field public static final WIFI_SAP_MAX_REACHED_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_MAX_REACHED"

.field public static final WIFI_SAP_STATION_ASSOC_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_STATION_ASSOC"

.field public static final WIFI_SAP_STATION_DISASSOC_ACTION:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_STATION_DISASSOC"

.field public static final WIFI_SAP_WPS_EVENT_DISABLE:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_DISABLE"

.field public static final WIFI_SAP_WPS_EVENT_FAIL:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_FAIL"

.field public static final WIFI_SAP_WPS_EVENT_REG_SUCCES:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_REG_SUCCES"

.field public static final WIFI_SAP_WPS_EVENT_SUCCESS:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_SUCCESS"

.field public static final WIFI_SAP_WPS_EVENT_TIMEOUT:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_TIMEOUT"

.field public static final WIFI_SAP_WPS_PBC_ACTIVE:Ljava/lang/String; = "com.lge.wifi.sap.WIFI_SAP_WPS_PBC_ACTIVE"

.field private static mService:Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

.field private static mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    sput-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mService:Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    return-void
.end method

.method private constructor <init>(Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;)V
    .locals 0
    .param p1, "service"    # Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sput-object p1, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mService:Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    return-void
.end method

.method public static getInstance()Lcom/lge/wifi/impl/wifiSap/WifiSapManager;
    .locals 3

    .prologue
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    if-nez v2, :cond_0

    const-string v2, "wifiSapService"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    .local v1, "service":Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;
    new-instance v2, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    invoke-direct {v2, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;-><init>(Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;)V

    sput-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    :cond_0
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mWifiSapManager:Lcom/lge/wifi/impl/wifiSap/WifiSapManager;

    return-object v2
.end method

.method private static getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;
    .locals 3

    .prologue
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mService:Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    if-nez v2, :cond_0

    const-string v2, "wifiSapService"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    .local v1, "service":Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;
    sput-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mService:Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    :cond_0
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->mService:Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    return-object v2
.end method


# virtual methods
.method public MacFilterremoveAllowedList(Ljava/lang/String;)I
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->MacFilterremoveAllowedList(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public MacFilterremoveDeniedList(Ljava/lang/String;)I
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->MacFilterremoveDeniedList(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public addMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->addMacFilterAllowList(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public addMacFilterDenyList(Ljava/lang/String;I)Z
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->addMacFilterDenyList(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public enableSoftAp(Z)Z
    .locals 2
    .param p1, "bEnable"    # Z

    .prologue
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->enableSoftAp(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public enableSoftApWifiCfg(ZLandroid/net/wifi/WifiConfiguration;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .param p1, "bEnable"    # Z
    .param p2, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p3, "wlanIface"    # Ljava/lang/String;
    .param p4, "softapIface"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    invoke-interface {v1, p1, p2, p3, p4}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->enableSoftApWifiCfg(ZLandroid/net/wifi/WifiConfiguration;Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAllAssocMacList()[Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getAllAssocMacList()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAllAssocMacListATT()Ljava/util/List;
    .locals 3
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
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getAllAssocMacListATT()Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getAllAssocMacListVZW()Ljava/util/List;
    .locals 3
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
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getAllAssocMacListVZW()Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getAssoStaMacListCount()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getAssoStaMacListCount()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getAutoShutOffTime()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getAutoShutOffTime()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getChannel()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getChannel()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getCountryCode()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getCountryCode()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getHiddenSsid()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getHiddenSsid()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getMacFilterByIndex(I)Ljava/lang/String;
    .locals 3
    .param p1, "index"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getMacFilterByIndex(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getMacFilterCount()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getMacFilterCount()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getMaxNumOfClients()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getMaxNumOfClients()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getPrivacySeparator()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getPrivacySeparator()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getSoftApStatus()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getSoftApStatus()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getSsid()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getSsid()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWepKey1()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWepKey1()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWepKey2()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWepKey2()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWepKey3()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWepKey3()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWepKey4()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWepKey4()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWepKeyIndex()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWepKeyIndex()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWpaKey()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWpaKey()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWpsNfcConfTokenFromAP(II)Ljava/lang/String;
    .locals 3
    .param p1, "isEnabled"    # I
    .param p2, "isNDEF"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWpsNfcConfTokenFromAP(II)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getWpsNfcHandoverSelect(I)Ljava/lang/String;
    .locals 3
    .param p1, "isNDEF"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->getWpsNfcHandoverSelect(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public removeAlltheList()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->removeAlltheList()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public removeMacFilterAllowList()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->removeMacFilterAllowList()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setAutoShutOffTime(I)Z
    .locals 3
    .param p1, "time"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setAutoShutOffTime(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setChannel(I)Z
    .locals 3
    .param p1, "channel"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setChannel(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setCountryCode(Ljava/lang/String;)Z
    .locals 3
    .param p1, "countryCode"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setCountryCode(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setDisassociateStation(Ljava/lang/String;)Z
    .locals 3
    .param p1, "staMac"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setDisassociateStation(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setHiddenSsid(Z)Z
    .locals 3
    .param p1, "hiddenSsid"    # Z

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setHiddenSsid(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setMacFilterByIndex(ILjava/lang/String;)Z
    .locals 3
    .param p1, "index"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setMacFilterByIndex(ILjava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setMacFilterCount(I)Z
    .locals 3
    .param p1, "filterCount"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setMacFilterCount(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;)Z
    .locals 2
    .param p1, "filterMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    .prologue
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setMacaddracl(I)Z
    .locals 3
    .param p1, "value"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setMacaddracl(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setMaxNumOfClients(I)Z
    .locals 3
    .param p1, "numClient"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setMaxNumOfClients(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setNstartMonitoring(ZLandroid/net/wifi/WifiConfiguration;II)Z
    .locals 3
    .param p1, "bEnable"    # Z
    .param p2, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p3, "channel"    # I
    .param p4, "maxScb"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2, p3, p4}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setNstartMonitoring(ZLandroid/net/wifi/WifiConfiguration;II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setOperationMode(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;)Z
    .locals 3
    .param p1, "opMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setOperationMode(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setPrivacySeparator(Z)Z
    .locals 3
    .param p1, "privacySep"    # Z

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setPrivacySeparator(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;)Z
    .locals 3
    .param p1, "secType"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setSoftApWifiCfg(Landroid/net/wifi/WifiConfiguration;IIZ)Z
    .locals 3
    .param p1, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p2, "channel"    # I
    .param p3, "maxScb"    # I
    .param p4, "bWoNmService"    # Z

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2, p3, p4}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setSoftApWifiCfg(Landroid/net/wifi/WifiConfiguration;IIZ)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setSsid(Ljava/lang/String;)Z
    .locals 3
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setSsid(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setTxPower(I)I
    .locals 3
    .param p1, "txPower"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setTxPower(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWepKey1(Ljava/lang/String;)Z
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWepKey1(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWepKey2(Ljava/lang/String;)Z
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWepKey2(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWepKey3(Ljava/lang/String;)Z
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWepKey3(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWepKey4(Ljava/lang/String;)Z
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWepKey4(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWepKeyIndex(I)Z
    .locals 3
    .param p1, "index"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWepKeyIndex(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWpaKey(Ljava/lang/String;)Z
    .locals 3
    .param p1, "phassphrase"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWpaKey(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWpsCancel()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWpsCancel()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWpsNfcPwToken(Ljava/lang/String;II)I
    .locals 3
    .param p1, "NDEF"    # Ljava/lang/String;
    .param p2, "isEnabled"    # I
    .param p3, "isNDEF"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWpsNfcPwToken(Ljava/lang/String;II)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWpsNfcReportHandover(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .param p1, "reqNDEF"    # Ljava/lang/String;
    .param p2, "selNDEF"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWpsNfcReportHandover(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWpsPbc()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWpsPbc()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setWpsPin(Ljava/lang/String;I)I
    .locals 3
    .param p1, "PinNum"    # Ljava/lang/String;
    .param p2, "expirationTime"    # I

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapManager;->getService()Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager;->setWpsPin(Ljava/lang/String;I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method
