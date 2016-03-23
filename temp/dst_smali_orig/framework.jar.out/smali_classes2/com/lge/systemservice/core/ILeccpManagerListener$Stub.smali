.class public abstract Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;
.super Landroid/os/Binder;
.source "ILeccpManagerListener.java"

# interfaces
.implements Lcom/lge/systemservice/core/ILeccpManagerListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/ILeccpManagerListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/ILeccpManagerListener$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.systemservice.core.ILeccpManagerListener"

.field static final TRANSACTION_onBLEServerStatusChanged:I = 0x3

.field static final TRANSACTION_onCardAdded:I = 0x4

.field static final TRANSACTION_onCardRemoved:I = 0x6

.field static final TRANSACTION_onCardUpdated:I = 0x5

.field static final TRANSACTION_onDeadListenerCheck:I = 0x1

.field static final TRANSACTION_onMyCardAdded:I = 0x7

.field static final TRANSACTION_onMyCardRemoved:I = 0x8

.field static final TRANSACTION_onResponseAction:I = 0x9

.field static final TRANSACTION_onStatusChanged:I = 0x2


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p0, p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILeccpManagerListener;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/systemservice/core/ILeccpManagerListener;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/systemservice/core/ILeccpManagerListener;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 6
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
    const/4 v4, 0x0

    const/4 v3, 0x1

    sparse-switch p1, :sswitch_data_0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v3

    :goto_0
    return v3

    :sswitch_0
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onDeadListenerCheck()V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    :sswitch_2
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_0

    sget-object v4, Lcom/lge/systemservice/core/LeccpInfo$Status;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Status;

    .local v0, "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Status;
    :goto_1
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onStatusChanged(Lcom/lge/systemservice/core/LeccpInfo$Status;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Status;
    :cond_0
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Status;
    goto :goto_1

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Status;
    :sswitch_3
    const-string v5, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    if-eqz v5, :cond_1

    move v0, v3

    .local v0, "_arg0":Z
    :goto_2
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onBLEServerStatusChanged(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Z
    :cond_1
    move v0, v4

    goto :goto_2

    :sswitch_4
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_2

    sget-object v4, Lcom/lge/systemservice/core/LeccpInfo$Card;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Card;

    .local v0, "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :goto_3
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onCardAdded(Lcom/lge/systemservice/core/LeccpInfo$Card;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    goto :goto_3

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :sswitch_5
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_3

    sget-object v4, Lcom/lge/systemservice/core/LeccpInfo$Card;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Card;

    .restart local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :goto_4
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onCardUpdated(Lcom/lge/systemservice/core/LeccpInfo$Card;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :cond_3
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    goto :goto_4

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :sswitch_6
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onCardRemoved(Ljava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_7
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_4

    sget-object v4, Lcom/lge/systemservice/core/LeccpInfo$Card;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v4, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Card;

    .local v0, "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :goto_5
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onMyCardAdded(Lcom/lge/systemservice/core/LeccpInfo$Card;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :cond_4
    const/4 v0, 0x0

    .restart local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    goto :goto_5

    .end local v0    # "_arg0":Lcom/lge/systemservice/core/LeccpInfo$Card;
    :sswitch_8
    const-string v4, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onMyCardRemoved(Ljava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_9
    const-string v5, "com.lge.systemservice.core.ILeccpManagerListener"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "_arg0":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    if-eqz v5, :cond_5

    move v1, v3

    .local v1, "_arg1":Z
    :goto_6
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "_arg2":I
    invoke-virtual {p0, v0, v1, v2}, Lcom/lge/systemservice/core/ILeccpManagerListener$Stub;->onResponseAction(Ljava/lang/String;ZI)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v1    # "_arg1":Z
    .end local v2    # "_arg2":I
    :cond_5
    move v1, v4

    goto :goto_6

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
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
