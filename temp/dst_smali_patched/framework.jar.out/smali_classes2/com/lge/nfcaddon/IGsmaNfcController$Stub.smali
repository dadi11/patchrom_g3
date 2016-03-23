.class public abstract Lcom/lge/nfcaddon/IGsmaNfcController$Stub;
.super Landroid/os/Binder;
.source "IGsmaNfcController.java"

# interfaces
.implements Lcom/lge/nfcaddon/IGsmaNfcController;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/nfcaddon/IGsmaNfcController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/nfcaddon/IGsmaNfcController$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.nfcaddon.IGsmaNfcController"

.field static final TRANSACTION_commitGsmaOffHostService:I = 0x8

.field static final TRANSACTION_disableNfcCardCallback:I = 0x4

.field static final TRANSACTION_enableMultiEvt_transactionReception:I = 0x5

.field static final TRANSACTION_enableNfcCardCallback:I = 0x3

.field static final TRANSACTION_enableNfcControllerCallback:I = 0x1

.field static final TRANSACTION_enableNfcControllerPopupCallback:I = 0x2

.field static final TRANSACTION_getActiveSecureElement:I = 0x9

.field static final TRANSACTION_isGSMACertificateAllowed:I = 0x6

.field static final TRANSACTION_isGSMACertificateAllowedArray:I = 0x7


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p0, p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/IGsmaNfcController;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/nfcaddon/IGsmaNfcController;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/nfcaddon/IGsmaNfcController;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/nfcaddon/IGsmaNfcController$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

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
    const/4 v3, 0x0

    const/4 v4, 0x1

    sparse-switch p1, :sswitch_data_0

    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v4

    :goto_0
    return v4

    :sswitch_0
    const-string v3, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v5, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/nfcaddon/IGsmaNfcControllerCallback$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;

    move-result-object v0

    .local v0, "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->enableNfcControllerCallback(Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;)Z

    move-result v2

    .local v2, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_0

    move v3, v4

    :cond_0
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    .end local v2    # "_result":Z
    :sswitch_2
    const-string v5, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/nfcaddon/IGsmaNfcControllerCallback$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;

    move-result-object v0

    .restart local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->enableNfcControllerPopupCallback(Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_1

    move v3, v4

    :cond_1
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    .end local v2    # "_result":Z
    :sswitch_3
    const-string v5, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/nfcaddon/IGsmaNfcControllerCallback$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;

    move-result-object v0

    .restart local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->enableNfcCardCallback(Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_2

    move v3, v4

    :cond_2
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    .end local v2    # "_result":Z
    :sswitch_4
    const-string v5, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/nfcaddon/IGsmaNfcControllerCallback$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;

    move-result-object v0

    .restart local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->disableNfcCardCallback(Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_3

    move v3, v4

    :cond_3
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":Lcom/lge/nfcaddon/IGsmaNfcControllerCallback;
    .end local v2    # "_result":Z
    :sswitch_5
    const-string v3, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->enableMultiEvt_transactionReception(Ljava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_6
    const-string v5, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->isGSMACertificateAllowed(Ljava/lang/String;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_4

    move v3, v4

    :cond_4
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v2    # "_result":Z
    :sswitch_7
    const-string v3, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createStringArray()[Ljava/lang/String;

    move-result-object v0

    .local v0, "_arg0":[Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->isGSMACertificateAllowedArray([Ljava/lang/String;)[Z

    move-result-object v2

    .local v2, "_result":[Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v2}, Landroid/os/Parcel;->writeBooleanArray([Z)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v2    # "_result":[Z
    :sswitch_8
    const-string v3, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    if-eqz v3, :cond_5

    sget-object v3, Lcom/lge/nfcaddon/GsmaOffHostServiceInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v3, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/nfcaddon/GsmaOffHostServiceInfo;

    .local v1, "_arg1":Lcom/lge/nfcaddon/GsmaOffHostServiceInfo;
    :goto_1
    invoke-virtual {p0, v0, v1}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->commitGsmaOffHostService(ILcom/lge/nfcaddon/GsmaOffHostServiceInfo;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v1    # "_arg1":Lcom/lge/nfcaddon/GsmaOffHostServiceInfo;
    :cond_5
    const/4 v1, 0x0

    .restart local v1    # "_arg1":Lcom/lge/nfcaddon/GsmaOffHostServiceInfo;
    goto :goto_1

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":Lcom/lge/nfcaddon/GsmaOffHostServiceInfo;
    :sswitch_9
    const-string v3, "com.lge.nfcaddon.IGsmaNfcController"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/nfcaddon/IGsmaNfcController$Stub;->getActiveSecureElement()Ljava/lang/String;

    move-result-object v2

    .local v2, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

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
