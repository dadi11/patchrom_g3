.class Lcom/android/internal/telephony/ePDGinterface$1;
.super Landroid/content/BroadcastReceiver;
.source "ePDGinterface.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/ePDGinterface;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/ePDGinterface;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/ePDGinterface;)V
    .locals 0

    .prologue
    .line 108
    iput-object p1, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v5, 0x0

    .line 112
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 113
    .local v0, "action":Ljava/lang/String;
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onReceive: action="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 114
    const-string v2, "android.net.wifi.STATE_CHANGE"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 115
    const-string v2, "networkInfo"

    invoke-virtual {p2, v2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    check-cast v1, Landroid/net/NetworkInfo;

    .line 117
    .local v1, "networkInfo":Landroid/net/NetworkInfo;
    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v2, 0x1

    :goto_0
    iput-boolean v2, v3, Lcom/android/internal/telephony/ePDGinterface;->mIsWifiConnected:Z

    .line 119
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "NETWORK_STATE_CHANGED_ACTION: mIsWifiConnected="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget-boolean v4, v4, Lcom/android/internal/telephony/ePDGinterface;->mIsWifiConnected:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 121
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget-boolean v2, v2, Lcom/android/internal/telephony/ePDGinterface;->mIsWifiConnected:Z

    if-eqz v2, :cond_2

    .line 123
    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "linkProperties"

    invoke-virtual {p2, v2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v2

    check-cast v2, Landroid/net/LinkProperties;

    # setter for: Lcom/android/internal/telephony/ePDGinterface;->mWifiLinkProperties:Landroid/net/LinkProperties;
    invoke-static {v3, v2}, Lcom/android/internal/telephony/ePDGinterface;->access$002(Lcom/android/internal/telephony/ePDGinterface;Landroid/net/LinkProperties;)Landroid/net/LinkProperties;

    .line 124
    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "wifiInfo"

    invoke-virtual {p2, v2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v2

    check-cast v2, Landroid/net/wifi/WifiInfo;

    # setter for: Lcom/android/internal/telephony/ePDGinterface;->mWifiInfo:Landroid/net/wifi/WifiInfo;
    invoke-static {v3, v2}, Lcom/android/internal/telephony/ePDGinterface;->access$102(Lcom/android/internal/telephony/ePDGinterface;Landroid/net/wifi/WifiInfo;)Landroid/net/wifi/WifiInfo;

    .line 125
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    # getter for: Lcom/android/internal/telephony/ePDGinterface;->mWifiLinkProperties:Landroid/net/LinkProperties;
    invoke-static {v2}, Lcom/android/internal/telephony/ePDGinterface;->access$000(Lcom/android/internal/telephony/ePDGinterface;)Landroid/net/LinkProperties;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    # getter for: Lcom/android/internal/telephony/ePDGinterface;->mWifiInfo:Landroid/net/wifi/WifiInfo;
    invoke-static {v2}, Lcom/android/internal/telephony/ePDGinterface;->access$100(Lcom/android/internal/telephony/ePDGinterface;)Landroid/net/wifi/WifiInfo;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 126
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget-boolean v3, v3, Lcom/android/internal/telephony/ePDGinterface;->mIsWifiConnected:Z

    iget-object v4, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    # getter for: Lcom/android/internal/telephony/ePDGinterface;->mWifiLinkProperties:Landroid/net/LinkProperties;
    invoke-static {v4}, Lcom/android/internal/telephony/ePDGinterface;->access$000(Lcom/android/internal/telephony/ePDGinterface;)Landroid/net/LinkProperties;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/LinkProperties;->getLinkAddresses()Ljava/util/List;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    # getter for: Lcom/android/internal/telephony/ePDGinterface;->mWifiInfo:Landroid/net/wifi/WifiInfo;
    invoke-static {v5}, Lcom/android/internal/telephony/ePDGinterface;->access$100(Lcom/android/internal/telephony/ePDGinterface;)Landroid/net/wifi/WifiInfo;

    move-result-object v5

    invoke-virtual {v5}, Landroid/net/wifi/WifiInfo;->getBSSID()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v3, v4, v5}, Lcom/android/internal/telephony/ePDGinterface;->sendWifiStatustoModem(ZLjava/util/Collection;Ljava/lang/String;)V

    .line 133
    .end local v1    # "networkInfo":Landroid/net/NetworkInfo;
    :cond_0
    :goto_1
    return-void

    .line 117
    .restart local v1    # "networkInfo":Landroid/net/NetworkInfo;
    :cond_1
    const/4 v2, 0x0

    goto :goto_0

    .line 129
    :cond_2
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface$1;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget-boolean v3, v3, Lcom/android/internal/telephony/ePDGinterface;->mIsWifiConnected:Z

    invoke-virtual {v2, v3, v5, v5}, Lcom/android/internal/telephony/ePDGinterface;->sendWifiStatustoModem(ZLjava/util/Collection;Ljava/lang/String;)V

    goto :goto_1
.end method
