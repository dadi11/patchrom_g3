.class public abstract Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;
.super Landroid/os/Binder;
.source "ILGBluetoothHandsfreeClientBrcm.java"

# interfaces
.implements Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

.field static final TRANSACTION_answer:I = 0x12

.field static final TRANSACTION_connect:I = 0x1

.field static final TRANSACTION_connectAudio:I = 0x7

.field static final TRANSACTION_dial:I = 0x10

.field static final TRANSACTION_disconnect:I = 0x2

.field static final TRANSACTION_disconnectAudio:I = 0x8

.field static final TRANSACTION_getAudioState:I = 0x6

.field static final TRANSACTION_getCLCC:I = 0x19

.field static final TRANSACTION_getCallStateInfo:I = 0xf

.field static final TRANSACTION_getConnectedDevices:I = 0x3

.field static final TRANSACTION_getConnectionState:I = 0x4

.field static final TRANSACTION_getDeviceIndicators:I = 0xe

.field static final TRANSACTION_getDevicesMatchingConnectionStates:I = 0x5

.field static final TRANSACTION_getLocalFeatures:I = 0x1e

.field static final TRANSACTION_getPeerFeatures:I = 0x1d

.field static final TRANSACTION_getPriority:I = 0xa

.field static final TRANSACTION_hangup:I = 0x13

.field static final TRANSACTION_hold:I = 0x14

.field static final TRANSACTION_queryOperatorSelectionInfo:I = 0x17

.field static final TRANSACTION_querySubscriberInfo:I = 0x18

.field static final TRANSACTION_readPhoneBookList:I = 0x1a

.field static final TRANSACTION_redial:I = 0x11

.field static final TRANSACTION_registerEventHandler:I = 0x1b

.field static final TRANSACTION_sendBIA:I = 0x20

.field static final TRANSACTION_sendDTMFcode:I = 0x15

.field static final TRANSACTION_sendKeyPressEvent:I = 0x1f

.field static final TRANSACTION_sendVendorCmd:I = 0x16

.field static final TRANSACTION_setPriority:I = 0x9

.field static final TRANSACTION_setVolume:I = 0xd

.field static final TRANSACTION_startVoiceRecognition:I = 0xb

.field static final TRANSACTION_stopVoiceRecognition:I = 0xc

.field static final TRANSACTION_unRegisterEventHandler:I = 0x1c


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 19
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 20
    const-string v0, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p0, p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 21
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 28
    if-nez p0, :cond_0

    .line 29
    const/4 v0, 0x0

    .line 35
    :goto_0
    return-object v0

    .line 31
    :cond_0
    const-string v1, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 32
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    if-eqz v1, :cond_1

    .line 33
    check-cast v0, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    goto :goto_0

    .line 35
    :cond_1
    new-instance v0, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 39
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 9
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
    const/4 v6, 0x0

    const/4 v7, 0x1

    .line 43
    sparse-switch p1, :sswitch_data_0

    .line 407
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v7

    :goto_0
    return v7

    .line 47
    :sswitch_0
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 52
    :sswitch_1
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 54
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_1

    .line 55
    sget-object v8, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v8, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 60
    .local v0, "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_1
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->connect(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v4

    .line 61
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 62
    if-eqz v4, :cond_0

    move v6, v7

    :cond_0
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 58
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":Z
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_1

    .line 67
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_2
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 69
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_3

    .line 70
    sget-object v8, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v8, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 75
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_2
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->disconnect(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v4

    .line 76
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 77
    if-eqz v4, :cond_2

    move v6, v7

    :cond_2
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 73
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":Z
    :cond_3
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_2

    .line 82
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_3
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 83
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getConnectedDevices()Ljava/util/List;

    move-result-object v5

    .line 84
    .local v5, "_result":Ljava/util/List;, "Ljava/util/List<Landroid/bluetooth/BluetoothDevice;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 85
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    goto :goto_0

    .line 90
    .end local v5    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/bluetooth/BluetoothDevice;>;"
    :sswitch_4
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 92
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_4

    .line 93
    sget-object v6, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v6, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 98
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_3
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getConnectionState(Landroid/bluetooth/BluetoothDevice;)I

    move-result v4

    .line 99
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 100
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 96
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":I
    :cond_4
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_3

    .line 105
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_5
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 107
    invoke-virtual {p2}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v0

    .line 108
    .local v0, "_arg0":[I
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getDevicesMatchingConnectionStates([I)Ljava/util/List;

    move-result-object v5

    .line 109
    .restart local v5    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/bluetooth/BluetoothDevice;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 110
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    goto/16 :goto_0

    .line 115
    .end local v0    # "_arg0":[I
    .end local v5    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/bluetooth/BluetoothDevice;>;"
    :sswitch_6
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 117
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_5

    .line 118
    sget-object v6, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v6, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 123
    .local v0, "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_4
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getAudioState(Landroid/bluetooth/BluetoothDevice;)I

    move-result v4

    .line 124
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 125
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 121
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":I
    :cond_5
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_4

    .line 130
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_7
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 131
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->connectAudio()Z

    move-result v4

    .line 132
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 133
    if-eqz v4, :cond_6

    move v6, v7

    :cond_6
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 138
    .end local v4    # "_result":Z
    :sswitch_8
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 139
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->disconnectAudio()Z

    move-result v4

    .line 140
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 141
    if-eqz v4, :cond_7

    move v6, v7

    :cond_7
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 146
    .end local v4    # "_result":Z
    :sswitch_9
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 148
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_9

    .line 149
    sget-object v8, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v8, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 155
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_5
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 156
    .local v1, "_arg1":I
    invoke-virtual {p0, v0, v1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->setPriority(Landroid/bluetooth/BluetoothDevice;I)Z

    move-result v4

    .line 157
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 158
    if-eqz v4, :cond_8

    move v6, v7

    :cond_8
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 152
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v1    # "_arg1":I
    .end local v4    # "_result":Z
    :cond_9
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_5

    .line 163
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_a
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 165
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_a

    .line 166
    sget-object v6, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v6, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 171
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_6
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getPriority(Landroid/bluetooth/BluetoothDevice;)I

    move-result v4

    .line 172
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 173
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 169
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":I
    :cond_a
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_6

    .line 178
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_b
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 180
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_c

    .line 181
    sget-object v8, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v8, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 186
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_7
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->startVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v4

    .line 187
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 188
    if-eqz v4, :cond_b

    move v6, v7

    :cond_b
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 184
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":Z
    :cond_c
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_7

    .line 193
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_c
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 195
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_e

    .line 196
    sget-object v8, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v8, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 201
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_8
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->stopVoiceRecognition(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v4

    .line 202
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 203
    if-eqz v4, :cond_d

    move v6, v7

    :cond_d
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 199
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":Z
    :cond_e
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_8

    .line 208
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_d
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 210
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 212
    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 213
    .restart local v1    # "_arg1":I
    invoke-virtual {p0, v0, v1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->setVolume(II)Z

    move-result v4

    .line 214
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 215
    if-eqz v4, :cond_f

    move v6, v7

    :cond_f
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 220
    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":I
    .end local v4    # "_result":Z
    :sswitch_e
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 222
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_10

    .line 223
    sget-object v6, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v6, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 228
    .local v0, "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_9
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getDeviceIndicators(Landroid/bluetooth/BluetoothDevice;)[I

    move-result-object v4

    .line 229
    .local v4, "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 230
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .line 226
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":[I
    :cond_10
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_9

    .line 235
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_f
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 237
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_11

    .line 238
    sget-object v6, Landroid/bluetooth/BluetoothDevice;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v6, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 243
    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :goto_a
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getCallStateInfo(Landroid/bluetooth/BluetoothDevice;)[I

    move-result-object v4

    .line 244
    .restart local v4    # "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 245
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .line 241
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "_result":[I
    :cond_11
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    goto :goto_a

    .line 250
    .end local v0    # "_arg0":Landroid/bluetooth/BluetoothDevice;
    :sswitch_10
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 252
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 253
    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->dial(Ljava/lang/String;)Z

    move-result v4

    .line 254
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 255
    if-eqz v4, :cond_12

    move v6, v7

    :cond_12
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 260
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v4    # "_result":Z
    :sswitch_11
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 261
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->redial()Z

    move-result v4

    .line 262
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 263
    if-eqz v4, :cond_13

    move v6, v7

    :cond_13
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 268
    .end local v4    # "_result":Z
    :sswitch_12
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 269
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->answer()Z

    move-result v4

    .line 270
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 271
    if-eqz v4, :cond_14

    move v6, v7

    :cond_14
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 276
    .end local v4    # "_result":Z
    :sswitch_13
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 277
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->hangup()Z

    move-result v4

    .line 278
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 279
    if-eqz v4, :cond_15

    move v6, v7

    :cond_15
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 284
    .end local v4    # "_result":Z
    :sswitch_14
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 286
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 287
    .local v0, "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->hold(I)Z

    move-result v4

    .line 288
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 289
    if-eqz v4, :cond_16

    move v6, v7

    :cond_16
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 294
    .end local v0    # "_arg0":I
    .end local v4    # "_result":Z
    :sswitch_15
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 296
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    int-to-char v0, v8

    .line 297
    .local v0, "_arg0":C
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->sendDTMFcode(C)Z

    move-result v4

    .line 298
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 299
    if-eqz v4, :cond_17

    move v6, v7

    :cond_17
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 304
    .end local v0    # "_arg0":C
    .end local v4    # "_result":Z
    :sswitch_16
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 306
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 307
    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->sendVendorCmd(Ljava/lang/String;)Z

    move-result v4

    .line 308
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 309
    if-eqz v4, :cond_18

    move v6, v7

    :cond_18
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 314
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v4    # "_result":Z
    :sswitch_17
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 315
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->queryOperatorSelectionInfo()Z

    move-result v4

    .line 316
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 317
    if-eqz v4, :cond_19

    move v6, v7

    :cond_19
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 322
    .end local v4    # "_result":Z
    :sswitch_18
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 323
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->querySubscriberInfo()Z

    move-result v4

    .line 324
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 325
    if-eqz v4, :cond_1a

    move v6, v7

    :cond_1a
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 330
    .end local v4    # "_result":Z
    :sswitch_19
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 331
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getCLCC()Z

    move-result v4

    .line 332
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 333
    if-eqz v4, :cond_1b

    move v6, v7

    :cond_1b
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 338
    .end local v4    # "_result":Z
    :sswitch_1a
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 340
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 342
    .restart local v0    # "_arg0":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 343
    .restart local v1    # "_arg1":I
    invoke-virtual {p0, v0, v1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->readPhoneBookList(Ljava/lang/String;I)Z

    move-result v4

    .line 344
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 345
    if-eqz v4, :cond_1c

    move v6, v7

    :cond_1c
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 350
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v1    # "_arg1":I
    .end local v4    # "_result":Z
    :sswitch_1b
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 352
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-static {v6}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    move-result-object v0

    .line 353
    .local v0, "_arg0":Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->registerEventHandler(Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;)V

    .line 354
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 359
    .end local v0    # "_arg0":Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
    :sswitch_1c
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 361
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-static {v6}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;

    move-result-object v0

    .line 362
    .restart local v0    # "_arg0":Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
    invoke-virtual {p0, v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->unRegisterEventHandler(Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;)V

    .line 363
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 368
    .end local v0    # "_arg0":Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
    :sswitch_1d
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 369
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getPeerFeatures()I

    move-result v4

    .line 370
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 371
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 376
    .end local v4    # "_result":I
    :sswitch_1e
    const-string v6, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 377
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->getLocalFeatures()I

    move-result v4

    .line 378
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 379
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 384
    .end local v4    # "_result":I
    :sswitch_1f
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 385
    invoke-virtual {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->sendKeyPressEvent()Z

    move-result v4

    .line 386
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 387
    if-eqz v4, :cond_1d

    move v6, v7

    :cond_1d
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 392
    .end local v4    # "_result":Z
    :sswitch_20
    const-string v8, "com.lge.bluetooth.hfpclient.ILGBluetoothHandsfreeClientBrcm"

    invoke-virtual {p2, v8}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 394
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_1f

    move v0, v7

    .line 396
    .local v0, "_arg0":Z
    :goto_b
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_20

    move v1, v7

    .line 398
    .local v1, "_arg1":Z
    :goto_c
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_21

    move v2, v7

    .line 400
    .local v2, "_arg2":Z
    :goto_d
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-eqz v8, :cond_22

    move v3, v7

    .line 401
    .local v3, "_arg3":Z
    :goto_e
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->sendBIA(ZZZZ)Z

    move-result v4

    .line 402
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 403
    if-eqz v4, :cond_1e

    move v6, v7

    :cond_1e
    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":Z
    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    .end local v3    # "_arg3":Z
    .end local v4    # "_result":Z
    :cond_1f
    move v0, v6

    .line 394
    goto :goto_b

    .restart local v0    # "_arg0":Z
    :cond_20
    move v1, v6

    .line 396
    goto :goto_c

    .restart local v1    # "_arg1":Z
    :cond_21
    move v2, v6

    .line 398
    goto :goto_d

    .restart local v2    # "_arg2":Z
    :cond_22
    move v3, v6

    .line 400
    goto :goto_e

    .line 43
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x4 -> :sswitch_4
        0x5 -> :sswitch_5
        0x6 -> :sswitch_6
        0x7 -> :sswitch_7
        0x8 -> :sswitch_8
        0x9 -> :sswitch_9
        0xa -> :sswitch_a
        0xb -> :sswitch_b
        0xc -> :sswitch_c
        0xd -> :sswitch_d
        0xe -> :sswitch_e
        0xf -> :sswitch_f
        0x10 -> :sswitch_10
        0x11 -> :sswitch_11
        0x12 -> :sswitch_12
        0x13 -> :sswitch_13
        0x14 -> :sswitch_14
        0x15 -> :sswitch_15
        0x16 -> :sswitch_16
        0x17 -> :sswitch_17
        0x18 -> :sswitch_18
        0x19 -> :sswitch_19
        0x1a -> :sswitch_1a
        0x1b -> :sswitch_1b
        0x1c -> :sswitch_1c
        0x1d -> :sswitch_1d
        0x1e -> :sswitch_1e
        0x1f -> :sswitch_1f
        0x20 -> :sswitch_20
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
