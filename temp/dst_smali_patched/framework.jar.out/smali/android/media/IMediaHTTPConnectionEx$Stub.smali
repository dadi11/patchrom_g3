.class public abstract Landroid/media/IMediaHTTPConnectionEx$Stub;
.super Landroid/os/Binder;
.source "IMediaHTTPConnectionEx.java"

# interfaces
.implements Landroid/media/IMediaHTTPConnectionEx;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/IMediaHTTPConnectionEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/media/IMediaHTTPConnectionEx$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.media.IMediaHTTPConnection"

.field static final TRANSACTION_getCurrentOffset:I = 0x2716

.field static final TRANSACTION_getRangeLastByte:I = 0x2719

.field static final TRANSACTION_getResponseCode:I = 0x271a

.field static final TRANSACTION_getResponseHeader:I = 0x2715

.field static final TRANSACTION_getResponseHeaderFields:I = 0x271c

.field static final TRANSACTION_isSupportRangeRequest:I = 0x2718

.field static final TRANSACTION_setContentSize:I = 0x2717

.field static final TRANSACTION_setDLNAByteRangeSeekMode:I = 0x2711

.field static final TRANSACTION_setDLNAPauseMode:I = 0x2712

.field static final TRANSACTION_setDLNAPlayback:I = 0x2713

.field static final TRANSACTION_setDLNATimeSeekMode:I = 0x2710

.field static final TRANSACTION_setDLNATimeSeekValue:I = 0x2714

.field static final TRANSACTION_setTimeout:I = 0x271b


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "android.media.IMediaHTTPConnection"

    invoke-virtual {p0, p0, v0}, Landroid/media/IMediaHTTPConnectionEx$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/media/IMediaHTTPConnectionEx;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "android.media.IMediaHTTPConnection"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/media/IMediaHTTPConnectionEx;

    if-eqz v1, :cond_1

    check-cast v0, Landroid/media/IMediaHTTPConnectionEx;

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/media/IMediaHTTPConnectionEx$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Landroid/media/IMediaHTTPConnectionEx$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method

.method public static onTransact(Landroid/media/IMediaHTTPConnectionEx;ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 7
    .param p0, "server"    # Landroid/media/IMediaHTTPConnectionEx;
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
    const/4 v0, 0x0

    const/4 v3, 0x1

    sparse-switch p1, :sswitch_data_0

    move v3, v0

    :goto_0
    return v3

    :sswitch_0
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_0

    move v0, v3

    .local v0, "_arg0":Z
    :cond_0
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNATimeSeekMode(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Z
    :sswitch_2
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_1

    move v0, v3

    .restart local v0    # "_arg0":Z
    :cond_1
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNAByteRangeSeekMode(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Z
    :sswitch_3
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_2

    move v0, v3

    .restart local v0    # "_arg0":Z
    :cond_2
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNAPauseMode(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Z
    :sswitch_4
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_3

    move v0, v3

    .restart local v0    # "_arg0":Z
    :cond_3
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNAPlayback(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":Z
    :sswitch_5
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    .local v0, "_arg0":J
    invoke-interface {p0, v0, v1}, Landroid/media/IMediaHTTPConnectionEx;->setDLNATimeSeekValue(J)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .end local v0    # "_arg0":J
    :sswitch_6
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getResponseHeader()Ljava/lang/String;

    move-result-object v4

    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_7
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getCurrentOffset()J

    move-result-wide v4

    .local v4, "_result":J
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v4, v5}, Landroid/os/Parcel;->writeLong(J)V

    goto/16 :goto_0

    .end local v4    # "_result":J
    :sswitch_8
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    .restart local v0    # "_arg0":J
    invoke-interface {p0, v0, v1}, Landroid/media/IMediaHTTPConnectionEx;->setContentSize(J)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":J
    :sswitch_9
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->isSupportRangeRequest()Z

    move-result v4

    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v4, :cond_4

    move v0, v3

    :cond_4
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v4    # "_result":Z
    :sswitch_a
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getRangeLastByte()J

    move-result-wide v4

    .local v4, "_result":J
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v4, v5}, Landroid/os/Parcel;->writeLong(J)V

    goto/16 :goto_0

    .end local v4    # "_result":J
    :sswitch_b
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getResponseCode()I

    move-result v4

    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v4    # "_result":I
    :sswitch_c
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "_arg1":I
    invoke-interface {p0, v0, v2}, Landroid/media/IMediaHTTPConnectionEx;->setTimeout(II)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v2    # "_arg1":I
    :sswitch_d
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getResponseHeaderFields()Ljava/lang/String;

    move-result-object v4

    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x2710 -> :sswitch_1
        0x2711 -> :sswitch_2
        0x2712 -> :sswitch_3
        0x2713 -> :sswitch_4
        0x2714 -> :sswitch_5
        0x2715 -> :sswitch_6
        0x2716 -> :sswitch_7
        0x2717 -> :sswitch_8
        0x2718 -> :sswitch_9
        0x2719 -> :sswitch_a
        0x271a -> :sswitch_b
        0x271b -> :sswitch_c
        0x271c -> :sswitch_d
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method
