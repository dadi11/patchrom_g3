.class final Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall$1;
.super Ljava/lang/Object;
.source "LGBluetoothHandsfreeClientCall.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;
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
        "Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;",
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
.method public createFromParcel(Landroid/os/Parcel;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;
    .locals 8
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x1

    new-instance v0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-ne v4, v5, :cond_0

    move v4, v5

    :goto_0
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-ne v7, v5, :cond_1

    :goto_1
    invoke-direct/range {v0 .. v5}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;-><init>(IILjava/lang/String;ZZ)V

    return-object v0

    :cond_0
    move v4, v6

    goto :goto_0

    :cond_1
    move v5, v6

    goto :goto_1
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall$1;->createFromParcel(Landroid/os/Parcel;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;
    .locals 1
    .param p1, "size"    # I

    .prologue
    new-array v0, p1, [Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall$1;->newArray(I)[Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;

    move-result-object v0

    return-object v0
.end method
