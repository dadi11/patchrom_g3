.class public Lcom/lge/uicc/framework/AsyncResultFetcher;
.super Ljava/lang/Object;
.source "AsyncResultFetcher.java"


# static fields
.field private static sAsyncResultHandler:Landroid/os/Handler;


# instance fields
.field private ar:Landroid/os/AsyncResult;

.field private notified:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/uicc/framework/AsyncResultFetcher;->sAsyncResultHandler:Landroid/os/Handler;

    return-void
.end method

.method protected constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    sget-object v0, Lcom/lge/uicc/framework/AsyncResultFetcher;->sAsyncResultHandler:Landroid/os/Handler;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "AsyncResultFetcher"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/AsyncResultFetcher;->sAsyncResultHandler:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_1

    const-string v0, "you have to use AsyncResultFetcher for Binder Thread Calls only"

    invoke-static {v0}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "AsyncResultFetcher"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/lge/uicc/framework/AsyncResultFetcher;->logd(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$202(Lcom/lge/uicc/framework/AsyncResultFetcher;Landroid/os/AsyncResult;)Landroid/os/AsyncResult;
    .locals 0
    .param p0, "x0"    # Lcom/lge/uicc/framework/AsyncResultFetcher;
    .param p1, "x1"    # Landroid/os/AsyncResult;

    .prologue
    iput-object p1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    return-object p1
.end method

.method static synthetic access$302(Lcom/lge/uicc/framework/AsyncResultFetcher;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/uicc/framework/AsyncResultFetcher;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    return p1
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 0
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[AsyncResultFetcher] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method protected static setup(Landroid/os/Looper;)V
    .locals 1
    .param p0, "mainLooper"    # Landroid/os/Looper;

    .prologue
    new-instance v0, Lcom/lge/uicc/framework/AsyncResultFetcher$1;

    invoke-direct {v0, p0}, Lcom/lge/uicc/framework/AsyncResultFetcher$1;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/lge/uicc/framework/AsyncResultFetcher;->sAsyncResultHandler:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method protected declared-synchronized getException()Ljava/lang/Throwable;
    .locals 2

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    iget-object v0, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-object v0

    :cond_0
    :try_start_1
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "AsyncResultFetcher"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized getResult()Ljava/lang/Object;
    .locals 1

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    iget-object v0, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized obtainMessage()Landroid/os/Message;
    .locals 2

    .prologue
    monitor-enter p0

    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->ar:Landroid/os/AsyncResult;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    sget-object v0, Lcom/lge/uicc/framework/AsyncResultFetcher;->sAsyncResultHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p0}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected declared-synchronized waitResponse()Z
    .locals 2

    .prologue
    monitor-enter p0

    :try_start_0
    iget-boolean v1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    if-nez v1, :cond_0

    const-string v1, "wait"

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->logd(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/Object;->wait()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :goto_0
    :try_start_1
    iget-boolean v1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    if-nez v1, :cond_1

    const-string v1, "wait() has returned without notify()"

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V

    const/16 v1, 0xa

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUICC;->traceStack(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V

    :cond_1
    iget-boolean v1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    const-string v1, "interrupted"

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method protected declared-synchronized waitResponse(J)Z
    .locals 3
    .param p1, "millis"    # J

    .prologue
    monitor-enter p0

    :try_start_0
    iget-boolean v1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "wait "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->logd(Ljava/lang/String;)V

    invoke-virtual {p0, p1, p2}, Ljava/lang/Object;->wait(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :goto_0
    :try_start_1
    iget-boolean v1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z

    if-nez v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "timout "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V

    const/16 v1, 0xa

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUICC;->traceStack(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V

    :cond_1
    iget-boolean v1, p0, Lcom/lge/uicc/framework/AsyncResultFetcher;->notified:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    const-string v1, "interrupted"

    invoke-static {v1}, Lcom/lge/uicc/framework/AsyncResultFetcher;->loge(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method
