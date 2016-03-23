.class Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;
.super Landroid/os/FileObserver;
.source "WifiSapService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/wifiSap/WifiSapService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DhcpInfoFileObserver"
.end annotation


# instance fields
.field private mDhcpInfoFileName:Ljava/lang/String;

.field private mDhcpInfoFilePath:Ljava/lang/String;

.field final synthetic this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;


# direct methods
.method public constructor <init>(Lcom/lge/wifi/impl/wifiSap/WifiSapService;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "fileName"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    const/4 v0, 0x2

    invoke-direct {p0, p2, v0}, Landroid/os/FileObserver;-><init>(Ljava/lang/String;I)V

    iput-object p2, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->mDhcpInfoFilePath:Ljava/lang/String;

    iput-object p3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->mDhcpInfoFileName:Ljava/lang/String;

    const-string v0, "WifiSapService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DhcpInfoFileObserver ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->mDhcpInfoFilePath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public onEvent(ILjava/lang/String;)V
    .locals 4
    .param p1, "event"    # I
    .param p2, "path"    # Ljava/lang/String;

    .prologue
    if-nez p2, :cond_1

    const-string v1, "WifiSapService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DhcpInfoFileObserver onEvent("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", null)"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    and-int/lit8 v1, p1, 0x2

    if-eqz v1, :cond_0

    const-string v1, "WifiSapService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DhcpInfoFileObserver ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->mDhcpInfoFilePath:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " is modified"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->mDhcpInfoFileName:Ljava/lang/String;

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "WifiSapService"

    const-string v2, "DhcpInfoFile is changed"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->doesSupportHotspotList()Z

    move-result v1

    if-nez v1, :cond_2

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useCommonHotspotAPI()Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->updateApClientList()Z

    :cond_3
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intentDhcpInfo":Landroid/content/Intent;
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v1

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0
.end method

.method public startMonitoring()V
    .locals 2

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "DhcpInfoFileObserver startMonitoring()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->startWatching()V

    return-void
.end method

.method public stopMonitoring()V
    .locals 2

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "DhcpInfoFileObserver stopMonitoring()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->stopWatching()V

    return-void
.end method
