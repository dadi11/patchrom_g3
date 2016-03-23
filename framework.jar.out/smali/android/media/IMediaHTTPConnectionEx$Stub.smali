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
    .line 14
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 15
    const-string v0, "android.media.IMediaHTTPConnection"

    invoke-virtual {p0, p0, v0}, Landroid/media/IMediaHTTPConnectionEx$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/media/IMediaHTTPConnectionEx;
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
    const-string v1, "android.media.IMediaHTTPConnection"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/media/IMediaHTTPConnectionEx;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Landroid/media/IMediaHTTPConnectionEx;

    goto :goto_0

    .line 30
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

    .line 38
    sparse-switch p1, :sswitch_data_0

    move v3, v0

    .line 159
    :goto_0
    return v3

    .line 42
    :sswitch_0
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p3, v6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_0

    move v0, v3

    .line 50
    .local v0, "_arg0":Z
    :cond_0
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNATimeSeekMode(Z)V

    .line 51
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 56
    .end local v0    # "_arg0":Z
    :sswitch_2
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 58
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_1

    move v0, v3

    .line 59
    .restart local v0    # "_arg0":Z
    :cond_1
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNAByteRangeSeekMode(Z)V

    .line 60
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 65
    .end local v0    # "_arg0":Z
    :sswitch_3
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 67
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_2

    move v0, v3

    .line 68
    .restart local v0    # "_arg0":Z
    :cond_2
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNAPauseMode(Z)V

    .line 69
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 74
    .end local v0    # "_arg0":Z
    :sswitch_4
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 76
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_3

    move v0, v3

    .line 77
    .restart local v0    # "_arg0":Z
    :cond_3
    invoke-interface {p0, v0}, Landroid/media/IMediaHTTPConnectionEx;->setDLNAPlayback(Z)V

    .line 78
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 83
    .end local v0    # "_arg0":Z
    :sswitch_5
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 85
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    .line 86
    .local v0, "_arg0":J
    invoke-interface {p0, v0, v1}, Landroid/media/IMediaHTTPConnectionEx;->setDLNATimeSeekValue(J)V

    .line 87
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 92
    .end local v0    # "_arg0":J
    :sswitch_6
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 93
    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getResponseHeader()Ljava/lang/String;

    move-result-object v4

    .line 94
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 95
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 100
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_7
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 101
    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getCurrentOffset()J

    move-result-wide v4

    .line 102
    .local v4, "_result":J
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 103
    invoke-virtual {p3, v4, v5}, Landroid/os/Parcel;->writeLong(J)V

    goto/16 :goto_0

    .line 108
    .end local v4    # "_result":J
    :sswitch_8
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 110
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    .line 111
    .restart local v0    # "_arg0":J
    invoke-interface {p0, v0, v1}, Landroid/media/IMediaHTTPConnectionEx;->setContentSize(J)V

    .line 112
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 117
    .end local v0    # "_arg0":J
    :sswitch_9
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 118
    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->isSupportRangeRequest()Z

    move-result v4

    .line 119
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 120
    if-eqz v4, :cond_4

    move v0, v3

    :cond_4
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 125
    .end local v4    # "_result":Z
    :sswitch_a
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 126
    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getRangeLastByte()J

    move-result-wide v4

    .line 127
    .local v4, "_result":J
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 128
    invoke-virtual {p3, v4, v5}, Landroid/os/Parcel;->writeLong(J)V

    goto/16 :goto_0

    .line 133
    .end local v4    # "_result":J
    :sswitch_b
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 134
    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getResponseCode()I

    move-result v4

    .line 135
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 136
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 141
    .end local v4    # "_result":I
    :sswitch_c
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 143
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 145
    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 146
    .local v2, "_arg1":I
    invoke-interface {p0, v0, v2}, Landroid/media/IMediaHTTPConnectionEx;->setTimeout(II)V

    .line 147
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 152
    .end local v0    # "_arg0":I
    .end local v2    # "_arg1":I
    :sswitch_d
    const-string v6, "android.media.IMediaHTTPConnection"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 153
    invoke-interface {p0}, Landroid/media/IMediaHTTPConnectionEx;->getResponseHeaderFields()Ljava/lang/String;

    move-result-object v4

    .line 154
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 155
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 38
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
    .line 34
    return-object p0
.end method
