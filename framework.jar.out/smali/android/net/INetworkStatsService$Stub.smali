.class public abstract Landroid/net/INetworkStatsService$Stub;
.super Landroid/os/Binder;
.source "INetworkStatsService.java"

# interfaces
.implements Landroid/net/INetworkStatsService;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/net/INetworkStatsService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/net/INetworkStatsService$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.net.INetworkStatsService"

.field static final TRANSACTION_advisePersistThreshold:I = 0x9

.field static final TRANSACTION_clearUsage:I = 0x2

.field static final TRANSACTION_forceUpdate:I = 0x8

.field static final TRANSACTION_getDataLayerSnapshotForUid:I = 0x4

.field static final TRANSACTION_getMobileIfaces:I = 0x5

.field static final TRANSACTION_getNetworkTotalBytes:I = 0x3

.field static final TRANSACTION_incrementOperationCount:I = 0x6

.field static final TRANSACTION_openSession:I = 0x1

.field static final TRANSACTION_setUidForeground:I = 0x7


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 15
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 16
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p0, p0, v0}, Landroid/net/INetworkStatsService$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 17
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/net/INetworkStatsService;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 24
    if-nez p0, :cond_0

    .line 25
    const/4 v0, 0x0

    .line 31
    :goto_0
    return-object v0

    .line 27
    :cond_0
    const-string v1, "android.net.INetworkStatsService"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 28
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/net/INetworkStatsService;

    if-eqz v1, :cond_1

    .line 29
    check-cast v0, Landroid/net/INetworkStatsService;

    goto :goto_0

    .line 31
    :cond_1
    new-instance v0, Landroid/net/INetworkStatsService$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Landroid/net/INetworkStatsService$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 35
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
    .line 39
    sparse-switch p1, :sswitch_data_0

    .line 153
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v0

    :goto_0
    return v0

    .line 43
    :sswitch_0
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 44
    const/4 v0, 0x1

    goto :goto_0

    .line 48
    :sswitch_1
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 49
    invoke-virtual {p0}, Landroid/net/INetworkStatsService$Stub;->openSession()Landroid/net/INetworkStatsSession;

    move-result-object v8

    .line 50
    .local v8, "_result":Landroid/net/INetworkStatsSession;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 51
    if-eqz v8, :cond_0

    invoke-interface {v8}, Landroid/net/INetworkStatsSession;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    :goto_1
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    .line 52
    const/4 v0, 0x1

    goto :goto_0

    .line 51
    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    .line 56
    .end local v8    # "_result":Landroid/net/INetworkStatsSession;
    :sswitch_2
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 58
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_1

    .line 59
    sget-object v0, Landroid/net/NetworkTemplate;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/NetworkTemplate;

    .line 64
    .local v1, "_arg0":Landroid/net/NetworkTemplate;
    :goto_2
    invoke-virtual {p0, v1}, Landroid/net/INetworkStatsService$Stub;->clearUsage(Landroid/net/NetworkTemplate;)Z

    move-result v8

    .line 65
    .local v8, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 66
    if-eqz v8, :cond_2

    const/4 v0, 0x1

    :goto_3
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 67
    const/4 v0, 0x1

    goto :goto_0

    .line 62
    .end local v1    # "_arg0":Landroid/net/NetworkTemplate;
    .end local v8    # "_result":Z
    :cond_1
    const/4 v1, 0x0

    .restart local v1    # "_arg0":Landroid/net/NetworkTemplate;
    goto :goto_2

    .line 66
    .restart local v8    # "_result":Z
    :cond_2
    const/4 v0, 0x0

    goto :goto_3

    .line 71
    .end local v1    # "_arg0":Landroid/net/NetworkTemplate;
    .end local v8    # "_result":Z
    :sswitch_3
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 73
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_3

    .line 74
    sget-object v0, Landroid/net/NetworkTemplate;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v0, p2}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/NetworkTemplate;

    .line 80
    .restart local v1    # "_arg0":Landroid/net/NetworkTemplate;
    :goto_4
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v2

    .line 82
    .local v2, "_arg1":J
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v4

    .local v4, "_arg2":J
    move-object v0, p0

    .line 83
    invoke-virtual/range {v0 .. v5}, Landroid/net/INetworkStatsService$Stub;->getNetworkTotalBytes(Landroid/net/NetworkTemplate;JJ)J

    move-result-wide v8

    .line 84
    .local v8, "_result":J
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 85
    invoke-virtual {p3, v8, v9}, Landroid/os/Parcel;->writeLong(J)V

    .line 86
    const/4 v0, 0x1

    goto :goto_0

    .line 77
    .end local v1    # "_arg0":Landroid/net/NetworkTemplate;
    .end local v2    # "_arg1":J
    .end local v4    # "_arg2":J
    .end local v8    # "_result":J
    :cond_3
    const/4 v1, 0x0

    .restart local v1    # "_arg0":Landroid/net/NetworkTemplate;
    goto :goto_4

    .line 90
    .end local v1    # "_arg0":Landroid/net/NetworkTemplate;
    :sswitch_4
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 92
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 93
    .local v1, "_arg0":I
    invoke-virtual {p0, v1}, Landroid/net/INetworkStatsService$Stub;->getDataLayerSnapshotForUid(I)Landroid/net/NetworkStats;

    move-result-object v8

    .line 94
    .local v8, "_result":Landroid/net/NetworkStats;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 95
    if-eqz v8, :cond_4

    .line 96
    const/4 v0, 0x1

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 97
    const/4 v0, 0x1

    invoke-virtual {v8, p3, v0}, Landroid/net/NetworkStats;->writeToParcel(Landroid/os/Parcel;I)V

    .line 102
    :goto_5
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 100
    :cond_4
    const/4 v0, 0x0

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_5

    .line 106
    .end local v1    # "_arg0":I
    .end local v8    # "_result":Landroid/net/NetworkStats;
    :sswitch_5
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 107
    invoke-virtual {p0}, Landroid/net/INetworkStatsService$Stub;->getMobileIfaces()[Ljava/lang/String;

    move-result-object v8

    .line 108
    .local v8, "_result":[Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 109
    invoke-virtual {p3, v8}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 110
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 114
    .end local v8    # "_result":[Ljava/lang/String;
    :sswitch_6
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 116
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 118
    .restart local v1    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 120
    .local v2, "_arg1":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 121
    .local v4, "_arg2":I
    invoke-virtual {p0, v1, v2, v4}, Landroid/net/INetworkStatsService$Stub;->incrementOperationCount(III)V

    .line 122
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 123
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 127
    .end local v1    # "_arg0":I
    .end local v2    # "_arg1":I
    .end local v4    # "_arg2":I
    :sswitch_7
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 129
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 131
    .restart local v1    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_5

    const/4 v2, 0x1

    .line 132
    .local v2, "_arg1":Z
    :goto_6
    invoke-virtual {p0, v1, v2}, Landroid/net/INetworkStatsService$Stub;->setUidForeground(IZ)V

    .line 133
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 134
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 131
    .end local v2    # "_arg1":Z
    :cond_5
    const/4 v2, 0x0

    goto :goto_6

    .line 138
    .end local v1    # "_arg0":I
    :sswitch_8
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 139
    invoke-virtual {p0}, Landroid/net/INetworkStatsService$Stub;->forceUpdate()V

    .line 140
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 141
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 145
    :sswitch_9
    const-string v0, "android.net.INetworkStatsService"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 147
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v6

    .line 148
    .local v6, "_arg0":J
    invoke-virtual {p0, v6, v7}, Landroid/net/INetworkStatsService$Stub;->advisePersistThreshold(J)V

    .line 149
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 150
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 39
    nop

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
