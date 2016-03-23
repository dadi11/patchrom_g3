.class public Lcom/lge/wfds/session/UdpDataReceiver;
.super Ljava/lang/Object;
.source "UdpDataReceiver.java"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static final DBG:Z = false

.field private static final TAG:Ljava/lang/String; = "WfdsSession:RECEIVE"


# instance fields
.field private bThreadRunning:Z

.field private mSessionList:Lcom/lge/wfds/session/AspSessionList;

.field private mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

.field private mSocket:Ljava/net/DatagramSocket;

.field private mWfdsStateMachine:Lcom/android/internal/util/StateMachine;


# direct methods
.method public constructor <init>(Lcom/android/internal/util/StateMachine;Lcom/lge/wfds/session/AspSessionList;Lcom/lge/wfds/session/AspSessionProtoOpcode;)V
    .locals 3
    .param p1, "sm"    # Lcom/android/internal/util/StateMachine;
    .param p2, "sessionList"    # Lcom/lge/wfds/session/AspSessionList;
    .param p3, "sessionOp"    # Lcom/lge/wfds/session/AspSessionProtoOpcode;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    iput-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    iput-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    const-string v0, "WfdsSession:RECEIVE"

    const-string v1, "UdpDataReceiver Created"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    iput-object p2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    iput-object p3, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->bThreadRunning:Z

    iput-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    return-void
.end method

.method private byteArrayToAddress([B)Ljava/lang/String;
    .locals 7
    .param p1, "bytes"    # [B

    .prologue
    const-string v1, ""

    .local v1, "mac":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v2, p1

    if-ge v0, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "%02x"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aget-byte v6, p1, v0

    invoke-static {v6}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    array-length v2, p1

    add-int/lit8 v2, v2, -0x1

    if-ge v0, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-object v1
.end method

.method private closeSocket()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    invoke-virtual {v0}, Ljava/net/DatagramSocket;->close()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    :cond_0
    return-void
.end method

.method private notifyReceivedAck(I)V
    .locals 4
    .param p1, "seq"    # I

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getRequestedType(I)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const v0, 0x901063

    invoke-direct {p0, v0, v2, v2, v3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getRequestedType(I)I

    move-result v0

    const/4 v1, 0x5

    if-ne v0, v1, :cond_1

    const v0, 0x901064

    invoke-direct {p0, v0, v2, v2, v3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_0

    :cond_1
    const v0, 0x901065

    invoke-direct {p0, v0, v2, v2, v3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_0
.end method

.method private notifyReceivedData(IILcom/lge/wfds/session/AspSession;Ljava/lang/String;)V
    .locals 4
    .param p1, "type"    # I
    .param p2, "seq"    # I
    .param p3, "session"    # Lcom/lge/wfds/session/AspSession;
    .param p4, "hostIpAddress"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    const-string v0, "WfdsSession:RECEIVE"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "notifyReceivedData : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getReqTypeString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", Seq:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", From:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x5

    if-ne v0, p1, :cond_1

    const v0, 0x90105c

    invoke-direct {p0, v0, v3, v3, p3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/16 v0, 0xfe

    if-ne v0, p1, :cond_2

    const-string v0, "WfdsSession:RECEIVE"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Received :ACK ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionProtoOpcode:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-virtual {v2, p2}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getRequestedType(I)I

    move-result v2

    invoke-static {v2}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getReqTypeString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, p2}, Lcom/lge/wfds/session/UdpDataReceiver;->notifyReceivedAck(I)V

    goto :goto_0

    :cond_2
    if-eqz p3, :cond_0

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    :pswitch_1
    invoke-direct {p0, p1, p3}, Lcom/lge/wfds/session/UdpDataReceiver;->notifyReceivedDataTo(ILcom/lge/wfds/session/AspSession;)V

    goto :goto_0

    :pswitch_2
    const v0, 0x901060

    invoke-direct {p0, v0, v3, v3, p3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_0

    :pswitch_3
    const v0, 0x901061

    invoke-direct {p0, v0, v3, v3, p3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_0

    :pswitch_4
    const v0, 0x901062

    invoke-direct {p0, v0, v3, v3, p3}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
        :pswitch_4
    .end packed-switch
.end method

.method private notifyReceivedDataTo(ILcom/lge/wfds/session/AspSession;)V
    .locals 6
    .param p1, "type"    # I
    .param p2, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    const/4 v5, 0x0

    const/4 v1, 0x0

    .local v1, "s":Lcom/lge/wfds/session/AspSession;
    const/4 v0, 0x0

    .local v0, "bSeeker":Z
    iget-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSessionList:Lcom/lge/wfds/session/AspSessionList;

    iget-object v3, p2, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v4, p2, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v2, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    if-eqz v2, :cond_1

    iget-object v2, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v3, v1, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "WfdsSession:RECEIVE"

    const-string v3, "notifyReceivedDataTo : I\'m a Seeker"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    :goto_0
    packed-switch p1, :pswitch_data_0

    :cond_0
    :goto_1
    return-void

    :cond_1
    const-string v2, "WfdsSession:RECEIVE"

    const-string v3, "notifyReceivedDataTo : I\'m an Advertiser"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    goto :goto_0

    :pswitch_0
    const/4 v2, 0x1

    if-eq v0, v2, :cond_0

    const v2, 0x90105d

    invoke-direct {p0, v2, v5, v5, p2}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_1

    :pswitch_1
    if-eqz v0, :cond_0

    const v2, 0x90105e

    invoke-direct {p0, v2, v5, v5, p2}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_1

    :pswitch_2
    if-eqz v0, :cond_0

    const v2, 0x90105f

    invoke-direct {p0, v2, v5, v5, p2}, Lcom/lge/wfds/session/UdpDataReceiver;->sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V

    goto :goto_1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private processAddedRejectedSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;
    .locals 5
    .param p1, "pack"    # Ljava/net/DatagramPacket;
    .param p2, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    const/4 v1, 0x0

    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    const/4 v3, 0x6

    new-array v0, v3, [B

    .local v0, "mac":[B
    const/4 v2, 0x0

    .local v2, "session_id":I
    invoke-virtual {p2, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v2

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v3

    if-nez v3, :cond_1

    :cond_0
    const-string v3, "WfdsSession:RECEIVE"

    const-string v4, "ADDED/REJECTED_SESSION failed because DatagramPacket is null"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    :goto_0
    return-object v3

    :cond_1
    new-instance v1, Lcom/lge/wfds/session/AspSession;

    .end local v1    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-direct {p0, v0}, Lcom/lge/wfds/session/UdpDataReceiver;->byteArrayToAddress([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v4

    invoke-virtual {v4}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v3, v2, v4}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .restart local v1    # "session":Lcom/lge/wfds/session/AspSession;
    move-object v3, v1

    goto :goto_0
.end method

.method private processAllowedPort(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;
    .locals 7
    .param p1, "pack"    # Ljava/net/DatagramPacket;
    .param p2, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    const/4 v3, 0x0

    .local v3, "session":Lcom/lge/wfds/session/AspSession;
    const/4 v5, 0x6

    new-array v0, v5, [B

    .local v0, "mac":[B
    const/4 v4, 0x0

    .local v4, "session_id":I
    const/4 v1, 0x0

    .local v1, "port":I
    const/4 v2, 0x0

    .local v2, "proto":I
    invoke-virtual {p2, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v4

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getChar()C

    move-result v5

    const v6, 0xffff

    and-int v1, v5, v6

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->get()B

    move-result v5

    and-int/lit16 v2, v5, 0xff

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v5

    if-nez v5, :cond_1

    :cond_0
    const-string v5, "WfdsSession:RECEIVE"

    const-string v6, "ALLOWED_SESSION failed because DatagramPacket is null"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, 0x0

    :goto_0
    return-object v5

    :cond_1
    new-instance v3, Lcom/lge/wfds/session/AspSession;

    .end local v3    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-direct {p0, v0}, Lcom/lge/wfds/session/UdpDataReceiver;->byteArrayToAddress([B)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v6

    invoke-virtual {v6}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v5, v4, v6}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .restart local v3    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-virtual {v3, v1, v2}, Lcom/lge/wfds/session/AspSession;->addPort(II)V

    move-object v5, v3

    goto :goto_0
.end method

.method private processDeferredSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;
    .locals 9
    .param p1, "pack"    # Ljava/net/DatagramPacket;
    .param p2, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    const/4 v0, 0x0

    .local v0, "session":Lcom/lge/wfds/session/AspSession;
    const/4 v1, 0x6

    new-array v8, v1, [B

    .local v8, "mac":[B
    const/4 v3, 0x0

    .local v3, "session_id":I
    const/4 v7, 0x0

    .local v7, "info_len":I
    const/4 v6, 0x0

    .local v6, "info":[B
    const/4 v4, 0x0

    .local v4, "adv_id":I
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    if-nez v1, :cond_1

    :cond_0
    const-string v1, "WfdsSession:RECEIVE"

    const-string v2, "DEFERRED_SESSION fail because DatagramPacket is null"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_1
    invoke-virtual {p2, v8}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v3

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->get()B

    move-result v1

    and-int/lit16 v7, v1, 0xff

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    new-array v6, v1, [B

    invoke-virtual {p2, v6}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    new-instance v0, Lcom/lge/wfds/session/AspSession;

    .end local v0    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v8}, Lcom/lge/wfds/session/UdpDataReceiver;->byteArrayToAddress([B)Ljava/lang/String;

    move-result-object v2

    new-instance v5, Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>([B)V

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    .restart local v0    # "session":Lcom/lge/wfds/session/AspSession;
    move-object v1, v0

    goto :goto_0
.end method

.method private processNack(Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p1, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->get()B

    move-result v0

    .local v0, "reason":B
    return-void
.end method

.method private processRemoveSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;
    .locals 6
    .param p1, "pack"    # Ljava/net/DatagramPacket;
    .param p2, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    const/4 v2, 0x0

    .local v2, "session":Lcom/lge/wfds/session/AspSession;
    const/4 v4, 0x6

    new-array v0, v4, [B

    .local v0, "mac":[B
    const/4 v3, 0x0

    .local v3, "session_id":I
    const/4 v1, 0x0

    .local v1, "reason":B
    invoke-virtual {p2, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v3

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->get()B

    move-result v1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v4

    if-nez v4, :cond_1

    :cond_0
    const-string v4, "WfdsSession:RECEIVE"

    const-string v5, "REMOVE_SESSION failed because DatagramPacket is null"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v4, 0x0

    :goto_0
    return-object v4

    :cond_1
    new-instance v2, Lcom/lge/wfds/session/AspSession;

    .end local v2    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-direct {p0, v0}, Lcom/lge/wfds/session/UdpDataReceiver;->byteArrayToAddress([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v5

    invoke-virtual {v5}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v4, v3, v5}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .restart local v2    # "session":Lcom/lge/wfds/session/AspSession;
    move-object v4, v2

    goto :goto_0
.end method

.method private processRequestSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;
    .locals 9
    .param p1, "pack"    # Ljava/net/DatagramPacket;
    .param p2, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    const/4 v5, 0x0

    const/4 v0, 0x0

    .local v0, "session":Lcom/lge/wfds/session/AspSession;
    const/4 v1, 0x6

    new-array v8, v1, [B

    .local v8, "mac":[B
    const/4 v3, 0x0

    .local v3, "session_id":I
    const/4 v4, 0x0

    .local v4, "adv_id":I
    const/4 v7, 0x0

    .local v7, "info_len":I
    const/4 v6, 0x0

    .local v6, "info":[B
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    if-nez v1, :cond_1

    :cond_0
    const-string v1, "WfdsSession:RECEIVE"

    const-string v2, "REQUEST_SESSION failed because DatagramPacket is null"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-object v5

    :cond_1
    invoke-virtual {p2, v8}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v3

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v4

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    if-lez v1, :cond_2

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->get()B

    move-result v1

    and-int/lit16 v7, v1, 0xff

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    new-array v6, v1, [B

    invoke-virtual {p2, v6}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    new-instance v0, Lcom/lge/wfds/session/AspSession;

    .end local v0    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v8}, Lcom/lge/wfds/session/UdpDataReceiver;->byteArrayToAddress([B)Ljava/lang/String;

    move-result-object v2

    new-instance v5, Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>([B)V

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    .restart local v0    # "session":Lcom/lge/wfds/session/AspSession;
    :goto_1
    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wfds/session/AspSession;->setIpAddress(Ljava/lang/String;)V

    move-object v5, v0

    goto :goto_0

    :cond_2
    new-instance v0, Lcom/lge/wfds/session/AspSession;

    .end local v0    # "session":Lcom/lge/wfds/session/AspSession;
    invoke-virtual {p1}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v8}, Lcom/lge/wfds/session/UdpDataReceiver;->byteArrayToAddress([B)Ljava/lang/String;

    move-result-object v2

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    .restart local v0    # "session":Lcom/lge/wfds/session/AspSession;
    goto :goto_1
.end method

.method private processVersion(Ljava/nio/ByteBuffer;)V
    .locals 4
    .param p1, "buff"    # Ljava/nio/ByteBuffer;

    .prologue
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->get()B

    move-result v3

    and-int/lit16 v2, v3, 0xff

    .local v2, "ver":I
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->get()B

    move-result v3

    and-int/lit16 v0, v3, 0xff

    .local v0, "info_len":I
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    new-array v1, v3, [B

    .local v1, "vendor_info":[B
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    return-void
.end method

.method private receiveUdpDatatPacket()V
    .locals 11

    .prologue
    const/4 v10, 0x1

    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "Wfds UdpDatatPacket Receiver Start"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v10, p0, Lcom/lge/wfds/session/UdpDataReceiver;->bThreadRunning:Z

    :try_start_0
    new-instance v8, Ljava/net/DatagramSocket;

    const/4 v9, 0x0

    invoke-direct {v8, v9}, Ljava/net/DatagramSocket;-><init>(Ljava/net/SocketAddress;)V

    iput-object v8, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    iget-object v8, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    const/4 v9, 0x1

    invoke-virtual {v8, v9}, Ljava/net/DatagramSocket;->setReuseAddress(Z)V

    new-instance v0, Ljava/net/InetSocketAddress;

    const/16 v8, 0x1c43

    invoke-direct {v0, v8}, Ljava/net/InetSocketAddress;-><init>(I)V

    .local v0, "addr":Ljava/net/InetSocketAddress;
    iget-object v8, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    invoke-virtual {v8, v0}, Ljava/net/DatagramSocket;->bind(Ljava/net/SocketAddress;)V

    const/16 v8, 0x200

    new-array v3, v8, [B

    .local v3, "msg":[B
    const/16 v8, 0x200

    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    .local v1, "buff":Ljava/nio/ByteBuffer;
    new-instance v4, Ljava/net/DatagramPacket;

    array-length v8, v3

    invoke-direct {v4, v3, v8}, Ljava/net/DatagramPacket;-><init>([BI)V

    .local v4, "pack":Ljava/net/DatagramPacket;
    :cond_0
    :goto_0
    iget-boolean v8, p0, Lcom/lge/wfds/session/UdpDataReceiver;->bThreadRunning:Z

    if-eqz v8, :cond_2

    iget-object v8, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    invoke-virtual {v8, v4}, Ljava/net/DatagramSocket;->receive(Ljava/net/DatagramPacket;)V

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    invoke-virtual {v4}, Ljava/net/DatagramPacket;->getData()[B

    move-result-object v8

    const/4 v9, 0x0

    invoke-virtual {v4}, Ljava/net/DatagramPacket;->getLength()I

    move-result v10

    invoke-virtual {v1, v8, v9, v10}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->get()B

    move-result v8

    and-int/lit16 v5, v8, 0xff

    .local v5, "req_type":I
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->get()B

    move-result v8

    and-int/lit16 v6, v8, 0xff

    .local v6, "seq":I
    const/4 v7, 0x0

    .local v7, "session":Lcom/lge/wfds/session/AspSession;
    const-string v8, "WfdsSession:RECEIVE"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Received :"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-static {v5}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getReqTypeString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sparse-switch v5, :sswitch_data_0

    const/16 v8, 0xfe

    if-eq v5, v8, :cond_1

    const-string v8, "WfdsSession:RECEIVE"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Unknown Request Type ["

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "]"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_1
    invoke-virtual {v4}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v8

    if-eqz v8, :cond_0

    invoke-virtual {v4}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v8

    invoke-virtual {v8}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v5, v6, v7, v8}, Lcom/lge/wfds/session/UdpDataReceiver;->notifyReceivedData(IILcom/lge/wfds/session/AspSession;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/SocketException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .end local v0    # "addr":Ljava/net/InetSocketAddress;
    .end local v1    # "buff":Ljava/nio/ByteBuffer;
    .end local v3    # "msg":[B
    .end local v4    # "pack":Ljava/net/DatagramPacket;
    .end local v5    # "req_type":I
    .end local v6    # "seq":I
    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :catch_0
    move-exception v2

    .local v2, "e":Ljava/net/SocketException;
    :try_start_1
    iget-boolean v8, p0, Lcom/lge/wfds/session/UdpDataReceiver;->bThreadRunning:Z

    if-nez v8, :cond_3

    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "SocketException : Socket is Closed"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_2
    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "Close Socket - stopReceiver called"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V

    .end local v2    # "e":Ljava/net/SocketException;
    :goto_3
    return-void

    .restart local v0    # "addr":Ljava/net/InetSocketAddress;
    .restart local v1    # "buff":Ljava/nio/ByteBuffer;
    .restart local v3    # "msg":[B
    .restart local v4    # "pack":Ljava/net/DatagramPacket;
    .restart local v5    # "req_type":I
    .restart local v6    # "seq":I
    .restart local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :sswitch_0
    :try_start_2
    invoke-direct {p0, v4, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processRequestSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v7

    invoke-direct {p0, v5, v4, v6}, Lcom/lge/wfds/session/UdpDataReceiver;->sendAckPacket(ILjava/net/DatagramPacket;I)V
    :try_end_2
    .catch Ljava/net/SocketException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .end local v0    # "addr":Ljava/net/InetSocketAddress;
    .end local v1    # "buff":Ljava/nio/ByteBuffer;
    .end local v3    # "msg":[B
    .end local v4    # "pack":Ljava/net/DatagramPacket;
    .end local v5    # "req_type":I
    .end local v6    # "seq":I
    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :catch_1
    move-exception v2

    .local v2, "e":Ljava/io/IOException;
    :try_start_3
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "Close Socket - stopReceiver called"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V

    goto :goto_3

    .end local v2    # "e":Ljava/io/IOException;
    .restart local v0    # "addr":Ljava/net/InetSocketAddress;
    .restart local v1    # "buff":Ljava/nio/ByteBuffer;
    .restart local v3    # "msg":[B
    .restart local v4    # "pack":Ljava/net/DatagramPacket;
    .restart local v5    # "req_type":I
    .restart local v6    # "seq":I
    .restart local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :sswitch_1
    :try_start_4
    invoke-direct {p0, v4, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processAddedRejectedSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v7

    invoke-direct {p0, v5, v4, v6}, Lcom/lge/wfds/session/UdpDataReceiver;->sendAckPacket(ILjava/net/DatagramPacket;I)V
    :try_end_4
    .catch Ljava/net/SocketException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .end local v0    # "addr":Ljava/net/InetSocketAddress;
    .end local v1    # "buff":Ljava/nio/ByteBuffer;
    .end local v3    # "msg":[B
    .end local v4    # "pack":Ljava/net/DatagramPacket;
    .end local v5    # "req_type":I
    .end local v6    # "seq":I
    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :catch_2
    move-exception v2

    .local v2, "e":Ljava/lang/Exception;
    :try_start_5
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "Close Socket - stopReceiver called"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V

    goto :goto_3

    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v0    # "addr":Ljava/net/InetSocketAddress;
    .restart local v1    # "buff":Ljava/nio/ByteBuffer;
    .restart local v3    # "msg":[B
    .restart local v4    # "pack":Ljava/net/DatagramPacket;
    .restart local v5    # "req_type":I
    .restart local v6    # "seq":I
    .restart local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :sswitch_2
    :try_start_6
    invoke-direct {p0, v4, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processRemoveSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v7

    invoke-direct {p0, v5, v4, v6}, Lcom/lge/wfds/session/UdpDataReceiver;->sendAckPacket(ILjava/net/DatagramPacket;I)V
    :try_end_6
    .catch Ljava/net/SocketException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_1

    .end local v0    # "addr":Ljava/net/InetSocketAddress;
    .end local v1    # "buff":Ljava/nio/ByteBuffer;
    .end local v3    # "msg":[B
    .end local v4    # "pack":Ljava/net/DatagramPacket;
    .end local v5    # "req_type":I
    .end local v6    # "seq":I
    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :catchall_0
    move-exception v8

    const-string v9, "WfdsSession:RECEIVE"

    const-string v10, "Close Socket - stopReceiver called"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V

    throw v8

    .restart local v0    # "addr":Ljava/net/InetSocketAddress;
    .restart local v1    # "buff":Ljava/nio/ByteBuffer;
    .restart local v3    # "msg":[B
    .restart local v4    # "pack":Ljava/net/DatagramPacket;
    .restart local v5    # "req_type":I
    .restart local v6    # "seq":I
    .restart local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :sswitch_3
    :try_start_7
    invoke-direct {p0, v4, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processAllowedPort(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v7

    invoke-direct {p0, v5, v4, v6}, Lcom/lge/wfds/session/UdpDataReceiver;->sendAckPacket(ILjava/net/DatagramPacket;I)V

    goto :goto_1

    :sswitch_4
    invoke-direct {p0, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processVersion(Ljava/nio/ByteBuffer;)V

    invoke-direct {p0, v5, v4, v6}, Lcom/lge/wfds/session/UdpDataReceiver;->sendAckPacket(ILjava/net/DatagramPacket;I)V

    goto :goto_1

    :sswitch_5
    invoke-direct {p0, v4, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processDeferredSession(Ljava/net/DatagramPacket;Ljava/nio/ByteBuffer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v7

    invoke-direct {p0, v5, v4, v6}, Lcom/lge/wfds/session/UdpDataReceiver;->sendAckPacket(ILjava/net/DatagramPacket;I)V

    goto/16 :goto_1

    :sswitch_6
    invoke-direct {p0, v1}, Lcom/lge/wfds/session/UdpDataReceiver;->processNack(Ljava/nio/ByteBuffer;)V

    goto/16 :goto_1

    .end local v5    # "req_type":I
    .end local v6    # "seq":I
    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :cond_2
    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "Close Socket"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V
    :try_end_7
    .catch Ljava/net/SocketException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    const-string v8, "WfdsSession:RECEIVE"

    const-string v9, "Close Socket - stopReceiver called"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V

    goto :goto_3

    .end local v0    # "addr":Ljava/net/InetSocketAddress;
    .end local v1    # "buff":Ljava/nio/ByteBuffer;
    .end local v3    # "msg":[B
    .end local v4    # "pack":Ljava/net/DatagramPacket;
    .local v2, "e":Ljava/net/SocketException;
    :cond_3
    :try_start_8
    invoke-virtual {v2}, Ljava/net/SocketException;->printStackTrace()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto/16 :goto_2

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x1 -> :sswitch_1
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0x4 -> :sswitch_3
        0x5 -> :sswitch_4
        0x6 -> :sswitch_5
        0xff -> :sswitch_6
    .end sparse-switch
.end method

.method private sendAckPacket(ILjava/net/DatagramPacket;I)V
    .locals 5
    .param p1, "req_type"    # I
    .param p2, "pack"    # Ljava/net/DatagramPacket;
    .param p3, "seq"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v2, 0xfe

    const/4 v3, 0x0

    invoke-static {v2, p3, v3}, Lcom/lge/wfds/session/UdpDataSender;->requestBuilderAck(III)[B

    move-result-object v0

    .local v0, "ack":[B
    new-instance v1, Ljava/net/DatagramPacket;

    array-length v2, v0

    invoke-virtual {p2}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v3

    const/16 v4, 0x1c43

    invoke-direct {v1, v0, v2, v3, v4}, Ljava/net/DatagramPacket;-><init>([BILjava/net/InetAddress;I)V

    .local v1, "p":Ljava/net/DatagramPacket;
    iget-object v2, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mSocket:Ljava/net/DatagramSocket;

    invoke-virtual {v2, v1}, Ljava/net/DatagramSocket;->send(Ljava/net/DatagramPacket;)V

    const-string v2, "WfdsSession:RECEIVE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Send ACK of "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p1}, Lcom/lge/wfds/session/AspSessionProtoOpcode;->getReqTypeString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p2}, Ljava/net/DatagramPacket;->getAddress()Ljava/net/InetAddress;

    move-result-object v4

    invoke-virtual {v4}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private sendMessageToStateMachine(IIILcom/lge/wfds/session/AspSession;)V
    .locals 3
    .param p1, "type"    # I
    .param p2, "arg1"    # I
    .param p3, "arg2"    # I
    .param p4, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iput p1, v0, Landroid/os/Message;->what:I

    iput p2, v0, Landroid/os/Message;->arg1:I

    iput p3, v0, Landroid/os/Message;->arg2:I

    if-eqz p4, :cond_0

    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p4}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/session/UdpDataReceiver;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    invoke-virtual {v1, v0}, Lcom/android/internal/util/StateMachine;->sendMessage(Landroid/os/Message;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->receiveUdpDatatPacket()V

    return-void
.end method

.method public stopReceiver()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/wfds/session/UdpDataReceiver;->bThreadRunning:Z

    invoke-direct {p0}, Lcom/lge/wfds/session/UdpDataReceiver;->closeSocket()V

    const-string v0, "WfdsSession:RECEIVE"

    const-string v1, "Stop Receiver : Socket Closed"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
