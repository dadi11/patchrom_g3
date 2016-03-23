.class public Lcom/lge/wfds/session/UdpDataManager;
.super Ljava/lang/Object;
.source "UdpDataManager.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "WfdsSession:Manager"

.field private static final UDP_REQUEST_RETRY_INTERVAL:I = 0x320

.field private static final UDP_REQUEST_RETRY_MAX:I = 0xa

.field private static mRequestTimes:I


# instance fields
.field private mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

.field private mReceiverThread:Ljava/lang/Thread;

.field private mReqType:I

.field private mRequestThreadHandler:Landroid/os/Handler;

.field private mRequestTread:Ljava/lang/Runnable;

.field private mSender:Lcom/lge/wfds/session/UdpDataSender;

.field private mSeq:I

.field private mSession:Lcom/lge/wfds/session/AspSession;

.field private mSessionList:Lcom/lge/wfds/session/AspSessionList;

.field private mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

.field private mWfdsStateMachine:Lcom/android/internal/util/StateMachine;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput v0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/util/StateMachine;Lcom/lge/wfds/session/AspSessionList;)V
    .locals 2
    .param p1, "sm"    # Lcom/android/internal/util/StateMachine;
    .param p2, "sesseionList"    # Lcom/lge/wfds/session/AspSessionList;

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSender:Lcom/lge/wfds/session/UdpDataSender;

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiverThread:Ljava/lang/Thread;

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReqType:I

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSession:Lcom/lge/wfds/session/AspSession;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestThreadHandler:Landroid/os/Handler;

    iput-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTread:Ljava/lang/Runnable;

    iput-object p1, p0, Lcom/lge/wfds/session/UdpDataManager;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    iput-object p2, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    new-instance v0, Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-direct {v0}, Lcom/lge/wfds/session/AspSessionProtoOpcode;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    new-instance v0, Lcom/lge/wfds/session/UdpDataManager$1;

    invoke-direct {v0, p0}, Lcom/lge/wfds/session/UdpDataManager$1;-><init>(Lcom/lge/wfds/session/UdpDataManager;)V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTread:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000()I
    .locals 1

    .prologue
    sget v0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    return v0
.end method

.method static synthetic access$002(I)I
    .locals 0
    .param p0, "x0"    # I

    .prologue
    sput p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    return p0
.end method

.method static synthetic access$008()I
    .locals 2

    .prologue
    sget v0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    return v0
.end method

.method static synthetic access$100(Lcom/lge/wfds/session/UdpDataManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReqType:I

    return v0
.end method

.method static synthetic access$200(Lcom/lge/wfds/session/UdpDataManager;)Lcom/android/internal/util/StateMachine;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/wfds/session/UdpDataManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    return v0
.end method

.method static synthetic access$400(Lcom/lge/wfds/session/UdpDataManager;)Lcom/lge/wfds/session/AspSession;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSession:Lcom/lge/wfds/session/AspSession;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/wfds/session/UdpDataManager;)Lcom/lge/wfds/session/AspSessionList;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    return-object v0
.end method

.method static synthetic access$600(Lcom/lge/wfds/session/UdpDataManager;)Lcom/lge/wfds/session/UdpDataSender;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSender:Lcom/lge/wfds/session/UdpDataSender;

    return-object v0
.end method

.method static synthetic access$700(Lcom/lge/wfds/session/UdpDataManager;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/session/UdpDataManager;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestThreadHandler:Landroid/os/Handler;

    return-object v0
.end method

.method private resetReqType()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReqType:I

    return-void
.end method

.method private setAspSession(Lcom/lge/wfds/session/AspSession;)V
    .locals 1
    .param p1, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    if-nez p1, :cond_0

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSession:Lcom/lge/wfds/session/AspSession;

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSession:Lcom/lge/wfds/session/AspSession;

    if-nez v0, :cond_1

    new-instance v0, Lcom/lge/wfds/session/AspSession;

    invoke-direct {v0}, Lcom/lge/wfds/session/AspSession;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSession:Lcom/lge/wfds/session/AspSession;

    :cond_1
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSession:Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/session/AspSession;->set(Lcom/lge/wfds/session/AspSession;)V

    goto :goto_0
.end method

.method private setReqType(I)V
    .locals 2
    .param p1, "type"    # I

    .prologue
    iget v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    iput p1, p0, Lcom/lge/wfds/session/UdpDataManager;->mReqType:I

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    iget v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    invoke-virtual {v0, v1, p1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->setRequestedType(II)V

    return-void
.end method


# virtual methods
.method public initUdpDataSender(Ljava/lang/String;)V
    .locals 1
    .param p1, "ip_address"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSender:Lcom/lge/wfds/session/UdpDataSender;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/wfds/session/UdpDataSender;

    invoke-direct {v0}, Lcom/lge/wfds/session/UdpDataSender;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSender:Lcom/lge/wfds/session/UdpDataSender;

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSender:Lcom/lge/wfds/session/UdpDataSender;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/session/UdpDataSender;->setTargetIpAddress(Ljava/lang/String;)V

    const/4 v0, 0x0

    sput v0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataManager;->resetReqType()V

    return-void
.end method

.method public startReceiver()V
    .locals 4

    .prologue
    const-string v0, "WfdsSession:Manager"

    const-string v1, "Create CoordinationProtocol Packet Receiver"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/wfds/session/UdpDataReceiver;

    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    iget-object v2, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    iget-object v3, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-direct {v0, v1, v2, v3}, Lcom/lge/wfds/session/UdpDataReceiver;-><init>(Lcom/android/internal/util/StateMachine;Lcom/lge/wfds/session/AspSessionList;Lcom/lge/wfds/session/AspSessionProtoOpcode;)V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiverThread:Ljava/lang/Thread;

    if-nez v0, :cond_1

    new-instance v0, Ljava/lang/Thread;

    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    const-string v2, "WfdsUdpPacketReceiverThread"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiverThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiverThread:Ljava/lang/Thread;

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setPriority(I)V

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiverThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    :cond_1
    return-void
.end method

.method public declared-synchronized startRequest(ILcom/lge/wfds/session/AspSession;)Z
    .locals 4
    .param p1, "req_type"    # I
    .param p2, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    const/4 v1, 0x0

    monitor-enter p0

    const/4 v2, -0x1

    if-eq p1, v2, :cond_0

    if-nez p2, :cond_1

    :cond_0
    :goto_0
    monitor-exit p0

    return v1

    :cond_1
    :try_start_0
    sget v1, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v1, p1, p2}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->putPendedSendRequest(ILcom/lge/wfds/session/AspSession;)V

    :goto_1
    const/4 v1, 0x1

    goto :goto_0

    :cond_2
    sget v1, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    invoke-direct {p0, p1}, Lcom/lge/wfds/session/UdpDataManager;->setReqType(I)V

    invoke-direct {p0, p2}, Lcom/lge/wfds/session/UdpDataManager;->setAspSession(Lcom/lge/wfds/session/AspSession;)V

    const-string v1, "WfdsSession:Manager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "startRequest : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getReqTypeString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", Seq:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/lge/wfds/session/UdpDataManager;->mSeq:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", To:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    invoke-virtual {v3, p2}, Lcom/lge/wfds/session/AspSessionList;->getSessionIpAddress(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x4

    if-ne p1, v1, :cond_3

    iget-object v1, p2, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    if-eqz v1, :cond_3

    iget-object v1, p2, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/AspServicePort;

    .local v0, "port_":Lcom/lge/wfds/session/AspServicePort;
    const-string v1, "WfdsSession:Manager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ALLOWED_PORT [Port:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Lcom/lge/wfds/session/AspServicePort;->port:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", proto:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Lcom/lge/wfds/session/AspServicePort;->proto:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "port_":Lcom/lge/wfds/session/AspServicePort;
    :cond_3
    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestThreadHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTread:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_1

    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public stopReceiver()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const-string v0, "WfdsSession:Manager"

    const-string v1, "Stop Receiver Thread"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    invoke-virtual {v0}, Lcom/lge/wfds/session/UdpDataReceiver;->stopReceiver()V

    iput-object v2, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiver:Lcom/lge/wfds/session/UdpDataReceiver;

    iput-object v2, p0, Lcom/lge/wfds/session/UdpDataManager;->mReceiverThread:Ljava/lang/Thread;

    :cond_0
    const-string v0, "WfdsSession:Manager"

    const-string v1, "remove mRequestTread from Handler"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v0}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->removeAllPendedSendReqSession()V

    invoke-virtual {p0}, Lcom/lge/wfds/session/UdpDataManager;->stopRequest()V

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataManager;->resetReqType()V

    return-void
.end method

.method public declared-synchronized stopRequest()V
    .locals 3

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestThreadHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestThreadHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTread:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v0}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->hasPendedSendRequest()Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "WfdsSession:Manager"

    const-string v1, "There is a PendedSendRequest...."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    sput v0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getPendedSendReqType()I

    move-result v1

    iget-object v2, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v2}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getPendedSendReqSession()Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/lge/wfds/session/UdpDataManager;->startRequest(ILcom/lge/wfds/session/AspSession;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataManager;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v0}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->removePendedSendReqSession()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    :goto_0
    monitor-exit p0

    return-void

    :cond_2
    const/4 v0, 0x0

    :try_start_1
    sput v0, Lcom/lge/wfds/session/UdpDataManager;->mRequestTimes:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
