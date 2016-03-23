.class public Lcom/lge/systemservice/core/WifiLgeExtManager;
.super Ljava/lang/Object;
.source "WifiLgeExtManager.java"


# static fields
.field static final SERVICE_NAME:Ljava/lang/String; = "wifiLgeExtService"

.field private static final TAG:Ljava/lang/String; = "WifiLgeExtManager"


# instance fields
.field private mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/WifiLgeExtManager;Lcom/lge/systemservice/core/IWifiLgeExtManager;)Lcom/lge/systemservice/core/IWifiLgeExtManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/WifiLgeExtManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IWifiLgeExtManager;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    return-object p1
.end method

.method private final getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;
    .locals 5

    .prologue
    iget-object v2, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    if-nez v2, :cond_0

    const-string v2, "wifiLgeExtService"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Lcom/lge/systemservice/core/IWifiLgeExtManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    iget-object v2, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    invoke-interface {v2}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->asBinder()Landroid/os/IBinder;

    move-result-object v2

    new-instance v3, Lcom/lge/systemservice/core/WifiLgeExtManager$1;

    invoke-direct {v3, p0}, Lcom/lge/systemservice/core/WifiLgeExtManager$1;-><init>(Lcom/lge/systemservice/core/WifiLgeExtManager;)V

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "b":Landroid/os/IBinder;
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    return-object v2

    .restart local v0    # "b":Landroid/os/IBinder;
    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/WifiLgeExtManager;->mWifiLgeExtManager:Lcom/lge/systemservice/core/IWifiLgeExtManager;

    goto :goto_0
.end method


# virtual methods
.method public Channel5G_HiddenMenu(II)Z
    .locals 5
    .param p1, "Channel"    # I
    .param p2, "BondingInfo"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Channel5G_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->Channel5G_HiddenMenu(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Channel5G_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Channel5G_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public Channel_HiddenMenu(II)Z
    .locals 5
    .param p1, "Channel"    # I
    .param p2, "BondingInfo"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Channel_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->Channel_HiddenMenu(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Channel_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Channel_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public CloseDUT_HiddenMenu(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] CloseDUT_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->CloseDUT_HiddenMenu(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] CloseDUT_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] CloseDUT_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public CodeRate_HiddenMenu(Ljava/lang/String;)I
    .locals 5
    .param p1, "ifname"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v2, "WifiLgeExtManager"

    const-string v3, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "CodeRate_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->CodeRate_HiddenMenu(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "CodeRate_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "CodeRate_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public FRError_HiddenMenu()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRError_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->FRError_HiddenMenu()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRError_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRError_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public FRGood_HiddenMenu()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRGood_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->FRGood_HiddenMenu()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRGood_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRGood_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public FRTotal_HiddenMenu()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRTotal_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->FRTotal_HiddenMenu()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRTotal_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] FRTotal_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public FrequencyAccuracy5G_HiddenMenu(Ljava/lang/String;I)Z
    .locals 5
    .param p1, "band"    # Ljava/lang/String;
    .param p2, "ChannelNo"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] FrequencyAccuracy5G_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->FrequencyAccuracy5G_HiddenMenu(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] FrequencyAccuracy5G_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] FrequencyAccuracy5G_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public FrequencyAccuracy_HiddenMenu(Ljava/lang/String;I)Z
    .locals 5
    .param p1, "band"    # Ljava/lang/String;
    .param p2, "ChannelNo"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] FrequencyAccuracy_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->FrequencyAccuracy_HiddenMenu(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] FrequencyAccuracy_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] FrequencyAccuracy_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public IsRunning_HiddenMenu()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] IsRunning_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->IsRunning_HiddenMenu()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] IsRunning_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] IsRunning_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public NoModTxStart_BCM_HiddenMenu(I)Z
    .locals 5
    .param p1, "channel"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] NoModTxStart_BCM_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->NoModTxStart_BCM_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] NoModTxStart_BCM_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] NoModTxStart_BCM_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public NoModTxStart_HiddenMenu()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStart_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->NoModTxStart_HiddenMenu()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStart_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStart_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public NoModTxStop_HiddenMenu()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStop_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->NoModTxStop_HiddenMenu()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStop_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStop_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public OpMode_HiddenMenu(Ljava/lang/String;)I
    .locals 5
    .param p1, "ifname"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v2, "WifiLgeExtManager"

    const-string v3, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "OpMode_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->OpMode_HiddenMenu(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "OpMode_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "OpMode_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public OpenDUT_HiddenMenu(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] OpenDUT_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->OpenDUT_HiddenMenu(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] OpenDUT_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] OpenDUT_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public OtaDisable_HiddenMenu()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] OtaDisable_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->OtaDisable_HiddenMenu()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] OtaDisable_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] OtaDisable_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public OtaEnable_HiddenMenu()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] OtaEnable_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->OtaEnable_HiddenMenu()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] OtaEnabled_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] OtaEnabled_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public RSSI_HiddenMenu()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RSSI_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->RSSI_HiddenMenu()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RSSI_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RSSI_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public RxPER_HiddenMenu(Ljava/lang/String;)I
    .locals 5
    .param p1, "ifname"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v2, "WifiLgeExtManager"

    const-string v3, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "RxPER_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->RxPER_HiddenMenu(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "RxPER_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "RxPER_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public RxStart_HiddenMenu(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RxStart_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->RxStart_HiddenMenu(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RxStart_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RxStart_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public RxStop_HiddenMenu(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RxStop_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->RxStop_HiddenMenu(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RxStop_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] RxStop_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public Set11nPreamble_HiddenMenu(I)Z
    .locals 5
    .param p1, "Preamble"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Set11nPreamble_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->Set11nPreamble_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Set11nPreamble_HiddenMenu is failed"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Set11nPreamble_HiddenMenu is is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public SetChainExt_HiddenMenu(I)Z
    .locals 5
    .param p1, "chainValue"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetChainExt_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->SetChainExt_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetChainExt_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetChainExt_HiddenMenu is failed2."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public SetChain_HiddenMenu(I)Z
    .locals 5
    .param p1, "chainValue"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetChain_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->SetChain_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetChain_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetChain_HiddenMenu is failed2."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public SetPreamble_HiddenMenu(I)Z
    .locals 5
    .param p1, "Preamble"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetPreamble_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->SetPreamble_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetPreamble_HiddenMenu is failed"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetPreamble_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public SetTxBF_HiddenMenu(I)Z
    .locals 5
    .param p1, "Value"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetTxBF_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->SetTxBF_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetTxBF_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] SetTxBF_HiddenMenu is failed2."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TXBW_40M_HiddenMenu(I)Z
    .locals 5
    .param p1, "ChannelNo"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] TXBW_40M_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TXBW_40M_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] TXBW_40M_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yoohoo] TXBW_40M_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TXBW_80M_HiddenMenu(I)Z
    .locals 5
    .param p1, "ChannelNo"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yeongsu.wu] TXBW_80M_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TXBW_80M_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yeongsu.wu] TXBW_80M_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager][yeongsu.wu] TXBW_80M_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxBurstFrames_HiddenMenu(I)Z
    .locals 5
    .param p1, "FrameNumber"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxBurstFrames_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxBurstFrames_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxBurstFrames_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxBurstFrames_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxBurstInterval_HiddenMenu(I)Z
    .locals 5
    .param p1, "SIFS"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxBurstInterval_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxBurstInterval_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxBurstInterval_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxBurstInterval_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate11ac_HiddenMenu(IIII)Z
    .locals 5
    .param p1, "nDataRate"    # I
    .param p2, "nBandWidth"    # I
    .param p3, "nChannel"    # I
    .param p4, "nGI"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11ac_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3, p4}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate11ac_HiddenMenu(IIII)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11ac_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11ac_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate11n40M_HiddenMenu(III)Z
    .locals 5
    .param p1, "nDataRate"    # I
    .param p2, "nFrameFormat"    # I
    .param p3, "nGI"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n40M_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate11n40M_HiddenMenu(III)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n40M_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n40M_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate11n5G40M_HiddenMenu(III)Z
    .locals 5
    .param p1, "nDataRate"    # I
    .param p2, "nFrameFormat"    # I
    .param p3, "nGI"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n5G40M_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate11n5G40M_HiddenMenu(III)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n5G40M_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n5G40M_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate11n5G_HiddenMenu(III)Z
    .locals 5
    .param p1, "nDataRate"    # I
    .param p2, "nFrameFormat"    # I
    .param p3, "nGI"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n5G_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate11n5G_HiddenMenu(III)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n5G_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n5G_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate11n_HiddenMenu(III)Z
    .locals 5
    .param p1, "nDataRate"    # I
    .param p2, "nFrameFormat"    # I
    .param p3, "nGI"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate11n_HiddenMenu(III)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate11n_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate5G_HiddenMenu(Ljava/lang/String;)Z
    .locals 5
    .param p1, "Datarate"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate5G_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate5G_HiddenMenu(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate5G_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate5G_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDataRate_HiddenMenu(Ljava/lang/String;)Z
    .locals 5
    .param p1, "Datarate"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDataRate_HiddenMenu(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDataRate_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxDestAddress_HiddenMenu(Ljava/lang/String;)Z
    .locals 5
    .param p1, "dstMacAddr"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDestAddress_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxDestAddress_HiddenMenu(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDestAddress_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxDestAddress_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxGain_HiddenMenu(I)Z
    .locals 5
    .param p1, "TxGain"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxGain_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxGain_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxGain_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxGain_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxPER_HiddenMenu(Ljava/lang/String;)I
    .locals 5
    .param p1, "ifname"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v2, "WifiLgeExtManager"

    const-string v3, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "TxPER_HiddenMenu called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxPER_HiddenMenu(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "TxPER_HiddenMenu failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "TxPER_HiddenMenu failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxPayloadLength_HiddenMenu(I)Z
    .locals 5
    .param p1, "payLength"    # I

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxPayloadLength_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxPayloadLength_HiddenMenu(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxPayloadLength_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxPayloadLength_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxStart_HiddenMenu(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStart_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxStart_HiddenMenu(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStart_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStart_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TxStop_HiddenMenu(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WifiLgeExtManager;->getIWifiLgeExtManager()Lcom/lge/systemservice/core/IWifiLgeExtManager;

    move-result-object v1

    .local v1, "wifiLgExtMgr":Lcom/lge/systemservice/core/IWifiLgeExtManager;
    if-nez v1, :cond_0

    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] Cannot get IWifiLgeExtManager."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStop_HiddenMenu is called."

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWifiLgeExtManager;->TxStop_HiddenMenu(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStop_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "WifiLgeExtManager"

    const-string v4, "[WifiManager] TxStop_HiddenMenu is failed."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
