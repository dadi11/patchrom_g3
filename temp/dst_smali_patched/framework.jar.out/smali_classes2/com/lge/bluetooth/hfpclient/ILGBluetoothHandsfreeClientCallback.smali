.class public interface abstract Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback;
.super Ljava/lang/Object;
.source "ILGBluetoothHandsfreeClientCallback.java"

# interfaces
.implements Landroid/os/IInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;
    }
.end annotation


# virtual methods
.method public abstract onAudioStateChange(II)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method

.method public abstract onCallStateChange(IIIIILjava/lang/String;IZ)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method

.method public abstract onConnectionStateChange(ILandroid/bluetooth/BluetoothDevice;IIII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
