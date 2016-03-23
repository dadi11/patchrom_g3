.class public Lcom/lge/wfds/WfdsManager;
.super Ljava/lang/Object;
.source "WfdsManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wfds/WfdsManager$Channel;,
        Lcom/lge/wfds/WfdsManager$WfdsAspSessionListener;,
        Lcom/lge/wfds/WfdsManager$WfdsIntStrListener;,
        Lcom/lge/wfds/WfdsManager$WfdsIntListener;,
        Lcom/lge/wfds/WfdsManager$WfdsStrListener;,
        Lcom/lge/wfds/WfdsManager$WfdsActionListener;,
        Lcom/lge/wfds/WfdsManager$WfdsChannelListener;
    }
.end annotation


# static fields
.field public static final APP_PKG_BUNDLE_KEY:Ljava/lang/String; = "appPkgName"

.field private static final BASE_WFDS_MANAGER:I = 0x900000

.field public static final CMD_ACTION_LISTENER_FAILED:I = 0x90001f

.field public static final CMD_ACTION_LISTENER_SUCCEEDED:I = 0x900020

.field public static final CMD_ADVERTISE_SERVICE:I = 0x900001

.field public static final CMD_ASPSESSION_LISTENER_FAILED:I = 0x900027

.field public static final CMD_ASPSESSION_LISTENER_SUCCEEDED:I = 0x900028

.field public static final CMD_BOUND_PORT:I = 0x900008

.field public static final CMD_CANCEL_ADVERTISE:I = 0x900003

.field public static final CMD_CANCEL_SEEK_SERVICE:I = 0x90000a

.field public static final CMD_CLOSE_SESSION:I = 0x900007

.field public static final CMD_CONFIRM_LISTEN_CHANNEL:I = 0x90005e

.field public static final CMD_CONFIRM_SESSION:I = 0x90000d

.field public static final CMD_CONNECT_SESSION:I = 0x900005

.field public static final CMD_DISCONNECT_SESSION:I = 0x90000e

.field public static final CMD_GET_DEVICE_ADDRESS:I = 0x90005b

.field public static final CMD_GET_LISTEN_CHANNEL:I = 0x90005c

.field public static final CMD_GET_SESSION:I = 0x90000c

.field public static final CMD_INT_LISTENER_FAILED:I = 0x900021

.field public static final CMD_INT_LISTENER_SUCCEEDED:I = 0x900022

.field public static final CMD_INT_STR_LISTENER_FAILED:I = 0x900025

.field public static final CMD_INT_STR_LISTENER_SUCCEEDED:I = 0x900026

.field public static final CMD_REJECT_SESSION:I = 0x90000b

.field public static final CMD_RELEASE_PORT:I = 0x900009

.field public static final CMD_SEEK_SERVICE:I = 0x900004

.field public static final CMD_SERVICE_STATUS_CHANGE:I = 0x900002

.field public static final CMD_SESSION_READY:I = 0x900006

.field public static final CMD_SET_LISTEN_CHANNEL:I = 0x90005d

.field public static final CMD_STR_LISTENER_FAILED:I = 0x900023

.field public static final CMD_STR_LISTENER_SUCCEEDED:I = 0x900024

.field public static final CMD_TEST_CREATE_GROUP:I = 0x900037

.field public static final CMD_TEST_GET_CONNECT_CAPA:I = 0x900034

.field public static final CMD_TEST_GET_DISPLAY_PIN:I = 0x900036

.field public static final CMD_TEST_SET_CONNECT_CAPA:I = 0x900033

.field public static final CMD_TEST_SET_LISTEN_CHANNEL:I = 0x900038

.field public static final CMD_TEST_SET_WSC_CONFIG_METHOD:I = 0x900035

.field public static final CMD_WFDS_SERVICE_BASE:I = 0x901000

.field public static final EXTRA_WFDS_PERSISTENT_UNKNOWN_GROUP:Ljava/lang/String; = "wfdsUnknownGroupId"

.field public static final EXTRA_WFDS_PROV_EVENT:Ljava/lang/String; = "wfdsPdEvent"

.field public static final EXTRA_WIFI_P2P_DEVICE:Ljava/lang/String; = "wifiP2pDevice"

.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.wfds.asp"

.field public static final REASON_BUSY:I = 0x5

.field public static final REASON_DUPLICATED:I = 0x1

.field public static final REASON_FAILURE:I = 0x2

.field public static final REASON_ROLE_CONFLICT:I = 0x6

.field public static final REASON_TIMEOUT:I = 0x3

.field public static final REASON_USER_REQUEST:I = 0x4

.field public static final RESET_DIALOG_LISTENER_BUNDLE_KEY:Ljava/lang/String; = "dialogResetFlag"

.field public static final SERVICE_NAME:Ljava/lang/String; = "WfdsService"

.field public static final SERVICE_REQUEST_ACCEPT:I = 0x3

.field public static final SERVICE_REQUEST_CONNECTED:I = 0x6

.field public static final SERVICE_REQUEST_DEFERRED:I = 0x2

.field public static final SERVICE_REQUEST_DISCONNECTED:I = 0x8

.field public static final SERVICE_REQUEST_FAILED:I = 0x7

.field public static final SERVICE_REQUEST_REJECT:I = 0x4

.field public static final SERVICE_REQUEST_SENT:I = 0x1

.field public static final SERVICE_REQUEST_TIMEOUT:I = 0x5

.field public static final TAG:Ljava/lang/String; = "WfdsManager"

.field public static final WFDS_CONNECTION_CAPABILITY_CLI:I = 0x2

.field public static final WFDS_CONNECTION_CAPABILITY_CLI_GO:I = 0x6

.field public static final WFDS_CONNECTION_CAPABILITY_GO:I = 0x4

.field public static final WFDS_CONNECTION_CAPABILITY_NEW:I = 0x1

.field public static final WFDS_CONNECTION_CAPABILITY_NEW_GO:I = 0x5

.field public static final WFDS_CREATE_GROUP_ACTION:Ljava/lang/String; = "com.lge.wfds.CREATE_GROUP"

.field public static final WFDS_DEVICE_CHANGED_ACTION:Ljava/lang/String; = "com.lge.wfds.DEVICE_CHANGED"

.field public static final WFDS_DEVICE_LOST_ACTION:Ljava/lang/String; = "com.lge.wfds.DEVICE_LOST"

.field public static final WFDS_PD_CHANGED_ACTION:Ljava/lang/String; = "com.lge.wfds.PROVISION_DISCOVERY_CHANGED"

.field public static final WFDS_PERSISTENT_RESULT_ACTION:Ljava/lang/String; = "com.lge.wfds.PERSISTENT_RESULT"

.field public static final WFDS_PERSISTENT_UNKNOWN_GROUP_ACTION:Ljava/lang/String; = "com.lge.wfds.PERSISTENT_UNKNOWN_GROUP"

.field public static final WFDS_PORT_STATUS_FAILURE:I = 0x2

.field public static final WFDS_PORT_STATUS_LOCAL_PORT_ALLOWED:I = 0x0

.field public static final WFDS_PORT_STATUS_LOCAL_PORT_BLOCKED:I = 0x1

.field public static final WFDS_PORT_STATUS_REMOTE_PORT_ALLOWED:I = 0x3

.field public static final WFDS_SESSION_STATE_CLOSED:I = 0x3

.field public static final WFDS_SESSION_STATE_INITIATED:I = 0x1

.field public static final WFDS_SESSION_STATE_OPEN:I = 0x0

.field public static final WFDS_SESSION_STATE_REQUESTED:I = 0x2

.field public static final WFDS_SESSION_STATUS_DISASSOCIATED:I = 0x1

.field public static final WFDS_SESSION_STATUS_LOCAL_CLOSED:I = 0x2

.field public static final WFDS_SESSION_STATUS_NO_RESPONSE_FROM_REMOTE:I = 0x5

.field public static final WFDS_SESSION_STATUS_OK:I = 0x0

.field public static final WFDS_SESSION_STATUS_REMOTE_CLOSED:I = 0x3

.field public static final WFDS_SESSION_STATUS_SYSTEM_FAILURE:I = 0x4

.field private static mWfdsManager:Lcom/lge/wfds/WfdsManager;

.field private static mWfdsService:Lcom/lge/wfds/IWfdsManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    sput-object v0, Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;

    return-void
.end method

.method private constructor <init>(Lcom/lge/wfds/IWfdsManager;)V
    .locals 0
    .param p1, "service"    # Lcom/lge/wfds/IWfdsManager;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sput-object p1, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    return-void
.end method

.method static synthetic access$002(Lcom/lge/wfds/IWfdsManager;)Lcom/lge/wfds/IWfdsManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/IWfdsManager;

    .prologue
    sput-object p0, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    return-object p0
.end method

.method static synthetic access$102(Lcom/lge/wfds/WfdsManager;)Lcom/lge/wfds/WfdsManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsManager;

    .prologue
    sput-object p0, Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;

    return-object p0
.end method

.method private static checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V
    .locals 2
    .param p0, "c"    # Lcom/lge/wfds/WfdsManager$Channel;

    .prologue
    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "[WFDS] Channel needs to be initialized"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method

.method private static checkMethod(Lcom/lge/wfds/WfdsDiscoveryMethod;)V
    .locals 2
    .param p0, "method"    # Lcom/lge/wfds/WfdsDiscoveryMethod;

    .prologue
    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "[WFDS] method info is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method

.method public static getInstance()Lcom/lge/wfds/WfdsManager;
    .locals 7

    .prologue
    const/4 v6, 0x0

    sget-object v3, Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;

    if-nez v3, :cond_0

    const-string v3, "WfdsService"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Lcom/lge/wfds/IWfdsManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/wfds/IWfdsManager;

    move-result-object v2

    .local v2, "service":Lcom/lge/wfds/IWfdsManager;
    new-instance v3, Lcom/lge/wfds/WfdsManager;

    invoke-direct {v3, v2}, Lcom/lge/wfds/WfdsManager;-><init>(Lcom/lge/wfds/IWfdsManager;)V

    sput-object v3, Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;

    sget-object v3, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    if-eqz v3, :cond_0

    :try_start_0
    sget-object v3, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    invoke-interface {v3}, Lcom/lge/wfds/IWfdsManager;->asBinder()Landroid/os/IBinder;

    move-result-object v3

    new-instance v4, Lcom/lge/wfds/WfdsManager$1;

    invoke-direct {v4}, Lcom/lge/wfds/WfdsManager$1;-><init>()V

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    sget-object v3, Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;

    return-object v3

    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    sput-object v6, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    sput-object v6, Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;

    goto :goto_0
.end method

.method private getMessenger()Landroid/os/Messenger;
    .locals 2

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    invoke-interface {v1}, Lcom/lge/wfds/IWfdsManager;->getMessenger()Landroid/os/Messenger;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private getSessionMessenger()Landroid/os/Messenger;
    .locals 2

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    invoke-interface {v1}, Lcom/lge/wfds/IWfdsManager;->getSessionMessenger()Landroid/os/Messenger;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method


# virtual methods
.method public advertiseService(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILjava/lang/String;IIILjava/lang/String;Lcom/lge/wfds/WfdsManager$WfdsIntListener;)V
    .locals 4
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "accept"    # I
    .param p4, "info"    # Ljava/lang/String;
    .param p5, "status"    # I
    .param p6, "role"    # I
    .param p7, "config"    # I
    .param p8, "deferred_session_response"    # Ljava/lang/String;
    .param p9, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .prologue
    const-string v2, "WfdsManager"

    const-string v3, "AdvertiseService method called"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p2, :cond_0

    :goto_0
    return-void

    :cond_0
    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    const/4 v2, 0x1

    invoke-direct {v0, p2, v2}, Lcom/lge/wfds/WfdsDiscoveryMethod;-><init>(Ljava/lang/String;I)V

    .local v0, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v0, :cond_1

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    if-nez v2, :cond_2

    :cond_1
    const-string v2, "WfdsManager"

    const-string v3, "AdvertiseService is failed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2, p3}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setAcceptMethod(I)V

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2, p5}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setServiceStatus(I)V

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2, p4}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setServiceInfo(Ljava/lang/String;)V

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2, p6}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setNetworkRole(I)V

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2, p7}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setNetworkConfig(I)V

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    const v2, 0x900001

    iput v2, v1, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v1, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p9}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v1, Landroid/os/Message;->arg2:I

    invoke-virtual {v1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v1}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public boundPort(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILjava/lang/String;IILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 5
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "mac"    # Ljava/lang/String;
    .param p3, "id"    # I
    .param p4, "ip"    # Ljava/lang/String;
    .param p5, "port"    # I
    .param p6, "proto"    # I
    .param p7, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    if-eqz p2, :cond_0

    const/4 v2, -0x1

    if-ne p3, v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "WfdsManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "BoundPort method called "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v1, p2, p3}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;I)V

    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    invoke-virtual {v1, p5, p6}, Lcom/lge/wfds/session/AspSession;->addPort(II)V

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v2, 0x900008

    iput v2, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p7}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg2:I

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public cancelAdvertiseService(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "id"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v0, "WfdsManager"

    const-string v1, "cancelAdvertiseService method called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x900003

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method

.method public cancelSeekService(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "id"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v0, "WfdsManager"

    const-string v1, "cancelSeekService method called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x90000a

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method

.method public closeSession(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 5
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "mac"    # Ljava/lang/String;
    .param p3, "id"    # I
    .param p4, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    if-eqz p2, :cond_0

    const/4 v2, -0x1

    if-ne p3, v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "WfdsManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "ClosePort method called "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v1, p2, p3}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;I)V

    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v2, 0x900007

    iput v2, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p4}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg2:I

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public confirmListenChannel(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsIntListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "iChannel"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .prologue
    const-string v0, "WfdsManager"

    const-string v1, "confirmListenChannel method called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x90005e

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method

.method public confirmSessions(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;IZLjava/lang/String;Lcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 8
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "addr"    # Ljava/lang/String;
    .param p3, "id"    # I
    .param p4, "confirmed"    # Z
    .param p5, "pinNumber"    # Ljava/lang/String;
    .param p6, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const v7, 0x90000d

    const/4 v6, 0x1

    if-eqz p2, :cond_0

    const/4 v3, -0x1

    if-ne p3, v3, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v3, "WfdsManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "ConfirmSessions method called "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    if-nez p3, :cond_4

    iput v7, v1, Landroid/os/Message;->what:I

    if-ne p4, v6, :cond_3

    if-eqz p5, :cond_2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "true "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "confirmMsg":Ljava/lang/String;
    :goto_1
    invoke-virtual {v1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v3

    const-string v4, "confirmMsg"

    invoke-virtual {v3, v4, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .end local v0    # "confirmMsg":Ljava/lang/String;
    :goto_2
    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v3

    iput v3, v1, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p6}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v3

    iput v3, v1, Landroid/os/Message;->arg2:I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget v3, v1, Landroid/os/Message;->what:I

    if-ne v3, v7, :cond_6

    iget-object v3, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v3, v1}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0

    :cond_2
    const-string v0, "true"

    .restart local v0    # "confirmMsg":Ljava/lang/String;
    goto :goto_1

    .end local v0    # "confirmMsg":Ljava/lang/String;
    :cond_3
    const-string v0, "false"

    .restart local v0    # "confirmMsg":Ljava/lang/String;
    goto :goto_1

    .end local v0    # "confirmMsg":Ljava/lang/String;
    :cond_4
    new-instance v2, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v2, p2, p3}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;I)V

    .local v2, "session":Lcom/lge/wfds/session/AspSession;
    if-ne p4, v6, :cond_5

    const v3, 0x900006

    iput v3, v1, Landroid/os/Message;->what:I

    :goto_3
    invoke-virtual {v1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4, v2}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    goto :goto_2

    :cond_5
    const v3, 0x90000b

    iput v3, v1, Landroid/os/Message;->what:I

    goto :goto_3

    .end local v2    # "session":Lcom/lge/wfds/session/AspSession;
    :cond_6
    iget-object v3, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v3, v1}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto/16 :goto_0
.end method

.method public connectSessions(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILjava/lang/String;IILcom/lge/wfds/WfdsManager$WfdsIntStrListener;)V
    .locals 8
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "addr"    # Ljava/lang/String;
    .param p3, "id"    # I
    .param p4, "info"    # Ljava/lang/String;
    .param p5, "role"    # I
    .param p6, "config"    # I
    .param p7, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntStrListener;

    .prologue
    if-nez p2, :cond_0

    :goto_0
    return-void

    :cond_0
    const-string v1, "0x%08x"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .local v7, "strId":Ljava/lang/String;
    const-string v1, "WfdsManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ConnectSessions method called "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/lge/wfds/WfdsPdMethod;

    move-object v1, p2

    move v2, p3

    move-object v3, p4

    move v4, p5

    move v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/WfdsPdMethod;-><init>(Ljava/lang/String;ILjava/lang/String;II)V

    .local v0, "method":Lcom/lge/wfds/WfdsPdMethod;
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v6

    .local v6, "msg":Landroid/os/Message;
    const v1, 0x900005

    iput v1, v6, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v1

    iput v1, v6, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p7}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v6, Landroid/os/Message;->arg2:I

    invoke-virtual {v6}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v6}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public createGroup(Lcom/lge/wfds/WfdsManager$Channel;ILjava/lang/String;Lcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "channel"    # I
    .param p3, "ssid"    # Ljava/lang/String;
    .param p4, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v1, "WfdsManager"

    const-string v2, "createGroup method is called"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v1, 0x900037

    iput v1, v0, Landroid/os/Message;->what:I

    iput p2, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p4}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg2:I

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "ssid"

    invoke-virtual {v1, v2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public deinitEventListener(I)V
    .locals 2
    .param p1, "listenerId"    # I

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    invoke-interface {v1, p1}, Lcom/lge/wfds/IWfdsManager;->deinitEventListener(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public disconnectSession(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 2
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v1, 0x90000e

    iput v1, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p2}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg2:I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public getConnectCapability(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsIntListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .prologue
    const-string v1, "WfdsManager"

    const-string v2, "getConnectCapability method called"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v1, 0x900034

    iput v1, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p2}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg2:I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public getDeviceAddress(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsStrListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsStrListener;

    .prologue
    const-string v1, "WfdsManager"

    const-string v2, "getDeviceAddress method called"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v1, 0x90005b

    iput v1, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p2}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg2:I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public getDisplayPin(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsIntListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .prologue
    const-string v1, "WfdsManager"

    const-string v2, "get Display PIN: method called"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v1, 0x900036

    iput v1, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p2}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg2:I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public getListenChannel(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsIntListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .prologue
    const-string v1, "WfdsManager"

    const-string v2, "getListenChannel method called"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v1, 0x90005c

    iput v1, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p2}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v1

    iput v1, v0, Landroid/os/Message;->arg2:I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v1, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public getSession(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILcom/lge/wfds/WfdsManager$WfdsAspSessionListener;)V
    .locals 5
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "sessionMac"    # Ljava/lang/String;
    .param p3, "sessionId"    # I
    .param p4, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsAspSessionListener;

    .prologue
    if-eqz p2, :cond_0

    const/4 v2, -0x1

    if-ne p3, v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "WfdsManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "GetSession method called "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v1, p2, p3}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;I)V

    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v2, 0x90000c

    iput v2, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p4}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg2:I

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public initEventListener(Lcom/lge/wfds/IWfdsEventListener;)I
    .locals 3
    .param p1, "listener"    # Lcom/lge/wfds/IWfdsEventListener;

    .prologue
    const/4 v1, -0x1

    if-eqz p1, :cond_0

    :try_start_0
    sget-object v2, Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;

    invoke-interface {v2, p1}, Lcom/lge/wfds/IWfdsManager;->initEventListener(Lcom/lge/wfds/IWfdsEventListener;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method

.method public initialize(Landroid/content/Context;Landroid/os/Looper;Lcom/lge/wfds/WfdsManager$WfdsChannelListener;)Lcom/lge/wfds/WfdsManager$Channel;
    .locals 6
    .param p1, "srcContext"    # Landroid/content/Context;
    .param p2, "srcLooper"    # Landroid/os/Looper;
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    .prologue
    const/4 v3, 0x0

    invoke-direct {p0}, Lcom/lge/wfds/WfdsManager;->getMessenger()Landroid/os/Messenger;

    move-result-object v1

    .local v1, "messenger":Landroid/os/Messenger;
    if-nez v1, :cond_1

    move-object v0, v3

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    invoke-direct {p0}, Lcom/lge/wfds/WfdsManager;->getSessionMessenger()Landroid/os/Messenger;

    move-result-object v2

    .local v2, "sessionMessenger":Landroid/os/Messenger;
    if-nez v2, :cond_2

    move-object v0, v3

    goto :goto_0

    :cond_2
    new-instance v0, Lcom/lge/wfds/WfdsManager$Channel;

    invoke-direct {v0, p1, p2, p3}, Lcom/lge/wfds/WfdsManager$Channel;-><init>(Landroid/content/Context;Landroid/os/Looper;Lcom/lge/wfds/WfdsManager$WfdsChannelListener;)V

    .local v0, "c":Lcom/lge/wfds/WfdsManager$Channel;
    iget-object v4, v0, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    # getter for: Lcom/lge/wfds/WfdsManager$Channel;->mHandler:Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;
    invoke-static {v0}, Lcom/lge/wfds/WfdsManager$Channel;->access$400(Lcom/lge/wfds/WfdsManager$Channel;)Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;

    move-result-object v5

    invoke-virtual {v4, p1, v5, v1}, Lcom/android/internal/util/AsyncChannel;->connectSync(Landroid/content/Context;Landroid/os/Handler;Landroid/os/Messenger;)I

    move-result v4

    if-nez v4, :cond_3

    iget-object v4, v0, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    # getter for: Lcom/lge/wfds/WfdsManager$Channel;->mHandler:Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;
    invoke-static {v0}, Lcom/lge/wfds/WfdsManager$Channel;->access$400(Lcom/lge/wfds/WfdsManager$Channel;)Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;

    move-result-object v5

    invoke-virtual {v4, p1, v5, v2}, Lcom/android/internal/util/AsyncChannel;->connectSync(Landroid/content/Context;Landroid/os/Handler;Landroid/os/Messenger;)I

    move-result v4

    if-eqz v4, :cond_0

    :cond_3
    move-object v0, v3

    goto :goto_0
.end method

.method public releasePort(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILjava/lang/String;IILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 5
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "mac"    # Ljava/lang/String;
    .param p3, "id"    # I
    .param p4, "ip"    # Ljava/lang/String;
    .param p5, "port"    # I
    .param p6, "proto"    # I
    .param p7, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    if-eqz p2, :cond_0

    const/4 v2, -0x1

    if-ne p3, v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "WfdsManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "ReleasePort method called "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v1, p2, p3, p4}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    invoke-virtual {v1, p5, p6}, Lcom/lge/wfds/session/AspSession;->addPort(II)V

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v2, 0x900009

    iput v2, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p7}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg2:I

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public seekService(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Lcom/lge/wfds/WfdsManager$WfdsIntListener;)V
    .locals 4
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "search"    # I
    .param p4, "mac"    # Ljava/lang/String;
    .param p5, "req"    # Ljava/lang/String;
    .param p6, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .prologue
    const-string v2, "WfdsManager"

    const-string v3, "SeekService method called"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p2, :cond_0

    :goto_0
    return-void

    :cond_0
    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    const/4 v2, 0x2

    invoke-direct {v0, p2, v2}, Lcom/lge/wfds/WfdsDiscoveryMethod;-><init>(Ljava/lang/String;I)V

    .local v0, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v0, :cond_1

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    if-nez v2, :cond_2

    :cond_1
    const-string v2, "WfdsManager"

    const-string v3, "SeekService is failed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v2, p3}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->setSearchMethod(I)V

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v2, p4}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->setP2pAddress(Ljava/lang/String;)V

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v2, p5}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->setServiceInfoRequest(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    const v2, 0x900004

    iput v2, v1, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v1, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p6}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v1, Landroid/os/Message;->arg2:I

    invoke-virtual {v1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v1}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public serviceStatusChange(Lcom/lge/wfds/WfdsManager$Channel;IILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 4
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "id"    # I
    .param p3, "status"    # I
    .param p4, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v2, "WfdsManager"

    const-string v3, "ServiceStatusChange method called"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    const/4 v2, 0x1

    invoke-direct {v0, p2, v2}, Lcom/lge/wfds/WfdsDiscoveryMethod;-><init>(II)V

    .local v0, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v0, :cond_0

    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    if-nez v2, :cond_1

    :cond_0
    const-string v2, "WfdsManager"

    const-string v3, "ServiceStatusChange is failed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_1
    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2, p3}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setServiceStatus(I)V

    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    const v2, 0x900002

    iput v2, v1, Landroid/os/Message;->what:I

    iput p2, v1, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p4}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v1, Landroid/os/Message;->arg2:I

    invoke-virtual {v1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v1}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public setConfigMethod(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "method"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v0, "WfdsManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setConfigMethod is called: method ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x900035

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method

.method public setConnectCapability(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "val"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v0, "WfdsManager"

    const-string v1, "setConnectCapability method called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x900033

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method

.method public setListenChannel(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "iChannel"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v0, "WfdsManager"

    const-string v1, "setListenChannel method called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x90005d

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method

.method public setSesstionReady(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/String;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 5
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "mac"    # Ljava/lang/String;
    .param p3, "id"    # I
    .param p4, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    if-eqz p2, :cond_0

    const/4 v2, -0x1

    if-ne p3, v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "WfdsManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SetSesstionReady method called "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v1, p2, p3}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;I)V

    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    const v2, 0x900006

    iput v2, v0, Landroid/os/Message;->what:I

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsManager$Channel;->getEventListenerId()I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p4}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    iput v2, v0, Landroid/os/Message;->arg2:I

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v2, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v2, v0}, Lcom/android/internal/util/AsyncChannel;->sendMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method public setWfdsListenChannel(Lcom/lge/wfds/WfdsManager$Channel;ILcom/lge/wfds/WfdsManager$WfdsActionListener;)V
    .locals 3
    .param p1, "c"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p2, "listenChn"    # I
    .param p3, "listener"    # Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .prologue
    const-string v0, "WfdsManager"

    const-string v1, "setWfdsListenChannel method called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1}, Lcom/lge/wfds/WfdsManager;->checkChannel(Lcom/lge/wfds/WfdsManager$Channel;)V

    iget-object v0, p1, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    const v1, 0x900038

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I
    invoke-static {p1, p3}, Lcom/lge/wfds/WfdsManager$Channel;->access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I

    move-result v2

    invoke-virtual {v0, v1, p2, v2}, Lcom/android/internal/util/AsyncChannel;->sendMessage(III)V

    return-void
.end method
