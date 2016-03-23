.class Lcom/lge/wfds/WfdsDiscoveryStore;
.super Ljava/lang/Object;
.source "WfdsDiscoveryStore.java"


# static fields
.field private static final DUPLICATED:Z = true

.field private static final NOT_DUPLICATED:Z = false

.field private static final TAG:Ljava/lang/String; = "WfdsDiscoveryStore"


# instance fields
.field private mConfiguredAdvertise:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Lcom/lge/wfds/WfdsDiscoveryMethod;",
            ">;"
        }
    .end annotation
.end field

.field private mConfiguredSearch:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Lcom/lge/wfds/WfdsDiscoveryMethod;",
            ">;"
        }
    .end annotation
.end field

.field private mWfdsNative:Lcom/lge/wfds/WfdsNative;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsNative;)V
    .locals 1
    .param p1, "wn"    # Lcom/lge/wfds/WfdsNative;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    return-void
.end method


# virtual methods
.method changeServiceStatus(III)Z
    .locals 4
    .param p1, "id"    # I
    .param p2, "status"    # I
    .param p3, "forcedChannel"    # I

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v0, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-nez v0, :cond_1

    const-string v2, "WfdsDiscoveryStore"

    const-string v3, "changeServiceStatus: method is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v1

    :cond_1
    iget-object v2, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceStatus()I

    move-result v2

    if-ne v2, p2, :cond_2

    const-string v2, "WfdsDiscoveryStore"

    const-string v3, "changeServiceStatus: not changed because of the identical status"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    iget-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    invoke-virtual {v2, p1, p2, p3}, Lcom/lge/wfds/WfdsNative;->changeServiceStatus(III)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v1, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1, p2}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setServiceStatus(I)V

    iget-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    monitor-enter v2

    :try_start_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v2

    const/4 v1, 0x1

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method checkAdvertiseMethod(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "info"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v1, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod;->getServiceName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    if-eqz p2, :cond_1

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceInfo()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceInfo()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :goto_0
    return v2

    .restart local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_1
    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceInfo()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    goto :goto_0

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_2
    const/4 v2, 0x0

    goto :goto_0
.end method

.method checkDiscovering()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method checkSearchMethod(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "req"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v1, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod;->getServiceName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    if-eqz p2, :cond_1

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getServiceInfoRequest()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getServiceInfoRequest()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :goto_0
    return v2

    .restart local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_1
    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getServiceInfoRequest()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    goto :goto_0

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_2
    const/4 v2, 0x0

    goto :goto_0
.end method

.method clearDiscoveryMap()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    return-void
.end method

.method getConfiguredAllAdvertise(I)Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .locals 3
    .param p1, "id"    # I

    .prologue
    iget-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v0, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-nez v0, :cond_0

    const-string v1, "WfdsDiscoveryStore"

    const-string v2, "changeServiceStatus: method is null"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_0
    iget-object v1, v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    goto :goto_0
.end method

.method getConfiguredAllAdvertise()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/lge/wfds/WfdsDiscoveryMethod;",
            ">;"
        }
    .end annotation

    .prologue
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .local v2, "methods":Ljava/util/List;, "Ljava/util/List<Lcom/lge/wfds/WfdsDiscoveryMethod;>;"
    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v1, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    new-instance v3, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-direct {v3, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod;-><init>(Lcom/lge/wfds/WfdsDiscoveryMethod;)V

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_0
    return-object v2
.end method

.method getConfiguredAllSearch()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/lge/wfds/WfdsDiscoveryMethod;",
            ">;"
        }
    .end annotation

    .prologue
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .local v2, "methods":Ljava/util/List;, "Ljava/util/List<Lcom/lge/wfds/WfdsDiscoveryMethod;>;"
    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v1, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    new-instance v3, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-direct {v3, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod;-><init>(Lcom/lge/wfds/WfdsDiscoveryMethod;)V

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_0
    return-object v2
.end method

.method hasAdvertisement()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method hasSearch()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method removeAdvertise(I)Z
    .locals 8
    .param p1, "id"    # I

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    const/4 v5, -0x1

    if-ne p1, v5, :cond_0

    :goto_0
    return v3

    :cond_0
    const-string v5, "0x%08x"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v3

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .local v2, "strId":Ljava/lang/String;
    const-string v5, "WfdsDiscoveryStore"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "removeAdvertise: enter id = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v0, "m":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-nez v0, :cond_1

    const-string v4, "WfdsDiscoveryStore"

    const-string v5, "WFDS: Remove Advertise Class: Unknown ID"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    iget-object v5, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    invoke-virtual {v5, p1}, Lcom/lge/wfds/WfdsNative;->cancelAdvertise(I)Z

    move-result v5

    if-eqz v5, :cond_3

    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v1, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v1, :cond_2

    iget-object v5, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    monitor-enter v5

    :try_start_0
    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v5

    :cond_2
    move v3, v4

    goto :goto_0

    :catchall_0
    move-exception v3

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_3
    const-string v4, "WfdsDiscoveryStore"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Failed to remove Advertise "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method removeSearch(I)Z
    .locals 6
    .param p1, "id"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v3, -0x1

    if-ne p1, v3, :cond_0

    :goto_0
    return v2

    :cond_0
    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v0, "m":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-nez v0, :cond_1

    const-string v3, "WfdsDiscoveryStore"

    const-string v4, "WFDS: Remove Seek Class: Unknown ID"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    invoke-virtual {v3, p1}, Lcom/lge/wfds/WfdsNative;->cancelSearch(I)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v1, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    if-eqz v1, :cond_2

    const-string v2, "WfdsDiscoveryStore"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "removeSearch: id = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    monitor-enter v3

    :try_start_0
    iget-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v3

    :cond_2
    const/4 v2, 0x1

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .end local v1    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_3
    const-string v3, "WfdsDiscoveryStore"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Failed to remove Search "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method requestAdvertise(Lcom/lge/wfds/WfdsDiscoveryMethod;I)I
    .locals 12
    .param p1, "method"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p2, "forcedChannel"    # I

    .prologue
    invoke-virtual {p1}, Lcom/lge/wfds/WfdsDiscoveryMethod;->getServiceName()Ljava/lang/String;

    move-result-object v1

    .local v1, "name":Ljava/lang/String;
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getAcceptMethod()I

    move-result v2

    .local v2, "accept":I
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceStatus()I

    move-result v3

    .local v3, "status":I
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getNetworkRole()I

    move-result v4

    .local v4, "role":I
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getNetworkConfig()I

    move-result v5

    .local v5, "config":I
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceInfo()Ljava/lang/String;

    move-result-object v6

    .local v6, "info":Ljava/lang/String;
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    move v7, p2

    invoke-virtual/range {v0 .. v7}, Lcom/lge/wfds/WfdsNative;->requestAdvertise(Ljava/lang/String;IIIILjava/lang/String;I)I

    move-result v8

    .local v8, "id":I
    const-string v0, "0x%08x"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v10, 0x0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v7, v10

    invoke-static {v0, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    .local v9, "strAdvId":Ljava/lang/String;
    const-string v0, "WfdsDiscoveryStore"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "requestAdvertise: advertise id = "

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v0, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0, v8}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setAdvertiseId(I)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    monitor-enter v7

    :try_start_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredAdvertise:Ljava/util/HashMap;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v0, v10, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v7

    return v8

    :catchall_0
    move-exception v0

    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method requestSearch(Lcom/lge/wfds/WfdsDiscoveryMethod;I)I
    .locals 8
    .param p1, "method"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p2, "forcedChannel"    # I

    .prologue
    invoke-virtual {p1}, Lcom/lge/wfds/WfdsDiscoveryMethod;->getServiceName()Ljava/lang/String;

    move-result-object v1

    .local v1, "name":Ljava/lang/String;
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getSearchMethod()I

    move-result v2

    .local v2, "search":I
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getP2pAddress()Ljava/lang/String;

    move-result-object v3

    .local v3, "addr":Ljava/lang/String;
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getServiceInfoRequest()Ljava/lang/String;

    move-result-object v4

    .local v4, "req":Ljava/lang/String;
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mWfdsNative:Lcom/lge/wfds/WfdsNative;

    move v5, p2

    invoke-virtual/range {v0 .. v5}, Lcom/lge/wfds/WfdsNative;->requestSearch(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;I)I

    move-result v6

    .local v6, "id":I
    const/4 v0, -0x1

    if-eq v6, v0, :cond_0

    const-string v0, "WfdsDiscoveryStore"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "requestSearch succeeded: id = "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, v1, v4}, Lcom/lge/wfds/WfdsDiscoveryStore;->checkSearchMethod(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v0, v6}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->setSearchId(I)V

    iget-object v5, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    monitor-enter v5

    :try_start_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryStore;->mConfiguredSearch:Ljava/util/HashMap;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v0, v7, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    const-string v0, "WfdsDiscoveryStore"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "requestSearch id "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v6

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
