.class public Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
.super Ljava/lang/Object;
.source "WfdsDiscoveryMethod.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsDiscoveryMethod;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "AdvertiseMethod"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mAcceptMethod:I

.field private mAdvertiseId:I

.field private mNetworkConfig:I

.field private mNetworkRole:I

.field private mServiceInfo:Ljava/lang/String;

.field private mServiceStatus:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod$1;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod$1;-><init>()V

    sput-object v0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAdvertiseId:I

    iput v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAcceptMethod:I

    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceStatus:I

    iput v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkRole:I

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceInfo:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$402(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAdvertiseId:I

    return p1
.end method

.method static synthetic access$502(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAcceptMethod:I

    return p1
.end method

.method static synthetic access$602(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceStatus:I

    return p1
.end method

.method static synthetic access$702(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceInfo:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$802(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkRole:I

    return p1
.end method

.method static synthetic access$902(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkConfig:I

    return p1
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getAcceptMethod()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAcceptMethod:I

    return v0
.end method

.method public getAdvertiseId()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAdvertiseId:I

    return v0
.end method

.method public getNetworkConfig()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkConfig:I

    return v0
.end method

.method public getNetworkRole()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkRole:I

    return v0
.end method

.method public getServiceInfo()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceInfo:Ljava/lang/String;

    return-object v0
.end method

.method public getServiceStatus()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceStatus:I

    return v0
.end method

.method public setAcceptMethod(I)V
    .locals 0
    .param p1, "acceptMethod"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAcceptMethod:I

    return-void
.end method

.method public setAdvertiseId(I)V
    .locals 0
    .param p1, "advId"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAdvertiseId:I

    return-void
.end method

.method public setNetworkConfig(I)V
    .locals 0
    .param p1, "networkConfig"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkConfig:I

    return-void
.end method

.method public setNetworkRole(I)V
    .locals 0
    .param p1, "networkRole"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkRole:I

    return-void
.end method

.method public setServiceInfo(Ljava/lang/String;)V
    .locals 0
    .param p1, "serviceInfo"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceInfo:Ljava/lang/String;

    return-void
.end method

.method public setServiceStatus(I)V
    .locals 0
    .param p1, "serviceStatus"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceStatus:I

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAdvertiseId:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAcceptMethod:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceStatus:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkRole:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkConfig:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceInfo:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
