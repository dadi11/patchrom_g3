.class public Lcom/lge/wfds/WfdsDiscoveryMethod;
.super Ljava/lang/Object;
.source "WfdsDiscoveryMethod.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;,
        Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wfds/WfdsDiscoveryMethod;",
            ">;"
        }
    .end annotation
.end field

.field public static final WFDS_ADVERTISER:I = 0x1

.field public static final WFDS_ADVERTISE_AVAILABLE_STATE:I = 0x1

.field public static final WFDS_ADVERTISE_NOT_AVAILABLE_STATE:I = 0x0

.field public static final WFDS_ADVERTISE_NOT_DEFINED_STATE:I = 0x2

.field private static final WFDS_DEFAULT_SERVICE_NAME:Ljava/lang/String; = "com.lge.wfds.send"

.field public static final WFDS_EXACT_SEARCH_METHOD:I = 0x1

.field public static final WFDS_PREFIX_SEARCH_METHOD:I = 0x0

.field public static final WFDS_SEEKER:I = 0x2

.field public static final WFDS_USER_AUTO_ACCEPT_METHOD:I = 0x1

.field public static final WFDS_USER_DEFERRED_ACCEPT_METHOD:I


# instance fields
.field public mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

.field public mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

.field public mServiceName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$1;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$1;-><init>()V

    sput-object v0, Lcom/lge/wfds/WfdsDiscoveryMethod;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "com.lge.wfds.send"

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mServiceName:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(II)V
    .locals 2
    .param p1, "id"    # I
    .param p2, "role"    # I

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x2

    if-ne p2, v0, :cond_1

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iput-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->setSearchId(I)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v0, 0x1

    if-ne p2, v0, :cond_0

    iput-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v0, p1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setAdvertiseId(I)V

    goto :goto_0
.end method

.method public constructor <init>(Lcom/lge/wfds/WfdsDiscoveryMethod;)V
    .locals 3
    .param p1, "src"    # Lcom/lge/wfds/WfdsDiscoveryMethod;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/lge/wfds/WfdsDiscoveryMethod;->getServiceName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mServiceName:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    if-eqz v0, :cond_1

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getSearchId()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchId:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->access$002(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;I)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getSearchMethod()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchMethod:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->access$102(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;I)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getP2pAddress()Ljava/lang/String;

    move-result-object v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mP2pAddress:Ljava/lang/String;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->access$202(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->getServiceInfoRequest()Ljava/lang/String;

    move-result-object v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mServiceInfoRequest:Ljava/lang/String;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->access$302(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;Ljava/lang/String;)Ljava/lang/String;

    :goto_0
    iget-object v0, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    if-eqz v0, :cond_2

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getAdvertiseId()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAdvertiseId:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->access$402(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getAcceptMethod()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mAcceptMethod:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->access$502(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceStatus()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceStatus:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->access$602(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceInfo()Ljava/lang/String;

    move-result-object v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mServiceInfo:Ljava/lang/String;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->access$702(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getNetworkRole()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkRole:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->access$802(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getNetworkConfig()I

    move-result v1

    # setter for: Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->mNetworkConfig:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->access$902(Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;I)I

    :cond_0
    :goto_1
    return-void

    :cond_1
    iput-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    goto :goto_0

    :cond_2
    iput-object v2, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    goto :goto_1
.end method

.method public constructor <init>(Ljava/lang/String;I)V
    .locals 2
    .param p1, "serviceName"    # Ljava/lang/String;
    .param p2, "role"    # I

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mServiceName:Ljava/lang/String;

    const/4 v0, 0x2

    if-ne p2, v0, :cond_1

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    iput-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v0, 0x1

    if-ne p2, v0, :cond_0

    iput-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    goto :goto_0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getServiceName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mServiceName:Ljava/lang/String;

    return-object v0
.end method

.method public setServiceName(Ljava/lang/String;)V
    .locals 0
    .param p1, "serviceName"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mServiceName:Ljava/lang/String;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v1, 0x0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mServiceName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    return-void
.end method
