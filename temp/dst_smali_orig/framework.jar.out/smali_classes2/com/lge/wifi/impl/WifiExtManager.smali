.class public Lcom/lge/wifi/impl/WifiExtManager;
.super Ljava/lang/Object;
.source "WifiExtManager.java"


# static fields
.field public static final ACTION_HS20_ANQP_FETCH_START:Ljava/lang/String; = "android.net.wifi.HS20_ANQP_FETCH_START"

.field public static final ACTION_HS20_AP_EVENT:Ljava/lang/String; = "android.net.wifi.HS20_AP_EVENT"

.field public static final ACTION_HS20_TRY_CONNECTION:Ljava/lang/String; = "android.net.wifi.HS20_TRY_CONNECTION"

.field public static final EXTRA_HS20_BSSID:Ljava/lang/String; = "bssid"

.field public static final EXTRA_HS20_OPERATOR_FRIENDLY_NAME:Ljava/lang/String; = "operator"

.field public static final EXTRA_HS20_RC_IND:Ljava/lang/String; = "roamingInd"

.field public static final EXTRA_HS20_SSID:Ljava/lang/String; = "ssid"

.field public static final EXTRA_HS20_VENUE_NAME:Ljava/lang/String; = "venue"

.field public static final SERVICE_NAME:Ljava/lang/String; = "wifiExtService"

.field private static mService:Lcom/lge/wifi/impl/IWifiExtManager;

.field private static mWifiExtManager:Lcom/lge/wifi/impl/WifiExtManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wifi/impl/WifiExtManager;->mWifiExtManager:Lcom/lge/wifi/impl/WifiExtManager;

    sput-object v0, Lcom/lge/wifi/impl/WifiExtManager;->mService:Lcom/lge/wifi/impl/IWifiExtManager;

    return-void
.end method

.method private constructor <init>(Lcom/lge/wifi/impl/IWifiExtManager;)V
    .locals 0
    .param p1, "service"    # Lcom/lge/wifi/impl/IWifiExtManager;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sput-object p1, Lcom/lge/wifi/impl/WifiExtManager;->mService:Lcom/lge/wifi/impl/IWifiExtManager;

    return-void
.end method

.method public static getInstance()Lcom/lge/wifi/impl/WifiExtManager;
    .locals 3

    .prologue
    sget-object v2, Lcom/lge/wifi/impl/WifiExtManager;->mWifiExtManager:Lcom/lge/wifi/impl/WifiExtManager;

    if-nez v2, :cond_0

    const-string v2, "wifiExtService"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Lcom/lge/wifi/impl/IWifiExtManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v1

    .local v1, "service":Lcom/lge/wifi/impl/IWifiExtManager;
    new-instance v2, Lcom/lge/wifi/impl/WifiExtManager;

    invoke-direct {v2, v1}, Lcom/lge/wifi/impl/WifiExtManager;-><init>(Lcom/lge/wifi/impl/IWifiExtManager;)V

    sput-object v2, Lcom/lge/wifi/impl/WifiExtManager;->mWifiExtManager:Lcom/lge/wifi/impl/WifiExtManager;

    :cond_0
    sget-object v2, Lcom/lge/wifi/impl/WifiExtManager;->mWifiExtManager:Lcom/lge/wifi/impl/WifiExtManager;

    return-object v2
.end method

.method private static getService()Lcom/lge/wifi/impl/IWifiExtManager;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/wifi/impl/WifiExtManager;->mService:Lcom/lge/wifi/impl/IWifiExtManager;

    return-object v0
.end method

.method public static getSoftApMaxScb(I)I
    .locals 3
    .param p0, "defaultMaxScb"    # I

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2, p0}, Lcom/lge/wifi/impl/IWifiExtManager;->getSoftApMaxScb(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public static isVZWMobileHotspotEnabled()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    .local v0, "e":Landroid/os/RemoteException;
    :goto_0
    return v1

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->isVZWMobileHotspotEnabled()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public static setVZWMobileHotspot(Z)Z
    .locals 3
    .param p0, "enable"    # Z

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2, p0}, Lcom/lge/wifi/impl/IWifiExtManager;->setVZWMobileHotspot(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method


# virtual methods
.method public getCallingWifiUid()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->getCallingWifiUid()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getConnectionExtInfo()Lcom/lge/wifi/impl/WifiExtInfo;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->getConnectionExtInfo()Lcom/lge/wifi/impl/WifiExtInfo;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getMacAddress()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->getMacAddress()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getP2pState()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->getP2pState()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public getSecurityType()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->getSecurityType()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public isInternetCheckAvailable()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/wifi/impl/IWifiExtManager;->isInternetCheckAvailable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setCallingWifiUid(I)V
    .locals 2
    .param p1, "uid"    # I

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v1

    if-nez v1, :cond_0

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/IWifiExtManager;->setCallingWifiUid(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setDLNAEnabled()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v2

    const/4 v3, 0x1

    invoke-interface {v2, v3}, Lcom/lge/wifi/impl/IWifiExtManager;->setDlnaUsing(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public setProvisioned(Z)V
    .locals 1
    .param p1, "value"    # Z

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/wifi/impl/WifiExtManager;->getService()Lcom/lge/wifi/impl/IWifiExtManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/IWifiExtManager;->setProvisioned(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method
