.class final Lcom/lge/wfds/WfdsDevice$1;
.super Ljava/lang/Object;
.source "WfdsDevice.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsDevice;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Lcom/lge/wfds/WfdsDevice;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/lge/wfds/WfdsDevice;
    .locals 4
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    new-instance v0, Lcom/lge/wfds/WfdsDevice;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDevice;-><init>()V

    .local v0, "device":Lcom/lge/wfds/WfdsDevice;
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->deviceName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->primaryDeviceType:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->secondaryDeviceType:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->wpsConfigMethodsSupported:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->deviceCapability:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->groupCapability:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, v0, Lcom/lge/wfds/WfdsDevice;->status:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    sget-object v1, Landroid/net/wifi/p2p/WifiP2pWfdInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v1, p1}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/wifi/p2p/WifiP2pWfdInfo;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->wfdInfo:Landroid/net/wifi/p2p/WifiP2pWfdInfo;

    :cond_0
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v2

    iput-wide v2, v0, Lcom/lge/wfds/WfdsDevice;->wfdsDeviceFound:J

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->readValue(Ljava/lang/ClassLoader;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wfds/WfdsInfo;

    iput-object v1, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsDevice$1;->createFromParcel(Landroid/os/Parcel;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/lge/wfds/WfdsDevice;
    .locals 1
    .param p1, "size"    # I

    .prologue
    new-array v0, p1, [Lcom/lge/wfds/WfdsDevice;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsDevice$1;->newArray(I)[Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    return-object v0
.end method
