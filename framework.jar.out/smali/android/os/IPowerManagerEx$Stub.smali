.class public abstract Landroid/os/IPowerManagerEx$Stub;
.super Landroid/os/Binder;
.source "IPowerManagerEx.java"

# interfaces
.implements Landroid/os/IPowerManagerEx;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/os/IPowerManagerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/os/IPowerManagerEx$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.os.IPowerManagerEx"

.field static final TRANSACTION_forceWakeLockRelease:I = 0x5

.field static final TRANSACTION_getPowerKeyWhenCalling:I = 0x3

.field static final TRANSACTION_getWakeLockFlags:I = 0x2

.field static final TRANSACTION_recoverBacklightBrightness:I = 0x6

.field static final TRANSACTION_setBattery:I = 0x1

.field static final TRANSACTION_setPowerKeyWhenCalling:I = 0x4


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 15
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p0, p0, v0}, Landroid/os/IPowerManagerEx$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/os/IPowerManagerEx;
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
    const-string v1, "android.os.IPowerManagerEx"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/os/IPowerManagerEx;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Landroid/os/IPowerManagerEx;

    goto :goto_0

    .line 30
    :cond_1
    new-instance v0, Landroid/os/IPowerManagerEx$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Landroid/os/IPowerManagerEx$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

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
    .line 38
    sparse-switch p1, :sswitch_data_0

    .line 117
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v0

    :goto_0
    return v0

    .line 42
    :sswitch_0
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 43
    const/4 v0, 0x1

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    .line 51
    .local v1, "_arg0":Z
    :goto_1
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 53
    .local v2, "_arg1":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 55
    .local v3, "_arg2":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_1

    const/4 v4, 0x1

    .line 57
    .local v4, "_arg3":Z
    :goto_2
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 59
    .local v5, "_arg4":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 61
    .local v6, "_arg5":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 63
    .local v7, "_arg6":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .local v8, "_arg7":Ljava/lang/String;
    move-object v0, p0

    .line 64
    invoke-virtual/range {v0 .. v8}, Landroid/os/IPowerManagerEx$Stub;->setBattery(ZIIZIIILjava/lang/String;)V

    .line 65
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 66
    const/4 v0, 0x1

    goto :goto_0

    .line 49
    .end local v1    # "_arg0":Z
    .end local v2    # "_arg1":I
    .end local v3    # "_arg2":I
    .end local v4    # "_arg3":Z
    .end local v5    # "_arg4":I
    .end local v6    # "_arg5":I
    .end local v7    # "_arg6":I
    .end local v8    # "_arg7":Ljava/lang/String;
    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    .line 55
    .restart local v1    # "_arg0":Z
    .restart local v2    # "_arg1":I
    .restart local v3    # "_arg2":I
    :cond_1
    const/4 v4, 0x0

    goto :goto_2

    .line 70
    .end local v1    # "_arg0":Z
    .end local v2    # "_arg1":I
    .end local v3    # "_arg2":I
    :sswitch_2
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 72
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 73
    .local v1, "_arg0":I
    invoke-virtual {p0, v1}, Landroid/os/IPowerManagerEx$Stub;->getWakeLockFlags(I)I

    move-result v9

    .line 74
    .local v9, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 75
    invoke-virtual {p3, v9}, Landroid/os/Parcel;->writeInt(I)V

    .line 76
    const/4 v0, 0x1

    goto :goto_0

    .line 80
    .end local v1    # "_arg0":I
    .end local v9    # "_result":I
    :sswitch_3
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 81
    invoke-virtual {p0}, Landroid/os/IPowerManagerEx$Stub;->getPowerKeyWhenCalling()Z

    move-result v9

    .line 82
    .local v9, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 83
    if-eqz v9, :cond_2

    const/4 v0, 0x1

    :goto_3
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 84
    const/4 v0, 0x1

    goto :goto_0

    .line 83
    :cond_2
    const/4 v0, 0x0

    goto :goto_3

    .line 88
    .end local v9    # "_result":Z
    :sswitch_4
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 90
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_3

    const/4 v1, 0x1

    .line 91
    .local v1, "_arg0":Z
    :goto_4
    invoke-virtual {p0, v1}, Landroid/os/IPowerManagerEx$Stub;->setPowerKeyWhenCalling(Z)V

    .line 92
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 93
    const/4 v0, 0x1

    goto :goto_0

    .line 90
    .end local v1    # "_arg0":Z
    :cond_3
    const/4 v1, 0x0

    goto :goto_4

    .line 97
    :sswitch_5
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 99
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 101
    .local v1, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 102
    .restart local v2    # "_arg1":I
    invoke-virtual {p0, v1, v2}, Landroid/os/IPowerManagerEx$Stub;->forceWakeLockRelease(II)I

    move-result v9

    .line 103
    .local v9, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 104
    invoke-virtual {p3, v9}, Landroid/os/Parcel;->writeInt(I)V

    .line 105
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 109
    .end local v1    # "_arg0":I
    .end local v2    # "_arg1":I
    .end local v9    # "_result":I
    :sswitch_6
    const-string v0, "android.os.IPowerManagerEx"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 111
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 112
    .restart local v1    # "_arg0":I
    invoke-virtual {p0, v1}, Landroid/os/IPowerManagerEx$Stub;->recoverBacklightBrightness(I)V

    .line 113
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 114
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 38
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x4 -> :sswitch_4
        0x5 -> :sswitch_5
        0x6 -> :sswitch_6
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
