.class public Lcom/lge/systemservice/core/LeccpManager;
.super Ljava/lang/Object;
.source "LeccpManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/LeccpManager$LeccpListener;,
        Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;,
        Lcom/lge/systemservice/core/LeccpManager$LeccpListenerId;
    }
.end annotation


# static fields
.field public static final ACTION_REASON_CONNECTION_FAIL:I = -0x4

.field public static final ACTION_REASON_NOT_FOUND:I = -0x2

.field public static final ACTION_REASON_REGISTRATION_FAIL:I = -0x3

.field public static final ACTION_REASON_SUCCESS:I = 0x0

.field public static final ACTION_REASON_UNKNOWN:I = -0x1

.field public static final EXTRA_SERVICE_INFO_ID:Ljava/lang/String; = "id"

.field public static final EXTRA_SERVICE_INFO_IS_ON:Ljava/lang/String; = "isOn"

.field public static final EXTRA_SERVICE_INFO_PACKAGE_NAME:Ljava/lang/String; = "packagName"

.field public static final EXTRA_SERVICE_INFO_TYPE:Ljava/lang/String; = "type"

.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.leccp"

.field public static final LECCP_GET_SERVICE_INFO_ACTION:Ljava/lang/String; = "com.lge.leccp.GET_SERVICE_INFO_ACTION"

.field public static final LECCP_SET_SERVICE_INFO_ACTION:Ljava/lang/String; = "com.lge.leccp.SET_SERVICE_INFO_ACTION"

.field public static final LECCP_USE_SERVICE_INFO_ACTION:Ljava/lang/String; = "com.lge.leccp.use.USE_SERVICE_INFO_ACTION"

.field public static final SERVICE_NAME:Ljava/lang/String; = "leccp"

.field public static final SERVICE_TPYE_BT_HEADSET:I = 0x0

.field public static final SERVICE_TPYE_BT_OPP:I = 0x1

.field public static final SERVICE_TYPE_CROMECAST:I = 0x7

.field public static final SERVICE_TYPE_DLNA:I = 0x9

.field public static final SERVICE_TYPE_MIRACAST:I = 0x3

.field public static final SERVICE_TYPE_MUSIC_SHARE:I = 0x8

.field public static final SERVICE_TYPE_QPAIR:I = 0x4

.field public static final SERVICE_TYPE_QREMOTE:I = 0x5

.field public static final SERVICE_TYPE_SMARTSHARE_BEAM:I = 0x2

.field public static final SERVICE_TYPE_WATCH_MANAGER:I = 0x6

.field public static final SUB_TAG:Ljava/lang/String;

.field public static final TAG:Ljava/lang/String;

.field private static sListenerTable:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/Integer;",
            "Lcom/lge/systemservice/core/LeccpManager$LeccpListener;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

.field private mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

.field private mILeccpManagerListener:Lcom/lge/systemservice/core/ILeccpManagerListener;

.field private mMessageLock:Ljava/lang/Object;

.field private mTempMessageQueue:Ljava/util/concurrent/BlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/BlockingQueue",
            "<",
            "Landroid/os/Message;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 40
    const-class v0, Lcom/lge/systemservice/core/LeccpManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    .line 41
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    .line 234
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpManager;->sListenerTable:Ljava/util/Hashtable;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .line 370
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 225
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    .line 227
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    .line 228
    new-instance v1, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mTempMessageQueue:Ljava/util/concurrent/BlockingQueue;

    .line 229
    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mMessageLock:Ljava/lang/Object;

    .line 240
    new-instance v1, Lcom/lge/systemservice/core/LeccpManager$1;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/core/LeccpManager$1;-><init>(Lcom/lge/systemservice/core/LeccpManager;)V

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManagerListener:Lcom/lge/systemservice/core/ILeccpManagerListener;

    .line 372
    new-instance v0, Lcom/lge/systemservice/core/LeccpManager$3;

    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/LeccpManager$3;-><init>(Lcom/lge/systemservice/core/LeccpManager;)V

    .line 390
    .local v0, "listenerThread":Ljava/lang/Thread;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "Thread"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    .line 391
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 392
    return-void
.end method

.method public constructor <init>(Lcom/lge/systemservice/core/ILeccpManager;)V
    .locals 3
    .param p1, "iLeccpManager"    # Lcom/lge/systemservice/core/ILeccpManager;

    .prologue
    const/4 v1, 0x0

    .line 345
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 225
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    .line 227
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    .line 228
    new-instance v1, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mTempMessageQueue:Ljava/util/concurrent/BlockingQueue;

    .line 229
    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mMessageLock:Ljava/lang/Object;

    .line 240
    new-instance v1, Lcom/lge/systemservice/core/LeccpManager$1;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/core/LeccpManager$1;-><init>(Lcom/lge/systemservice/core/LeccpManager;)V

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManagerListener:Lcom/lge/systemservice/core/ILeccpManagerListener;

    .line 346
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    .line 348
    new-instance v0, Lcom/lge/systemservice/core/LeccpManager$2;

    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/LeccpManager$2;-><init>(Lcom/lge/systemservice/core/LeccpManager;)V

    .line 366
    .local v0, "listenerThread":Ljava/lang/Thread;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "Thread"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    .line 367
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 368
    return-void
.end method

.method static synthetic access$000(ILjava/lang/Object;)V
    .locals 0
    .param p0, "x0"    # I
    .param p1, "x1"    # Ljava/lang/Object;

    .prologue
    .line 39
    invoke-static {p0, p1}, Lcom/lge/systemservice/core/LeccpManager;->onLeccpListenerMessage(ILjava/lang/Object;)V

    return-void
.end method

.method static synthetic access$100(Lcom/lge/systemservice/core/LeccpManager;I[Ljava/lang/Object;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LeccpManager;
    .param p1, "x1"    # I
    .param p2, "x2"    # [Ljava/lang/Object;

    .prologue
    .line 39
    invoke-direct {p0, p1, p2}, Lcom/lge/systemservice/core/LeccpManager;->onLeccpListener(I[Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/systemservice/core/LeccpManager;)Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/core/LeccpManager;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    return-object v0
.end method

.method static synthetic access$202(Lcom/lge/systemservice/core/LeccpManager;Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;)Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LeccpManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    .prologue
    .line 39
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    return-object p1
.end method

.method static synthetic access$400(Lcom/lge/systemservice/core/LeccpManager;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/core/LeccpManager;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpManager;->mMessageLock:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/systemservice/core/LeccpManager;)Ljava/util/concurrent/BlockingQueue;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/core/LeccpManager;

    .prologue
    .line 39
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpManager;->mTempMessageQueue:Ljava/util/concurrent/BlockingQueue;

    return-object v0
.end method

.method static synthetic access$602(Lcom/lge/systemservice/core/LeccpManager;Lcom/lge/systemservice/core/ILeccpManager;)Lcom/lge/systemservice/core/ILeccpManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LeccpManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ILeccpManager;

    .prologue
    .line 39
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/ILeccpManager;
    .locals 4

    .prologue
    .line 395
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    if-nez v1, :cond_0

    .line 396
    const-string v1, "leccp"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ILeccpManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    .line 397
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    if-eqz v1, :cond_0

    .line 399
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/LeccpManager$4;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/LeccpManager$4;-><init>(Lcom/lge/systemservice/core/LeccpManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 408
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    return-object v1

    .line 405
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManager:Lcom/lge/systemservice/core/ILeccpManager;

    goto :goto_0
.end method

.method private varargs onLeccpListener(I[Ljava/lang/Object;)V
    .locals 3
    .param p1, "type"    # I
    .param p2, "objList"    # [Ljava/lang/Object;

    .prologue
    .line 478
    iget-object v2, p0, Lcom/lge/systemservice/core/LeccpManager;->mMessageLock:Ljava/lang/Object;

    monitor-enter v2

    .line 479
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    if-nez v1, :cond_0

    .line 480
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 481
    .local v0, "message":Landroid/os/Message;
    iput p1, v0, Landroid/os/Message;->what:I

    .line 482
    iput-object p2, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 483
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mTempMessageQueue:Ljava/util/concurrent/BlockingQueue;

    invoke-interface {v1, v0}, Ljava/util/concurrent/BlockingQueue;->add(Ljava/lang/Object;)Z

    .line 484
    monitor-exit v2

    .line 489
    .end local v0    # "message":Landroid/os/Message;
    :goto_0
    return-void

    .line 486
    :cond_0
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 488
    iget-object v1, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    iget-object v2, p0, Lcom/lge/systemservice/core/LeccpManager;->mHandler:Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;

    invoke-virtual {v2, p1, p2}, Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/lge/systemservice/core/LeccpManager$ListenerHandler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0

    .line 486
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static onLeccpListenerMessage(ILjava/lang/Object;)V
    .locals 8
    .param p0, "type"    # I
    .param p1, "objListElement"    # Ljava/lang/Object;

    .prologue
    const/4 v7, 0x0

    .line 497
    check-cast p1, [Ljava/lang/Object;

    .end local p1    # "objListElement":Ljava/lang/Object;
    move-object v3, p1

    check-cast v3, [Ljava/lang/Object;

    .line 498
    .local v3, "objList":[Ljava/lang/Object;
    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->sListenerTable:Ljava/util/Hashtable;

    invoke-virtual {v4}, Ljava/util/Hashtable;->elements()Ljava/util/Enumeration;

    move-result-object v1

    .local v1, "enumer":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Lcom/lge/systemservice/core/LeccpManager$LeccpListener;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 500
    const/4 v2, 0x0

    .line 504
    .local v2, "listener":Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    :try_start_0
    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    .end local v2    # "listener":Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    check-cast v2, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 512
    .restart local v2    # "listener":Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    packed-switch p0, :pswitch_data_0

    goto :goto_0

    .line 514
    :pswitch_0
    aget-object v4, v3, v7

    check-cast v4, Lcom/lge/systemservice/core/LeccpInfo$Status;

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onStatusChanged(Lcom/lge/systemservice/core/LeccpInfo$Status;)V

    goto :goto_0

    .line 506
    .end local v2    # "listener":Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    :catch_0
    move-exception v0

    .line 508
    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "onDlnaListenerMessage exceptional case: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 544
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    return-void

    .line 517
    .restart local v2    # "listener":Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    :pswitch_1
    aget-object v4, v3, v7

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onBLEServerStatusChanged(Z)V

    goto :goto_0

    .line 520
    :pswitch_2
    aget-object v4, v3, v7

    check-cast v4, Ljava/lang/String;

    const/4 v5, 0x1

    aget-object v5, v3, v5

    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    const/4 v5, 0x2

    aget-object v5, v3, v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    invoke-virtual {v2, v4, v6, v5}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onResponseAction(Ljava/lang/String;ZI)V

    goto :goto_0

    .line 523
    :pswitch_3
    aget-object v4, v3, v7

    check-cast v4, Lcom/lge/systemservice/core/LeccpInfo$Card;

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onMyCardAdded(Lcom/lge/systemservice/core/LeccpInfo$Card;)V

    goto :goto_0

    .line 526
    :pswitch_4
    aget-object v4, v3, v7

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onMyCardRemoved(Ljava/lang/String;)V

    goto :goto_0

    .line 529
    :pswitch_5
    aget-object v4, v3, v7

    check-cast v4, Lcom/lge/systemservice/core/LeccpInfo$Card;

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onCardAdded(Lcom/lge/systemservice/core/LeccpInfo$Card;)V

    goto :goto_0

    .line 532
    :pswitch_6
    aget-object v4, v3, v7

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onCardRemoved(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 535
    :pswitch_7
    aget-object v4, v3, v7

    check-cast v4, Lcom/lge/systemservice/core/LeccpInfo$Card;

    invoke-virtual {v2, v4}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onCardUpdated(Lcom/lge/systemservice/core/LeccpInfo$Card;)V

    goto/16 :goto_0

    .line 538
    :pswitch_8
    invoke-virtual {v2}, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;->onDeadListenerCheck()V

    goto/16 :goto_0

    .line 512
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
    .end packed-switch
.end method

.method public static responseGetServiceInfo(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;Z)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "serviceType"    # I
    .param p3, "serviceId"    # Ljava/lang/String;
    .param p4, "isOn"    # Z

    .prologue
    .line 956
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 957
    :cond_0
    sget-object v1, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "responseGetServiceInfo has null context"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 971
    :goto_0
    return-void

    .line 961
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "responseGetServiceInfo packageName: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", serviceType: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", serviceId: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", isOn: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 963
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.leccp.SET_SERVICE_INFO_ACTION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 964
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.lge.leccp"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 965
    const-string v1, "packagName"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 966
    const-string v1, "type"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 967
    const-string v1, "id"

    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 968
    const-string v1, "isOn"

    invoke-virtual {v0, v1, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 970
    invoke-virtual {p0, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method public static sendUsedServiceInfo(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "serviceType"    # I
    .param p3, "serviceId"    # Ljava/lang/String;

    .prologue
    .line 981
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 982
    :cond_0
    sget-object v1, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "sendUsedServiceInfo has null context"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 994
    :goto_0
    return-void

    .line 986
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "sendUsedServiceInfo packageName: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", serviceType: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", serviceId: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 988
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.leccp.use.USE_SERVICE_INFO_ACTION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 989
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "packagName"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 990
    const-string v1, "type"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 991
    const-string v1, "id"

    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 993
    invoke-virtual {p0, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method


# virtual methods
.method public addMyCard(Ljava/lang/String;)Z
    .locals 6
    .param p1, "cardId"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 760
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 761
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 762
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "addMyCard get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 773
    :goto_0
    return v2

    .line 766
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "addMyCard cardId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 769
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILeccpManager;->addMyCard(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .line 770
    :catch_0
    move-exception v0

    .line 771
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "addMyCard: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public clearMyCard()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 806
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 807
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 808
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "clearMyCard get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 819
    :goto_0
    return v2

    .line 812
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "clearMyCard"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 815
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->clearMyCard()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .line 816
    :catch_0
    move-exception v0

    .line 817
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "clearMyCard: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getCard(Ljava/lang/String;)Lcom/lge/systemservice/core/LeccpInfo$Card;
    .locals 6
    .param p1, "cardId"    # Ljava/lang/String;

    .prologue
    .line 685
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v2

    .line 686
    .local v2, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v2, :cond_0

    .line 687
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getCards get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 688
    const/4 v0, 0x0

    .line 700
    :goto_0
    return-object v0

    .line 691
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getCard cardId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 693
    const/4 v0, 0x0

    .line 695
    .local v0, "card":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/ILeccpManager;->getCard(Ljava/lang/String;)Lcom/lge/systemservice/core/LeccpInfo$Card;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 696
    :catch_0
    move-exception v1

    .line 697
    .local v1, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getCard: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getCards()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$Card;",
            ">;"
        }
    .end annotation

    .prologue
    .line 660
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v2

    .line 661
    .local v2, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v2, :cond_0

    .line 662
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getCards get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 663
    const/4 v0, 0x0

    .line 675
    :goto_0
    return-object v0

    .line 666
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getCards"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 668
    const/4 v0, 0x0

    .line 670
    .local v0, "cards":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/LeccpInfo$Card;>;"
    :try_start_0
    invoke-interface {v2}, Lcom/lge/systemservice/core/ILeccpManager;->getCards()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 671
    :catch_0
    move-exception v1

    .line 672
    .local v1, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getCards: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getMyCard(Ljava/lang/String;)Lcom/lge/systemservice/core/LeccpInfo$Card;
    .locals 6
    .param p1, "cardId"    # Ljava/lang/String;

    .prologue
    .line 734
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 735
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 736
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getMyCard get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 737
    const/4 v2, 0x0

    .line 749
    :goto_0
    return-object v2

    .line 740
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getMyCard cardId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 742
    const/4 v2, 0x0

    .line 744
    .local v2, "myCard":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILeccpManager;->getMyCard(Ljava/lang/String;)Lcom/lge/systemservice/core/LeccpInfo$Card;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 745
    :catch_0
    move-exception v0

    .line 746
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getMyCard: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getMyCards()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$Card;",
            ">;"
        }
    .end annotation

    .prologue
    .line 709
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 710
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 711
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getMyCards get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 712
    const/4 v2, 0x0

    .line 724
    :goto_0
    return-object v2

    .line 715
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getMyCards"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 717
    const/4 v2, 0x0

    .line 719
    .local v2, "myCards":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/LeccpInfo$Card;>;"
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->getMyCards()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 720
    :catch_0
    move-exception v0

    .line 721
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getMyCards: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getStatus()Lcom/lge/systemservice/core/LeccpInfo$Status;
    .locals 6

    .prologue
    .line 552
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 553
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 554
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "unregister get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 555
    const/4 v2, 0x0

    .line 566
    :goto_0
    return-object v2

    .line 558
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getStatus"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 560
    const/4 v2, 0x0

    .line 562
    .local v2, "status":Lcom/lge/systemservice/core/LeccpInfo$Status;
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->getStatus()Lcom/lge/systemservice/core/LeccpInfo$Status;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 563
    :catch_0
    move-exception v0

    .line 564
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "getStatus: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isBLEServerEnabled()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 575
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 576
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 577
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isBLEServerEnabled get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 588
    :goto_0
    return v2

    .line 581
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isBLEServerEnabled"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 584
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->isBLEServerEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .line 585
    :catch_0
    move-exception v0

    .line 586
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isBLEServerEnabled: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isFriendCheck()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 887
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 888
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 889
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isFriendCheck get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 900
    :goto_0
    return v2

    .line 893
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isFriendCheck"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 895
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->isFriendCheck()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .line 896
    :catch_0
    move-exception v0

    .line 897
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isFriendCheck: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isPhoneSpeakerEnabled()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 909
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 910
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 911
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isPhoneSpeakerEnabled get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 922
    :goto_0
    return v2

    .line 915
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isPhoneSpeakerEnabled"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 918
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->isPhoneSpeakerEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .line 919
    :catch_0
    move-exception v0

    .line 920
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "isPhoneSpeakerEnabled: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public register(Lcom/lge/systemservice/core/LeccpManager$LeccpListener;)V
    .locals 5
    .param p1, "listener"    # Lcom/lge/systemservice/core/LeccpManager$LeccpListener;

    .prologue
    .line 417
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 418
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 419
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "register get service fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 439
    :goto_0
    return-void

    .line 423
    :cond_0
    if-nez p1, :cond_1

    .line 424
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "register null parameter"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 428
    :cond_1
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "register listener: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 430
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->sListenerTable:Ljava/util/Hashtable;

    invoke-virtual {v2}, Ljava/util/Hashtable;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 432
    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LeccpManager;->mILeccpManagerListener:Lcom/lge/systemservice/core/ILeccpManagerListener;

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v3

    invoke-interface {v1, v2, v3}, Lcom/lge/systemservice/core/ILeccpManager;->register(Lcom/lge/systemservice/core/ILeccpManagerListener;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 438
    :cond_2
    :goto_1
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->sListenerTable:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3, p1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 433
    :catch_0
    move-exception v0

    .line 434
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "register: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public removeMyCard(Ljava/lang/String;)Z
    .locals 6
    .param p1, "cardId"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 784
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 785
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 786
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "removeMyCard get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 797
    :goto_0
    return v2

    .line 790
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "removeMyCard cardId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 793
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILeccpManager;->removeMyCard(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .line 794
    :catch_0
    move-exception v0

    .line 795
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "removeMyCard: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public requestAction(Ljava/lang/String;Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;)Ljava/lang/String;
    .locals 6
    .param p1, "cardId"    # Ljava/lang/String;
    .param p2, "actionRequestData"    # Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;

    .prologue
    const/4 v2, 0x0

    .line 845
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 846
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 847
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "requestAction get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 858
    :goto_0
    return-object v2

    .line 851
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "requestAction cardId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 853
    :try_start_0
    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/ILeccpManager;->requestAction(Ljava/lang/String;Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 854
    :catch_0
    move-exception v0

    .line 855
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "requestAction: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setBLEServerEnabled(Z)V
    .locals 5
    .param p1, "isEnabled"    # Z

    .prologue
    .line 598
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 599
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 600
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setBLEServerEnabled get service fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 611
    :goto_0
    return-void

    .line 604
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setBLEServerEnabled isEnabled: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 607
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILeccpManager;->setBLEServerEnabled(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 608
    :catch_0
    move-exception v0

    .line 609
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setBLEServerEnabled: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setFriendCheck(Z)V
    .locals 5
    .param p1, "enabled"    # Z

    .prologue
    .line 867
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 868
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 869
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setFriendCheck get service fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 879
    :goto_0
    return-void

    .line 873
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setFriendCheck enabled: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 875
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILeccpManager;->setFriendCheck(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 876
    :catch_0
    move-exception v0

    .line 877
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setFriendCheck: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setPhoneSpeakerEnabled(Z)V
    .locals 5
    .param p1, "isEnabled"    # Z

    .prologue
    .line 932
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 933
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 934
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setPhoneSpeakerEnabled get service fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 945
    :goto_0
    return-void

    .line 938
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setPhoneSpeakerEnabled isEnabled: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 941
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILeccpManager;->setPhoneSpeakerEnabled(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 942
    :catch_0
    move-exception v0

    .line 943
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "setPhoneSpeakerEnabled: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public startDiscovery()V
    .locals 5

    .prologue
    .line 618
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 619
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 620
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "startDiscovery get service fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 631
    :goto_0
    return-void

    .line 624
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "startDiscovery"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 627
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->startDiscovery()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 628
    :catch_0
    move-exception v0

    .line 629
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "startDiscovery: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public stopDiscovery()V
    .locals 5

    .prologue
    .line 638
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 639
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_0

    .line 640
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "stopDiscovery get service fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 651
    :goto_0
    return-void

    .line 644
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "stopDiscovery"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 647
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/ILeccpManager;->stopDiscovery()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 648
    :catch_0
    move-exception v0

    .line 649
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "stopDiscovery: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public unregister(Lcom/lge/systemservice/core/LeccpManager$LeccpListener;)V
    .locals 6
    .param p1, "listener"    # Lcom/lge/systemservice/core/LeccpManager$LeccpListener;

    .prologue
    .line 447
    invoke-direct {p0}, Lcom/lge/systemservice/core/LeccpManager;->getService()Lcom/lge/systemservice/core/ILeccpManager;

    move-result-object v1

    .line 448
    .local v1, "iLeccpManager":Lcom/lge/systemservice/core/ILeccpManager;
    if-nez v1, :cond_1

    .line 449
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "unregister get service fail"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 470
    :cond_0
    :goto_0
    return-void

    .line 453
    :cond_1
    if-nez p1, :cond_2

    .line 454
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "unregister listener is null"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 458
    :cond_2
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->sListenerTable:Ljava/util/Hashtable;

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/systemservice/core/LeccpManager$LeccpListener;

    .line 459
    .local v2, "leccpListener":Lcom/lge/systemservice/core/LeccpManager$LeccpListener;
    if-eqz v2, :cond_3

    .line 460
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "unregister listener: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 463
    :cond_3
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->sListenerTable:Ljava/util/Hashtable;

    invoke-virtual {v3}, Ljava/util/Hashtable;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 465
    :try_start_0
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v3

    invoke-interface {v1, v3}, Lcom/lge/systemservice/core/ILeccpManager;->unregister(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 466
    :catch_0
    move-exception v0

    .line 467
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/lge/systemservice/core/LeccpManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/lge/systemservice/core/LeccpManager;->SUB_TAG:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "unregister: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method
