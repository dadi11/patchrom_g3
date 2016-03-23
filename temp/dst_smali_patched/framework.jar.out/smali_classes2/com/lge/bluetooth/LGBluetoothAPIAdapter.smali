.class public final Lcom/lge/bluetooth/LGBluetoothAPIAdapter;
.super Ljava/lang/Object;
.source "LGBluetoothAPIAdapter.java"


# static fields
.field private static final DBG:Z = true

.field private static final SERVICE_NAME:Ljava/lang/String; = "lg_bluetoothapi_service"

.field private static final TAG:Ljava/lang/String; = "LGBluetoothAPIAdapter"

.field private static mContext:Landroid/content/Context;

.field private static mLGAPIAdapter:Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

.field private static mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;


# instance fields
.field private final mLGAPIManager:Lcom/lge/systemservice/core/ILGBluetoothAPIManager;

.field private final mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

.field private mProxyServiceStateCallbacks:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/lge/systemservice/core/ILGBluetoothAPIManager;)V
    .locals 3
    .param p1, "managerService"    # Lcom/lge/systemservice/core/ILGBluetoothAPIManager;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter$1;

    invoke-direct {v1, p0}, Lcom/lge/bluetooth/LGBluetoothAPIAdapter$1;-><init>(Lcom/lge/bluetooth/LGBluetoothAPIAdapter;)V

    iput-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mProxyServiceStateCallbacks:Ljava/util/ArrayList;

    if-nez p1, :cond_0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "LGBluetoothAPIManager service is null"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_0
    if-eqz p1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    if-eqz v1, :cond_1

    :try_start_0
    iget-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    invoke-interface {p1, v1}, Lcom/lge/systemservice/core/ILGBluetoothAPIManager;->unregisterAdapter(Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
    :try_start_1
    iget-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    invoke-interface {p1, v1}, Lcom/lge/systemservice/core/ILGBluetoothAPIManager;->registerAdapter(Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;)Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    move-result-object v1

    sput-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    :goto_1
    iput-object p1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mLGAPIManager:Lcom/lge/systemservice/core/ILGBluetoothAPIManager;

    return-void

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, "[BTUI] unregisterAdapter RemoteException"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "re":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .restart local v0    # "re":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, "[BTUI] RemoteException"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method

.method static synthetic access$000(Lcom/lge/bluetooth/LGBluetoothAPIAdapter;)Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    return-object v0
.end method

.method static synthetic access$100()Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    return-object v0
.end method

.method static synthetic access$102(Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;)Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;
    .locals 0
    .param p0, "x0"    # Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    .prologue
    sput-object p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    return-object p0
.end method

.method static synthetic access$200(Lcom/lge/bluetooth/LGBluetoothAPIAdapter;)Ljava/util/ArrayList;
    .locals 1
    .param p0, "x0"    # Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mProxyServiceStateCallbacks:Ljava/util/ArrayList;

    return-object v0
.end method

.method public static declared-synchronized getDefaultAdapter()Lcom/lge/bluetooth/LGBluetoothAPIAdapter;
    .locals 5

    .prologue
    const-class v3, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

    monitor-enter v3

    :try_start_0
    sget-object v2, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mLGAPIAdapter:Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-nez v2, :cond_1

    :cond_0
    const-string v2, "lg_bluetoothapi_service"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    if-eqz v0, :cond_2

    invoke-static {v0}, Lcom/lge/systemservice/core/ILGBluetoothAPIManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILGBluetoothAPIManager;

    move-result-object v1

    .local v1, "managerService":Lcom/lge/systemservice/core/ILGBluetoothAPIManager;
    new-instance v2, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

    invoke-direct {v2, v1}, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;-><init>(Lcom/lge/systemservice/core/ILGBluetoothAPIManager;)V

    sput-object v2, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mLGAPIAdapter:Lcom/lge/bluetooth/LGBluetoothAPIAdapter;

    .end local v1    # "managerService":Lcom/lge/systemservice/core/ILGBluetoothAPIManager;
    :cond_1
    :goto_0
    sget-object v2, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mLGAPIAdapter:Lcom/lge/bluetooth/LGBluetoothAPIAdapter;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v3

    return-object v2

    :cond_2
    :try_start_1
    const-string v2, "LGBluetoothAPIAdapter"

    const-string v4, "Bluetooth binder is null"

    invoke-static {v2, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v3

    throw v2
.end method


# virtual methods
.method public a2dpSetContentProtectionType(I)Z
    .locals 5
    .param p1, "cp_type"    # I

    .prologue
    const-string v1, "LGBluetoothAPIAdapter"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[BTUI] Call a2dpSetContentProtectionType :  cp_type ="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    monitor-enter v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-eqz v1, :cond_1

    const-string v1, "LGBluetoothAPIAdapter"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[BTUI] Call a2dpSetContentProtectionType :  cp_type ="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-nez v1, :cond_0

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "mService is Null"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    invoke-interface {v1, p1}, Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;->a2dpSetContentProtectionType(I)Z

    move-result v1

    monitor-exit v2

    :goto_0
    return v1

    :cond_1
    monitor-exit v2

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, "[BTUI] RemoteException"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method

.method protected finalize()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mLGAPIManager:Lcom/lge/systemservice/core/ILGBluetoothAPIManager;

    iget-object v2, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    invoke-interface {v1, v2}, Lcom/lge/systemservice/core/ILGBluetoothAPIManager;->unregisterAdapter(Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, ""

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v1
.end method

.method getBluetoothService(Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;)Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;
    .locals 3
    .param p1, "cb"    # Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    .prologue
    iget-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    monitor-enter v1

    if-nez p1, :cond_1

    :try_start_0
    const-string v0, "LGBluetoothAPIAdapter"

    const-string v2, "getBluetoothService() called with no BluetoothManagerCallback"

    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sget-object v0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    return-object v0

    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mProxyServiceStateCallbacks:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mProxyServiceStateCallbacks:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public getTrustState(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .prologue
    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    monitor-enter v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-eqz v1, :cond_1

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "[BTUI] LGBluetoothAPIAdapter  : getTrustState"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-nez v1, :cond_0

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "mService is Null"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    invoke-interface {v1, p1}, Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;->getTrustState(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    monitor-exit v2

    :goto_0
    return v1

    :cond_1
    monitor-exit v2

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, "[BTUI] RemoteException"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method

.method public onProfileConnectionStateChanged(Landroid/bluetooth/BluetoothDevice;III)V
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "profileId"    # I
    .param p3, "newState"    # I
    .param p4, "prevState"    # I

    .prologue
    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    monitor-enter v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-eqz v1, :cond_1

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "[BTUI] LGBluetoothAPIAdapter  : onProfileConnectionStateChanged"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-nez v1, :cond_0

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "mService is Null"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    invoke-interface {v1, p1, p2, p3, p4}, Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;->onProfileConnectionStateChanged(Landroid/bluetooth/BluetoothDevice;III)V

    :cond_1
    monitor-exit v2

    :goto_0
    return-void

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, "[BTUI] RemoteException"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method removeServiceStateCallback(Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;)V
    .locals 2
    .param p1, "cb"    # Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    .prologue
    iget-object v1, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mProxyServiceStateCallbacks:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public setTrustState(Landroid/bluetooth/BluetoothDevice;Z)Z
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "value"    # Z

    .prologue
    :try_start_0
    iget-object v2, p0, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mManagerCallback:Lcom/lge/bluetooth/ILGBluetoothAPIAdapterCallback;

    monitor-enter v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-eqz v1, :cond_1

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "[BTUI] LGBluetoothAPIAdapter  : setTrustState"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    if-nez v1, :cond_0

    const-string v1, "LGBluetoothAPIAdapter"

    const-string v3, "mService is Null"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/lge/bluetooth/LGBluetoothAPIAdapter;->mService:Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;

    invoke-interface {v1, p1, p2}, Lcom/lge/bluetooth/ILGBluetoothAPIAdapter;->setTrustState(Landroid/bluetooth/BluetoothDevice;Z)Z

    move-result v1

    monitor-exit v2

    :goto_0
    return v1

    :cond_1
    monitor-exit v2

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LGBluetoothAPIAdapter"

    const-string v2, "[BTUI] RemoteException"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method
