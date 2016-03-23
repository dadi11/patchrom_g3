.class Lcom/lge/upnp/uda/device/JNIHostDeviceListener;
.super Ljava/lang/Object;
.source "JNIHostDeviceListener.java"


# instance fields
.field public stVarArr:[Lcom/lge/upnp/uda/service/IStateVarInfo;


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/upnp/uda/device/JNIHostDeviceListener;->stVarArr:[Lcom/lge/upnp/uda/service/IStateVarInfo;

    return-void
.end method


# virtual methods
.method public onSubscriptionRequested(Lcom/lge/upnp/uda/device/IHostDeviceListener;Lcom/lge/upnp/uda/service/EError;Lcom/lge/upnp/uda/service/ISubscriberInfo;Lcom/lge/upnp/uda/service/INetworkInfo;)V
    .locals 2
    .param p1, "listner"    # Lcom/lge/upnp/uda/device/IHostDeviceListener;
    .param p2, "eError"    # Lcom/lge/upnp/uda/service/EError;
    .param p3, "subInfo"    # Lcom/lge/upnp/uda/service/ISubscriberInfo;
    .param p4, "networkInfo"    # Lcom/lge/upnp/uda/service/INetworkInfo;

    .prologue
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .local v0, "stVarList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/upnp/uda/service/IStateVarInfo;>;"
    invoke-interface {p1, p2, p3, p4, v0}, Lcom/lge/upnp/uda/device/IHostDeviceListener;->onSubscriptionRequested(Lcom/lge/upnp/uda/service/EError;Lcom/lge/upnp/uda/service/ISubscriberInfo;Lcom/lge/upnp/uda/service/INetworkInfo;Ljava/util/ArrayList;)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v1, v1, [Lcom/lge/upnp/uda/service/IStateVarInfo;

    iput-object v1, p0, Lcom/lge/upnp/uda/device/JNIHostDeviceListener;->stVarArr:[Lcom/lge/upnp/uda/service/IStateVarInfo;

    iget-object v1, p0, Lcom/lge/upnp/uda/device/JNIHostDeviceListener;->stVarArr:[Lcom/lge/upnp/uda/service/IStateVarInfo;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    return-void
.end method
