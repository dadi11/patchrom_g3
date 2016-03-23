.class Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;
.super Landroid/os/Handler;
.source "WifiSapService.java"

# interfaces
.implements Lcom/lge/wifi/impl/wifiSap/WifiSapTypes;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/wifiSap/WifiSapService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "WifiSapHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;


# direct methods
.method public constructor <init>(Lcom/lge/wifi/impl/wifiSap/WifiSapService;Landroid/os/Looper;)V
    .locals 0
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    .line 147
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    .line 148
    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 149
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 25
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 153
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->what:I

    move/from16 v22, v0

    packed-switch v22, :pswitch_data_0

    .line 359
    :cond_0
    :goto_0
    return-void

    .line 156
    :pswitch_0
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_AP_ENABLED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 162
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getOperator()Ljava/lang/String;

    move-result-object v22

    const-string v23, "CMCC"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v22

    if-eqz v22, :cond_1

    .line 164
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    const-string v23, "connectivity"

    invoke-virtual/range {v22 .. v23}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/ConnectivityManager;

    .line 165
    .local v5, "cm":Landroid/net/ConnectivityManager;
    if-eqz v5, :cond_1

    invoke-virtual {v5}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z

    move-result v22

    if-nez v22, :cond_1

    .line 167
    const-string v22, "WifiSapService"

    const-string v23, "Enable Mobile Data"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 182
    .end local v5    # "cm":Landroid/net/ConnectivityManager;
    :cond_1
    new-instance v10, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.ENABLED"

    move-object/from16 v0, v22

    invoke-direct {v10, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 183
    .local v10, "intentApEnabled":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v10, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0

    .line 187
    .end local v10    # "intentApEnabled":Landroid/content/Intent;
    :pswitch_1
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_AP_DISABLED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 191
    new-instance v9, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.DISABLED"

    move-object/from16 v0, v22

    invoke-direct {v9, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 192
    .local v9, "intentApDisabled":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v9, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 195
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useCommonHotspotAPI()Z

    move-result v22

    if-eqz v22, :cond_2

    .line 196
    const-string v22, "WifiSapService"

    const-string v23, "[LG Common UI] mStations.clear()"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$100(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Ljava/util/List;

    move-result-object v22

    invoke-interface/range {v22 .. v22}, Ljava/util/List;->clear()V

    .line 207
    :cond_2
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getOperator()Ljava/lang/String;

    move-result-object v22

    const-string v23, "VZW"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v22

    if-nez v22, :cond_3

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->doesSupportHotspotList()Z

    move-result v22

    if-eqz v22, :cond_0

    :cond_3
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getCountry()Ljava/lang/String;

    move-result-object v22

    const-string v23, "US"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v22

    if-eqz v22, :cond_0

    .line 212
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mStations:Ljava/util/List;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$100(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Ljava/util/List;

    move-result-object v22

    invoke-interface/range {v22 .. v22}, Ljava/util/List;->clear()V

    goto/16 :goto_0

    .line 219
    .end local v9    # "intentApDisabled":Landroid/content/Intent;
    :pswitch_2
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_STA_ASSOCIATED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 224
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->doesSupportHotspotList()Z

    move-result v22

    if-nez v22, :cond_4

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useCommonHotspotAPI()Z

    move-result v22

    if-eqz v22, :cond_0

    .line 225
    :cond_4
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useCommonHotspotAPI()Z

    move-result v22

    if-eqz v22, :cond_5

    .line 226
    const-string v22, "WifiSapService"

    const-string v23, "[LG Common UI] handleMessage [MESSAGE_STA_ASSOCIATED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 228
    :cond_5
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->updateApClientList()Z

    .line 230
    new-instance v17, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_STATION_ASSOC"

    move-object/from16 v0, v17

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 231
    .local v17, "intentStaAss":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v17

    move-object/from16 v2, v23

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 238
    .end local v17    # "intentStaAss":Landroid/content/Intent;
    :pswitch_3
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_STA_DISASSOCIATED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 243
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->doesSupportHotspotList()Z

    move-result v22

    if-nez v22, :cond_6

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useCommonHotspotAPI()Z

    move-result v22

    if-eqz v22, :cond_0

    .line 244
    :cond_6
    const/16 v22, 0xa

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v23, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mWifiApState:I
    invoke-static/range {v23 .. v23}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$200(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)I

    move-result v23

    move/from16 v0, v22

    move/from16 v1, v23

    if-eq v0, v1, :cond_7

    .line 245
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->updateApClientList()Z

    .line 248
    :cond_7
    new-instance v18, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_STATION_DISASSOC"

    move-object/from16 v0, v18

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 250
    .local v18, "intentStaDisass":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v18

    move-object/from16 v2, v23

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 256
    .end local v18    # "intentStaDisass":Landroid/content/Intent;
    :pswitch_4
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_STA_MAX_REACHED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 260
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->doesSupportHotspotList()Z

    move-result v22

    if-eqz v22, :cond_0

    .line 261
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->updateApClientList()Z

    .line 262
    new-instance v19, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_MAX_REACHED"

    move-object/from16 v0, v19

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 264
    .local v19, "intentStaMaxReached":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v19

    move-object/from16 v2, v23

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 269
    .end local v19    # "intentStaMaxReached":Landroid/content/Intent;
    :pswitch_5
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_CONNECTED]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 272
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getOperator()Ljava/lang/String;

    move-result-object v22

    const-string v23, "TMO"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v22

    if-nez v22, :cond_8

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getOperator()Ljava/lang/String;

    move-result-object v22

    const-string v23, "MPCS"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v22

    if-eqz v22, :cond_9

    :cond_8
    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->getCountry()Ljava/lang/String;

    move-result-object v22

    const-string v23, "US"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v22

    if-eqz v22, :cond_9

    .line 274
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v22

    const-string/jumbo v23, "wifi_ap_broadcast_channel"

    const/16 v24, 0x0

    invoke-static/range {v22 .. v24}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v6

    .line 275
    .local v6, "defaultChannel":I
    new-instance v7, Landroid/content/IntentFilter;

    const-string v22, "android.intent.action.BATTERY_CHANGED"

    move-object/from16 v0, v22

    invoke-direct {v7, v0}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 276
    .local v7, "filter":Landroid/content/IntentFilter;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    const/16 v23, 0x0

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v1, v7}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    move-result-object v3

    .line 277
    .local v3, "BatteryState":Landroid/content/Intent;
    const-string v22, "status"

    const/16 v23, -0x1

    move-object/from16 v0, v22

    move/from16 v1, v23

    invoke-virtual {v3, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v4

    .line 278
    .local v4, "chargeState":I
    const-string v22, "WifiSapService"

    const-string v23, "[txPowerMode] Charging : 2 FULL : 5"

    invoke-static/range {v22 .. v23}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 279
    const-string v22, "WifiSapService"

    new-instance v23, Ljava/lang/StringBuilder;

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuilder;-><init>()V

    const-string v24, "[txPowerMode] Current State : "

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    invoke-static/range {v22 .. v23}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 281
    packed-switch v4, :pswitch_data_1

    .line 292
    :pswitch_6
    const-string v22, "WifiSapService"

    new-instance v23, Ljava/lang/StringBuilder;

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuilder;-><init>()V

    const-string v24, "[txPowerMode] Current State : "

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    invoke-static/range {v22 .. v23}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 293
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v22

    const-string/jumbo v23, "wifi_ap_power_mode_high"

    const/16 v24, 0x0

    invoke-static/range {v22 .. v24}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v21

    .line 296
    .local v21, "txPowerMode":I
    :goto_1
    const-string v22, "WifiSapService"

    new-instance v23, Ljava/lang/StringBuilder;

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuilder;-><init>()V

    const-string v24, "[txPowerMode] : "

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    invoke-static/range {v22 .. v23}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 297
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    move/from16 v0, v21

    invoke-static {v0, v6}, Lcom/lge/wifi/config/LgeWifiConfig;->getTxPowerValue(II)I

    move-result v23

    invoke-virtual/range {v22 .. v23}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->setTxPower(I)I

    .line 300
    .end local v3    # "BatteryState":Landroid/content/Intent;
    .end local v4    # "chargeState":I
    .end local v6    # "defaultChannel":I
    .end local v7    # "filter":Landroid/content/IntentFilter;
    .end local v21    # "txPowerMode":I
    :cond_9
    new-instance v15, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_HOSTAPD_CONNECTED"

    move-object/from16 v0, v22

    invoke-direct {v15, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 301
    .local v15, "intentHostapdConnected":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v15, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 284
    .end local v15    # "intentHostapdConnected":Landroid/content/Intent;
    .restart local v3    # "BatteryState":Landroid/content/Intent;
    .restart local v4    # "chargeState":I
    .restart local v6    # "defaultChannel":I
    .restart local v7    # "filter":Landroid/content/IntentFilter;
    :pswitch_7
    const-string v22, "WifiSapService"

    const-string v23, "[txPowerMode]Charging : 2 FULL : 5"

    invoke-static/range {v22 .. v23}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 285
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v22

    const-string/jumbo v23, "wifi_ap_power_mode_high_with_usb"

    const/16 v24, 0x1

    invoke-static/range {v22 .. v24}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v21

    .line 286
    .restart local v21    # "txPowerMode":I
    goto :goto_1

    .line 307
    .end local v3    # "BatteryState":Landroid/content/Intent;
    .end local v4    # "chargeState":I
    .end local v6    # "defaultChannel":I
    .end local v7    # "filter":Landroid/content/IntentFilter;
    .end local v21    # "txPowerMode":I
    :pswitch_8
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_WPS_PBC_ACTIVE]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 309
    new-instance v20, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_WPS_PBC_ACTIVE"

    move-object/from16 v0, v20

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 310
    .local v20, "intentpbcActive":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v20

    move-object/from16 v2, v23

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 314
    .end local v20    # "intentpbcActive":Landroid/content/Intent;
    :pswitch_9
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_WPS_EVENT_DISABLE]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 316
    new-instance v11, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_DISABLE"

    move-object/from16 v0, v22

    invoke-direct {v11, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 317
    .local v11, "intentEventDisable":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v11, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 321
    .end local v11    # "intentEventDisable":Landroid/content/Intent;
    :pswitch_a
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_WPS_EVENT_TIMEOUT]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 323
    new-instance v14, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_TIMEOUT"

    move-object/from16 v0, v22

    invoke-direct {v14, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 324
    .local v14, "intentEventTimeout":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v14, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 328
    .end local v14    # "intentEventTimeout":Landroid/content/Intent;
    :pswitch_b
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_WPS_EVENT_SUCCESS]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 330
    new-instance v13, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_SUCCESS"

    move-object/from16 v0, v22

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 331
    .local v13, "intentEventSuccess":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v13, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 335
    .end local v13    # "intentEventSuccess":Landroid/content/Intent;
    :pswitch_c
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_WPS_EVENT_FAIL]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 337
    new-instance v12, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_FAIL"

    move-object/from16 v0, v22

    invoke-direct {v12, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 338
    .local v12, "intentEventFail":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v12, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 342
    .end local v12    # "intentEventFail":Landroid/content/Intent;
    :pswitch_d
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_HOSTAPD_WPS_EVENT_REG_SUCCESS]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 344
    new-instance v16, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_WPS_EVENT_REG_SUCCES"

    move-object/from16 v0, v16

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 345
    .local v16, "intentRegSuccess":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v16

    move-object/from16 v2, v23

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 351
    .end local v16    # "intentRegSuccess":Landroid/content/Intent;
    :pswitch_e
    const-string v22, "WifiSapService"

    const-string v23, "handleMessage [MESSAGE_SAP_DRIVER_HUNG_EVENT]"

    invoke-static/range {v22 .. v23}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 353
    new-instance v8, Landroid/content/Intent;

    const-string v22, "com.lge.wifi.sap.WIFI_SAP_DRIVER_HUNG_EVENT"

    move-object/from16 v0, v22

    invoke-direct {v8, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 354
    .local v8, "hangEvent":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/wifiSap/WifiSapService$WifiSapHandler;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiSapService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiSapService;->mContext:Landroid/content/Context;
    invoke-static/range {v22 .. v22}, Lcom/lge/wifi/impl/wifiSap/WifiSapService;->access$000(Lcom/lge/wifi/impl/wifiSap/WifiSapService;)Landroid/content/Context;

    move-result-object v22

    sget-object v23, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v0, v8, v1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .line 153
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
        :pswitch_e
    .end packed-switch

    .line 281
    :pswitch_data_1
    .packed-switch 0x2
        :pswitch_7
        :pswitch_6
        :pswitch_6
        :pswitch_7
    .end packed-switch
.end method
