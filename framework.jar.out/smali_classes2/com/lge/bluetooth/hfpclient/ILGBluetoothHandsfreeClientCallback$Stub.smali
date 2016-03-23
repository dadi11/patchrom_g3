.class public abstract Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;
.super Landroid/os/Binder;
.source "ILGBluetoothHandsfreeClientCallback.java"

# interfaces
.implements Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

.field static final TRANSACTION_onAudioStateChange:I = 0x2

.field static final TRANSACTION_onCallStateChange:I = 0x3

.field static final TRANSACTION_onConnectionStateChange:I = 0x1


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 15
    const-string v0, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

    invoke-virtual {p0, p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 23
    if-nez p0, :cond_0

    .line 24
    const/4 v0, 0x0

    .line 30
    :goto_0
    return-object v0

    .line 26
    :cond_0
    const-string v1, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    goto :goto_0

    .line 30
    :cond_1
    new-instance v0, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 34
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 10
    .param p1, "code"    # I
    .param p2, "data"    # Landroid/os/Parcel;
    .param p3, "reply"    # Landroid/os/Parcel;
    .param p4, "flags"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v9, 0x1

    .line 38
    sparse-switch p1, :sswitch_data_0

    .line 104
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v9

    :goto_0
    return v9

    .line 42
    :sswitch_0
    const-string v0, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v0, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 51
    .local v1, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_0

    .line 52
    sget-object v0, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothDevice;

    .line 58
    .local v2, "_arg1":Landroid/bluetooth/BluetoothDevice;
    :goto_1
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 60
    .local v3, "_arg2":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 62
    .local v4, "_arg3":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 64
    .local v5, "_arg4":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .local v6, "_arg5":I
    move-object v0, p0

    .line 65
    invoke-virtual/range {v0 .. v6}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;->onConnectionStateChange(ILandroid/bluetooth/BluetoothDevice;IIII)V

    .line 66
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 55
    .end local v2    # "_arg1":Landroid/bluetooth/BluetoothDevice;
    .end local v3    # "_arg2":I
    .end local v4    # "_arg3":I
    .end local v5    # "_arg4":I
    .end local v6    # "_arg5":I
    :cond_0
    const/4 v2, 0x0

    .restart local v2    # "_arg1":Landroid/bluetooth/BluetoothDevice;
    goto :goto_1

    .line 71
    .end local v1    # "_arg0":I
    .end local v2    # "_arg1":Landroid/bluetooth/BluetoothDevice;
    :sswitch_2
    const-string v0, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 73
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 75
    .restart local v1    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 76
    .local v2, "_arg1":I
    invoke-virtual {p0, v1, v2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;->onAudioStateChange(II)V

    .line 77
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 82
    .end local v1    # "_arg0":I
    .end local v2    # "_arg1":I
    :sswitch_3
    const-string v0, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientCallback"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 84
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 86
    .restart local v1    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 88
    .restart local v2    # "_arg1":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 90
    .restart local v3    # "_arg2":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 92
    .restart local v4    # "_arg3":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 94
    .restart local v5    # "_arg4":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 96
    .local v6, "_arg5":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 98
    .local v7, "_arg6":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_1

    move v8, v9

    .local v8, "_arg7":Z
    :goto_2
    move-object v0, p0

    .line 99
    invoke-virtual/range {v0 .. v8}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;->onCallStateChange(IIIIILjava/lang/String;IZ)V

    .line 100
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 98
    .end local v8    # "_arg7":Z
    :cond_1
    const/4 v8, 0x0

    goto :goto_2

    .line 38
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
