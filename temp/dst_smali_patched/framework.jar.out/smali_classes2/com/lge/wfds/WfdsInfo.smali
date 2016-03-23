.class public Lcom/lge/wfds/WfdsInfo;
.super Ljava/lang/Object;
.source "WfdsInfo.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wfds/WfdsInfo;",
            ">;"
        }
    .end annotation
.end field

.field public static final WFDS_SERVICE_STATUS_AVAILABLE:I = 0x1

.field public static final WFDS_SERVICE_STATUS_LOST:I = 0x2

.field public static final WFDS_SERVICE_STATUS_NOT_AVAILABLE:I


# instance fields
.field public mWfdsAdvertiseId:I

.field public mWfdsInterfaceAddress:Ljava/lang/String;

.field public mWfdsRequestRole:I

.field public mWfdsServiceInfo:Ljava/lang/String;

.field public mWfdsServiceName:Ljava/lang/String;

.field public mWfdsServiceStatus:I

.field public mWfdsSessionDeviceName:Ljava/lang/String;

.field public mWfdsSessionId:I

.field public mWfdsSessionInfo:Ljava/lang/String;

.field public mWfdsSessionMac:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wfds/WfdsInfo$1;

    invoke-direct {v0}, Lcom/lge/wfds/WfdsInfo$1;-><init>()V

    sput-object v0, Lcom/lge/wfds/WfdsInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, -0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    iput v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    iput v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsInterfaceAddress:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    return-void
.end method

.method public constructor <init>(Lcom/lge/wfds/WfdsInfo;)V
    .locals 1
    .param p1, "source"    # Lcom/lge/wfds/WfdsInfo;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p1, :cond_0

    iget-object v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    iget v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iget-object v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    iget v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    iget-object v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    iget v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    iget-object v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    iget v0, p1, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    :cond_0
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;I)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "advId"    # I

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    iput p2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .prologue
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .local v0, "sbuf":Ljava/lang/StringBuffer;
    const-string v2, "0x%08x"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    iget v5, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .local v1, "strId":Ljava/lang/String;
    const-string v2, " advertise id: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    if-eqz v2, :cond_0

    const-string v2, "\n service name: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_0
    iget-object v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    if-eqz v2, :cond_1

    const-string v2, "\n service info: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v2, "\n service status: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    :cond_1
    iget-object v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    if-eqz v2, :cond_2

    const-string v2, "\n session id: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    const-string v2, "\n session Mac: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v2, "\n session info: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v2, "\n session device: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceInfo:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionDeviceName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsInterfaceAddress:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method
