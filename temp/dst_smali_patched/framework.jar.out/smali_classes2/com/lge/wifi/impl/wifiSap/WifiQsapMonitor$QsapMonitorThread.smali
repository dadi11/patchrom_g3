.class Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;
.super Ljava/lang/Thread;
.source "WifiQsapMonitor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "QsapMonitorThread"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;


# direct methods
.method public constructor <init>(Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;)V
    .locals 1

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;

    const-string v0, "WifiQsapMonitor"

    invoke-direct {p0, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method private handleEvent(Ljava/lang/String;)V
    .locals 3
    .param p1, "eventStr"    # Ljava/lang/String;

    .prologue
    const-string v0, "WifiQsapMonitor"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Event ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "104"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "105"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    # setter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mThreadRunning:Z
    invoke-static {v0}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$002(Z)Z

    :cond_1
    :goto_0
    return-void

    :cond_2
    const-string v0, "100"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "101"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    const-string v0, "100"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->notifySoftApEnabled()V

    goto :goto_0

    :cond_4
    const-string v0, "WifiQsapMonitor"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unhandled Event ["

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

    goto :goto_0
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const-string v1, "WifiQsapMonitor"

    const-string v2, "Thread Started"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mWifiQsapApi:Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;
    invoke-static {v1}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$100(Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;)Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;->OpenNetlink()Z

    move-result v1

    if-ne v3, v1, :cond_3

    const-string v1, "WifiQsapMonitor"

    const-string v2, "Connection success"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mThreadRunning:Z
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$000()Z

    move-result v1

    if-ne v3, v1, :cond_2

    const/4 v0, 0x0

    .local v0, "eventStr":Ljava/lang/String;
    const-string v1, "WifiQsapMonitor"

    const-string v2, "Waiting For Broadcast"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mWifiQsapApi:Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;
    invoke-static {v1}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$100(Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;)Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;->WaitForEvent()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    const-string v1, "WifiQsapMonitor"

    const-string v2, "Null Event Received"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    invoke-direct {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->handleEvent(Ljava/lang/String;)V

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mThreadRunning:Z
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$000()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "WifiQsapMonitor"

    const-string v2, "mThreadRunning is false"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "eventStr":Ljava/lang/String;
    :cond_2
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;

    # getter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mWifiQsapApi:Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;
    invoke-static {v1}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$100(Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;)Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiQsapApi;->CloseNetlink()V

    :goto_1
    const-string v1, "WifiQsapMonitor"

    const-string v2, "Thread Stoped"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;->this$0:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;

    const/4 v2, 0x0

    # setter for: Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->mQsapMonitorThread:Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;
    invoke-static {v1, v2}, Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;->access$202(Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor;Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;)Lcom/lge/wifi/impl/wifiSap/WifiQsapMonitor$QsapMonitorThread;

    return-void

    :cond_3
    const-string v1, "WifiQsapMonitor"

    const-string v2, "Connection Failed"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
