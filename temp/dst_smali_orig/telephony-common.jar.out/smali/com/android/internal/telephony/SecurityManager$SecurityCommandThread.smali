.class Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
.super Ljava/lang/Thread;
.source "SecurityManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/SecurityManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SecurityCommandThread"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;
    }
.end annotation


# instance fields
.field data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

.field private mDone:Z

.field private mHandler:Landroid/os/Handler;

.field private mPhone:Lcom/android/internal/telephony/Phone;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z

    invoke-static {}, Lcom/android/internal/telephony/PhoneFactory;->getDefaultPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mPhone:Lcom/android/internal/telephony/Phone;

    iget-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mPhone:Lcom/android/internal/telephony/Phone;

    if-nez v0, :cond_0

    const-string v0, "SecurityManager"

    const-string v1, "Phone Failed"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    const-string v0, "Phone Successfully"

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private declared-synchronized SecurityCommand(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p1, "command"    # I
    .param p2, "request"    # Ljava/lang/Object;
    .param p3, "response"    # Ljava/lang/Object;

    .prologue
    monitor-enter p0

    :goto_0
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mHandler:Landroid/os/Handler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_0

    :try_start_1
    invoke-virtual {p0}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Thread;->interrupt()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .end local v1    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v2

    monitor-exit p0

    throw v2

    :cond_0
    :try_start_3
    new-instance v2, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    invoke-direct {v2, p2, p3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    iput-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mHandler:Landroid/os/Handler;

    invoke-static {v2, p1}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v0

    .local v0, "callback":Landroid/os/Message;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "callback: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    const-string v2, "SecurityCommand Start!"

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Request Data: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v2, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->request:Ljava/lang/Object;

    check-cast v2, [B

    check-cast v2, [B

    invoke-static {v2}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mPhone:Lcom/android/internal/telephony/Phone;

    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v2, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->request:Ljava/lang/Object;

    check-cast v2, [B

    check-cast v2, [B

    invoke-interface {v3, v2, v0}, Lcom/android/internal/telephony/Phone;->invokeOemRilRequestRaw([BLandroid/os/Message;)V

    :goto_1
    iget-boolean v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-nez v2, :cond_1

    :try_start_4
    invoke-virtual {p0}, Ljava/lang/Object;->wait()V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    :catch_1
    move-exception v1

    .restart local v1    # "e":Ljava/lang/InterruptedException;
    :try_start_5
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Thread;->interrupt()V

    goto :goto_1

    .end local v1    # "e":Ljava/lang/InterruptedException;
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "callback after invokeOemRilRequestRaw: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Response Data: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v2, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    check-cast v2, [B

    check-cast v2, [B

    invoke-static {v2}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    const-string v2, "SecurityCommand End!"

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v2, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    monitor-exit p0

    return-object v2
.end method

.method static synthetic access$102(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z

    return p1
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .param p1, "x1"    # I
    .param p2, "x2"    # Ljava/lang/Object;
    .param p3, "x3"    # Ljava/lang/Object;

    .prologue
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->SecurityCommand(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    const-string v0, "SecurityCommandThread Start!"

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Looper;->prepare()V

    monitor-enter p0

    :try_start_0
    new-instance v0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;-><init>(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mHandler:Landroid/os/Handler;

    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-static {}, Landroid/os/Looper;->loop()V

    const-string v0, "SecurityCommandThread End!"

    # invokes: Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/android/internal/telephony/SecurityManager;->access$000(Ljava/lang/String;)V

    return-void

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
