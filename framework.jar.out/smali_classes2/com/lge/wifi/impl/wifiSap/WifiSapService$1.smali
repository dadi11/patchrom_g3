.class Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;
.super Landroid/content/BroadcastReceiver;
.source "WifiSapService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/wifi/impl/wifiSap/WifiSapService;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;


# direct methods
.method constructor <init>(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)V
    .locals 0

    .prologue
    .line 488
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v7, 0x0

    const/16 v6, 0xb

    .line 491
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 493
    .local v0, "action":Ljava/lang/String;
    const-string v4, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 495
    const-string v4, "WifiSapService"

    const-string v5, "WifiSapService [ACTION_BOOT_COMPLETED]"

    invoke-static {v4, v5}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 501
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getOperator()Ljava/lang/String;

    move-result-object v4

    const-string v5, "VZW"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getCountry()Ljava/lang/String;

    move-result-object v4

    const-string v5, "US"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 504
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiHostapdApi:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$300(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;

    move-result-object v4

    invoke-virtual {v4}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SyncConfigVaules()V

    .line 556
    :cond_0
    :goto_0
    return-void

    .line 510
    :cond_1
    const-string v4, "android.net.wifi.WIFI_AP_STATE_CHANGED"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 520
    const-string v4, "WifiSapService"

    const-string v5, "BroadcastReceiver : WIFI_AP_STATE_CHANGED_ACTION"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 523
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    const-string/jumbo v5, "wifi_state"

    invoke-virtual {p2, v5, v6}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v5

    # setter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I
    invoke-static {v4, v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$202(Lcom/lge/wifi/impl/wifiSap/WifiSapService;I)I

    .line 525
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$200(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)I

    move-result v4

    const/16 v5, 0xd

    if-ne v4, v5, :cond_2

    .line 526
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiSapHandler:Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$400(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;

    move-result-object v4

    invoke-static {v4, v7}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {v4}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 528
    :cond_2
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$200(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)I

    move-result v4

    if-ne v4, v6, :cond_0

    .line 529
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiSapHandler:Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$400(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;

    move-result-object v4

    const/4 v5, 0x1

    invoke-static {v4, v5}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {v4}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 533
    :cond_3
    const-string v4, "android.net.conn.TETHER_STATE_CHANGED"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 534
    const-string/jumbo v4, "wifi.lge.mhp"

    invoke-static {v4, v7}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-nez v4, :cond_0

    .line 535
    const-string v4, "availableArray"

    invoke-virtual {p2, v4}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v2

    .line 537
    .local v2, "available":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const-string v4, "activeArray"

    invoke-virtual {p2, v4}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v1

    .line 539
    .local v1, "active":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const-string v4, "erroredArray"

    invoke-virtual {p2, v4}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v3

    .line 542
    .local v3, "errored":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiManager:Landroid/net/wifi/WifiManager;
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$500(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/net/wifi/WifiManager;

    move-result-object v4

    if-eqz v4, :cond_0

    .line 543
    const/16 v4, 0xa

    iget-object v5, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiManager:Landroid/net/wifi/WifiManager;
    invoke-static {v5}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$500(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/net/wifi/WifiManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/net/wifi/WifiManager;->getWifiApState()I

    move-result v5

    if-eq v4, v5, :cond_4

    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiManager:Landroid/net/wifi/WifiManager;
    invoke-static {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$500(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/net/wifi/WifiManager;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/wifi/WifiManager;->getWifiApState()I

    move-result v4

    if-ne v6, v4, :cond_0

    .line 546
    :cond_4
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$1;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    invoke-virtual {v4}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->removeMacFilterDenyList()I

    goto/16 :goto_0

    .line 553
    .end local v1    # "active":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v2    # "available":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v3    # "errored":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_5
    const-string v4, "WifiSapService"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "BroadcastReceiver : unknown Intent ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method