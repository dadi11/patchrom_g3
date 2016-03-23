.class Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;
.super Landroid/content/BroadcastReceiver;
.source "WifiSapWrapperBcm.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;


# direct methods
.method constructor <init>(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)V
    .locals 0

    .prologue
    .line 55
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 58
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 59
    .local v0, "action":Ljava/lang/String;
    const/4 v2, 0x0

    .line 61
    .local v2, "notivalue":I
    const-string v3, "com.lge.wifi.sap.ENABLED"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 63
    const-string v3, "WifiSapWrapperBcm"

    const-string v4, "BroadcastReceiver : WIFI_SAP_ENABLED_ACTION"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 65
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 66
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->BCMP2P_NOTIF_SOFTAP_READY:Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->getVal()I

    move-result v2

    .line 68
    if-eqz v2, :cond_0

    .line 69
    :try_start_0
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    invoke-interface {v3, v2}, Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;->sendP2PNotificaiton(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    :cond_0
    :goto_0
    return-void

    .line 71
    :catch_0
    move-exception v1

    .line 72
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 76
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_1
    const-string v3, "com.lge.wifi.sap.DISABLED"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 78
    const-string v3, "WifiSapWrapperBcm"

    const-string v4, "BroadcastReceiver : WIFI_SAP_DISABLED_ACTION"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 80
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 81
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->BCMP2P_NOTIF_SOFTAP_STOP:Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->getVal()I

    move-result v2

    .line 83
    if-eqz v2, :cond_0

    .line 84
    :try_start_1
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    invoke-interface {v3, v2}, Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;->sendP2PNotificaiton(I)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 86
    :catch_1
    move-exception v1

    .line 87
    .restart local v1    # "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 91
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_2
    const-string v3, "com.lge.wifi.sap.WIFI_SAP_STATION_ASSOC"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 93
    const-string v3, "WifiSapWrapperBcm"

    const-string v4, "BroadcastReceiver : WIFI_SAP_STATION_ASSOC_ACTION"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 95
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    if-eqz v3, :cond_0

    goto :goto_0

    .line 99
    :cond_3
    const-string v3, "com.lge.wifi.sap.WIFI_SAP_STATION_DISASSOC"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 101
    const-string v3, "WifiSapWrapperBcm"

    const-string v4, "BroadcastReceiver : WIFI_SAP_STATION_DISASSOC_ACTION"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 103
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 104
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->BCMP2P_NOTIF_SOFTAP_STA_DISASSOC:Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->getVal()I

    move-result v2

    .line 106
    if-eqz v2, :cond_0

    .line 107
    :try_start_2
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    invoke-interface {v3, v2}, Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;->sendP2PNotificaiton(I)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    .line 109
    :catch_2
    move-exception v1

    .line 110
    .restart local v1    # "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 113
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_4
    const-string v3, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 115
    const-string v3, "WifiSapWrapperBcm"

    const-string v4, "BroadcastReceiver : WIFI_SAP_DHCP_INFO_CHANGED_ACTION"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 117
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 120
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->BCMP2P_NOTIF_CREATE_LINK_COMPLETE:Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapMHPCmd$BCMP2P_NOTIFICATION_CODE;->getVal()I

    move-result v2

    .line 122
    if-eqz v2, :cond_0

    .line 123
    :try_start_3
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$1;->this$0:Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;

    # getter for: Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->mMhpManager:Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;->access$000(Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;)Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;

    move-result-object v3

    invoke-interface {v3, v2}, Lcom/lge/wifi/impl/mobilehotspot/IMHPNotificationReceiver;->sendP2PNotificaiton(I)V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_3

    goto/16 :goto_0

    .line 125
    :catch_3
    move-exception v1

    .line 126
    .restart local v1    # "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto/16 :goto_0

    .line 130
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_5
    const-string v3, "WifiSapWrapperBcm"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "BroadcastReceiver : unknown Intent ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method
