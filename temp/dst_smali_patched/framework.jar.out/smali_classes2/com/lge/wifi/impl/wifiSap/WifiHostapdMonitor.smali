.class public Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;
.super Lcom/lge/wifi/impl/wifiSap/WifiApMonitor;
.source "WifiHostapdMonitor.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;
    }
.end annotation


# static fields
.field private static final AP_CTRL_EVENT_DRIVER:Ljava/lang/String; = "CTRL-EVENT-DRIVER-STATE"

.field private static final AP_STA_CONNECTED:Ljava/lang/String; = "AP-STA-CONNECTED"

.field private static final AP_STA_DISCONNECTED:Ljava/lang/String; = "AP-STA-DISCONNECTED"

.field private static final AP_STA_MAX_REACHED:Ljava/lang/String; = "AP-STA-MAX-REACHED"

.field private static final AP_WPS_AP_AVAILABLE:Ljava/lang/String; = "WPS-AP-AVAILABLE"

.field private static final AP_WPS_AP_AVAILABLE_AUTH:Ljava/lang/String; = "WPS-AP-AVAILABLE-AUTH"

.field private static final AP_WPS_AP_AVAILABLE_PBC:Ljava/lang/String; = "WPS-AP-AVAILABLE-PBC"

.field private static final AP_WPS_AP_AVAILABLE_PIN:Ljava/lang/String; = "WPS-AP-AVAILABLE-PIN"

.field private static final AP_WPS_CRED_RECEIVED:Ljava/lang/String; = "WPS-CRED-RECEIVED"

.field private static final AP_WPS_EVENT:Ljava/lang/String; = "WPS-"

.field private static final AP_WPS_EVENT_DISABLE:Ljava/lang/String; = "WPS-PBC-DISABLE"

.field private static final AP_WPS_EVENT_FAIL:Ljava/lang/String; = "WPS-FAIL"

.field private static final AP_WPS_EVENT_OVERLAP:Ljava/lang/String; = "WPS-OVERLAP-DETECTED"

.field private static final AP_WPS_EVENT_REG_SUCCESS:Ljava/lang/String; = "WPS-REG-SUCCESS"

.field private static final AP_WPS_EVENT_SUCCESS:Ljava/lang/String; = "WPS-SUCCESS"

.field private static final AP_WPS_EVENT_TIMEOUT:Ljava/lang/String; = "WPS-TIMEOUT"

.field private static final AP_WPS_PBC_ACTIVE:Ljava/lang/String; = "WPS-PBC-ACTIVE"

.field private static final LOCAL_LOGD:Z = true

.field private static final TAG:Ljava/lang/String; = "WifiHostapdMonitor"

.field private static final WPS_AP_DISABLE:I = 0x1

.field private static final WPS_AP_FAIL:I = 0x4

.field private static final WPS_AP_PBC_ACTIVE:I = 0x0

.field private static final WPS_AP_REG_SUCCESS:I = 0x5

.field private static final WPS_AP_SUCCESS:I = 0x3

.field private static final WPS_AP_TIMEOUT:I = 0x2

.field private static mThreadRunning:Z


# instance fields
.field private mMonitorThread:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;

.field private final mThreadRunningLock:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunning:Z

    return-void
.end method

.method public constructor <init>(Landroid/os/Handler;)V
    .locals 1
    .param p1, "sapHandler"    # Landroid/os/Handler;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiApMonitor;-><init>(Landroid/os/Handler;)V

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunningLock:Ljava/lang/Object;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mMonitorThread:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;

    return-void
.end method

.method static synthetic access$000()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunning:Z

    return v0
.end method

.method static synthetic access$100(I)V
    .locals 0
    .param p0, "x0"    # I

    .prologue
    invoke-static {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->nap(I)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->handleEvent(Ljava/lang/String;)V

    return-void
.end method

.method private handleApDriverEvent(Ljava/lang/String;)V
    .locals 2
    .param p1, "eventStr"    # Ljava/lang/String;

    .prologue
    const-string v0, "HANGED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "WifiHostapdMonitor"

    const-string v1, "SOFTAP DRIVER HANGED EVENT !!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyDriverHungToHostapd()V

    :cond_0
    return-void
.end method

.method private handleEvent(Ljava/lang/String;)V
    .locals 3
    .param p1, "eventStr"    # Ljava/lang/String;

    .prologue
    const-string v0, "WifiHostapdMonitor"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleEvent  Event ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "AP-STA-CONNECTED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyStationAssociated()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v0, "AP-STA-DISCONNECTED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyStationDisassociated()V

    goto :goto_0

    :cond_2
    const-string v0, "AP-STA-MAX-REACHED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyMaxClientReached()V

    goto :goto_0

    :cond_3
    const-string v0, "WPS-"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->handleWpsEvent(Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    const-string v0, "CTRL-EVENT-DRIVER-STATE"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->handleApDriverEvent(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleWpsEvent(Ljava/lang/String;)V
    .locals 1
    .param p1, "eventStr"    # Ljava/lang/String;

    .prologue
    const-string v0, "WPS-PBC-ACTIVE"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyWPStoToHostapd(I)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v0, "WPS-PBC-DISABLE"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyWPStoToHostapd(I)V

    goto :goto_0

    :cond_2
    const-string v0, "WPS-TIMEOUT"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyWPStoToHostapd(I)V

    goto :goto_0

    :cond_3
    const-string v0, "WPS-SUCCESS"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyWPStoToHostapd(I)V

    goto :goto_0

    :cond_4
    const-string v0, "WPS-FAIL"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_5

    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyWPStoToHostapd(I)V

    goto :goto_0

    :cond_5
    const-string v0, "WPS-REG-SUCCESS"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_6

    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->notifyWPStoToHostapd(I)V

    goto :goto_0

    :cond_6
    const-string v0, "WPS-OVERLAP-DETECTED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "WPS-AP-AVAILABLE-PBC"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "WPS-AP-AVAILABLE-AUTH"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "WPS-AP-AVAILABLE-PIN"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "WPS-AP-AVAILABLE"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "WPS-CRED-RECEIVED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0
.end method

.method private static nap(I)V
    .locals 2
    .param p0, "secs"    # I

    .prologue
    mul-int/lit16 v0, p0, 0x3e8

    int-to-long v0, v0

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public startMonitoring()V
    .locals 2

    .prologue
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunningLock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v0, 0x1

    :try_start_0
    sput-boolean v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunning:Z

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    new-instance v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mMonitorThread:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;

    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mMonitorThread:Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor$HostapdMonitorThread;->start()V

    const-string v0, "WifiHostapdMonitor"

    const-string v1, "HostapdMonitorThread started"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public stopMonitoring()V
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunningLock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-boolean v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdMonitor;->mThreadRunning:Z

    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->closeHostapdConnection()V

    const-string v0, "WifiHostapdMonitor"

    const-string v2, "HostapdMonitorThread stopped"

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v0, "WifiHostapdMonitor"

    const-string v1, "HostapdMonitorThread stopped"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
