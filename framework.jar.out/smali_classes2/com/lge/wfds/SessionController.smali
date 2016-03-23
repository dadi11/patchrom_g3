.class public Lcom/lge/wfds/SessionController;
.super Lcom/android/internal/util/StateMachine;
.source "SessionController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wfds/SessionController$SessionCtrlBroadcastRcvr;,
        Lcom/lge/wfds/SessionController$SessionOpenedState;,
        Lcom/lge/wfds/SessionController$SessionOpeningState;,
        Lcom/lge/wfds/SessionController$SessionDeferredState;,
        Lcom/lge/wfds/SessionController$SessionReadyState;,
        Lcom/lge/wfds/SessionController$SessionClosedState;,
        Lcom/lge/wfds/SessionController$DefaultState;
    }
.end annotation


# static fields
.field public static final ASP_ACK_ADDED_SESSION_RECEIVED:I = 0x901063

.field public static final ASP_ACK_UNKNOWN_RECEIVED:I = 0x901065

.field public static final ASP_ACK_VERSION_RECEIVED:I = 0x901064

.field public static final ASP_ADDED_SESSION_RECEIVED:I = 0x90105e

.field public static final ASP_ALLOWED_PORT_RECEIVED:I = 0x901061

.field public static final ASP_DEFERRED_SESSION_RECEIVED:I = 0x901062

.field public static final ASP_REJECTED_SESSION_RECEIVED:I = 0x90105f

.field public static final ASP_REMOVE_SESSION_RECEIVED:I = 0x901060

.field public static final ASP_REQUEST_SESSION_RECEIVED:I = 0x90105d

.field public static final ASP_SESSION_OPEN_FAILED:I = 0x90105b

.field public static final ASP_VERSION_RECEIVED:I = 0x90105c

.field private static final BASE:I = 0x901032

.field private static final CMD_REQUEST_SESSION:I = 0x901033

.field private static final CMD_SESSION_COUNT_ZERO_TIMEOUT:I = 0x901037

.field private static final CMD_SESSION_DEFERRED_TIMEOUT:I = 0x901038

.field private static final CMD_SESSION_OPEN_FAILED_TIMEOUT:I = 0x901036

.field private static final CMD_VERSION:I = 0x901034

.field private static final CMD_VERSION_EXCHANGED:I = 0x901035

.field public static final EVT_P2P_DISABLED:I = 0x90104b

.field public static final EVT_P2P_DISCONNECTED:I = 0x901049

.field public static final EVT_P2P_GROUP_INFO_AVLBL:I = 0x90104a

.field public static final EVT_P2P_GROUP_REMOVED:I = 0x901048

.field public static final EVT_REQUEST_OPEN_SESSION:I = 0x901047

.field private static final SESSION_AFTER_COUNT_ZERO_TIME:I = 0xea60

.field private static final SESSION_AFTER_COUNT_ZERO_TIMEOUT_ACTION:Ljava/lang/String; = "com.lge.wfds.session.COUNT_ZERO_TIMEOUT"

.field private static final SESSION_AFTER_OPEN_FAILED_TIME:I = 0x2710

.field private static final SESSION_AFTER_OPEN_FAILED_TIMEOUT_ACTION:Ljava/lang/String; = "com.lge.wfds.session.OPEN_FAILED_TIMEOUT"

.field private static final SESSION_DEFERRED_TIME:I = 0x1d4c0

.field private static final SESSION_DEFERRED_TIMEOUT_ACTION:Ljava/lang/String; = "com.lge.wfds.session.DEFERRED_TIMEOUT"

.field private static final TAG:Ljava/lang/String; = "WfdsSession:Controller"

.field private static final macAddressPattern:Ljava/util/regex/Pattern;


# instance fields
.field private bVersionReceived:Z

.field private bVersionSent:Z

.field private mAlarmManager:Landroid/app/AlarmManager;

.field private mContext:Landroid/content/Context;

.field private mDefaultState:Lcom/lge/wfds/SessionController$DefaultState;

.field private mGroup:Landroid/net/wifi/p2p/WifiP2pGroup;

.field private mPortIsolation:Lcom/lge/wfds/session/PortIsolation;

.field private mReplyChannel:Lcom/android/internal/util/AsyncChannel;

.field private mRequestedSession:Lcom/lge/wfds/session/AspSession;

.field private mSessionClosedState:Lcom/lge/wfds/SessionController$SessionClosedState;

.field private mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

.field private mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

.field private mSessionDeferredState:Lcom/lge/wfds/SessionController$SessionDeferredState;

.field private mSessionDeferredTimeoutIntent:Landroid/app/PendingIntent;

.field private mSessionList:Lcom/lge/wfds/session/AspSessionList;

.field private mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;

.field private mSessionOpenedState:Lcom/lge/wfds/SessionController$SessionOpenedState;

.field private mSessionOpeningState:Lcom/lge/wfds/SessionController$SessionOpeningState;

.field private mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

.field private mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

.field private mWfdsDialog:Lcom/lge/wfds/WfdsDialog;

.field private mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;

.field private mWfdsEvent:Lcom/lge/wfds/WfdsEvent;

.field private mWfdsNative:Lcom/lge/wfds/WfdsNative;

.field private mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

.field private mWifiManager:Landroid/net/wifi/WifiManager;

.field private mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 117
    const-string v0, "(?:[0-9a-f]{2}:){5}[0-9a-f]{2}"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/lge/wfds/SessionController;->macAddressPattern:Ljava/util/regex/Pattern;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Lcom/lge/wfds/WfdsNative;Lcom/lge/wfds/WfdsEvent;Lcom/android/internal/util/StateMachine;Lcom/lge/wfds/WfdsDiscoveryStore;Landroid/os/Looper;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "wfdsNative"    # Lcom/lge/wfds/WfdsNative;
    .param p3, "wfdsEvent"    # Lcom/lge/wfds/WfdsEvent;
    .param p4, "stateMachine"    # Lcom/android/internal/util/StateMachine;
    .param p5, "wfdsDiscoveryStore"    # Lcom/lge/wfds/WfdsDiscoveryStore;
    .param p6, "looper"    # Landroid/os/Looper;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 121
    const-string v0, "WfdsSession:Controller"

    invoke-direct {p0, v0, p6}, Lcom/android/internal/util/StateMachine;-><init>(Ljava/lang/String;Landroid/os/Looper;)V

    .line 39
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 40
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    .line 41
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;

    .line 42
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;

    .line 43
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;

    .line 44
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    .line 45
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;

    .line 46
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    .line 47
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;

    .line 48
    new-instance v0, Lcom/android/internal/util/AsyncChannel;

    invoke-direct {v0}, Lcom/android/internal/util/AsyncChannel;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;

    .line 51
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;

    .line 52
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

    .line 53
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredTimeoutIntent:Landroid/app/PendingIntent;

    .line 54
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    .line 56
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mGroup:Landroid/net/wifi/p2p/WifiP2pGroup;

    .line 57
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;

    .line 59
    iput-boolean v2, p0, Lcom/lge/wfds/SessionController;->bVersionReceived:Z

    .line 60
    iput-boolean v2, p0, Lcom/lge/wfds/SessionController;->bVersionSent:Z

    .line 62
    new-instance v0, Lcom/lge/wfds/SessionController$DefaultState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/SessionController$DefaultState;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mDefaultState:Lcom/lge/wfds/SessionController$DefaultState;

    .line 63
    new-instance v0, Lcom/lge/wfds/SessionController$SessionClosedState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/SessionController$SessionClosedState;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionClosedState:Lcom/lge/wfds/SessionController$SessionClosedState;

    .line 64
    new-instance v0, Lcom/lge/wfds/SessionController$SessionReadyState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/SessionController$SessionReadyState;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

    .line 65
    new-instance v0, Lcom/lge/wfds/SessionController$SessionDeferredState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/SessionController$SessionDeferredState;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredState:Lcom/lge/wfds/SessionController$SessionDeferredState;

    .line 66
    new-instance v0, Lcom/lge/wfds/SessionController$SessionOpeningState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/SessionController$SessionOpeningState;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpeningState:Lcom/lge/wfds/SessionController$SessionOpeningState;

    .line 67
    new-instance v0, Lcom/lge/wfds/SessionController$SessionOpenedState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/SessionController$SessionOpenedState;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpenedState:Lcom/lge/wfds/SessionController$SessionOpenedState;

    .line 123
    iput-object p1, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    .line 124
    iput-object p4, p0, Lcom/lge/wfds/SessionController;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    .line 125
    iput-object p2, p0, Lcom/lge/wfds/SessionController;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    .line 126
    iput-object p3, p0, Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;

    .line 127
    iput-object p5, p0, Lcom/lge/wfds/SessionController;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;

    .line 129
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    const-string/jumbo v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 130
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 131
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWifiManager:Landroid/net/wifi/WifiManager;

    const-string v1, "WfdsAsp"

    invoke-virtual {v0, v1}, Landroid/net/wifi/WifiManager;->createMulticastLock(Ljava/lang/String;)Landroid/net/wifi/WifiManager$MulticastLock;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;

    .line 134
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    const-string v1, "alarm"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mAlarmManager:Landroid/app/AlarmManager;

    .line 135
    new-instance v0, Lcom/lge/wfds/session/AspSessionList;

    const-string v1, "WfdsSession:List"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/lge/wfds/session/AspSessionList;-><init>(Ljava/lang/String;Z)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    .line 136
    new-instance v0, Lcom/lge/wfds/session/PortIsolation;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-direct {v0, v1}, Lcom/lge/wfds/session/PortIsolation;-><init>(Lcom/lge/wfds/session/AspSessionList;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;

    .line 137
    new-instance v0, Lcom/lge/wfds/session/UdpDataManager;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-direct {v0, p0, v1}, Lcom/lge/wfds/session/UdpDataManager;-><init>(Lcom/android/internal/util/StateMachine;Lcom/lge/wfds/session/AspSessionList;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    .line 138
    new-instance v0, Lcom/lge/wfds/WfdsDialog;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, p0}, Lcom/lge/wfds/WfdsDialog;-><init>(Landroid/content/Context;Lcom/android/internal/util/StateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;

    .line 140
    invoke-direct {p0}, Lcom/lge/wfds/SessionController;->registerSessionCtrlBroadcastRcvr()V

    .line 142
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mDefaultState:Lcom/lge/wfds/SessionController$DefaultState;

    invoke-virtual {p0, v0}, Lcom/lge/wfds/SessionController;->addState(Lcom/android/internal/util/State;)V

    .line 143
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionClosedState:Lcom/lge/wfds/SessionController$SessionClosedState;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mDefaultState:Lcom/lge/wfds/SessionController$DefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/SessionController;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 144
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mDefaultState:Lcom/lge/wfds/SessionController$DefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/SessionController;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 145
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredState:Lcom/lge/wfds/SessionController$SessionDeferredState;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/SessionController;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 146
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpeningState:Lcom/lge/wfds/SessionController$SessionOpeningState;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/SessionController;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 147
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpenedState:Lcom/lge/wfds/SessionController$SessionOpenedState;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/SessionController;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 149
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionClosedState:Lcom/lge/wfds/SessionController$SessionClosedState;

    invoke-virtual {p0, v0}, Lcom/lge/wfds/SessionController;->setInitialState(Lcom/android/internal/util/State;)V

    .line 150
    return-void
.end method

.method static synthetic access$002(Lcom/lge/wfds/SessionController;Landroid/net/wifi/p2p/WifiP2pGroup;)Landroid/net/wifi/p2p/WifiP2pGroup;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/lge/wfds/SessionController;->mGroup:Landroid/net/wifi/p2p/WifiP2pGroup;

    return-object p1
.end method

.method static synthetic access$100(Lcom/lge/wfds/SessionController;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 34
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$1000(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionOpeningState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpeningState:Lcom/lge/wfds/SessionController$SessionOpeningState;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/lge/wfds/SessionController;)Lcom/android/internal/util/StateMachine;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/lge/wfds/SessionController;)Landroid/app/PendingIntent;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

    return-object v0
.end method

.method static synthetic access$1302(Lcom/lge/wfds/SessionController;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Landroid/app/PendingIntent;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/lge/wfds/SessionController;->mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

    return-object p1
.end method

.method static synthetic access$1400(Lcom/lge/wfds/SessionController;Ljava/lang/String;I)Landroid/app/PendingIntent;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # I

    .prologue
    .line 34
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/SessionController;->startTimeout(Ljava/lang/String;I)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1500(Lcom/lge/wfds/SessionController;Ljava/lang/String;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 34
    invoke-direct {p0, p1}, Lcom/lge/wfds/SessionController;->isKnownService(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$1600(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1700(Lcom/lge/wfds/SessionController;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/lge/wfds/SessionController;->sendRequestSession()V

    return-void
.end method

.method static synthetic access$1800(Lcom/lge/wfds/SessionController;ILcom/lge/wfds/session/AspSession;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # I
    .param p2, "x2"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    .line 34
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/SessionController;->startAspSessionRequest(ILcom/lge/wfds/session/AspSession;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$1900(Lcom/lge/wfds/SessionController;Ljava/lang/String;Ljava/lang/Integer;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Ljava/lang/Integer;

    .prologue
    .line 34
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/SessionController;->removePortIsolation(Ljava/lang/String;Ljava/lang/Integer;)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/wfds/SessionController;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/lge/wfds/SessionController;->stopAspSessionRequest()V

    return-void
.end method

.method static synthetic access$2000(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;II)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/lge/wfds/session/AspSession;
    .param p2, "x2"    # I
    .param p3, "x3"    # I

    .prologue
    .line 34
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/SessionController;->sendSessionStatus(Lcom/lge/wfds/session/AspSession;II)V

    return-void
.end method

.method static synthetic access$2100(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionReadyState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;

    return-object v0
.end method

.method static synthetic access$2200(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionOpenedState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpenedState:Lcom/lge/wfds/SessionController$SessionOpenedState;

    return-object v0
.end method

.method static synthetic access$2400(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2500(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionClosedState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionClosedState:Lcom/lge/wfds/SessionController$SessionClosedState;

    return-object v0
.end method

.method static synthetic access$2600(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2700(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2800(Lcom/lge/wfds/SessionController;Landroid/os/Message;ILcom/lge/wfds/session/AspSession;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I
    .param p3, "x3"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    .line 34
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;ILcom/lge/wfds/session/AspSession;)V

    return-void
.end method

.method static synthetic access$2900(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    .line 34
    invoke-direct {p0, p1}, Lcom/lge/wfds/SessionController;->sessionToString(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;

    return-object v0
.end method

.method static synthetic access$3000(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$302(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;)Lcom/lge/wfds/session/AspSession;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;

    return-object p1
.end method

.method static synthetic access$3100(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3200(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionDeferredState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredState:Lcom/lge/wfds/SessionController$SessionDeferredState;

    return-object v0
.end method

.method static synthetic access$3300(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3400(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3500(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3600(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/WfdsDiscoveryStore;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;

    return-object v0
.end method

.method static synthetic access$3800(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/WfdsDialog;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;

    return-object v0
.end method

.method static synthetic access$3900(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$400(Lcom/lge/wfds/SessionController;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/lge/wfds/SessionController;->stopSessionReadyTimeouts()V

    return-void
.end method

.method static synthetic access$4000(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/WfdsEvent;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;

    return-object v0
.end method

.method static synthetic access$4100(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4200(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4300()Ljava/util/regex/Pattern;
    .locals 1

    .prologue
    .line 34
    sget-object v0, Lcom/lge/wfds/SessionController;->macAddressPattern:Ljava/util/regex/Pattern;

    return-object v0
.end method

.method static synthetic access$4402(Lcom/lge/wfds/SessionController;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Landroid/app/PendingIntent;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredTimeoutIntent:Landroid/app/PendingIntent;

    return-object p1
.end method

.method static synthetic access$4500(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4600(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4700(Lcom/lge/wfds/SessionController;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Z

    .prologue
    .line 34
    invoke-direct {p0, p1}, Lcom/lge/wfds/SessionController;->setP2pPowerSave(Z)V

    return-void
.end method

.method static synthetic access$4800(Lcom/lge/wfds/SessionController;)Landroid/net/wifi/WifiManager$MulticastLock;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;

    return-object v0
.end method

.method static synthetic access$4900(Lcom/lge/wfds/SessionController;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-boolean v0, p0, Lcom/lge/wfds/SessionController;->bVersionReceived:Z

    return v0
.end method

.method static synthetic access$4902(Lcom/lge/wfds/SessionController;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Z

    .prologue
    .line 34
    iput-boolean p1, p0, Lcom/lge/wfds/SessionController;->bVersionReceived:Z

    return p1
.end method

.method static synthetic access$500(Lcom/lge/wfds/SessionController;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/lge/wfds/SessionController;->stopDeferredTimeout()V

    return-void
.end method

.method static synthetic access$5000(Lcom/lge/wfds/SessionController;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-boolean v0, p0, Lcom/lge/wfds/SessionController;->bVersionSent:Z

    return v0
.end method

.method static synthetic access$5002(Lcom/lge/wfds/SessionController;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Z

    .prologue
    .line 34
    iput-boolean p1, p0, Lcom/lge/wfds/SessionController;->bVersionSent:Z

    return p1
.end method

.method static synthetic access$5102(Lcom/lge/wfds/SessionController;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Landroid/app/PendingIntent;

    .prologue
    .line 34
    iput-object p1, p0, Lcom/lge/wfds/SessionController;->mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;

    return-object p1
.end method

.method static synthetic access$5200(Lcom/lge/wfds/SessionController;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # I

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->removeMessages(I)V

    return-void
.end method

.method static synthetic access$5300(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5400(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 34
    invoke-virtual {p0, p1}, Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$600(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/PortIsolation;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;

    return-object v0
.end method

.method static synthetic access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    return-object v0
.end method

.method static synthetic access$800(Lcom/lge/wfds/SessionController;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    invoke-direct {p0}, Lcom/lge/wfds/SessionController;->printSessionListInfo()V

    return-void
.end method

.method static synthetic access$900(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/UdpDataManager;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/SessionController;

    .prologue
    .line 34
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    return-object v0
.end method

.method private isKnownService(Ljava/lang/String;)Z
    .locals 2
    .param p1, "service_mac"    # Ljava/lang/String;

    .prologue
    .line 1016
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v1, p1}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v0

    .line 1017
    .local v0, "sessionList":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    return v1
.end method

.method private obtainDstMessage(Landroid/os/Message;)Landroid/os/Message;
    .locals 2
    .param p1, "srcMsg"    # Landroid/os/Message;

    .prologue
    .line 963
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .line 964
    .local v0, "msg":Landroid/os/Message;
    iget v1, p1, Landroid/os/Message;->arg2:I

    iput v1, v0, Landroid/os/Message;->arg2:I

    .line 965
    return-object v0
.end method

.method private printSessionListInfo()V
    .locals 7

    .prologue
    .line 1021
    iget-object v4, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    if-nez v4, :cond_0

    .line 1022
    const-string v4, "WfdsSession:Controller"

    const-string v5, "mSessionList is not created yet !!"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1037
    :goto_0
    return-void

    .line 1024
    :cond_0
    const-string v4, "WfdsSession:Controller"

    const-string v5, "========================"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1025
    const-string v4, "WfdsSession:Controller"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "SessionMap Size :"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v6}, Lcom/lge/wfds/session/AspSessionList;->getSessionSize()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1026
    const-string v4, "WfdsSession:Controller"

    const-string v5, "------------------------"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1028
    const/4 v0, 0x1

    .line 1029
    .local v0, "idx":I
    iget-object v4, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v4}, Lcom/lge/wfds/session/AspSessionList;->getSessionList()Ljava/util/Iterator;

    move-result-object v3

    .line 1030
    .local v3, "sessionList":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1031
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/wfds/session/AspSession;

    .line 1032
    .local v2, "session":Lcom/lge/wfds/session/AspSession;
    const-string v4, "WfdsSession:Controller"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    add-int/lit8 v1, v0, 0x1

    .end local v0    # "idx":I
    .local v1, "idx":I
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1033
    const-string v4, "WfdsSession:Controller"

    invoke-direct {p0, v2}, Lcom/lge/wfds/SessionController;->sessionToString(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v1

    .line 1034
    .end local v1    # "idx":I
    .restart local v0    # "idx":I
    goto :goto_1

    .line 1035
    .end local v2    # "session":Lcom/lge/wfds/session/AspSession;
    :cond_1
    const-string v4, "WfdsSession:Controller"

    const-string v5, "========================"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private registerSessionCtrlBroadcastRcvr()V
    .locals 3

    .prologue
    .line 1107
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    if-nez v1, :cond_0

    .line 1108
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 1110
    .local v0, "mIntentFilter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.wfds.session.OPEN_FAILED_TIMEOUT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1111
    const-string v1, "com.lge.wfds.session.COUNT_ZERO_TIMEOUT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1112
    const-string v1, "com.lge.wfds.session.DEFERRED_TIMEOUT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1114
    new-instance v1, Lcom/lge/wfds/SessionController$SessionCtrlBroadcastRcvr;

    invoke-direct {v1, p0}, Lcom/lge/wfds/SessionController$SessionCtrlBroadcastRcvr;-><init>(Lcom/lge/wfds/SessionController;)V

    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    .line 1115
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 1119
    .end local v0    # "mIntentFilter":Landroid/content/IntentFilter;
    :goto_0
    return-void

    .line 1117
    :cond_0
    const-string v1, "WfdsSession:Controller"

    const-string v2, "registerSessionCtrlBroadcastRcvr: already registered"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private removePortIsolation(Ljava/lang/String;Ljava/lang/Integer;)V
    .locals 1
    .param p1, "session_mac"    # Ljava/lang/String;
    .param p2, "session_id"    # Ljava/lang/Integer;

    .prologue
    .line 1058
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wfds/session/PortIsolation;->disable(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1066
    return-void
.end method

.method private replyToMessage(Landroid/os/Message;I)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "what"    # I

    .prologue
    .line 969
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    if-nez v1, :cond_0

    .line 975
    :goto_0
    return-void

    .line 972
    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wfds/SessionController;->obtainDstMessage(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    .line 973
    .local v0, "dstMsg":Landroid/os/Message;
    iput p2, v0, Landroid/os/Message;->what:I

    .line 974
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, p1, v0}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;Landroid/os/Message;)V

    goto :goto_0
.end method

.method private replyToMessage(Landroid/os/Message;ILcom/lge/wfds/session/AspSession;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "what"    # I
    .param p3, "aspSession"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    .line 978
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    if-nez v1, :cond_0

    .line 985
    :goto_0
    return-void

    .line 981
    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wfds/SessionController;->obtainDstMessage(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    .line 982
    .local v0, "dstMsg":Landroid/os/Message;
    iput p2, v0, Landroid/os/Message;->what:I

    .line 983
    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p3}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 984
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;

    invoke-virtual {v1, p1, v0}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;Landroid/os/Message;)V

    goto :goto_0
.end method

.method private sendRequestSession()V
    .locals 6

    .prologue
    .line 947
    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;

    if-eqz v2, :cond_0

    .line 948
    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    iget-object v3, p0, Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;

    iget-object v3, v3, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v4, p0, Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;

    iget v4, v4, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    .line 949
    .local v1, "sSession":Lcom/lge/wfds/session/AspSession;
    if-eqz v1, :cond_0

    iget-object v2, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v3, v1, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 951
    const-string v2, "WfdsSession:Controller"

    const-string v3, "SEEKER : Send REQUEST_SESSION"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 952
    const-string v2, "WfdsSession:Controller"

    invoke-direct {p0, v1}, Lcom/lge/wfds/SessionController;->sessionToString(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 953
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .line 954
    .local v0, "msg":Landroid/os/Message;
    const v2, 0x901033

    iput v2, v0, Landroid/os/Message;->what:I

    .line 955
    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 956
    invoke-virtual {p0, v0}, Lcom/lge/wfds/SessionController;->sendMessage(Landroid/os/Message;)V

    .line 957
    const v2, 0x90105b

    const-wide/16 v4, 0x1388

    invoke-virtual {p0, v2, v4, v5}, Lcom/lge/wfds/SessionController;->sendMessageDelayed(IJ)V

    .line 960
    .end local v0    # "msg":Landroid/os/Message;
    .end local v1    # "sSession":Lcom/lge/wfds/session/AspSession;
    :cond_0
    return-void
.end method

.method private sendSessionStatus(Lcom/lge/wfds/session/AspSession;II)V
    .locals 3
    .param p1, "session"    # Lcom/lge/wfds/session/AspSession;
    .param p2, "state"    # I
    .param p3, "status"    # I

    .prologue
    .line 1004
    if-eqz p1, :cond_0

    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;

    if-nez v2, :cond_1

    .line 1013
    :cond_0
    :goto_0
    return-void

    .line 1008
    :cond_1
    iget v0, p1, Lcom/lge/wfds/session/AspSession;->session_id:I

    .line 1009
    .local v0, "sessionId":I
    iget-object v1, p1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    .line 1011
    .local v1, "sessionMac":Ljava/lang/String;
    invoke-virtual {p1, p2}, Lcom/lge/wfds/session/AspSession;->setState(I)V

    .line 1012
    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;

    invoke-virtual {v2, v1, v0, p2, p3}, Lcom/lge/wfds/WfdsEvent;->notifySessionStatusToService(Ljava/lang/String;III)V

    goto :goto_0
.end method

.method private sessionToString(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;
    .locals 3
    .param p1, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    .line 1040
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 1041
    .local v0, "sbuf":Ljava/lang/StringBuffer;
    const-string v1, "------------------------"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1042
    if-eqz p1, :cond_0

    .line 1043
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    invoke-virtual {p1}, Lcom/lge/wfds/session/AspSession;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1045
    :cond_0
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v1

    const-string v2, "------------------------"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1046
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private setP2pPowerSave(Z)V
    .locals 1
    .param p1, "enable"    # Z

    .prologue
    .line 1050
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mGroup:Landroid/net/wifi/p2p/WifiP2pGroup;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mGroup:Landroid/net/wifi/p2p/WifiP2pGroup;

    invoke-virtual {v0}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1051
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    if-eqz v0, :cond_0

    .line 1052
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/WfdsNative;->setP2pPowerSave(Z)Z

    .line 1055
    :cond_0
    return-void
.end method

.method private startAspSessionRequest(ILcom/lge/wfds/session/AspSession;)Z
    .locals 3
    .param p1, "req_type"    # I
    .param p2, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    const/4 v0, 0x1

    .line 988
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    monitor-enter v1

    .line 989
    :try_start_0
    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    invoke-virtual {v2, p1, p2}, Lcom/lge/wfds/session/UdpDataManager;->startRequest(ILcom/lge/wfds/session/AspSession;)Z

    move-result v2

    if-ne v2, v0, :cond_0

    .line 990
    monitor-exit v1

    .line 994
    :goto_0
    return v0

    .line 992
    :cond_0
    monitor-exit v1

    .line 994
    const/4 v0, 0x0

    goto :goto_0

    .line 992
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private startTimeout(Ljava/lang/String;I)Landroid/app/PendingIntent;
    .locals 9
    .param p1, "timeoutAction"    # Ljava/lang/String;
    .param p2, "timeout"    # I

    .prologue
    const/4 v8, 0x0

    .line 1069
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1070
    .local v1, "timeoutIntent":Landroid/content/Intent;
    iget-object v4, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    invoke-static {v4, v8, v1, v8}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    .line 1072
    .local v0, "pendingIntent":Landroid/app/PendingIntent;
    if-eqz v0, :cond_0

    .line 1073
    const-string v4, "WfdsSession:Controller"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "startTimeout : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Landroid/app/PendingIntent;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1074
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    int-to-long v6, p2

    add-long v2, v4, v6

    .line 1075
    .local v2, "triggerTime":J
    iget-object v4, p0, Lcom/lge/wfds/SessionController;->mAlarmManager:Landroid/app/AlarmManager;

    invoke-virtual {v4, v8, v2, v3, v0}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    .line 1078
    .end local v2    # "triggerTime":J
    :cond_0
    return-object v0
.end method

.method private stopAspSessionRequest()V
    .locals 2

    .prologue
    .line 998
    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    monitor-enter v1

    .line 999
    :try_start_0
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;

    invoke-virtual {v0}, Lcom/lge/wfds/session/UdpDataManager;->stopRequest()V

    .line 1000
    monitor-exit v1

    .line 1001
    return-void

    .line 1000
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private stopDeferredTimeout()V
    .locals 1

    .prologue
    .line 1100
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredTimeoutIntent:Landroid/app/PendingIntent;

    if-eqz v0, :cond_0

    .line 1101
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredTimeoutIntent:Landroid/app/PendingIntent;

    invoke-direct {p0, v0}, Lcom/lge/wfds/SessionController;->stopTimeout(Landroid/app/PendingIntent;)V

    .line 1102
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionDeferredTimeoutIntent:Landroid/app/PendingIntent;

    .line 1104
    :cond_0
    return-void
.end method

.method private stopSessionReadyTimeouts()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 1089
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;

    if-eqz v0, :cond_0

    .line 1090
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;

    invoke-direct {p0, v0}, Lcom/lge/wfds/SessionController;->stopTimeout(Landroid/app/PendingIntent;)V

    .line 1091
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;

    .line 1093
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

    if-eqz v0, :cond_1

    .line 1094
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

    invoke-direct {p0, v0}, Lcom/lge/wfds/SessionController;->stopTimeout(Landroid/app/PendingIntent;)V

    .line 1095
    iput-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionCountZeroTimeoutIntent:Landroid/app/PendingIntent;

    .line 1097
    :cond_1
    return-void
.end method

.method private stopTimeout(Landroid/app/PendingIntent;)V
    .locals 3
    .param p1, "pendingIntent"    # Landroid/app/PendingIntent;

    .prologue
    .line 1082
    if-eqz p1, :cond_0

    .line 1083
    const-string v0, "WfdsSession:Controller"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopTimeout : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/app/PendingIntent;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1084
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mAlarmManager:Landroid/app/AlarmManager;

    invoke-virtual {v0, p1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 1086
    :cond_0
    return-void
.end method

.method private unregisterSessionCtrlBroadcastRcvr()V
    .locals 2

    .prologue
    .line 1122
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 1123
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 1124
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionCtrlBroadcastRcvr:Landroid/content/BroadcastReceiver;

    .line 1128
    :goto_0
    return-void

    .line 1126
    :cond_0
    const-string v0, "WfdsSession:Controller"

    const-string v1, "unregisterSessionCtrlBroadcastRcvr: already unregistered"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public getSession(Ljava/lang/Integer;Ljava/lang/String;)Lcom/lge/wfds/session/AspSession;
    .locals 1
    .param p1, "session_id"    # Ljava/lang/Integer;
    .param p2, "session_mac"    # Ljava/lang/String;

    .prologue
    .line 157
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v0, p2, p1}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    return-object v0
.end method

.method public getSession(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 1
    .param p1, "service_mac"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Iterator",
            "<",
            "Lcom/lge/wfds/session/AspSession;",
            ">;"
        }
    .end annotation

    .prologue
    .line 153
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public getSessionList()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator",
            "<",
            "Lcom/lge/wfds/session/AspSession;",
            ">;"
        }
    .end annotation

    .prologue
    .line 161
    iget-object v0, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v0}, Lcom/lge/wfds/session/AspSessionList;->getSessionList()Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public hasOpenedSession()Z
    .locals 3

    .prologue
    .line 165
    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v2}, Lcom/lge/wfds/session/AspSessionList;->getSessionSize()I

    move-result v2

    if-lez v2, :cond_1

    .line 166
    iget-object v2, p0, Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v2}, Lcom/lge/wfds/session/AspSessionList;->getSessionList()Ljava/util/Iterator;

    move-result-object v1

    .line 167
    .local v1, "sessionList":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 168
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/AspSession;

    .line 169
    .local v0, "session":Lcom/lge/wfds/session/AspSession;
    iget v2, v0, Lcom/lge/wfds/session/AspSession;->state:I

    if-nez v2, :cond_0

    .line 170
    const/4 v2, 0x1

    .line 174
    .end local v0    # "session":Lcom/lge/wfds/session/AspSession;
    .end local v1    # "sessionList":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :goto_0
    return v2

    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method
