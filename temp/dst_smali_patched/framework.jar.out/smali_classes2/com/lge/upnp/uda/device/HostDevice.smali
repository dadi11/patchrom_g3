.class public Lcom/lge/upnp/uda/device/HostDevice;
.super Ljava/lang/Object;
.source "HostDevice.java"


# instance fields
.field private m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "lgupnp"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Lcom/lge/upnp/uda/device/IHostDeviceListener;)V
    .locals 4
    .param p1, "hdListner"    # Lcom/lge/upnp/uda/device/IHostDeviceListener;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v2, 0x0

    invoke-direct {v0, v2, v3}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-static {p1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->Initialize(Lcom/lge/upnp/uda/device/IHostDeviceListener;)J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/util/concurrent/atomic/AtomicLong;->set(J)V

    :cond_0
    return-void
.end method


# virtual methods
.method public announce(Ljava/util/List;II)Ljava/util/ArrayList;
    .locals 10
    .param p2, "freq"    # I
    .param p3, "maxAge"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;II)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .local p1, "ipAddressList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v6, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v6

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-eqz v6, :cond_0

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v6

    if-lez v6, :cond_0

    if-ltz p2, :cond_0

    if-ltz p3, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v6

    new-array v1, v6, [Ljava/lang/String;

    .local v1, "arrIpList":[Ljava/lang/String;
    invoke-interface {p1, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    iget-object v6, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v6

    invoke-static {v6, v7, v1, p2, p3}, Lcom/lge/upnp/uda/device/JNIHostDevice;->Announce(J[Ljava/lang/String;II)[Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .local v4, "ipList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    move-object v0, v1

    .local v0, "arr$":[Ljava/lang/String;
    array-length v5, v0

    .local v5, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v5, :cond_1

    aget-object v3, v0, v2

    .local v3, "ip":Ljava/lang/String;
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "arrIpList":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "ip":Ljava/lang/String;
    .end local v4    # "ipList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v5    # "len$":I
    :cond_0
    const/4 v4, 0x0

    :cond_1
    return-object v4
.end method

.method public announce(Ljava/util/List;[Lcom/lge/upnp/uda/http/IHttpHeader;I)Ljava/util/ArrayList;
    .locals 10
    .param p2, "httpheaders"    # [Lcom/lge/upnp/uda/http/IHttpHeader;
    .param p3, "freq"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;[",
            "Lcom/lge/upnp/uda/http/IHttpHeader;",
            "I)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .local p1, "ipAddressList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v6, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v6

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-eqz v6, :cond_0

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v6

    if-lez v6, :cond_0

    if-ltz p3, :cond_0

    if-eqz p2, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v6

    new-array v1, v6, [Ljava/lang/String;

    .local v1, "arrIpList":[Ljava/lang/String;
    invoke-interface {p1, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    iget-object v6, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v6

    invoke-static {v6, v7, v1, p2, p3}, Lcom/lge/upnp/uda/device/JNIHostDevice;->Announce(J[Ljava/lang/String;[Lcom/lge/upnp/uda/http/IHttpHeader;I)[Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .local v4, "ipList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    move-object v0, v1

    .local v0, "arr$":[Ljava/lang/String;
    array-length v5, v0

    .local v5, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v5, :cond_1

    aget-object v3, v0, v2

    .local v3, "ip":Ljava/lang/String;
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "arrIpList":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "ip":Ljava/lang/String;
    .end local v4    # "ipList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v5    # "len$":I
    :cond_0
    const/4 v4, 0x0

    :cond_1
    return-object v4
.end method

.method public byebye(Ljava/util/List;)Lcom/lge/upnp/uda/service/Result;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/lge/upnp/uda/service/Result;"
        }
    .end annotation

    .prologue
    .local p1, "ipAddressList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-eqz v1, :cond_0

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    new-array v0, v1, [Ljava/lang/String;

    .local v0, "arrIpList":[Ljava/lang/String;
    invoke-interface {p1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    invoke-static {v2, v3, v0}, Lcom/lge/upnp/uda/device/JNIHostDevice;->ByeBye(J[Ljava/lang/String;)Lcom/lge/upnp/uda/service/Result;

    move-result-object v1

    .end local v0    # "arrIpList":[Ljava/lang/String;
    :goto_0
    return-object v1

    :cond_0
    new-instance v1, Lcom/lge/upnp/uda/service/Result;

    invoke-direct {v1}, Lcom/lge/upnp/uda/service/Result;-><init>()V

    goto :goto_0
.end method

.method public changePortRangeSize(Ljava/lang/String;ZI)Lcom/lge/upnp/uda/service/Result;
    .locals 6
    .param p1, "localIPAddress"    # Ljava/lang/String;
    .param p2, "isUDP"    # Z
    .param p3, "size"    # I

    .prologue
    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-eqz v1, :cond_0

    if-eqz p1, :cond_0

    const/4 v1, 0x1

    if-lt p3, v1, :cond_0

    const/16 v1, 0xff

    if-gt p3, v1, :cond_0

    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    int-to-short v1, p3

    invoke-static {v2, v3, p1, p2, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->changePortRangeSize(JLjava/lang/String;ZS)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    const/4 v1, -0x1

    invoke-direct {v0, v1}, Lcom/lge/upnp/uda/service/Result;-><init>(I)V

    .local v0, "res":Lcom/lge/upnp/uda/service/Result;
    goto :goto_0
.end method

.method public declared-synchronized destroy()V
    .locals 6

    .prologue
    const-wide/16 v4, 0x0

    monitor-enter p0

    :try_start_0
    iget-object v2, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    cmp-long v2, v2, v4

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    .local v0, "objId":J
    iget-object v2, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v4, 0x0

    invoke-virtual {v2, v4, v5}, Ljava/util/concurrent/atomic/AtomicLong;->set(J)V

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->destroy(J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v0    # "objId":J
    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v2

    monitor-exit p0

    throw v2
.end method

.method protected finalize()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    const-wide/16 v4, 0x0

    :try_start_0
    iget-object v2, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    cmp-long v2, v2, v4

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    .local v0, "objId":J
    iget-object v2, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v4, 0x0

    invoke-virtual {v2, v4, v5}, Ljava/util/concurrent/atomic/AtomicLong;->set(J)V

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->destroy(J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v0    # "objId":J
    :cond_0
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    return-void

    :catchall_0
    move-exception v2

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v2
.end method

.method public getDeviceInfo()Lcom/lge/upnp/uda/service/IDeviceInfo;
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->GetDeviceInfo(J)Lcom/lge/upnp/uda/service/IDeviceInfo;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getServerName()Ljava/lang/String;
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->GetServerName(J)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isMediaTransferInProgress()Z
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->IsMediaTransferInProgress(J)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isRunning()Z
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->IsRunning(J)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public loadDeviceDescription(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/upnp/uda/service/Result;
    .locals 4
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "descriptionXml"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1, p1, p2}, Lcom/lge/upnp/uda/device/JNIHostDevice;->loadDeviceDescription(JLjava/lang/String;Ljava/lang/String;)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    invoke-direct {v0}, Lcom/lge/upnp/uda/service/Result;-><init>()V

    goto :goto_0
.end method

.method public loadServiceDescription(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/upnp/uda/service/Result;
    .locals 4
    .param p1, "serviceId"    # Ljava/lang/String;
    .param p2, "serviceXml"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1, p1, p2}, Lcom/lge/upnp/uda/device/JNIHostDevice;->loadServiceDescription(JLjava/lang/String;Ljava/lang/String;)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    invoke-direct {v0}, Lcom/lge/upnp/uda/service/Result;-><init>()V

    goto :goto_0
.end method

.method public sendEventNotification(Lcom/lge/upnp/uda/service/IServiceInfo;[Lcom/lge/upnp/uda/service/IStateVarInfo;Ljava/lang/Object;)Lcom/lge/upnp/uda/service/Result;
    .locals 8
    .param p1, "serviceInfo"    # Lcom/lge/upnp/uda/service/IServiceInfo;
    .param p2, "stateVarInfoList"    # [Lcom/lge/upnp/uda/service/IStateVarInfo;
    .param p3, "AppData"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    array-length v7, p2

    .local v7, "length":I
    new-array v4, v7, [J

    .local v4, "stVarInfoListObjId":[J
    const/4 v6, 0x0

    .local v6, "idx":I
    :goto_0
    if-ge v6, v7, :cond_0

    aget-object v0, p2, v6

    check-cast v0, Lcom/lge/upnp/uda/service/StateVarInfo;

    invoke-virtual {v0}, Lcom/lge/upnp/uda/service/StateVarInfo;->GetObjectId()J

    move-result-wide v0

    aput-wide v0, v4, v6

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    check-cast p1, Lcom/lge/upnp/uda/service/ServiceInfo;

    .end local p1    # "serviceInfo":Lcom/lge/upnp/uda/service/IServiceInfo;
    invoke-virtual {p1}, Lcom/lge/upnp/uda/service/ServiceInfo;->getObjectId()J

    move-result-wide v2

    move-object v5, p3

    invoke-static/range {v0 .. v5}, Lcom/lge/upnp/uda/device/JNIHostDevice;->SendEventNotification(JJ[JLjava/lang/Object;)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    .end local v4    # "stVarInfoListObjId":[J
    .end local v6    # "idx":I
    .end local v7    # "length":I
    :goto_1
    return-object v0

    .restart local p1    # "serviceInfo":Lcom/lge/upnp/uda/service/IServiceInfo;
    :cond_1
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    invoke-direct {v0}, Lcom/lge/upnp/uda/service/Result;-><init>()V

    goto :goto_1
.end method

.method public setServerName(Ljava/lang/String;)V
    .locals 4
    .param p1, "strServerName"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->SetServerName(JLjava/lang/String;)V

    :cond_0
    return-void
.end method

.method public setSourcePortRange(Ljava/lang/String;ZII)Lcom/lge/upnp/uda/service/Result;
    .locals 7
    .param p1, "localIPAddress"    # Ljava/lang/String;
    .param p2, "isUDP"    # Z
    .param p3, "startingPort"    # I
    .param p4, "size"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    if-ltz p3, :cond_0

    const v0, 0xffff

    if-gt p3, v0, :cond_0

    const/4 v0, 0x1

    if-lt p4, v0, :cond_0

    const/16 v0, 0xff

    if-gt p4, v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    int-to-short v5, p4

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-static/range {v0 .. v5}, Lcom/lge/upnp/uda/device/JNIHostDevice;->setSourcePortRange(JLjava/lang/String;ZIS)Lcom/lge/upnp/uda/service/Result;

    move-result-object v6

    :goto_0
    return-object v6

    :cond_0
    new-instance v6, Lcom/lge/upnp/uda/service/Result;

    const/4 v0, -0x1

    invoke-direct {v6, v0}, Lcom/lge/upnp/uda/service/Result;-><init>(I)V

    .local v6, "res":Lcom/lge/upnp/uda/service/Result;
    goto :goto_0
.end method

.method public start()Lcom/lge/upnp/uda/service/Result;
    .locals 6

    .prologue
    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    invoke-static {v2, v3}, Lcom/lge/upnp/uda/device/JNIHostDevice;->Start(J)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    const/4 v1, -0x1

    invoke-direct {v0, v1}, Lcom/lge/upnp/uda/service/Result;-><init>(I)V

    .local v0, "res":Lcom/lge/upnp/uda/service/Result;
    goto :goto_0
.end method

.method public start(IZ)Lcom/lge/upnp/uda/service/Result;
    .locals 6
    .param p1, "httpPort"    # I
    .param p2, "reuse"    # Z

    .prologue
    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    invoke-static {v2, v3, p1, p2}, Lcom/lge/upnp/uda/device/JNIHostDevice;->Start(JIZ)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    invoke-direct {v0}, Lcom/lge/upnp/uda/service/Result;-><init>()V

    .local v0, "result":Lcom/lge/upnp/uda/service/Result;
    const/4 v1, 0x1

    if-ne p2, v1, :cond_0

    if-nez p1, :cond_0

    const/4 v1, -0x6

    invoke-virtual {v0, v1}, Lcom/lge/upnp/uda/service/Result;->setResultCode(I)V

    goto :goto_0
.end method

.method public stop()Lcom/lge/upnp/uda/service/Result;
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/device/HostDevice;->m_ObjId:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/device/JNIHostDevice;->Stop(J)Lcom/lge/upnp/uda/service/Result;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lcom/lge/upnp/uda/service/Result;

    invoke-direct {v0}, Lcom/lge/upnp/uda/service/Result;-><init>()V

    goto :goto_0
.end method
