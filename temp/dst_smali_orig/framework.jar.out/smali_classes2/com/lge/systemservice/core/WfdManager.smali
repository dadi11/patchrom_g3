.class public Lcom/lge/systemservice/core/WfdManager;
.super Ljava/lang/Object;
.source "WfdManager.java"


# static fields
.field public static final DIRECT_STATE_CONNECTED:I = 0x4

.field public static final DIRECT_STATE_CONNECTING:I = 0x3

.field public static final DIRECT_STATE_DISABLED:I = 0x0

.field public static final DIRECT_STATE_DISABLING:I = 0x6

.field public static final DIRECT_STATE_DISCONNECTING:I = 0x5

.field public static final DIRECT_STATE_ENABLING:I = 0x1

.field public static final DIRECT_STATE_NOT_CONNECTED:I = 0x2

.field public static final DIRECT_STATE_UNKNOWN:I = 0x7

.field public static final DRM_REQ_FORCED_PAUSE:I = 0x2

.field public static final DRM_REQ_NONE:I = 0x3

.field public static final DRM_REQ_PAUSE:I = 0x1

.field public static final DRM_REQ_RESUME:I = 0x0

.field public static final EXTRA_CONNECTED_UDN:Ljava/lang/String; = "connected_udn"

.field public static final EXTRA_DLNA_TRANSIT_ENABLE:Ljava/lang/String; = "wfd_switch"

.field public static final EXTRA_DLNA_UDN:Ljava/lang/String; = "dlna_udn"

.field public static final EXTRA_HDCP_ENABLED:Ljava/lang/String; = "hdcp_enabled"

.field public static final EXTRA_IGNORE_DIRECT_CONNECTION:Ljava/lang/String; = "ignore_direct_connection"

.field public static final EXTRA_LG_MIRACAST_VER:Ljava/lang/String; = "lg_wfd_version"

.field public static final EXTRA_PAUSE_REQ:Ljava/lang/String; = "drm_pause_req"

.field public static final EXTRA_PLAYER:Ljava/lang/String; = "drm_player"

.field public static final EXTRA_PREVIOUS_WFD_STATE:Ljava/lang/String; = "previous_wfd_state"

.field public static final EXTRA_RTSP_STATE:Ljava/lang/String; = "rtsp_state"

.field public static final EXTRA_SESSION_ID:Ljava/lang/String; = "session_id"

.field public static final EXTRA_WFD_CALLBACK:Ljava/lang/String; = "extra_wfd_callback"

.field public static final EXTRA_WFD_STATE:Ljava/lang/String; = "wfd_state"

.field public static final EXTRA_WFD_TRANSIT_FAIL_REASON:Ljava/lang/String; = "extra_fail_reason"

.field public static final EXTRA_WHRZ_PORTS:Ljava/lang/String; = "whrz_ports"

.field public static final EXTRA_WIFI_FEATURE:Ljava/lang/String; = "wifi_feature"

.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.wfdService"

.field public static final RTSP_STATE_CHANGED_ACTION:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.rtsp.STATE_CHANGE"

.field public static final RTSP_STATE_CREATING:I = 0x2

.field public static final RTSP_STATE_INIT:I = 0x4

.field public static final RTSP_STATE_LISTEN:I = 0x3

.field public static final RTSP_STATE_NEW:I = 0x0

.field public static final RTSP_STATE_NOT_RUNNING:I = 0x1

.field public static final RTSP_STATE_PLAYING:I = 0x6

.field public static final RTSP_STATE_READY:I = 0x5

.field public static final RTSP_STATE_UNKNOWN:I = 0x7

.field public static final SERVICE_NAME:Ljava/lang/String; = "wfdService"

.field public static final SESSION_CB_HDCP_CONNECT_FAIL:I = 0x2

.field public static final SESSION_CB_HDCP_CONNECT_SUCCESS:I = 0x1

.field public static final SESSION_CB_NONE:I = 0x0

.field public static final SESSION_CB_TEARDOWN_STARTED:I = 0x5

.field public static final SESSION_CB_UIBC_DISABLED:I = 0x7

.field public static final SESSION_CB_UIBC_ENABLED:I = 0x6

.field public static final SESSION_CB_UIBC_NOT_SUPPORTED:I = 0x4

.field public static final SESSION_CB_UIBC_SUPPORTED:I = 0x3

.field private static final TAG:Ljava/lang/String; = "WfdManager"

.field public static final WFD_INFORM_DRM_STATUS:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_INFORM_DRM_STATUS"

.field public static final WFD_LG_PEER_EVENT_FAIL_REASON:I = 0x3

.field public static final WFD_LG_PEER_EVENT_NONE:I = 0x0

.field public static final WFD_LG_PEER_EVENT_PEER_INFO:I = 0x1

.field public static final WFD_LG_PEER_EVENT_SRC_IP:I = 0x2

.field public static final WFD_REQUEST_WIFI_ENABLED_ACTION:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_REQUEST_WIFI_ENABLED_ACTION"

.field public static final WFD_REQ_DISABLE:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_DISABLE"

.field public static final WFD_REQ_DLNA_TRANSIT:Ljava/lang/String; = "lge.wfd.switch.start"

.field public static final WFD_REQ_ENABLE:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_ENABLE"

.field public static final WFD_REQ_RESUME_FROM_DLNA:Ljava/lang/String; = "lge.wfd.switch.stop"

.field public static final WFD_REQ_RESUME_FROM_WHRZ:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_REQ_RESUME_FROM_WHRZ"

.field public static final WFD_REQ_WHRZ_TRANSIT:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_REQ_WHRZ_TRANSIT"

.field public static final WFD_SET_TO_ASK:I = 0x2

.field public static final WFD_SET_TO_SINK:I = 0x1

.field public static final WFD_SET_TO_SOURCE:I = 0x0

.field public static final WFD_STATE_CHANGED_ACTION:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_STATE_CHANGED"

.field public static final WFD_STATE_CONNECTING:I = 0x3

.field public static final WFD_STATE_DISABLED:I = 0x0

.field public static final WFD_STATE_DISABLING:I = 0x7

.field public static final WFD_STATE_DISCONNECTING:I = 0x6

.field public static final WFD_STATE_ENABLING:I = 0x1

.field public static final WFD_STATE_LINK_CONNECTED:I = 0x4

.field public static final WFD_STATE_NOT_CONNECTED:I = 0x2

.field public static final WFD_STATE_UNKNOWN:I = 0x8

.field public static final WFD_STATE_WFD_PAIRED:I = 0x5

.field public static final WFD_TRANSIT_CALLBACK:Ljava/lang/String; = "com.lge.systemservice.core.wfdmanager.WFD_TRANSIT_CALLBACK"

.field public static final WFD_TRANSIT_DLNA_READY:I = 0x2

.field public static final WFD_TRANSIT_FAIL:I = 0x0

.field public static final WFD_TRANSIT_FAIL_ALREADY_DONE:I = 0x2

.field public static final WFD_TRANSIT_FAIL_NOT_SUPPORTED:I = 0x1

.field public static final WFD_TRANSIT_FAIL_NO_REASON:I = 0x0

.field public static final WFD_TRANSIT_FAIL_OTHER_PLAYER_IS_RUNNING:I = 0x3

.field public static final WFD_TRANSIT_FAIL_PEER_NOT_READY:I = 0x4

.field public static final WFD_TRANSIT_FAIL_PEER_RESPONSE_TIMEOUT:I = 0x5

.field public static final WFD_TRANSIT_WFD_READY:I = 0x1

.field public static final WFD_TRANSIT_WHRZ_READY:I = 0x3

.field public static final WIFI_FEATURE_AP:I = 0x2

.field public static final WIFI_FEATURE_UNKNOWN:I = 0x0

.field public static final WIFI_FEATURE_WIFI:I = 0x1

.field public static final WIFI_STATE_CONNECTED:I = 0x1

.field public static final WIFI_STATE_NOT_CONNECTED:I


# instance fields
.field private mService:Lcom/lge/systemservice/core/IWfdManager;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/WfdManager;Lcom/lge/systemservice/core/IWfdManager;)Lcom/lge/systemservice/core/IWfdManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/WfdManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IWfdManager;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/IWfdManager;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    if-nez v1, :cond_0

    const-string v1, "wfdService"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/IWfdManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    iget-object v1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/WfdManager$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/WfdManager$1;-><init>(Lcom/lge/systemservice/core/WfdManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method


# virtual methods
.method public cancelP2pConnect(Lcom/lge/systemservice/core/IWfdServiceListener;)Z
    .locals 5
    .param p1, "listener"    # Lcom/lge/systemservice/core/IWfdServiceListener;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "cancelP2pConnect: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->cancelP2pConnect(Lcom/lge/systemservice/core/IWfdServiceListener;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public cancelP2pConnect(Lcom/lge/systemservice/core/WfdServiceListener;)Z
    .locals 6
    .param p1, "listener"    # Lcom/lge/systemservice/core/WfdServiceListener;

    .prologue
    const/4 v3, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v2

    .local v2, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v2, :cond_0

    const-string v4, "WfdManager"

    const-string v5, "cancelP2pConnect: fail to get WfdService"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v3

    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lcom/lge/systemservice/core/WfdServiceListener;->getWfdServiceListener()Lcom/lge/systemservice/core/IWfdServiceListener;

    move-result-object v0

    .local v0, "_listener":Lcom/lge/systemservice/core/IWfdServiceListener;
    invoke-interface {v2, v0}, Lcom/lge/systemservice/core/IWfdManager;->cancelP2pConnect(Lcom/lge/systemservice/core/IWfdServiceListener;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v3, 0x1

    goto :goto_0

    .end local v0    # "_listener":Lcom/lge/systemservice/core/IWfdServiceListener;
    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v4, 0x0

    iput-object v4, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public cancelWifiDisplayConnect()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "cancelWifiDisplayConnect: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->cancelWifiDisplayConnect()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public clientConnect()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "clientConnect: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->clientConnect()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public discoverWfdPeers(Lcom/lge/systemservice/core/IWfdServiceListener;)Z
    .locals 5
    .param p1, "listener"    # Lcom/lge/systemservice/core/IWfdServiceListener;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "discoverWfdPeers: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->discoverWfdPeers(Lcom/lge/systemservice/core/IWfdServiceListener;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public discoverWfdPeers(Lcom/lge/systemservice/core/WfdServiceListener;)Z
    .locals 6
    .param p1, "listener"    # Lcom/lge/systemservice/core/WfdServiceListener;

    .prologue
    const/4 v3, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v2

    .local v2, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v2, :cond_0

    const-string v4, "WfdManager"

    const-string v5, "discoverWfdPeers: fail to get WfdService"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v3

    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lcom/lge/systemservice/core/WfdServiceListener;->getWfdServiceListener()Lcom/lge/systemservice/core/IWfdServiceListener;

    move-result-object v0

    .local v0, "_listener":Lcom/lge/systemservice/core/IWfdServiceListener;
    invoke-interface {v2, v0}, Lcom/lge/systemservice/core/IWfdManager;->discoverWfdPeers(Lcom/lge/systemservice/core/IWfdServiceListener;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v3, 0x1

    goto :goto_0

    .end local v0    # "_listener":Lcom/lge/systemservice/core/IWfdServiceListener;
    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v4, 0x0

    iput-object v4, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public getRtspState()I
    .locals 5

    .prologue
    const/4 v2, 0x1

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "getRtspState: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->getRtspState()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public getTargetUrl()Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "getTargetUrl: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-object v2

    :cond_0
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->getTargetUrl()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    iput-object v2, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public getWfdMode()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "getWfdMode: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->getWfdMode()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public getWfdState()I
    .locals 5

    .prologue
    const/16 v2, 0x8

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "getWfdState: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IWfdManager;->getWfdState()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public informConnectionRequstedUdn(Ljava/lang/String;)V
    .locals 4
    .param p1, "req_udn"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v2, "WfdManager"

    const-string v3, "informConnectionRequstedUdn: fail to get WfdService"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->informConnectionRequstedUdn(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public requestConnect(Ljava/lang/String;ILcom/lge/systemservice/core/IWfdServiceListener;)Z
    .locals 5
    .param p1, "peer_addr"    # Ljava/lang/String;
    .param p2, "wps_method"    # I
    .param p3, "listener"    # Lcom/lge/systemservice/core/IWfdServiceListener;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "requestConnect: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IWfdManager;->requestConnect(Ljava/lang/String;ILcom/lge/systemservice/core/IWfdServiceListener;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public requestConnect(Ljava/lang/String;ILcom/lge/systemservice/core/WfdServiceListener;)Z
    .locals 6
    .param p1, "peer_addr"    # Ljava/lang/String;
    .param p2, "wps_method"    # I
    .param p3, "listener"    # Lcom/lge/systemservice/core/WfdServiceListener;

    .prologue
    const/4 v3, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v2

    .local v2, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v2, :cond_0

    const-string v4, "WfdManager"

    const-string v5, "requestConnect: fail to get WfdService"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v3

    :cond_0
    :try_start_0
    invoke-virtual {p3}, Lcom/lge/systemservice/core/WfdServiceListener;->getWfdServiceListener()Lcom/lge/systemservice/core/IWfdServiceListener;

    move-result-object v0

    .local v0, "_listener":Lcom/lge/systemservice/core/IWfdServiceListener;
    invoke-interface {v2, p1, p2, v0}, Lcom/lge/systemservice/core/IWfdManager;->requestConnect(Ljava/lang/String;ILcom/lge/systemservice/core/IWfdServiceListener;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v3, 0x1

    goto :goto_0

    .end local v0    # "_listener":Lcom/lge/systemservice/core/IWfdServiceListener;
    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v4, 0x0

    iput-object v4, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public setTargetIpAddress_Url(I)V
    .locals 4
    .param p1, "inet"    # I

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v2, "WfdManager"

    const-string v3, "setTargetIpAddress_Url: fail to get WfdService"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->setTargetIpAddress_Url(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public setTargetRtspPort(I)V
    .locals 4
    .param p1, "port"    # I

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v2, "WfdManager"

    const-string v3, "setTargetRtspPort: fail to get WfdService"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->setTargetRtspPort(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public setTargetUrl(Ljava/lang/String;)V
    .locals 4
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v2, "WfdManager"

    const-string v3, "setTargetUrl: fail to get WfdService"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->setTargetUrl(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public setWfdMode(I)V
    .locals 4
    .param p1, "mode"    # I

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v2, "WfdManager"

    const-string v3, "setWfdMode: fail to get WfdService"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->setWfdMode(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public setWifiDisplayEnabled(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "setWifiDisplayEnabled: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->setWifiDisplayEnabled(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method

.method public setWifiDisplayEnabledWithPopUp(Z)Z
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/WfdManager;->getService()Lcom/lge/systemservice/core/IWfdManager;

    move-result-object v1

    .local v1, "wfdService":Lcom/lge/systemservice/core/IWfdManager;
    if-nez v1, :cond_0

    const-string v3, "WfdManager"

    const-string v4, "setWifiDisplayEnabledWithPopUp: fail to get WfdService"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IWfdManager;->setWifiDisplayEnabledWithPopUp(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/lge/systemservice/core/WfdManager;->mService:Lcom/lge/systemservice/core/IWfdManager;

    goto :goto_0
.end method
