.class Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;
.super Landroid/content/BroadcastReceiver;
.source "MHPService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/mobilehotspot/MHPService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;


# direct methods
.method constructor <init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 17
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    .local v2, "action":Ljava/lang/String;
    const-string v14, "com.lge.mobilehotspot.action.STATE_CHANGED"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_2

    const-string v14, "com.lge.mobilehotspot.extra.MOBILEHOTSPOT_STATE"

    const/4 v15, -0x1

    move-object/from16 v0, p2

    invoke-virtual {v0, v14, v15}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v11

    .local v11, "state":I
    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, " ACTION_MOBILEHOTSPOT_STATE_CHANGED :"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I
    invoke-static {v14, v11}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$002(Lcom/lge/wifi/impl/mobilehotspot/MHPService;I)I

    const/16 v14, 0xc

    if-ne v11, v14, :cond_1

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$102(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    .end local v11    # "state":I
    :cond_0
    :goto_0
    return-void

    .restart local v11    # "state":I
    :cond_1
    const/16 v14, 0xa

    if-ne v11, v14, :cond_0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$102(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$200(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/util/ArrayList;

    move-result-object v14

    invoke-virtual {v14}, Ljava/util/ArrayList;->clear()V

    :try_start_0
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->setBatteryUsageTime(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$300(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v14

    if-eqz v14, :cond_0

    new-instance v7, Landroid/content/Intent;

    const-string v14, "com.lge.mobilehotspot.action.AP_POWER_ONOFF_CONFIG"

    invoke-direct {v7, v14}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v7, "intentCmd":Landroid/content/Intent;
    const-string v14, "MobileHotspotService"

    const-string v15, "[MHP_AlanPark] AP_POWER_ONOF_CONFIG send in ACTION_MOBILEHOTSPOT_STATE_CHANGED"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$400(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Landroid/content/Context;

    move-result-object v14

    invoke-virtual {v14, v7}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0

    .end local v7    # "intentCmd":Landroid/content/Intent;
    :catch_0
    move-exception v5

    .local v5, "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_1

    .end local v5    # "e":Landroid/os/RemoteException;
    .end local v11    # "state":I
    :cond_2
    const-string v14, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_LOG"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_3

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const-string v15, "persist.service.mhp.log"

    const-string v16, "0"

    invoke-static/range {v15 .. v16}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    const-string v16, "1"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v15

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsLoging:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$502(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] 3G Mobile Hotspot Logging On >> "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    move-object/from16 v16, v0

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsLoging:Z
    invoke-static/range {v16 .. v16}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$500(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_3
    const-string v14, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_7

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$400(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Landroid/content/Context;

    move-result-object v14

    const-string v15, "wifi"

    invoke-virtual {v14, v15}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/net/wifi/WifiManager;

    .local v12, "wifiManager":Landroid/net/wifi/WifiManager;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isAirPlaneModeOn()Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$600(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v6

    .local v6, "enabled":Z
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isAirplaneModeOn:Z
    invoke-static {v14, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$702(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    if-eqz v6, :cond_4

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$100(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v14

    if-eqz v14, :cond_0

    :try_start_1
    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] Airplane mode On, Hotspot off ==> "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->disable(Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOffByAirplaneMode:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$802(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    :catch_1
    move-exception v5

    .restart local v5    # "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto/16 :goto_0

    .end local v5    # "e":Landroid/os/RemoteException;
    :cond_4
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOffByAirplaneMode:Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$800(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v14

    if-eqz v14, :cond_6

    invoke-virtual {v12}, Landroid/net/wifi/WifiManager;->isWifiEnabled()Z

    move-result v14

    if-nez v14, :cond_6

    invoke-static {}, Lcom/lge/wifi/extension/LgWifiManager;->getWifiServiceExtIface()Lcom/lge/wifi/extension/IWifiServiceExtension;

    move-result-object v13

    .local v13, "wifiSvcExt":Lcom/lge/wifi/extension/IWifiServiceExtension;
    if-eqz v13, :cond_5

    const/4 v14, 0x1

    invoke-interface {v13, v14}, Lcom/lge/wifi/extension/IWifiServiceExtension;->setProvisioned(Z)V

    :cond_5
    const-wide/16 v14, 0x7d0

    :try_start_2
    invoke-static {v14, v15}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_2

    :goto_2
    :try_start_3
    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] Airplane mode Off, Restart Hotspot by previos state ==> "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->enable(Z)Z
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_3

    :goto_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOffByAirplaneMode:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$802(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    goto/16 :goto_0

    :catch_2
    move-exception v5

    .local v5, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v5}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_2

    .end local v5    # "e":Ljava/lang/InterruptedException;
    :catch_3
    move-exception v5

    .local v5, "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_3

    .end local v5    # "e":Landroid/os/RemoteException;
    .end local v13    # "wifiSvcExt":Lcom/lge/wifi/extension/IWifiServiceExtension;
    :cond_6
    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM] Don\'t turn on by airplane off(wifi enabled or previous state off)"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v6    # "enabled":Z
    .end local v12    # "wifiManager":Landroid/net/wifi/WifiManager;
    :cond_7
    const-string v14, "android.intent.action.ANY_DATA_STATE"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_f

    const-string v14, "apnType"

    move-object/from16 v0, p2

    invoke-virtual {v0, v14}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "apnType":Ljava/lang/String;
    if-eqz v3, :cond_0

    const-string v14, "default"

    invoke-virtual {v3, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_8

    const-string v14, "internet"

    invoke-virtual {v3, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_0

    :cond_8
    const-string v14, "state"

    move-object/from16 v0, p2

    invoke-virtual {v0, v14}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .local v11, "state":Ljava/lang/String;
    const-string v14, "networkUnvailable"

    const/4 v15, 0x1

    move-object/from16 v0, p2

    invoke-virtual {v0, v14, v15}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v4

    .local v4, "dataConnectivityImpossible":Z
    const-string v9, "INET"

    .local v9, "ipVersion":Ljava/lang/String;
    const-string v14, "iface"

    move-object/from16 v0, p2

    invoke-virtual {v0, v14}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .local v8, "interfaceName":Ljava/lang/String;
    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] ACTION_ANY_DATA_CONNECTION_STATE_CHANGED dataConnectivityImpossible : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] Change network interface (state : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ", iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, "iface"

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ")"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz v3, :cond_0

    if-eqz v9, :cond_0

    const-string v14, "default"

    invoke-virtual {v3, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_9

    const-string v14, "internet"

    invoke-virtual {v3, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_0

    :cond_9
    const-string v14, "INET"

    invoke-virtual {v9, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v14

    if-eqz v14, :cond_a

    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM]  reset interface for MHP"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$902(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Ljava/lang/String;)Ljava/lang/String;

    goto/16 :goto_0

    :cond_a
    if-eqz v8, :cond_0

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v14

    const/4 v15, 0x1

    if-le v14, v15, :cond_b

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v14

    if-nez v14, :cond_b

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] initial set network interface (old iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    move-object/from16 v16, v0

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static/range {v16 .. v16}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ", new iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ")"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$902(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Ljava/lang/String;)Ljava/lang/String;

    goto/16 :goto_0

    :cond_b
    :try_start_4
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    invoke-virtual {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isEnabled()Z

    move-result v14

    if-eqz v14, :cond_0

    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM]  MobileHotSpot Currenttly On. Lets check if we change the upstreaming interface"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v14

    const/4 v15, 0x1

    if-le v14, v15, :cond_c

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v14

    if-eqz v14, :cond_c

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v8, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_c

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] Unchange network interface (old iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    move-object/from16 v16, v0

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static/range {v16 .. v16}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ", new iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ")"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    :catch_4
    move-exception v14

    goto/16 :goto_0

    :cond_c
    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v14

    const/4 v15, 0x1

    if-le v14, v15, :cond_d

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v14

    if-nez v14, :cond_d

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] Initial set network interface (iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ")"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    :cond_d
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v8, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_e

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] Change network interface (old iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    move-object/from16 v16, v0

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static/range {v16 .. v16}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ", new iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ")"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    :cond_e
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v14, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$902(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Ljava/lang/String;)Ljava/lang/String;

    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] p2pSetNetDynamicInterface (iface : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ")"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1000(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;
    invoke-static {v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetNetDynamicInterface(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    invoke-virtual {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isEnabled()Z
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    move-result v14

    if-eqz v14, :cond_0

    goto/16 :goto_0

    .end local v3    # "apnType":Ljava/lang/String;
    .end local v4    # "dataConnectivityImpossible":Z
    .end local v8    # "interfaceName":Ljava/lang/String;
    .end local v9    # "ipVersion":Ljava/lang/String;
    .end local v11    # "state":Ljava/lang/String;
    :cond_f
    const-string v14, "android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_10

    const-string v14, "phoneinECMState"

    const/4 v15, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v14, v15}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v14

    if-nez v14, :cond_0

    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM] Exit Emergency call mode)"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isECM:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1102(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1200(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v14

    if-eqz v14, :cond_0

    :try_start_5
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1202(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->enable(Z)Z
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_5} :catch_5

    goto/16 :goto_0

    :catch_5
    move-exception v5

    .restart local v5    # "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto/16 :goto_0

    .end local v5    # "e":Landroid/os/RemoteException;
    :cond_10
    const-string v14, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_EMC_EVENT"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_12

    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM] Enter Emergency call mode)"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isECM:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1102(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$100(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v14

    if-eqz v14, :cond_11

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1202(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    :try_start_6
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->disable(Z)Z
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_6 .. :try_end_6} :catch_6

    goto/16 :goto_0

    :catch_6
    move-exception v5

    .restart local v5    # "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto/16 :goto_0

    .end local v5    # "e":Landroid/os/RemoteException;
    :cond_11
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1202(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    goto/16 :goto_0

    :cond_12
    const-string v14, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_13

    const-string v14, "MobileHotspotService"

    const-string v15, " WIFI_SAP_DHCP_INFO_CHANGED_ACTION"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_7
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    invoke-virtual {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isEnabled()Z

    move-result v14

    if-eqz v14, :cond_0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->syncAllConectedDevices()V
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$1300(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V
    :try_end_7
    .catch Landroid/os/RemoteException; {:try_start_7 .. :try_end_7} :catch_7

    goto/16 :goto_0

    :catch_7
    move-exception v5

    .restart local v5    # "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto/16 :goto_0

    .end local v5    # "e":Landroid/os/RemoteException;
    :cond_13
    const-string v14, "com.lge.mobilehotspot.action.AP_POWER_ONOFF_CONFIG"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_15

    :try_start_8
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z
    invoke-static {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$300(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z

    move-result v14

    if-nez v14, :cond_14

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    invoke-virtual {v14}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isEnabled()Z

    move-result v14

    if-eqz v14, :cond_14

    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM] Hotspot off because of re-setting configure"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$302(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->disable(Z)Z
    :try_end_8
    .catch Landroid/os/RemoteException; {:try_start_8 .. :try_end_8} :catch_8

    goto/16 :goto_0

    :catch_8
    move-exception v5

    .restart local v5    # "e":Landroid/os/RemoteException;
    invoke-virtual {v5}, Landroid/os/RemoteException;->printStackTrace()V

    goto/16 :goto_0

    .end local v5    # "e":Landroid/os/RemoteException;
    :cond_14
    :try_start_9
    const-string v14, "MobileHotspotService"

    const-string v15, "[MHS_NEZZIMOM] Hotspot on because of re-setting configure"

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x0

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$302(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/4 v15, 0x1

    invoke-virtual {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->enable(Z)Z
    :try_end_9
    .catch Landroid/os/RemoteException; {:try_start_9 .. :try_end_9} :catch_8

    goto/16 :goto_0

    :cond_15
    const-string v14, "android.net.wifi.WIFI_AP_STATE_CHANGED"

    invoke-virtual {v2, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_0

    const-string v14, "wifi_state"

    const/16 v15, 0xe

    move-object/from16 v0, p2

    invoke-virtual {v0, v14, v15}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v10

    .local v10, "newWifiApState":I
    const-string v14, "MobileHotspotService"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[MHS_NEZZIMOM] WIFI_AP_STATE_CHANGED_ACTION : "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const/16 v14, 0xb

    if-ne v10, v14, :cond_16

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/16 v15, 0xa

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$002(Lcom/lge/wifi/impl/mobilehotspot/MHPService;I)I

    goto/16 :goto_0

    :cond_16
    const/16 v14, 0xd

    if-ne v10, v14, :cond_0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    const/16 v15, 0xc

    # setter for: Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I
    invoke-static {v14, v15}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->access$002(Lcom/lge/wifi/impl/mobilehotspot/MHPService;I)I

    goto/16 :goto_0
.end method
