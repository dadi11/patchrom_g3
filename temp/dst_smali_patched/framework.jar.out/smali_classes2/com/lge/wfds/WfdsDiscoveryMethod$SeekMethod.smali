.class public Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;
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
    name = "SeekMethod"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mP2pAddress:Ljava/lang/String;

.field private mSearchId:I

.field private mSearchMethod:I

.field private mServiceInfoRequest:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod$1;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod$1;-><init>()V

    sput-object v0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchId:I

    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchMethod:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mP2pAddress:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mServiceInfoRequest:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$002(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchId:I

    return p1
.end method

.method static synthetic access$102(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchMethod:I

    return p1
.end method

.method static synthetic access$202(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mP2pAddress:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$302(Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mServiceInfoRequest:Ljava/lang/String;

    return-object p1
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getP2pAddress()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mP2pAddress:Ljava/lang/String;

    return-object v0
.end method

.method public getSearchId()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchId:I

    return v0
.end method

.method public getSearchMethod()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchMethod:I

    return v0
.end method

.method public getServiceInfoRequest()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mServiceInfoRequest:Ljava/lang/String;

    return-object v0
.end method

.method public setP2pAddress(Ljava/lang/String;)V
    .locals 0
    .param p1, "macAddress"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mP2pAddress:Ljava/lang/String;

    return-void
.end method

.method public setSearchId(I)V
    .locals 0
    .param p1, "searchId"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchId:I

    return-void
.end method

.method public setSearchMethod(I)V
    .locals 0
    .param p1, "searchMethod"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchMethod:I

    return-void
.end method

.method public setServiceInfoRequest(Ljava/lang/String;)V
    .locals 0
    .param p1, "serviceInfo"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mServiceInfoRequest:Ljava/lang/String;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchId:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mSearchMethod:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mP2pAddress:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;->mServiceInfoRequest:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
