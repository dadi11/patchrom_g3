.class public Lcom/lge/wfds/WfdsDeviceList;
.super Ljava/lang/Object;
.source "WfdsDeviceList.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wfds/WfdsDeviceList;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final mDevices:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/lge/wfds/WfdsDevice;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wfds/WfdsDeviceList$1;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDeviceList$1;-><init>()V

    sput-object v0, Lcom/lge/wfds/WfdsDeviceList;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    return-void
.end method

.method public constructor <init>(Lcom/lge/wfds/WfdsDeviceList;)V
    .locals 5
    .param p1, "source"    # Lcom/lge/wfds/WfdsDeviceList;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsDeviceList;->getDeviceList()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "d":Lcom/lge/wfds/WfdsDevice;
    iget-object v2, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v3, v0, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    new-instance v4, Lcom/lge/wfds/WfdsDevice;

    invoke-direct {v4, v0}, Lcom/lge/wfds/WfdsDevice;-><init>(Lcom/lge/wfds/WfdsDevice;)V

    invoke-virtual {v2, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .end local v0    # "d":Lcom/lge/wfds/WfdsDevice;
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_0
    return-void
.end method

.method public constructor <init>(Ljava/util/ArrayList;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/wfds/WfdsDevice;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "devices":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/wfds/WfdsDevice;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "device":Lcom/lge/wfds/WfdsDevice;
    iget-object v2, v0, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v3, v0, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    new-instance v4, Lcom/lge/wfds/WfdsDevice;

    invoke-direct {v4, v0}, Lcom/lge/wfds/WfdsDevice;-><init>(Lcom/lge/wfds/WfdsDevice;)V

    invoke-virtual {v2, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .end local v0    # "device":Lcom/lge/wfds/WfdsDevice;
    :cond_1
    return-void
.end method

.method private validateDevice(Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 2
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .prologue
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null device"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget-object v0, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Empty deviceAddress"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    return-void
.end method

.method private validateDevice(Lcom/lge/wfds/WfdsDevice;)V
    .locals 2
    .param p1, "device"    # Lcom/lge/wfds/WfdsDevice;

    .prologue
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null device"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget-object v0, p1, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Empty deviceAddress"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    return-void
.end method

.method private validateDeviceAddress(Ljava/lang/String;)V
    .locals 2
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Empty deviceAddress"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method


# virtual methods
.method public clear()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public get(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;
    .locals 1
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDeviceAddress(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    return-object v0
.end method

.method public getDeviceList()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection",
            "<",
            "Lcom/lge/wfds/WfdsDevice;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableCollection(Ljava/util/Collection;)Ljava/util/Collection;

    move-result-object v0

    return-object v0
.end method

.method public isGroupOwner(Ljava/lang/String;)Z
    .locals 4
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDeviceAddress(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "device":Lcom/lge/wfds/WfdsDevice;
    if-nez v0, :cond_0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Device not found "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_0
    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDevice;->isGroupOwner()Z

    move-result v1

    return v1
.end method

.method public remove(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;
    .locals 1
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDeviceAddress(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    return-object v0
.end method

.method public remove(Lcom/lge/wfds/WfdsDevice;)Z
    .locals 2
    .param p1, "device"    # Lcom/lge/wfds/WfdsDevice;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDevice(Lcom/lge/wfds/WfdsDevice;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public remove(Lcom/lge/wfds/WfdsDeviceList;)Z
    .locals 4
    .param p1, "list"    # Lcom/lge/wfds/WfdsDeviceList;

    .prologue
    const/4 v2, 0x0

    .local v2, "ret":Z
    iget-object v3, p1, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "d":Lcom/lge/wfds/WfdsDevice;
    invoke-virtual {p0, v0}, Lcom/lge/wfds/WfdsDeviceList;->remove(Lcom/lge/wfds/WfdsDevice;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    .end local v0    # "d":Lcom/lge/wfds/WfdsDevice;
    :cond_1
    return v2
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    .local v2, "sbuf":Ljava/lang/StringBuffer;
    iget-object v3, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "device":Lcom/lge/wfds/WfdsDevice;
    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    goto :goto_0

    .end local v0    # "device":Lcom/lge/wfds/WfdsDevice;
    :cond_0
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method public update(Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 2
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->updateSupplicantDetails(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    iget v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->status:I

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->status:I

    return-void
.end method

.method public update(Lcom/lge/wfds/WfdsDevice;)V
    .locals 4
    .param p1, "device"    # Lcom/lge/wfds/WfdsDevice;

    .prologue
    invoke-virtual {p1}, Lcom/lge/wfds/WfdsDevice;->getWifiP2pDevice()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/wfds/WfdsDeviceList;->update(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    iget-object v1, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v2, p1, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "d":Lcom/lge/wfds/WfdsDevice;
    iget-wide v2, p1, Lcom/lge/wfds/WfdsDevice;->wfdsDeviceFound:J

    iput-wide v2, v0, Lcom/lge/wfds/WfdsDevice;->wfdsDeviceFound:J

    if-eqz v0, :cond_0

    iget-object v1, p1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    :cond_0
    return-void
.end method

.method updateGroupCapability(Ljava/lang/String;I)V
    .locals 2
    .param p1, "deviceAddress"    # Ljava/lang/String;
    .param p2, "groupCapab"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDeviceAddress(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "d":Lcom/lge/wfds/WfdsDevice;
    if-eqz v0, :cond_0

    iput p2, v0, Lcom/lge/wfds/WfdsDevice;->groupCapability:I

    :cond_0
    return-void
.end method

.method updateStatus(Ljava/lang/String;I)V
    .locals 2
    .param p1, "deviceAddress"    # Ljava/lang/String;
    .param p2, "status"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDeviceAddress(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "d":Lcom/lge/wfds/WfdsDevice;
    if-eqz v0, :cond_0

    iput p2, v0, Lcom/lge/wfds/WfdsDevice;->status:I

    :cond_0
    return-void
.end method

.method updateSupplicantDetails(Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 4
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDeviceList;->validateDevice(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    iget-object v1, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v2, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "d":Lcom/lge/wfds/WfdsDevice;
    if-eqz v0, :cond_0

    iget-object v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->deviceName:Ljava/lang/String;

    iget-object v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->primaryDeviceType:Ljava/lang/String;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->primaryDeviceType:Ljava/lang/String;

    iget-object v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->secondaryDeviceType:Ljava/lang/String;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->secondaryDeviceType:Ljava/lang/String;

    iget v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->wpsConfigMethodsSupported:I

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->wpsConfigMethodsSupported:I

    iget v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceCapability:I

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->deviceCapability:I

    iget v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->groupCapability:I

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->groupCapability:I

    iget-object v1, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->wfdInfo:Landroid/net/wifi/p2p/WifiP2pWfdInfo;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->wfdInfo:Landroid/net/wifi/p2p/WifiP2pWfdInfo;

    :goto_0
    return-void

    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    iget-object v2, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    new-instance v3, Lcom/lge/wfds/WfdsDevice;

    invoke-direct {v3, p1}, Lcom/lge/wfds/WfdsDevice;-><init>(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget-object v2, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->size()I

    move-result v2

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v2, p0, Lcom/lge/wfds/WfdsDeviceList;->mDevices:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDevice;

    .local v0, "device":Lcom/lge/wfds/WfdsDevice;
    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_0

    .end local v0    # "device":Lcom/lge/wfds/WfdsDevice;
    :cond_0
    return-void
.end method
