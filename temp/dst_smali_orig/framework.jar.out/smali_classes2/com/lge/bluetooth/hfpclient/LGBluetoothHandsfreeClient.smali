.class public final Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
.super Ljava/lang/Object;
.source "LGBluetoothHandsfreeClient.java"

# interfaces
.implements Landroid/bluetooth/BluetoothProfile;


# static fields
.field public static final CALL_ACCEPT_HOLD:I = 0x1

.field public static final CALL_ACCEPT_NONE:I = 0x0

.field public static final CALL_ACCEPT_TERMINATE:I = 0x2

.field private static final DBG:Z = true

.field public static final ERROR_AG_FAILURE:I = 0x0

.field public static final NO_ERROR:I = 0xff

.field public static final STATE_AUDIO_CONNECTED:I = 0x2

.field public static final STATE_AUDIO_CONNECTING:I = 0x1

.field public static final STATE_AUDIO_DISCONNECTED:I = 0x0

.field public static final STATE_AUDIO_DISCONNECTING:I = 0x3

.field private static final TAG:Ljava/lang/String; = "LGBluetoothHandsfreeClient"

.field private static final VDBG:Z = true

.field private static updateCallState:Z


# instance fields
.field private mAdapter:Landroid/bluetooth/BluetoothAdapter;

.field private mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

.field private final mBluetoothStateChangeCallback:Landroid/bluetooth/IBluetoothStateChangeCallback;

.field private mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

.field private mConnection:Landroid/content/ServiceConnection;

.field private mContext:Landroid/content/Context;

.field private mDevice:Landroid/bluetooth/BluetoothDevice;

.field private final mHfDeviceCallback:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

.field private mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

.field private mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->updateCallState:Z

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Landroid/bluetooth/BluetoothProfile$ServiceListener;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "serviceListener"    # Landroid/bluetooth/BluetoothProfile$ServiceListener;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v3, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;

    invoke-direct {v3, p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;-><init>(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V

    iput-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBluetoothStateChangeCallback:Landroid/bluetooth/IBluetoothStateChangeCallback;

    new-instance v3, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;

    invoke-direct {v3, p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;-><init>(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V

    iput-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;

    new-instance v3, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;

    invoke-direct {v3, p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;-><init>(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V

    iput-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mHfDeviceCallback:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;

    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mAdapter:Landroid/bluetooth/BluetoothAdapter;

    const-string v3, "bluetooth_manager"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    if-eqz v0, :cond_1

    invoke-static {v0}, Landroid/bluetooth/IBluetoothManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/bluetooth/IBluetoothManager;

    move-result-object v2

    .local v2, "mgr":Landroid/bluetooth/IBluetoothManager;
    if-eqz v2, :cond_0

    :try_start_0
    iget-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBluetoothStateChangeCallback:Landroid/bluetooth/IBluetoothStateChangeCallback;

    invoke-interface {v2, v3}, Landroid/bluetooth/IBluetoothManager;->registerStateChangeCallback(Landroid/bluetooth/IBluetoothStateChangeCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "mgr":Landroid/bluetooth/IBluetoothManager;
    :cond_0
    :goto_0
    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->doBind()V

    return-void

    .restart local v2    # "mgr":Landroid/bluetooth/IBluetoothManager;
    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    const-string v3, "LGBluetoothHandsfreeClient"

    const-string v4, ""

    invoke-static {v3, v4, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v1    # "e":Landroid/os/RemoteException;
    .end local v2    # "mgr":Landroid/bluetooth/IBluetoothManager;
    :cond_1
    const-string v3, "LGBluetoothHandsfreeClient"

    const-string v4, "Unable to get BluetoothManager interface."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method static synthetic access$000(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/ServiceConnection;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;

    return-object v0
.end method

.method static synthetic access$200(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    return-object v0
.end method

.method static synthetic access$202(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    .locals 0
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    .param p1, "x1"    # Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    .prologue
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    return-object p1
.end method

.method static synthetic access$300(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    return-object v0
.end method

.method static synthetic access$302(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    .locals 0
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    .param p1, "x1"    # Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    .prologue
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    return-object p1
.end method

.method static synthetic access$400(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->doBind()V

    return-void
.end method

.method static synthetic access$600(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothProfile$ServiceListener;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;

    return-object v0
.end method

.method static synthetic access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    return-object v0
.end method

.method static synthetic access$800(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothDevice;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mDevice:Landroid/bluetooth/BluetoothDevice;

    return-object v0
.end method

.method static synthetic access$802(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Landroid/bluetooth/BluetoothDevice;)Landroid/bluetooth/BluetoothDevice;
    .locals 0
    .param p0, "x0"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    .param p1, "x1"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mDevice:Landroid/bluetooth/BluetoothDevice;

    return-object p1
.end method

.method static synthetic access$900()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->updateCallState:Z

    return v0
.end method

.method static synthetic access$902(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    sput-boolean p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->updateCallState:Z

    return p0
.end method

.method private declared-synchronized close()V
    .locals 7

    .prologue
    monitor-enter p0

    :try_start_0
    const-string v4, "close"

    invoke-static {v4}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    const-string v4, "bluetooth_manager"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Landroid/bluetooth/IBluetoothManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/bluetooth/IBluetoothManager;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .local v2, "mgr":Landroid/bluetooth/IBluetoothManager;
    if-eqz v2, :cond_0

    :try_start_1
    iget-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBluetoothStateChangeCallback:Landroid/bluetooth/IBluetoothStateChangeCallback;

    invoke-interface {v2, v4}, Landroid/bluetooth/IBluetoothManager;->unregisterStateChangeCallback(Landroid/bluetooth/IBluetoothStateChangeCallback;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_0
    :goto_0
    :try_start_2
    iget-object v5, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;

    monitor-enter v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-eqz v4, :cond_1

    const/4 v4, 0x0

    :try_start_4
    iput-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    iget-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    iget-object v6, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v4, v6}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :cond_1
    :goto_1
    :try_start_5
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-eqz v4, :cond_2

    const/4 v4, 0x0

    :try_start_6
    iput-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    iget-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    if-eqz v4, :cond_2

    iget-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    iget-object v6, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v4, v6}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    :cond_2
    :goto_2
    :try_start_7
    monitor-exit v5
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    const/4 v4, 0x0

    :try_start_8
    iput-object v4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    monitor-exit p0

    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    :try_start_9
    const-string v4, "LGBluetoothHandsfreeClient"

    const-string v5, ""

    invoke-static {v4, v5, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto :goto_0

    .end local v0    # "b":Landroid/os/IBinder;
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "mgr":Landroid/bluetooth/IBluetoothManager;
    :catchall_0
    move-exception v4

    monitor-exit p0

    throw v4

    .restart local v0    # "b":Landroid/os/IBinder;
    .restart local v2    # "mgr":Landroid/bluetooth/IBluetoothManager;
    :catch_1
    move-exception v3

    .local v3, "re":Ljava/lang/Exception;
    :try_start_a
    const-string v4, "LGBluetoothHandsfreeClient"

    const-string v6, ""

    invoke-static {v4, v6, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v3    # "re":Ljava/lang/Exception;
    :catchall_1
    move-exception v4

    monitor-exit v5
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    :try_start_b
    throw v4
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    :catch_2
    move-exception v3

    .restart local v3    # "re":Ljava/lang/Exception;
    :try_start_c
    const-string v4, "LGBluetoothHandsfreeClient"

    const-string v6, ""

    invoke-static {v4, v6, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    goto :goto_2
.end method

.method public static closeProfileProxy(Landroid/bluetooth/BluetoothProfile;)V
    .locals 2
    .param p0, "proxy"    # Landroid/bluetooth/BluetoothProfile;

    .prologue
    const-string v1, "closeProfileProxy"

    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p0, :cond_0

    move-object v0, p0

    check-cast v0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    .local v0, "hfpc":Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    invoke-direct {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->close()V

    .end local v0    # "hfpc":Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    :cond_0
    return-void
.end method

.method private doBind()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const-string v2, "doBind"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    :goto_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/content/Intent;->resolveSystemService(Landroid/content/pm/PackageManager;I)Landroid/content/ComponentName;

    move-result-object v0

    .local v0, "comp":Landroid/content/ComponentName;
    invoke-virtual {v1, v0}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    if-eqz v0, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;

    iget-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v2, v1, v3, v4}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    const-string v2, "LGBluetoothHandsfreeClient"

    const-string v3, "Could not bind to Bluetooth Handsfree Client Service"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "comp":Landroid/content/ComponentName;
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_1
    return-void

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_1

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v1    # "intent":Landroid/content/Intent;
    goto :goto_0
.end method

.method public static getProfileProxy(Landroid/content/Context;Landroid/bluetooth/BluetoothProfile$ServiceListener;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "listener"    # Landroid/bluetooth/BluetoothProfile$ServiceListener;

    .prologue
    const-string v2, "getProfileProxy"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    .local v0, "adapter":Landroid/bluetooth/BluetoothAdapter;
    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    new-instance v1, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-direct {v1, p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;-><init>(Landroid/content/Context;Landroid/bluetooth/BluetoothProfile$ServiceListener;)V

    .local v1, "hfpc":Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    const/4 v2, 0x1

    .end local v1    # "hfpc":Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
    :goto_0
    return v2

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private isEnabled()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mAdapter:Landroid/bluetooth/BluetoothAdapter;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getState()I

    move-result v0

    const/16 v1, 0xc

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    if-nez p1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v0

    goto :goto_0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 3
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGBluetoothHandsfreeClient"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[BTUI] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public acceptCall(Landroid/bluetooth/BluetoothDevice;I)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "flag"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "acceptCall)"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->acceptCall(Landroid/bluetooth/BluetoothDevice;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    :try_start_1
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->answer()Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    goto :goto_0

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public connect(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "connect ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->connect(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->connect(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public connectAudio()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const-string v2, "connectAudio"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->connectAudio()Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->connectAudio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public dialNumber(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "number"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dialNumber ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->dial(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    :try_start_1
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->dial(Ljava/lang/String;)Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    goto :goto_0

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public disconnect(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "disconnect ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->disconnect(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->disconnect(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public disconnectAudio()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const-string v2, "disconnectAudio"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->disconnectAudio()Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->disconnectAudio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getAudioState(Landroid/bluetooth/BluetoothDevice;)I
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    const-string v2, "getAudioState"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->getAudioState(Landroid/bluetooth/BluetoothDevice;)I

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->getAudioState(Landroid/bluetooth/BluetoothDevice;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getConnectedDevices()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation

    .prologue
    const-string v1, "getConnectedDevices"

    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->getConnectedDevices()Ljava/util/List;

    move-result-object v1

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->getConnectedDevices()Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothHandsfreeClient"

    new-instance v2, Ljava/lang/Throwable;

    invoke-direct {v2}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v2}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method public getConnectionState(Landroid/bluetooth/BluetoothDevice;)I
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getConnectionState ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->getConnectionState(Landroid/bluetooth/BluetoothDevice;)I

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->getConnectionState(Landroid/bluetooth/BluetoothDevice;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getDevicesMatchingConnectionStates([I)Ljava/util/List;
    .locals 3
    .param p1, "states"    # [I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([I)",
            "Ljava/util/List",
            "<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation

    .prologue
    const-string v1, "getDevicesMatchingConnectionStates"

    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v1, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->getDevicesMatchingConnectionStates([I)Ljava/util/List;

    move-result-object v1

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v1, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->getDevicesMatchingConnectionStates([I)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothHandsfreeClient"

    new-instance v2, Ljava/lang/Throwable;

    invoke-direct {v2}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v2}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method public getPriority(Landroid/bluetooth/BluetoothDevice;)I
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPriority ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->getPriority(Landroid/bluetooth/BluetoothDevice;)I

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->getPriority(Landroid/bluetooth/BluetoothDevice;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public holdCall(Landroid/bluetooth/BluetoothDevice;I)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "holdType"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "holdCall"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->holdCall(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    :try_start_1
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->hold(I)Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    goto :goto_0

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public redial(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    const-string v2, "redial"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->redial(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    :try_start_1
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->redial()Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    goto :goto_0

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public registerEventHandler(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;)V
    .locals 3
    .param p1, "handler"    # Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    .prologue
    const-string v1, "registerEventHandler"

    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v1, :cond_1

    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mHfDeviceCallback:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    invoke-interface {v1, v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->registerEventHandler(Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v1, :cond_0

    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mHfDeviceCallback:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    invoke-interface {v1, v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->registerEventHandler(Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothHandsfreeClient"

    new-instance v2, Ljava/lang/Throwable;

    invoke-direct {v2}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v2}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public rejectCall(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    const-string v2, "rejectCall"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->rejectCall(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    :try_start_1
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->hangup()Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    goto :goto_0

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setPriority(Landroid/bluetooth/BluetoothDevice;I)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "priority"    # I

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setPriority ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    if-eqz p2, :cond_2

    const/16 v2, 0x64

    if-ne p2, v2, :cond_0

    :cond_2
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->setPriority(Landroid/bluetooth/BluetoothDevice;I)Z

    move-result v1

    goto :goto_0

    :cond_3
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->setPriority(Landroid/bluetooth/BluetoothDevice;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public startVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    const-string v2, "startVoiceRecognition"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->startVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->startVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public stopVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    const/4 v1, 0x0

    const-string v2, "stopVoiceRecognition"

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isValidDevice(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->stopVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2, p1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->stopVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public terminateCall(Landroid/bluetooth/BluetoothDevice;I)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "index"    # I

    .prologue
    const/4 v1, 0x0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "terminateCall ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    invoke-interface {v2, p1, p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->terminateCall(Landroid/bluetooth/BluetoothDevice;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v2, :cond_0

    :try_start_1
    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    invoke-interface {v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->hangup()Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    goto :goto_0

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v2, "LGBluetoothHandsfreeClient"

    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public unregisterEventHandler()V
    .locals 3

    .prologue
    const-string v1, "unregisterEventHandler"

    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V

    :try_start_0
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    if-eqz v1, :cond_1

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mHfDeviceCallback:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    invoke-interface {v1, v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->unRegisterEventHandler(Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mHfDeviceCallback:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    invoke-interface {v1, v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->unRegisterEventHandler(Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothHandsfreeClient"

    new-instance v2, Ljava/lang/Throwable;

    invoke-direct {v2}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v2}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
