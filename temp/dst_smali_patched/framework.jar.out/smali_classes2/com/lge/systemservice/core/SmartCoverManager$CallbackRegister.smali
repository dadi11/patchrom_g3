.class Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;
.super Landroid/os/Handler;
.source "SmartCoverManager.java"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/SmartCoverManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "CallbackRegister"
.end annotation


# static fields
.field private static final MSG_REGISTER:I


# instance fields
.field private final MAX_REGISTER_COUNT:I

.field private final WAIT_SERVICE_MILLIS:I

.field private awaiter:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/ISmartCoverCallback;",
            ">;"
        }
    .end annotation
.end field

.field private registrant:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/ISmartCoverCallback;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/lge/systemservice/core/SmartCoverManager;

.field private tryCount:I


# direct methods
.method public constructor <init>(Lcom/lge/systemservice/core/SmartCoverManager;Landroid/os/Looper;)V
    .locals 1
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->this$0:Lcom/lge/systemservice/core/SmartCoverManager;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    const/16 v0, 0x14

    iput v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->MAX_REGISTER_COUNT:I

    const/16 v0, 0xbb8

    iput v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->WAIT_SERVICE_MILLIS:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    return-void
.end method

.method static synthetic access$000(Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;Lcom/lge/systemservice/core/ISmartCoverCallback;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ISmartCoverCallback;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->register(Lcom/lge/systemservice/core/ISmartCoverCallback;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$100(Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;Lcom/lge/systemservice/core/ISmartCoverCallback;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ISmartCoverCallback;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->unRegister(Lcom/lge/systemservice/core/ISmartCoverCallback;)V

    return-void
.end method

.method private onCompletedRegistrationLocked()V
    .locals 3

    .prologue
    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/ISmartCoverCallback;

    .local v0, "clbk":Lcom/lge/systemservice/core/ISmartCoverCallback;
    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v0    # "clbk":Lcom/lge/systemservice/core/ISmartCoverCallback;
    :cond_1
    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->clear()V

    const/4 v2, 0x0

    iput v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    return-void
.end method

.method private declared-synchronized register(Lcom/lge/systemservice/core/ISmartCoverCallback;)Z
    .locals 5
    .param p1, "clbk"    # Lcom/lge/systemservice/core/ISmartCoverCallback;

    .prologue
    const/4 v1, 0x0

    monitor-enter p0

    if-nez p1, :cond_0

    :try_start_0
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Callback must be not null"

    new-instance v4, Ljava/lang/IllegalArgumentException;

    invoke-direct {v4}, Ljava/lang/IllegalArgumentException;-><init>()V

    invoke-static {v2, v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return v1

    :cond_0
    :try_start_1
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v2

    const-string v3, "calling registerCallback()"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->this$0:Lcom/lge/systemservice/core/SmartCoverManager;

    # invokes: Lcom/lge/systemservice/core/SmartCoverManager;->getService()Lcom/lge/systemservice/core/ISmartCoverManager;
    invoke-static {v2}, Lcom/lge/systemservice/core/SmartCoverManager;->access$200(Lcom/lge/systemservice/core/SmartCoverManager;)Lcom/lge/systemservice/core/ISmartCoverManager;

    move-result-object v0

    .local v0, "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    if-eqz v0, :cond_3

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerCallback(Lcom/lge/systemservice/core/ISmartCoverManager;Lcom/lge/systemservice/core/ISmartCoverCallback;)Z

    move-result v2

    if-nez v2, :cond_1

    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v2

    const-string v3, "register(), Can\'t register callback"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .end local v0    # "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1

    .restart local v0    # "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    :cond_1
    :try_start_2
    iget-object v1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v1

    const-string v2, "register callback successfully"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerAwaiter()V

    :goto_1
    const/4 v1, 0x1

    goto :goto_0

    :cond_3
    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    monitor-enter v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    iget-object v1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget v1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    const/16 v3, 0x14

    if-lt v1, v3, :cond_4

    const/4 v1, 0x0

    iput v1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    :cond_4
    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerDelayedLocked()V

    monitor-exit v2

    goto :goto_1

    :catchall_1
    move-exception v1

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :try_start_4
    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0
.end method

.method private registerAwaiter()V
    .locals 7

    .prologue
    iget-object v3, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->this$0:Lcom/lge/systemservice/core/SmartCoverManager;

    # invokes: Lcom/lge/systemservice/core/SmartCoverManager;->getService()Lcom/lge/systemservice/core/ISmartCoverManager;
    invoke-static {v3}, Lcom/lge/systemservice/core/SmartCoverManager;->access$200(Lcom/lge/systemservice/core/SmartCoverManager;)Lcom/lge/systemservice/core/ISmartCoverManager;

    move-result-object v2

    .local v2, "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    iget-object v4, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    monitor-enter v4

    :try_start_0
    iget-object v3, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    monitor-exit v4

    :goto_0
    return-void

    :cond_0
    if-nez v2, :cond_1

    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerDelayedLocked()V

    monitor-exit v4

    goto :goto_0

    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3

    :cond_1
    :try_start_1
    iget-object v3, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/ISmartCoverCallback;

    .local v0, "clbk":Lcom/lge/systemservice/core/ISmartCoverCallback;
    invoke-direct {p0, v2, v0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerCallback(Lcom/lge/systemservice/core/ISmartCoverManager;Lcom/lge/systemservice/core/ISmartCoverCallback;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerDelayedLocked()V

    monitor-exit v4

    goto :goto_0

    .end local v0    # "clbk":Lcom/lge/systemservice/core/ISmartCoverCallback;
    :cond_3
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "register "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "callbacks successfully"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->onCompletedRegistrationLocked()V

    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method

.method private registerCallback(Lcom/lge/systemservice/core/ISmartCoverManager;Lcom/lge/systemservice/core/ISmartCoverCallback;)Z
    .locals 6
    .param p1, "service"    # Lcom/lge/systemservice/core/ISmartCoverManager;
    .param p2, "clbk"    # Lcom/lge/systemservice/core/ISmartCoverCallback;

    .prologue
    const/4 v2, 0x0

    instance-of v3, p2, Lcom/lge/systemservice/core/SmartCoverManager$CoverCallback;

    if-eqz v3, :cond_1

    const/4 v1, 0x1

    .local v1, "eventType":I
    :goto_0
    instance-of v3, p2, Lcom/lge/systemservice/core/SmartCoverManager$FolderCallback;

    if-eqz v3, :cond_0

    const/4 v1, 0x4

    :cond_0
    :try_start_0
    invoke-interface {p1, p2, v1}, Lcom/lge/systemservice/core/ISmartCoverManager;->registerCallback(Lcom/lge/systemservice/core/ISmartCoverCallback;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "eventType":I
    :goto_1
    return v2

    :cond_1
    instance-of v3, p2, Lcom/lge/systemservice/core/SmartCoverManager$PenCallback;

    if-eqz v3, :cond_2

    const/4 v1, 0x2

    .restart local v1    # "eventType":I
    goto :goto_0

    .end local v1    # "eventType":I
    :cond_2
    instance-of v3, p2, Lcom/lge/systemservice/core/SmartCoverManager$SubCoverCallback;

    if-eqz v3, :cond_3

    const/4 v1, 0x3

    .restart local v1    # "eventType":I
    goto :goto_0

    .end local v1    # "eventType":I
    :cond_3
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v3

    const-string v4, "Is this proper callback?"

    new-instance v5, Ljava/lang/IllegalArgumentException;

    invoke-direct {v5}, Ljava/lang/IllegalArgumentException;-><init>()V

    invoke-static {v3, v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .restart local v1    # "eventType":I
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private registerDelayedLocked()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SmartCoverService is null or has some problem.. please waiting.."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, v2}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->hasMessages(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    const/16 v1, 0x14

    if-ge v0, v1, :cond_1

    const-wide/16 v0, 0xbb8

    invoke-virtual {p0, v2, v0, v1}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->sendEmptyMessageDelayed(IJ)Z

    iget v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Get tired of waiting SmartCoverService... Please register later"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private declared-synchronized unRegister(Lcom/lge/systemservice/core/ISmartCoverCallback;)V
    .locals 5
    .param p1, "clbk"    # Lcom/lge/systemservice/core/ISmartCoverCallback;

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v4, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    monitor-enter v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v3, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    invoke-interface {v3, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    iget-object v3, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->this$0:Lcom/lge/systemservice/core/SmartCoverManager;

    # invokes: Lcom/lge/systemservice/core/SmartCoverManager;->getService()Lcom/lge/systemservice/core/ISmartCoverManager;
    invoke-static {v3}, Lcom/lge/systemservice/core/SmartCoverManager;->access$200(Lcom/lge/systemservice/core/SmartCoverManager;)Lcom/lge/systemservice/core/ISmartCoverManager;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v2

    .local v2, "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    if-eqz v2, :cond_1

    const/4 v1, 0x1

    .local v1, "eventType":I
    :try_start_3
    instance-of v3, p1, Lcom/lge/systemservice/core/SmartCoverManager$PenCallback;

    if-eqz v3, :cond_2

    const/4 v1, 0x2

    :cond_0
    :goto_0
    invoke-interface {v2, p1, v1}, Lcom/lge/systemservice/core/ISmartCoverManager;->unRegisterCallback(Lcom/lge/systemservice/core/ISmartCoverCallback;I)V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .end local v1    # "eventType":I
    :cond_1
    :goto_1
    monitor-exit p0

    return-void

    .end local v2    # "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    :catchall_0
    move-exception v3

    :try_start_4
    monitor-exit v4
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :catchall_1
    move-exception v3

    monitor-exit p0

    throw v3

    .restart local v1    # "eventType":I
    .restart local v2    # "service":Lcom/lge/systemservice/core/ISmartCoverManager;
    :cond_2
    :try_start_6
    instance-of v3, p1, Lcom/lge/systemservice/core/SmartCoverManager$SubCoverCallback;
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    if-eqz v3, :cond_0

    const/4 v1, 0x3

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_7
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    goto :goto_1
.end method


# virtual methods
.method public binderDied()V
    .locals 3

    .prologue
    # getter for: Lcom/lge/systemservice/core/SmartCoverManager;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/core/SmartCoverManager;->access$300()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SmartCoverService has been died. Tring to recover, please wait.."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->awaiter:Ljava/util/List;

    iget-object v2, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registrant:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->tryCount:I

    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerDelayedLocked()V

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 1
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget v0, p1, Landroid/os/Message;->what:I

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/SmartCoverManager$CallbackRegister;->registerAwaiter()V

    :cond_0
    return-void
.end method
