.class public abstract Landroid/os/INetworkManagementServiceEx$Stub;
.super Landroid/os/Binder;
.source "INetworkManagementServiceEx.java"

# interfaces
.implements Landroid/os/INetworkManagementServiceEx;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/os/INetworkManagementServiceEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/os/INetworkManagementServiceEx$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.os.INetworkManagementService"

.field static final TRANSACTION_getNetworkStatsUidInterface:I = 0x2712

.field static final TRANSACTION_registerObserverEx:I = 0x2710

.field static final TRANSACTION_unregisterObserverEx:I = 0x2711


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "android.os.INetworkManagementService"

    invoke-virtual {p0, p0, v0}, Landroid/os/INetworkManagementServiceEx$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/os/INetworkManagementServiceEx;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "android.os.INetworkManagementService"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/os/INetworkManagementServiceEx;

    if-eqz v1, :cond_1

    check-cast v0, Landroid/os/INetworkManagementServiceEx;

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/os/INetworkManagementServiceEx$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Landroid/os/INetworkManagementServiceEx$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method

.method public static onTransact(Landroid/os/INetworkManagementServiceEx;ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 7
    .param p0, "server"    # Landroid/os/INetworkManagementServiceEx;
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
    const/4 v3, 0x1

    sparse-switch p1, :sswitch_data_0

    const/4 v3, 0x0

    :goto_0
    return v3

    :sswitch_0
    const-string v6, "android.os.INetworkManagementService"

    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v6, "android.os.INetworkManagementService"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-static {v6}, Landroid/net/INetworkManagementEventObserverEx$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/INetworkManagementEventObserverEx;

    move-result-object v0

    .local v0, "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    invoke-interface {p0, v0}, Landroid/os/INetworkManagementServiceEx;->registerObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    :sswitch_2
    const-string v6, "android.os.INetworkManagementService"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-static {v6}, Landroid/net/INetworkManagementEventObserverEx$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/INetworkManagementEventObserverEx;

    move-result-object v0

    .restart local v0    # "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    invoke-interface {p0, v0}, Landroid/os/INetworkManagementServiceEx;->unregisterObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    :sswitch_3
    const-string v6, "android.os.INetworkManagementService"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .local v1, "_arg1":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "_arg2":I
    invoke-interface {p0, v0, v1, v2}, Landroid/os/INetworkManagementServiceEx;->getNetworkStatsUidInterface(ILjava/lang/String;I)J

    move-result-wide v4

    .local v4, "_result":J
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v4, v5}, Landroid/os/Parcel;->writeLong(J)V

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x2710 -> :sswitch_1
        0x2711 -> :sswitch_2
        0x2712 -> :sswitch_3
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method
