.class public Lcom/lge/wifi/impl/wifiSap/WifiSapService;
.super Lcom/lge/wifi/impl/wifiSap/IWifiSapManager$Stub;
.source "WifiSapService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;,
        Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;
    }
.end annotation


# static fields
.field private static final LOCAL_LOGD:Z = true

.field private static final TAG:Ljava/lang/String; = "WifiSapService"


# instance fields
.field private final mContext:Landroid/content/Context;

.field private final mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

.field private final mStations:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/net/wifi/ScanResult;",
            ">;"
        }
    .end annotation
.end field

.field private mWifiApState:I

.field private mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

.field private mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

.field private final mWifiManager:Landroid/net/wifi/WifiManager;

.field private mWifiSapHandler:Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/wifiSap/IWifiSapManager$Stub;-><init>()V

    const/16 v3, 0xb

    iput v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I

    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v3, "android.net.wifi.WIFI_AP_STATE_CHANGED"

    invoke-virtual {v0, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v3, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v0, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;

    const-string v4, "wifi"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/wifi/WifiManager;

    iput-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiManager:Landroid/net/wifi/WifiManager;

    new-instance v3, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-direct {v3, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    new-instance v2, Landroid/os/HandlerThread;

    const-string v3, "WifiSapService"

    invoke-direct {v2, v3}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .local v2, "wifiSapThread":Landroid/os/HandlerThread;
    invoke-virtual {v2}, Landroid/os/HandlerThread;->start()V

    invoke-virtual {v2}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    .local v1, "looper":Landroid/os/Looper;
    if-eqz v1, :cond_0

    new-instance v3, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;

    invoke-direct {v3, p0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapService;Landroid/os/Looper;)V

    iput-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiSapHandler:Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;

    new-instance v3, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiSapHandler:Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;

    invoke-direct {v3, v4}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;-><init>(Landroid/os/Handler;)V

    iput-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    :cond_0
    new-instance v3, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/misc/dhcp/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "dnsmasq.leases"

    invoke-direct {v3, p0, v4, v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapService;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;

    new-instance v4, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;

    invoke-direct {v4, p0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)V

    invoke-virtual {v3, v4, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$200(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .prologue
    iget v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I

    return v0
.end method

.method static synthetic access$202(Lcom/lge/wifi/impl/wifiSap/WifiSapService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I

    return p1
.end method

.method static synthetic access$300(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    return-object v0
.end method

.method static synthetic access$400(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiSapHandler:Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/net/wifi/WifiManager;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiManager:Landroid/net/wifi/WifiManager;

    return-object v0
.end method

.method private findDhcpAttribute([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "dhcpInfos"    # [Ljava/lang/String;
    .param p2, "MacAddress"    # Ljava/lang/String;

    .prologue
    new-instance v5, Ljava/lang/String;

    const-string v6, "void"

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .local v5, "result":Ljava/lang/String;
    :try_start_0
    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_WLAN] findDhcpAttribute Mac="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, p1

    .local v0, "arr$":[Ljava/lang/String;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_0
    if-ge v3, v4, :cond_0

    aget-object v1, v0, v3

    .local v1, "dhcpInfo":Ljava/lang/String;
    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_WLAN] findDhcpAttribute dhcpInfo"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    const/4 v7, -0x1

    if-le v6, v7, :cond_1

    move-object v5, v1

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "dhcpInfo":Ljava/lang/String;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    .end local v5    # "result":Ljava/lang/String;
    :cond_0
    :goto_1
    return-object v5

    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v1    # "dhcpInfo":Ljava/lang/String;
    .restart local v3    # "i$":I
    .restart local v4    # "len$":I
    .restart local v5    # "result":Ljava/lang/String;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "dhcpInfo":Ljava/lang/String;
    .end local v3    # "i$":I
    .end local v4    # "len$":I
    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/NullPointerException;
    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_WLAN] findDhcpAttribute NullPointerException =  "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private static nap(I)V
    .locals 4
    .param p0, "secs"    # I

    .prologue
    mul-int/lit16 v1, p0, 0x3e8

    int-to-long v2, v1

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "ignore":Ljava/lang/InterruptedException;
    const-string v1, "WifiSapService"

    const-string v2, "nap error"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private readDHCPInfo()[Ljava/lang/String;
    .locals 12

    .prologue
    const/4 v8, 0x0

    const-string v9, "WifiSapService"

    const-string v10, "[LGE_WLAN]  readDHCPInfo"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .local v2, "dhcpInfos":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v0, 0x0

    .local v0, "br":Ljava/io/BufferedReader;
    const/4 v4, 0x0

    .local v4, "fr":Ljava/io/FileReader;
    :try_start_0
    new-instance v5, Ljava/io/FileReader;

    const-string v9, "/data/misc/dhcp/dnsmasq.leases"

    invoke-direct {v5, v9}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_d
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v4    # "fr":Ljava/io/FileReader;
    .local v5, "fr":Ljava/io/FileReader;
    :try_start_1
    new-instance v1, Ljava/io/BufferedReader;

    invoke-direct {v1, v5}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_e
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_9
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local v0    # "br":Ljava/io/BufferedReader;
    .local v1, "br":Ljava/io/BufferedReader;
    :goto_0
    :try_start_2
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v7

    .local v7, "s":Ljava/lang/String;
    if-eqz v7, :cond_2

    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN]  "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_c
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_a
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_0

    .end local v7    # "s":Ljava/lang/String;
    :catch_0
    move-exception v3

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    .local v3, "e":Ljava/io/IOException;
    :goto_1
    :try_start_3
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo1 = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v0, :cond_0

    :try_start_4
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    :cond_0
    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/io/FileReader;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    .end local v3    # "e":Ljava/io/IOException;
    :cond_1
    :goto_2
    move-object v6, v8

    :goto_3
    return-object v6

    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    .restart local v7    # "s":Ljava/lang/String;
    :cond_2
    :try_start_5
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_5 .. :try_end_5} :catch_c
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_a
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    move-result v9

    const/4 v10, 0x1

    if-ge v9, v10, :cond_5

    if-eqz v1, :cond_3

    :try_start_6
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    :cond_3
    if-eqz v5, :cond_4

    invoke-virtual {v5}, Ljava/io/FileReader;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    :cond_4
    :goto_4
    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    move-object v6, v8

    goto :goto_3

    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_1
    move-exception v3

    .local v3, "e":Ljava/lang/Exception;
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo close = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_4

    .end local v3    # "e":Ljava/lang/Exception;
    :cond_5
    :try_start_7
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v9

    new-array v6, v9, [Ljava/lang/String;

    .local v6, "result":[Ljava/lang/String;
    invoke-virtual {v2, v6}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v6

    .end local v6    # "result":[Ljava/lang/String;
    check-cast v6, [Ljava/lang/String;
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_7 .. :try_end_7} :catch_c
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_a
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .restart local v6    # "result":[Ljava/lang/String;
    if-eqz v1, :cond_6

    :try_start_8
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    :cond_6
    if-eqz v5, :cond_7

    invoke-virtual {v5}, Ljava/io/FileReader;->close()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2

    :cond_7
    :goto_5
    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    goto :goto_3

    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_2
    move-exception v3

    .restart local v3    # "e":Ljava/lang/Exception;
    const-string v8, "WifiSapService"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[LGE_WLAN] readDHCPInfo close = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_5

    .end local v1    # "br":Ljava/io/BufferedReader;
    .end local v5    # "fr":Ljava/io/FileReader;
    .end local v6    # "result":[Ljava/lang/String;
    .end local v7    # "s":Ljava/lang/String;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    .local v3, "e":Ljava/io/IOException;
    .restart local v4    # "fr":Ljava/io/FileReader;
    :catch_3
    move-exception v3

    .local v3, "e":Ljava/lang/Exception;
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo close = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .end local v3    # "e":Ljava/lang/Exception;
    :catch_4
    move-exception v3

    .local v3, "e":Ljava/lang/NullPointerException;
    :goto_6
    :try_start_9
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo2 = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    if-eqz v0, :cond_8

    :try_start_a
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    :cond_8
    if-eqz v4, :cond_9

    invoke-virtual {v4}, Ljava/io/FileReader;->close()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_5

    .end local v3    # "e":Ljava/lang/NullPointerException;
    :cond_9
    :goto_7
    move-object v6, v8

    goto/16 :goto_3

    .restart local v3    # "e":Ljava/lang/NullPointerException;
    :catch_5
    move-exception v3

    .local v3, "e":Ljava/lang/Exception;
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo close = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_7

    .end local v3    # "e":Ljava/lang/Exception;
    :catch_6
    move-exception v3

    .restart local v3    # "e":Ljava/lang/Exception;
    :goto_8
    :try_start_b
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo3= "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    if-eqz v0, :cond_a

    :try_start_c
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    :cond_a
    if-eqz v4, :cond_b

    invoke-virtual {v4}, Ljava/io/FileReader;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_7

    :cond_b
    :goto_9
    move-object v6, v8

    goto/16 :goto_3

    :catch_7
    move-exception v3

    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo close = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_9

    .end local v3    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v8

    :goto_a
    if-eqz v0, :cond_c

    :try_start_d
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    :cond_c
    if-eqz v4, :cond_d

    invoke-virtual {v4}, Ljava/io/FileReader;->close()V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_8

    :cond_d
    :goto_b
    throw v8

    :catch_8
    move-exception v3

    .restart local v3    # "e":Ljava/lang/Exception;
    const-string v9, "WifiSapService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[LGE_WLAN] readDHCPInfo close = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_b

    .end local v3    # "e":Ljava/lang/Exception;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catchall_1
    move-exception v8

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    goto :goto_a

    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catchall_2
    move-exception v8

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    goto :goto_a

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_9
    move-exception v3

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    goto :goto_8

    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_a
    move-exception v3

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    goto :goto_8

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_b
    move-exception v3

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    goto/16 :goto_6

    .end local v0    # "br":Ljava/io/BufferedReader;
    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_c
    move-exception v3

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    goto/16 :goto_6

    :catch_d
    move-exception v3

    goto/16 :goto_1

    .end local v4    # "fr":Ljava/io/FileReader;
    .restart local v5    # "fr":Ljava/io/FileReader;
    :catch_e
    move-exception v3

    move-object v4, v5

    .end local v5    # "fr":Ljava/io/FileReader;
    .restart local v4    # "fr":Ljava/io/FileReader;
    goto/16 :goto_1
.end method


# virtual methods
.method public MacFilterremoveAllowedList(Ljava/lang/String;)I
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->MacFilterremoveAllowedList(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public MacFilterremoveDeniedList(Ljava/lang/String;)I
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->MacFilterremoveDeniedList(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public addMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->AddMacFilterAllowList(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public addMacFilterDenyList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->AddMacFilterDenyList(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public enableSoftAp(Z)Z
    .locals 4
    .param p1, "bEnable"    # Z

    .prologue
    const/4 v3, 0x1

    if-ne v3, p1, :cond_1

    const-string v1, "WifiSapService"

    const-string v2, "enableSoftAp startMonitoring"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->startMonitoring()V

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->startMonitoring()V

    :goto_0
    if-ne v3, p1, :cond_2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->getSoftApStatus()Z

    move-result v1

    if-ne v3, v1, :cond_2

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetCommit()Z

    move-result v0

    :cond_0
    :goto_1
    return v0

    :cond_1
    const-string v1, "WifiSapService"

    const-string v2, "enableSoftAp stopMonitoring"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->stopMonitoring()V

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->stopMonitoring()V

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->EnableSoftAp(Z)Z

    move-result v0

    .local v0, "ret":Z
    if-nez p1, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->stopMonitoring()V

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->stopMonitoring()V

    goto :goto_1
.end method

.method public enableSoftApWifiCfg(ZLandroid/net/wifi/WifiConfiguration;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "bEnable"    # Z
    .param p2, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p3, "wlanIface"    # Ljava/lang/String;
    .param p4, "softapIface"    # Ljava/lang/String;

    .prologue
    const/4 v2, -0x1

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-ne v1, p1, :cond_3

    if-eqz p2, :cond_1

    invoke-virtual {p0, p2, v2, v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setSoftApWifiCfg(Landroid/net/wifi/WifiConfiguration;IIZ)Z

    move-result v2

    if-eq v1, v2, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-virtual {p0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->enableSoftAp(Z)Z

    move-result v2

    if-ne v1, v2, :cond_0

    :cond_2
    move v0, v1

    goto :goto_0

    :cond_3
    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->enableSoftAp(Z)Z

    move-result v2

    if-eq v1, v2, :cond_2

    goto :goto_0
.end method

.method public getAllAssocMacList()[Ljava/lang/String;
    .locals 8

    .prologue
    const/4 v0, 0x0

    .local v0, "count":I
    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->getAssoStaMacListCount()I

    move-result v0

    new-array v5, v0, [Ljava/lang/String;

    .local v5, "macList":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v7, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/wifi/ScanResult;

    .local v4, "iface":Landroid/net/wifi/ScanResult;
    iget-object v6, v4, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    .local v6, "macaddr":Ljava/lang/String;
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "i":I
    .local v2, "i":I
    aput-object v6, v5, v1

    move v1, v2

    .end local v2    # "i":I
    .restart local v1    # "i":I
    goto :goto_0

    .end local v4    # "iface":Landroid/net/wifi/ScanResult;
    .end local v6    # "macaddr":Ljava/lang/String;
    :cond_0
    return-object v5
.end method

.method public getAllAssocMacListATT()Ljava/util/List;
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
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    return-object v0
.end method

.method public getAllAssocMacListVZW()Ljava/util/List;
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
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    return-object v0
.end method

.method public getAssoStaMacListCount()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    const-string v0, ""

    .local v0, "deviceIp":Ljava/lang/String;
    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    if-nez v3, :cond_0

    const-string v3, ""

    :goto_0
    return-object v3

    :cond_0
    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/wifi/ScanResult;

    .local v2, "iface":Landroid/net/wifi/ScanResult;
    if-eqz p1, :cond_1

    iget-object v3, v2, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v0, v2, Landroid/net/wifi/ScanResult;->capabilities:Ljava/lang/String;

    .end local v2    # "iface":Landroid/net/wifi/ScanResult;
    :cond_2
    const-string v3, "WifiSapService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[NEZZIMOM] deviceIp : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v0, :cond_3

    move-object v3, v0

    goto :goto_0

    :cond_3
    const-string v3, ""

    goto :goto_0
.end method

.method public getAutoShutOffTime()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetAutoShutOffTime()I

    move-result v0

    return v0
.end method

.method public getChannel()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetChannel()I

    move-result v0

    return v0
.end method

.method public getCountryCode()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetCountryCode()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getHiddenSsid()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetHiddenSsid()Z

    move-result v0

    return v0
.end method

.method public getMacFilterByIndex(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetMacFilterByIndex(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMacFilterCount()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetMacFilterCount()I

    move-result v0

    return v0
.end method

.method public getMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;
    .locals 2

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)V

    return-object v0
.end method

.method public getMaxNumOfClients()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetMaxNumOfClients()I

    move-result v0

    return v0
.end method

.method public getOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;
    .locals 2

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;)V

    return-object v0
.end method

.method public getPrivacySeparator()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetApIsolation()Z

    move-result v0

    return v0
.end method

.method public getSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    .locals 5

    .prologue
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;

    move-result-object v0

    .local v0, "secType":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;
    new-instance v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v2

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v3

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    return-object v1
.end method

.method public getSoftApStatus()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetSoftApStatus()Z

    move-result v0

    return v0
.end method

.method public getSsid()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetSsid()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWepKey1()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetWepKey1()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWepKey2()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetWepKey2()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWepKey3()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetWepKey3()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWepKey4()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetWepKey4()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWepKeyIndex()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetWepKeyIndex()I

    move-result v0

    return v0
.end method

.method public getWpaKey()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetWpaKey()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWpsNfcConfTokenFromAP(II)Ljava/lang/String;
    .locals 2
    .param p1, "isEnabled"    # I
    .param p2, "isNDEF"    # I

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "WPS : getWpsNfcConfTokenFromAP"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->getWpsNfcConfTokenFromAP(II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWpsNfcHandoverSelect(I)Ljava/lang/String;
    .locals 2
    .param p1, "isNDEF"    # I

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "WPS : getWpsNfcHandoverSelect"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->getWpsNfcHandoverSelect(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public removeAlltheList()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->removeAlltheList()I

    move-result v0

    return v0
.end method

.method public removeMacFilterAllowList()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->removeMacFilterAllowList()I

    move-result v0

    return v0
.end method

.method public removeMacFilterDenyList()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->removeMacFilterDenyList()I

    move-result v0

    return v0
.end method

.method public setAutoShutOffTime(I)Z
    .locals 1
    .param p1, "time"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAutoShutOffTime(I)Z

    move-result v0

    return v0
.end method

.method public setChannel(I)Z
    .locals 1
    .param p1, "channel"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetChannel(I)Z

    move-result v0

    return v0
.end method

.method public setCountryCode(Ljava/lang/String;)Z
    .locals 1
    .param p1, "countryCode"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetCountryCode(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setDisassociateStation(Ljava/lang/String;)Z
    .locals 1
    .param p1, "staMac"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetDisassociateStation(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setHiddenSsid(Z)Z
    .locals 1
    .param p1, "hiddenSsid"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetHiddenSsid(Z)Z

    move-result v0

    return v0
.end method

.method public setMacFilterByIndex(ILjava/lang/String;)Z
    .locals 1
    .param p1, "index"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetMacFilterByIndex(ILjava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setMacFilterCount(I)Z
    .locals 1
    .param p1, "filterCount"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetMacFilterCount(I)Z

    move-result v0

    return v0
.end method

.method public setMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;)Z
    .locals 2
    .param p1, "filterMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterModeP;->getFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)Z

    move-result v0

    return v0
.end method

.method public setMacaddracl(I)Z
    .locals 2
    .param p1, "value"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_mac_acl"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setMacaddracl(I)Z

    move-result v0

    return v0
.end method

.method public setMaxNumOfClients(I)Z
    .locals 1
    .param p1, "numClient"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetMaxNumOfClients(I)Z

    move-result v0

    return v0
.end method

.method public setNstartMonitoring(ZLandroid/net/wifi/WifiConfiguration;II)Z
    .locals 2
    .param p1, "bEnable"    # Z
    .param p2, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p3, "channel"    # I
    .param p4, "maxScb"    # I

    .prologue
    const/4 v1, 0x1

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->doesSupportHotspotList()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useCommonHotspotAPI()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_1
    if-ne v1, p1, :cond_2

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->startMonitoring()V

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->startMonitoring()V

    :goto_0
    return v1

    :cond_2
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdMonitor:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->stopMonitoring()V

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mDhcpInfoFileObserver:Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService$DhcpInfoFileObserver;->stopMonitoring()V

    goto :goto_0
.end method

.method public setOperationMode(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;)Z
    .locals 2
    .param p1, "opMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->getOpMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetOperationMode(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;)Z

    move-result v0

    return v0
.end method

.method public setPrivacySeparator(Z)Z
    .locals 1
    .param p1, "privacySep"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetApIsolation(Z)Z

    move-result v0

    return v0
.end method

.method public setSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;)Z
    .locals 5
    .param p1, "secType"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    new-instance v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;

    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v2

    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v3

    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;)Z

    move-result v0

    return v0
.end method

.method public setSoftApWifiCfg(Landroid/net/wifi/WifiConfiguration;IIZ)Z
    .locals 10
    .param p1, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p2, "channel"    # I
    .param p3, "maxScb"    # I
    .param p4, "bWoNmService"    # Z

    .prologue
    const/4 v9, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz p1, :cond_a

    if-ne v3, p4, :cond_2

    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    iget-object v5, p1, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateSsid(Ljava/lang/String;)V

    :cond_0
    const/4 v0, 0x0

    .local v0, "phassphrase":Ljava/lang/String;
    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    invoke-virtual {v4, v3}, Ljava/util/BitSet;->get(I)Z

    move-result v4

    if-ne v3, v4, :cond_3

    new-instance v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    sget-object v4, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    sget-object v6, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->TKIP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    invoke-direct {v1, v4, v5, v6}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    .local v1, "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    iget-object v0, p1, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    :goto_0
    if-ne v3, p4, :cond_6

    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    new-instance v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v6

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v7

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v8

    invoke-direct {v5, v6, v7, v8}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    invoke-virtual {v4, v5}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;)Z

    :cond_1
    if-eqz v0, :cond_7

    if-eq v3, p4, :cond_8

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setWpaKey(Ljava/lang/String;)Z

    move-result v4

    if-eq v3, v4, :cond_8

    .end local v0    # "phassphrase":Ljava/lang/String;
    .end local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    :goto_1
    return v2

    :cond_2
    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-virtual {p0, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setSsid(Ljava/lang/String;)Z

    move-result v4

    if-eq v3, v4, :cond_0

    goto :goto_1

    .restart local v0    # "phassphrase":Ljava/lang/String;
    :cond_3
    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->allowedKeyManagement:Ljava/util/BitSet;

    const/4 v5, 0x4

    invoke-virtual {v4, v5}, Ljava/util/BitSet;->get(I)Z

    move-result v4

    if-ne v3, v4, :cond_4

    new-instance v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    sget-object v4, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WPA2_PSK:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    sget-object v6, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->CCMP:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    invoke-direct {v1, v4, v5, v6}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    .restart local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    iget-object v0, p1, Landroid/net/wifi/WifiConfiguration;->preSharedKey:Ljava/lang/String;

    goto :goto_0

    .end local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    :cond_4
    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    aget-object v4, v4, v2

    if-nez v4, :cond_5

    new-instance v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    sget-object v4, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    sget-object v6, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    invoke-direct {v1, v4, v5, v6}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    .restart local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    goto :goto_0

    .end local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    :cond_5
    new-instance v1, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;

    sget-object v4, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    sget-object v5, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    sget-object v6, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    invoke-direct {v1, v4, v5, v6}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    .restart local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    goto :goto_0

    :cond_6
    invoke-virtual {p0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;)Z

    move-result v4

    if-eq v3, v4, :cond_1

    goto :goto_1

    :cond_7
    sget-object v4, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->WEP:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v5

    if-ne v4, v5, :cond_8

    iget v4, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    invoke-virtual {p0, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setWepKeyIndex(I)Z

    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    iget v5, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    aget-object v4, v4, v5

    if-eqz v4, :cond_8

    iget v4, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    if-nez v4, :cond_b

    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    iget v5, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    aget-object v4, v4, v5

    invoke-virtual {p0, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setWepKey1(Ljava/lang/String;)Z

    :cond_8
    :goto_2
    iget-boolean v4, p1, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    if-ne v3, v4, :cond_e

    invoke-virtual {p0, v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setHiddenSsid(Z)Z

    :goto_3
    if-eq v9, p2, :cond_9

    if-nez p2, :cond_f

    const/4 v2, 0x6

    invoke-virtual {p0, v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setChannel(I)Z

    :cond_9
    :goto_4
    if-eq v9, p3, :cond_a

    if-nez p2, :cond_10

    const/4 v2, 0x5

    invoke-virtual {p0, v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setMaxNumOfClients(I)Z

    .end local v0    # "phassphrase":Ljava/lang/String;
    .end local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    :cond_a
    :goto_5
    move v2, v3

    goto :goto_1

    .restart local v0    # "phassphrase":Ljava/lang/String;
    .restart local v1    # "secTypeP":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityTypeP;
    :cond_b
    iget v4, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    if-ne v4, v3, :cond_c

    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    iget v5, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    aget-object v4, v4, v5

    invoke-virtual {p0, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setWepKey2(Ljava/lang/String;)Z

    goto :goto_2

    :cond_c
    iget v4, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    const/4 v5, 0x2

    if-ne v4, v5, :cond_d

    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    iget v5, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    aget-object v4, v4, v5

    invoke-virtual {p0, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setWepKey3(Ljava/lang/String;)Z

    goto :goto_2

    :cond_d
    iget v4, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    const/4 v5, 0x3

    if-ne v4, v5, :cond_8

    iget-object v4, p1, Landroid/net/wifi/WifiConfiguration;->wepKeys:[Ljava/lang/String;

    iget v5, p1, Landroid/net/wifi/WifiConfiguration;->wepTxKeyIndex:I

    aget-object v4, v4, v5

    invoke-virtual {p0, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setWepKey4(Ljava/lang/String;)Z

    goto :goto_2

    :cond_e
    invoke-virtual {p0, v2}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setHiddenSsid(Z)Z

    goto :goto_3

    :cond_f
    invoke-virtual {p0, p2}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setChannel(I)Z

    goto :goto_4

    :cond_10
    invoke-virtual {p0, p3}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setMaxNumOfClients(I)Z

    goto :goto_5
.end method

.method public setSsid(Ljava/lang/String;)Z
    .locals 1
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetSsid(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setTxPower(I)I
    .locals 1
    .param p1, "txPower"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setTxPower(I)I

    move-result v0

    return v0
.end method

.method public setWepKey1(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetWepKey1(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setWepKey2(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetWepKey2(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setWepKey3(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetWepKey3(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setWepKey4(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetWepKey4(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setWepKeyIndex(I)Z
    .locals 1
    .param p1, "index"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetWepKeyIndex(I)Z

    move-result v0

    return v0
.end method

.method public setWpaKey(Ljava/lang/String;)Z
    .locals 1
    .param p1, "phassphrase"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetWpaKey(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setWpsCancel()I
    .locals 2

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "WPS : setWpsCancel"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setWpsCancel()I

    move-result v0

    return v0
.end method

.method public setWpsNfcPwToken(Ljava/lang/String;II)I
    .locals 2
    .param p1, "NDEF"    # Ljava/lang/String;
    .param p2, "isEnabled"    # I
    .param p3, "isNDEF"    # I

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "WPS : setWpsNfcPwToken"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setWpsNfcPwToken(Ljava/lang/String;II)I

    move-result v0

    return v0
.end method

.method public setWpsNfcReportHandover(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p1, "reqNDEF"    # Ljava/lang/String;
    .param p2, "selNDEF"    # Ljava/lang/String;

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "WPS : setWpsNfcReportHandover"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setWpsNfcReportHandover(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setWpsPbc()I
    .locals 2

    .prologue
    const-string v0, "WifiSapService"

    const-string v1, "WPS : setWpsPbc"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setWpsPbc()I

    move-result v0

    return v0
.end method

.method public setWpsPin(Ljava/lang/String;I)I
    .locals 3
    .param p1, "PinNum"    # Ljava/lang/String;
    .param p2, "expirationTime"    # I

    .prologue
    const-string v0, "WifiSapService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WPS : setWpsPin expiretime is["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] PinNum is["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->setWpsPin(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public declared-synchronized updateApClientList()Z
    .locals 22

    .prologue
    monitor-enter p0

    :try_start_0
    new-instance v11, Ljava/lang/String;

    const-string v6, "Unknown host name"

    invoke-direct {v11, v6}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .local v11, "devName":Ljava/lang/String;
    new-instance v5, Ljava/lang/String;

    const-string v6, "Unknown"

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .local v5, "ipAddress":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "wifiSsid":Landroid/net/wifi/WifiSsid;
    const/16 v19, 0x0

    .local v19, "reply":Ljava/lang/String;
    new-instance v21, Ljava/util/ArrayList;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    move-object/from16 v0, v21

    invoke-direct {v0, v6}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .local v21, "tmpStations":Ljava/util/List;, "Ljava/util/List<Landroid/net/wifi/ScanResult;>;"
    const-string v6, "WifiSapService"

    const-string v7, "[LGE_WLAN] updateApClientList  "

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v6, "PING"

    invoke-static {v6}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->doStringCommandNative(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "reply: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    move-object/from16 v0, v19

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct/range {p0 .. p0}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->readDHCPInfo()[Ljava/lang/String;

    move-result-object v14

    .local v14, "dhcpInfos":[Ljava/lang/String;
    if-nez v14, :cond_0

    const-string v6, "WifiSapService"

    const-string v7, "Read Failed to DHCP Info file"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const-string v6, "WifiSapService"

    const-string v7, "[LGE_WLAN] getAllSta  "

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v6, "WifiSapService"

    const-string v7, "[LGE_WLAN] updateApClientList  "

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v20, 0x0

    .local v20, "stations":[Ljava/lang/String;
    const/4 v6, 0x1

    invoke-static {v6}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->nap(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->getAllSta()Ljava/lang/String;

    move-result-object v6

    const-string v7, "\\n"

    invoke-virtual {v6, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v20

    :goto_0
    :try_start_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->clear()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v20, :cond_1

    const/4 v6, 0x0

    :goto_1
    monitor-exit p0

    return v6

    :catch_0
    move-exception v15

    .local v15, "e":Ljava/lang/NullPointerException;
    :try_start_3
    const-string v6, "WifiSapService"

    const-string v7, "[LGE_WLAN] There is no client "

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .end local v3    # "wifiSsid":Landroid/net/wifi/WifiSsid;
    .end local v5    # "ipAddress":Ljava/lang/String;
    .end local v11    # "devName":Ljava/lang/String;
    .end local v14    # "dhcpInfos":[Ljava/lang/String;
    .end local v15    # "e":Ljava/lang/NullPointerException;
    .end local v19    # "reply":Ljava/lang/String;
    .end local v20    # "stations":[Ljava/lang/String;
    .end local v21    # "tmpStations":Ljava/util/List;, "Ljava/util/List<Landroid/net/wifi/ScanResult;>;"
    :catchall_0
    move-exception v6

    monitor-exit p0

    throw v6

    .restart local v3    # "wifiSsid":Landroid/net/wifi/WifiSsid;
    .restart local v5    # "ipAddress":Ljava/lang/String;
    .restart local v11    # "devName":Ljava/lang/String;
    .restart local v14    # "dhcpInfos":[Ljava/lang/String;
    .restart local v19    # "reply":Ljava/lang/String;
    .restart local v20    # "stations":[Ljava/lang/String;
    .restart local v21    # "tmpStations":Ljava/util/List;, "Ljava/util/List<Landroid/net/wifi/ScanResult;>;"
    :cond_1
    :try_start_4
    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_WLAN] getAllSta count = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    move-object/from16 v0, v20

    array-length v8, v0

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v10, v20

    .local v10, "arr$":[Ljava/lang/String;
    array-length v0, v10

    move/from16 v18, v0

    .local v18, "len$":I
    const/16 v17, 0x0

    .local v17, "i$":I
    :goto_2
    move/from16 v0, v17

    move/from16 v1, v18

    if-ge v0, v1, :cond_5

    aget-object v4, v10, v17

    .local v4, "iface":Ljava/lang/String;
    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_WLAN] StationList =  "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v14, :cond_4

    move-object/from16 v0, p0

    invoke-direct {v0, v14, v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->findDhcpAttribute([Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .local v12, "dhcpInfo":Ljava/lang/String;
    const-string v6, " "

    invoke-virtual {v12, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v13

    .local v13, "dhcpInfoElement":[Ljava/lang/String;
    array-length v6, v13

    const/4 v7, 0x4

    if-lt v6, v7, :cond_4

    const/4 v6, 0x1

    aget-object v6, v13, v6

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    const-string v6, "WifiSapService"

    const-string v7, "[LGE_WLAN] Found dhcpinfo matched to Mac"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v6, 0x3

    aget-object v11, v13, v6

    const-string v6, "WifiSapService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_WLAN] devName =  "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v6, "*"

    invoke-virtual {v11, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    const/16 v16, 0x0

    .local v16, "i":I
    :goto_3
    invoke-interface/range {v21 .. v21}, Ljava/util/List;->size()I

    move-result v6

    move/from16 v0, v16

    if-ge v0, v6, :cond_3

    move-object/from16 v0, v21

    move/from16 v1, v16

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/net/wifi/ScanResult;

    iget-object v6, v6, Landroid/net/wifi/ScanResult;->BSSID:Ljava/lang/String;

    invoke-virtual {v6, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    move-object/from16 v0, v21

    move/from16 v1, v16

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/net/wifi/ScanResult;

    iget-object v6, v6, Landroid/net/wifi/ScanResult;->wifiSsid:Landroid/net/wifi/WifiSsid;

    invoke-virtual {v6}, Landroid/net/wifi/WifiSsid;->toString()Ljava/lang/String;

    move-result-object v11

    const-string v6, "WifiSapService"

    const-string v7, "[LGE_WLAN] devName is changed to \"*\" so restore prev name"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    add-int/lit8 v16, v16, 0x1

    goto :goto_3

    .end local v16    # "i":I
    :cond_3
    const/4 v6, 0x2

    aget-object v5, v13, v6

    invoke-static {v11}, Landroid/net/wifi/WifiSsidEx;->createFromAsciiEncoded(Ljava/lang/String;)Landroid/net/wifi/WifiSsid;

    move-result-object v3

    .end local v12    # "dhcpInfo":Ljava/lang/String;
    .end local v13    # "dhcpInfoElement":[Ljava/lang/String;
    :cond_4
    new-instance v2, Landroid/net/wifi/ScanResult;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const-wide/16 v8, 0x0

    invoke-direct/range {v2 .. v9}, Landroid/net/wifi/ScanResult;-><init>(Landroid/net/wifi/WifiSsid;Ljava/lang/String;Ljava/lang/String;IIJ)V

    .local v2, "client":Landroid/net/wifi/ScanResult;
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;

    invoke-interface {v6, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v17, v17, 0x1

    goto/16 :goto_2

    .end local v2    # "client":Landroid/net/wifi/ScanResult;
    .end local v4    # "iface":Ljava/lang/String;
    :cond_5
    invoke-interface/range {v21 .. v21}, Ljava/util/List;->clear()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    const/4 v6, 0x1

    goto/16 :goto_1
.end method
