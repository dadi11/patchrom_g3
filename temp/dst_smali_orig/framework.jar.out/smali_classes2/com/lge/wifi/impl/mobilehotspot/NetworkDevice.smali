.class public Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
.super Ljava/lang/Object;
.source "NetworkDevice.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final ALLOWED:I = 0x2

.field public static final BLOCKED:I = 0x1

.field public static final CONNECTED:I = 0x3

.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;",
            ">;"
        }
    .end annotation
.end field

.field public static final DISCONNECTED:I = 0x4

.field public static final IDLE:I


# instance fields
.field private mDeviceName:Ljava/lang/String;

.field private mIPAddress:Ljava/lang/String;

.field private mMacAddress:Ljava/lang/String;

.field private mState:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice$1;

    invoke-direct {v0}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice$1;-><init>()V

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    const-string v0, "No name"

    invoke-direct {p0, p1, v0}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;

    .prologue
    const-string v0, ""

    invoke-direct {p0, p1, p2, v0}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "ipAddr"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mState:I

    iput-object p2, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mDeviceName:Ljava/lang/String;

    iput-object p3, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mIPAddress:Ljava/lang/String;

    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mMacAddress:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public disconnect()V
    .locals 0

    .prologue
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    move-object v0, p1

    check-cast v0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    .local v0, "nd":Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->getMacAddress()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->getMacAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public getDeviceName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mDeviceName:Ljava/lang/String;

    return-object v0
.end method

.method public getIPAddress()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mIPAddress:Ljava/lang/String;

    return-object v0
.end method

.method public getMacAddress()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mMacAddress:Ljava/lang/String;

    return-object v0
.end method

.method public getState()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mState:I

    return v0
.end method

.method public setDeviceName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mDeviceName:Ljava/lang/String;

    return-void
.end method

.method public setIPAddress(Ljava/lang/String;)V
    .locals 0
    .param p1, "ipaddr"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mIPAddress:Ljava/lang/String;

    return-void
.end method

.method public setMacAddress(Ljava/lang/String;)V
    .locals 0
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mMacAddress:Ljava/lang/String;

    return-void
.end method

.method public setState(I)V
    .locals 0
    .param p1, "state"    # I

    .prologue
    iput p1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mState:I

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mDeviceName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "__"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mIPAddress:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "__"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mMacAddress:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mMacAddress:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mDeviceName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->mIPAddress:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
