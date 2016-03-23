.class public abstract Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;
.super Landroid/os/Binder;
.source "INfcAdapterNxp.java"

# interfaces
.implements Lcom/lge/nfcaddon/INfcAdapterNxp;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/nfcaddon/INfcAdapterNxp;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/nfcaddon/INfcAdapterNxp$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.nfcaddon.INfcAdapterNxp"

.field static final TRANSACTION_DefaultRouteSet:I = 0x4

.field static final TRANSACTION_MifareCLTRouteSet:I = 0x5

.field static final TRANSACTION_MifareDesfireRouteSet:I = 0x3

.field static final TRANSACTION_getNfcSecureElementInterface:I = 0x6

.field static final TRANSACTION_setScreenOffCondition:I = 0x2

.field static final TRANSACTION_setVzwAidList:I = 0x1


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p0, p0, v0}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/INfcAdapterNxp;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/nfcaddon/INfcAdapterNxp;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/nfcaddon/INfcAdapterNxp;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 8
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
    const/4 v5, 0x0

    const/4 v6, 0x1

    sparse-switch p1, :sswitch_data_0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v6

    :goto_0
    return v6

    :sswitch_0
    const-string v5, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v7, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    sget-object v7, Lcom/vzw/nfc/RouteEntry;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->createTypedArray(Landroid/os/Parcelable$Creator;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/vzw/nfc/RouteEntry;

    .local v0, "_arg0":[Lcom/vzw/nfc/RouteEntry;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->setVzwAidList([Lcom/vzw/nfc/RouteEntry;)Z

    move-result v4

    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v4, :cond_0

    move v5, v6

    :cond_0
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":[Lcom/vzw/nfc/RouteEntry;
    .end local v4    # "_result":Z
    :sswitch_2
    const-string v7, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_1

    move v0, v6

    .local v0, "_arg0":Z
    :goto_1
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->setScreenOffCondition(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Z
    :cond_1
    move v0, v5

    goto :goto_1

    :sswitch_3
    const-string v7, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_2

    move v1, v6

    .local v1, "_arg1":Z
    :goto_2
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_3

    move v2, v6

    .local v2, "_arg2":Z
    :goto_3
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_4

    move v3, v6

    .local v3, "_arg3":Z
    :goto_4
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->MifareDesfireRouteSet(IZZZ)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    .end local v3    # "_arg3":Z
    :cond_2
    move v1, v5

    goto :goto_2

    .restart local v1    # "_arg1":Z
    :cond_3
    move v2, v5

    goto :goto_3

    .restart local v2    # "_arg2":Z
    :cond_4
    move v3, v5

    goto :goto_4

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    :sswitch_4
    const-string v7, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_5

    move v1, v6

    .restart local v1    # "_arg1":Z
    :goto_5
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_6

    move v2, v6

    .restart local v2    # "_arg2":Z
    :goto_6
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_7

    move v3, v6

    .restart local v3    # "_arg3":Z
    :goto_7
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->DefaultRouteSet(IZZZ)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    .end local v3    # "_arg3":Z
    :cond_5
    move v1, v5

    goto :goto_5

    .restart local v1    # "_arg1":Z
    :cond_6
    move v2, v5

    goto :goto_6

    .restart local v2    # "_arg2":Z
    :cond_7
    move v3, v5

    goto :goto_7

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    :sswitch_5
    const-string v7, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_8

    move v1, v6

    .restart local v1    # "_arg1":Z
    :goto_8
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_9

    move v2, v6

    .restart local v2    # "_arg2":Z
    :goto_9
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_a

    move v3, v6

    .restart local v3    # "_arg3":Z
    :goto_a
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->MifareCLTRouteSet(IZZZ)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    .end local v3    # "_arg3":Z
    :cond_8
    move v1, v5

    goto :goto_8

    .restart local v1    # "_arg1":Z
    :cond_9
    move v2, v5

    goto :goto_9

    .restart local v2    # "_arg2":Z
    :cond_a
    move v3, v5

    goto :goto_a

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":Z
    :sswitch_6
    const-string v5, "com.lge.nfcaddon.INfcAdapterNxp"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->getNfcSecureElementInterface()Lcom/lge/nfcaddon/INfcSecureElement;

    move-result-object v4

    .local v4, "_result":Lcom/lge/nfcaddon/INfcSecureElement;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v4, :cond_b

    invoke-interface {v4}, Lcom/lge/nfcaddon/INfcSecureElement;->asBinder()Landroid/os/IBinder;

    move-result-object v5

    :goto_b
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    goto/16 :goto_0

    :cond_b
    const/4 v5, 0x0

    goto :goto_b

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
