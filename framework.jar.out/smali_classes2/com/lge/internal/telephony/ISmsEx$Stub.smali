.class public abstract Lcom/lge/internal/telephony/ISmsEx$Stub;
.super Landroid/os/Binder;
.source "ISmsEx.java"

# interfaces
.implements Lcom/lge/internal/telephony/ISmsEx;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/telephony/ISmsEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/internal/telephony/ISmsEx$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.internal.telephony.ISmsEx"

.field static final TRANSACTION_copySmsToIccEf:I = 0x6

.field static final TRANSACTION_copySmsToIccEfForSubscriber:I = 0x19

.field static final TRANSACTION_copySmsToIccEfPrivate:I = 0xa

.field static final TRANSACTION_disableGsmBroadcastRange:I = 0x18

.field static final TRANSACTION_enableAutoDCDisconnect:I = 0x12

.field static final TRANSACTION_enableGsmBroadcastRange:I = 0x17

.field static final TRANSACTION_getMaxEfSms:I = 0x4

.field static final TRANSACTION_getMaxEfSmsForSubscriber:I = 0x1a

.field static final TRANSACTION_getSmscenterAddress:I = 0x2

.field static final TRANSACTION_getSmscenterAddressForSubscriber:I = 0x1c

.field static final TRANSACTION_getUiccType:I = 0xc

.field static final TRANSACTION_insertDBForLGMessage:I = 0x15

.field static final TRANSACTION_isFdnEnabled:I = 0x13

.field static final TRANSACTION_isFdnEnabledOnSubscription:I = 0x1e

.field static final TRANSACTION_sendEmailoverMultipartText:I = 0xf

.field static final TRANSACTION_sendEmailoverText:I = 0xe

.field static final TRANSACTION_sendMultipartTextLge:I = 0x11

.field static final TRANSACTION_sendMultipartTextWithCbAddress:I = 0x9

.field static final TRANSACTION_sendTextLge:I = 0x10

.field static final TRANSACTION_sendTextWithCbAddress:I = 0x8

.field static final TRANSACTION_setMultipartTextValidityPeriod:I = 0x1

.field static final TRANSACTION_setMultipartTextValidityPeriodForSubscriber:I = 0x1f

.field static final TRANSACTION_setSmsIsRoaming:I = 0x14

.field static final TRANSACTION_setSmsPriority:I = 0x7

.field static final TRANSACTION_setSmscenterAddress:I = 0x3

.field static final TRANSACTION_setSmscenterAddressForSubscriber:I = 0x1d

.field static final TRANSACTION_setUiccType:I = 0xb

.field static final TRANSACTION_smsReceptionBlockingforNIAPPolicy:I = 0x16

.field static final TRANSACTION_updateMessageOnIccEfMultiMode:I = 0xd

.field static final TRANSACTION_updateSmsOnSimReadStatus:I = 0x5

.field static final TRANSACTION_updateSmsOnSimReadStatusForSubscriber:I = 0x1b


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 27
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 28
    const-string v0, "com.lge.internal.telephony.ISmsEx"

    invoke-virtual {p0, p0, v0}, Lcom/lge/internal/telephony/ISmsEx$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 29
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ISmsEx;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 36
    if-nez p0, :cond_0

    .line 37
    const/4 v0, 0x0

    .line 43
    :goto_0
    return-object v0

    .line 39
    :cond_0
    const-string v1, "com.lge.internal.telephony.ISmsEx"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 40
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/internal/telephony/ISmsEx;

    if-eqz v1, :cond_1

    .line 41
    check-cast v0, Lcom/lge/internal/telephony/ISmsEx;

    goto :goto_0

    .line 43
    :cond_1
    new-instance v0, Lcom/lge/internal/telephony/ISmsEx$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/internal/telephony/ISmsEx$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 47
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 38
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
    .line 51
    sparse-switch p1, :sswitch_data_0

    .line 517
    invoke-super/range {p0 .. p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v4

    :goto_0
    return v4

    .line 55
    :sswitch_0
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 56
    const/4 v4, 0x1

    goto :goto_0

    .line 60
    :sswitch_1
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 62
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 63
    .local v5, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setMultipartTextValidityPeriod(I)V

    .line 64
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 65
    const/4 v4, 0x1

    goto :goto_0

    .line 69
    .end local v5    # "_arg0":I
    :sswitch_2
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 70
    invoke-virtual/range {p0 .. p0}, Lcom/lge/internal/telephony/ISmsEx$Stub;->getSmscenterAddress()Ljava/lang/String;

    move-result-object v31

    .line 71
    .local v31, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 72
    move-object/from16 v0, p3

    move-object/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 73
    const/4 v4, 0x1

    goto :goto_0

    .line 77
    .end local v31    # "_result":Ljava/lang/String;
    :sswitch_3
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 79
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 80
    .local v5, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setSmscenterAddress(Ljava/lang/String;)Z

    move-result v31

    .line 81
    .local v31, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 82
    if-eqz v31, :cond_0

    const/4 v4, 0x1

    :goto_1
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 83
    const/4 v4, 0x1

    goto :goto_0

    .line 82
    :cond_0
    const/4 v4, 0x0

    goto :goto_1

    .line 87
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v31    # "_result":Z
    :sswitch_4
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 88
    invoke-virtual/range {p0 .. p0}, Lcom/lge/internal/telephony/ISmsEx$Stub;->getMaxEfSms()I

    move-result v31

    .line 89
    .local v31, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 90
    move-object/from16 v0, p3

    move/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 91
    const/4 v4, 0x1

    goto :goto_0

    .line 95
    .end local v31    # "_result":I
    :sswitch_5
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 97
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 99
    .local v5, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_1

    const/4 v6, 0x1

    .line 100
    .local v6, "_arg1":Z
    :goto_2
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6}, Lcom/lge/internal/telephony/ISmsEx$Stub;->updateSmsOnSimReadStatus(IZ)Z

    move-result v31

    .line 101
    .local v31, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 102
    if-eqz v31, :cond_2

    const/4 v4, 0x1

    :goto_3
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 103
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 99
    .end local v6    # "_arg1":Z
    .end local v31    # "_result":Z
    :cond_1
    const/4 v6, 0x0

    goto :goto_2

    .line 102
    .restart local v6    # "_arg1":Z
    .restart local v31    # "_result":Z
    :cond_2
    const/4 v4, 0x0

    goto :goto_3

    .line 107
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":Z
    .end local v31    # "_result":Z
    :sswitch_6
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 109
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 111
    .restart local v5    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v6

    .line 113
    .local v6, "_arg1":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v7

    .line 114
    .local v7, "_arg2":[B
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6, v7}, Lcom/lge/internal/telephony/ISmsEx$Stub;->copySmsToIccEf(I[B[B)I

    move-result v31

    .line 115
    .local v31, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 116
    move-object/from16 v0, p3

    move/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 117
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 121
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":[B
    .end local v7    # "_arg2":[B
    .end local v31    # "_result":I
    :sswitch_7
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 123
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 124
    .restart local v5    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setSmsPriority(I)V

    .line 125
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 126
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 130
    .end local v5    # "_arg0":I
    :sswitch_8
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 132
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 134
    .local v5, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 136
    .local v6, "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 138
    .local v7, "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .line 140
    .local v8, "_arg3":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_3

    .line 141
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/app/PendingIntent;

    .line 147
    .local v9, "_arg4":Landroid/app/PendingIntent;
    :goto_4
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_4

    .line 148
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/app/PendingIntent;

    .line 154
    .local v10, "_arg5":Landroid/app/PendingIntent;
    :goto_5
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v11

    .local v11, "_arg6":Ljava/lang/String;
    move-object/from16 v4, p0

    .line 155
    invoke-virtual/range {v4 .. v11}, Lcom/lge/internal/telephony/ISmsEx$Stub;->sendTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V

    .line 156
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 157
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 144
    .end local v9    # "_arg4":Landroid/app/PendingIntent;
    .end local v10    # "_arg5":Landroid/app/PendingIntent;
    .end local v11    # "_arg6":Ljava/lang/String;
    :cond_3
    const/4 v9, 0x0

    .restart local v9    # "_arg4":Landroid/app/PendingIntent;
    goto :goto_4

    .line 151
    :cond_4
    const/4 v10, 0x0

    .restart local v10    # "_arg5":Landroid/app/PendingIntent;
    goto :goto_5

    .line 161
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v6    # "_arg1":Ljava/lang/String;
    .end local v7    # "_arg2":Ljava/lang/String;
    .end local v8    # "_arg3":Ljava/lang/String;
    .end local v9    # "_arg4":Landroid/app/PendingIntent;
    .end local v10    # "_arg5":Landroid/app/PendingIntent;
    :sswitch_9
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 163
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 165
    .restart local v5    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 167
    .restart local v6    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 169
    .restart local v7    # "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;

    move-result-object v16

    .line 171
    .local v16, "_arg3":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v17

    .line 173
    .local v17, "_arg4":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v18

    .line 175
    .local v18, "_arg5":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v11

    .restart local v11    # "_arg6":Ljava/lang/String;
    move-object/from16 v12, p0

    move-object v13, v5

    move-object v14, v6

    move-object v15, v7

    move-object/from16 v19, v11

    .line 176
    invoke-virtual/range {v12 .. v19}, Lcom/lge/internal/telephony/ISmsEx$Stub;->sendMultipartTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V

    .line 177
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 178
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 182
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v6    # "_arg1":Ljava/lang/String;
    .end local v7    # "_arg2":Ljava/lang/String;
    .end local v11    # "_arg6":Ljava/lang/String;
    .end local v16    # "_arg3":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v17    # "_arg4":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .end local v18    # "_arg5":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    :sswitch_a
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 184
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 186
    .local v5, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v6

    .line 188
    .local v6, "_arg1":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v7

    .line 190
    .local v7, "_arg2":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .line 191
    .local v8, "_arg3":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6, v7, v8}, Lcom/lge/internal/telephony/ISmsEx$Stub;->copySmsToIccEfPrivate(I[B[BI)I

    move-result v31

    .line 192
    .restart local v31    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 193
    move-object/from16 v0, p3

    move/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 194
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 198
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":[B
    .end local v7    # "_arg2":[B
    .end local v8    # "_arg3":I
    .end local v31    # "_result":I
    :sswitch_b
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 200
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 201
    .restart local v5    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setUiccType(I)V

    .line 202
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 203
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 207
    .end local v5    # "_arg0":I
    :sswitch_c
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 208
    invoke-virtual/range {p0 .. p0}, Lcom/lge/internal/telephony/ISmsEx$Stub;->getUiccType()I

    move-result v31

    .line 209
    .restart local v31    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 210
    move-object/from16 v0, p3

    move/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 211
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 215
    .end local v31    # "_result":I
    :sswitch_d
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 217
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 219
    .restart local v5    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 221
    .local v6, "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v7

    .line 223
    .restart local v7    # "_arg2":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .line 224
    .restart local v8    # "_arg3":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6, v7, v8}, Lcom/lge/internal/telephony/ISmsEx$Stub;->updateMessageOnIccEfMultiMode(II[BI)Z

    move-result v31

    .line 225
    .local v31, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 226
    if-eqz v31, :cond_5

    const/4 v4, 0x1

    :goto_6
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 227
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 226
    :cond_5
    const/4 v4, 0x0

    goto :goto_6

    .line 231
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":I
    .end local v7    # "_arg2":[B
    .end local v8    # "_arg3":I
    .end local v31    # "_result":Z
    :sswitch_e
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 233
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 235
    .local v5, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 237
    .local v6, "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 239
    .local v7, "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .line 241
    .local v8, "_arg3":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_6

    .line 242
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/app/PendingIntent;

    .line 248
    .restart local v9    # "_arg4":Landroid/app/PendingIntent;
    :goto_7
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_7

    .line 249
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/app/PendingIntent;

    .restart local v10    # "_arg5":Landroid/app/PendingIntent;
    :goto_8
    move-object/from16 v4, p0

    .line 254
    invoke-virtual/range {v4 .. v10}, Lcom/lge/internal/telephony/ISmsEx$Stub;->sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 255
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 256
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 245
    .end local v9    # "_arg4":Landroid/app/PendingIntent;
    .end local v10    # "_arg5":Landroid/app/PendingIntent;
    :cond_6
    const/4 v9, 0x0

    .restart local v9    # "_arg4":Landroid/app/PendingIntent;
    goto :goto_7

    .line 252
    :cond_7
    const/4 v10, 0x0

    .restart local v10    # "_arg5":Landroid/app/PendingIntent;
    goto :goto_8

    .line 260
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v6    # "_arg1":Ljava/lang/String;
    .end local v7    # "_arg2":Ljava/lang/String;
    .end local v8    # "_arg3":Ljava/lang/String;
    .end local v9    # "_arg4":Landroid/app/PendingIntent;
    .end local v10    # "_arg5":Landroid/app/PendingIntent;
    :sswitch_f
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 262
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 264
    .restart local v5    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 266
    .restart local v6    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 268
    .restart local v7    # "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;

    move-result-object v16

    .line 270
    .restart local v16    # "_arg3":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v17

    .line 272
    .restart local v17    # "_arg4":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v18

    .restart local v18    # "_arg5":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    move-object/from16 v12, p0

    move-object v13, v5

    move-object v14, v6

    move-object v15, v7

    .line 273
    invoke-virtual/range {v12 .. v18}, Lcom/lge/internal/telephony/ISmsEx$Stub;->sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;)V

    .line 274
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 275
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 279
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v6    # "_arg1":Ljava/lang/String;
    .end local v7    # "_arg2":Ljava/lang/String;
    .end local v16    # "_arg3":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v17    # "_arg4":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .end local v18    # "_arg5":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    :sswitch_10
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 281
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 283
    .restart local v5    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 285
    .restart local v6    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 287
    .restart local v7    # "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .line 289
    .restart local v8    # "_arg3":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_8

    .line 290
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/app/PendingIntent;

    .line 296
    .restart local v9    # "_arg4":Landroid/app/PendingIntent;
    :goto_9
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_9

    .line 297
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/app/PendingIntent;

    .line 303
    .restart local v10    # "_arg5":Landroid/app/PendingIntent;
    :goto_a
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v11

    .line 305
    .restart local v11    # "_arg6":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v12

    .line 307
    .local v12, "_arg7":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v13

    .line 309
    .local v13, "_arg8":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v14

    .line 311
    .local v14, "_arg9":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_a

    const/4 v15, 0x1

    .local v15, "_arg10":Z
    :goto_b
    move-object/from16 v4, p0

    .line 312
    invoke-virtual/range {v4 .. v15}, Lcom/lge/internal/telephony/ISmsEx$Stub;->sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V

    .line 313
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 314
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 293
    .end local v9    # "_arg4":Landroid/app/PendingIntent;
    .end local v10    # "_arg5":Landroid/app/PendingIntent;
    .end local v11    # "_arg6":Ljava/lang/String;
    .end local v12    # "_arg7":I
    .end local v13    # "_arg8":I
    .end local v14    # "_arg9":I
    .end local v15    # "_arg10":Z
    :cond_8
    const/4 v9, 0x0

    .restart local v9    # "_arg4":Landroid/app/PendingIntent;
    goto :goto_9

    .line 300
    :cond_9
    const/4 v10, 0x0

    .restart local v10    # "_arg5":Landroid/app/PendingIntent;
    goto :goto_a

    .line 311
    .restart local v11    # "_arg6":Ljava/lang/String;
    .restart local v12    # "_arg7":I
    .restart local v13    # "_arg8":I
    .restart local v14    # "_arg9":I
    :cond_a
    const/4 v15, 0x0

    goto :goto_b

    .line 318
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v6    # "_arg1":Ljava/lang/String;
    .end local v7    # "_arg2":Ljava/lang/String;
    .end local v8    # "_arg3":Ljava/lang/String;
    .end local v9    # "_arg4":Landroid/app/PendingIntent;
    .end local v10    # "_arg5":Landroid/app/PendingIntent;
    .end local v11    # "_arg6":Ljava/lang/String;
    .end local v12    # "_arg7":I
    .end local v13    # "_arg8":I
    .end local v14    # "_arg9":I
    :sswitch_11
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 320
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 322
    .restart local v5    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 324
    .restart local v6    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 326
    .restart local v7    # "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;

    move-result-object v16

    .line 328
    .restart local v16    # "_arg3":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v17

    .line 330
    .restart local v17    # "_arg4":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    sget-object v4, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v18

    .line 332
    .restart local v18    # "_arg5":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v11

    .line 334
    .restart local v11    # "_arg6":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v12

    .line 336
    .restart local v12    # "_arg7":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v13

    .line 338
    .restart local v13    # "_arg8":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v14

    .line 340
    .restart local v14    # "_arg9":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_b

    const/4 v15, 0x1

    .restart local v15    # "_arg10":Z
    :goto_c
    move-object/from16 v19, p0

    move-object/from16 v20, v5

    move-object/from16 v21, v6

    move-object/from16 v22, v7

    move-object/from16 v23, v16

    move-object/from16 v24, v17

    move-object/from16 v25, v18

    move-object/from16 v26, v11

    move/from16 v27, v12

    move/from16 v28, v13

    move/from16 v29, v14

    move/from16 v30, v15

    .line 341
    invoke-virtual/range {v19 .. v30}, Lcom/lge/internal/telephony/ISmsEx$Stub;->sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;IIIZ)V

    .line 342
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 343
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 340
    .end local v15    # "_arg10":Z
    :cond_b
    const/4 v15, 0x0

    goto :goto_c

    .line 347
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v6    # "_arg1":Ljava/lang/String;
    .end local v7    # "_arg2":Ljava/lang/String;
    .end local v11    # "_arg6":Ljava/lang/String;
    .end local v12    # "_arg7":I
    .end local v13    # "_arg8":I
    .end local v14    # "_arg9":I
    .end local v16    # "_arg3":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v17    # "_arg4":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .end local v18    # "_arg5":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    :sswitch_12
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 349
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 350
    .local v5, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->enableAutoDCDisconnect(I)V

    .line 351
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 352
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 356
    .end local v5    # "_arg0":I
    :sswitch_13
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 357
    invoke-virtual/range {p0 .. p0}, Lcom/lge/internal/telephony/ISmsEx$Stub;->isFdnEnabled()Z

    move-result v31

    .line 358
    .restart local v31    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 359
    if-eqz v31, :cond_c

    const/4 v4, 0x1

    :goto_d
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 360
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 359
    :cond_c
    const/4 v4, 0x0

    goto :goto_d

    .line 364
    .end local v31    # "_result":Z
    :sswitch_14
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 366
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_d

    const/4 v5, 0x1

    .line 367
    .local v5, "_arg0":Z
    :goto_e
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setSmsIsRoaming(Z)V

    .line 368
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 369
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 366
    .end local v5    # "_arg0":Z
    :cond_d
    const/4 v5, 0x0

    goto :goto_e

    .line 373
    :sswitch_15
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 375
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_e

    .line 376
    sget-object v4, Landroid/net/Uri;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/Uri;

    .line 382
    .local v5, "_arg0":Landroid/net/Uri;
    :goto_f
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_f

    .line 383
    sget-object v4, Landroid/content/ContentValues;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v4, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/content/ContentValues;

    .line 388
    .local v6, "_arg1":Landroid/content/ContentValues;
    :goto_10
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6}, Lcom/lge/internal/telephony/ISmsEx$Stub;->insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v31

    .line 389
    .local v31, "_result":Landroid/net/Uri;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 390
    if-eqz v31, :cond_10

    .line 391
    const/4 v4, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 392
    const/4 v4, 0x1

    move-object/from16 v0, v31

    move-object/from16 v1, p3

    invoke-virtual {v0, v1, v4}, Landroid/net/Uri;->writeToParcel(Landroid/os/Parcel;I)V

    .line 397
    :goto_11
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 379
    .end local v5    # "_arg0":Landroid/net/Uri;
    .end local v6    # "_arg1":Landroid/content/ContentValues;
    .end local v31    # "_result":Landroid/net/Uri;
    :cond_e
    const/4 v5, 0x0

    .restart local v5    # "_arg0":Landroid/net/Uri;
    goto :goto_f

    .line 386
    :cond_f
    const/4 v6, 0x0

    .restart local v6    # "_arg1":Landroid/content/ContentValues;
    goto :goto_10

    .line 395
    .restart local v31    # "_result":Landroid/net/Uri;
    :cond_10
    const/4 v4, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_11

    .line 401
    .end local v5    # "_arg0":Landroid/net/Uri;
    .end local v6    # "_arg1":Landroid/content/ContentValues;
    .end local v31    # "_result":Landroid/net/Uri;
    :sswitch_16
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 403
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 404
    .local v5, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/internal/telephony/ISmsEx$Stub;->smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z

    move-result v31

    .line 405
    .local v31, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 406
    if-eqz v31, :cond_11

    const/4 v4, 0x1

    :goto_12
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 407
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 406
    :cond_11
    const/4 v4, 0x0

    goto :goto_12

    .line 411
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v31    # "_result":Z
    :sswitch_17
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 413
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 415
    .local v5, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 416
    .local v6, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6}, Lcom/lge/internal/telephony/ISmsEx$Stub;->enableGsmBroadcastRange(II)Z

    move-result v31

    .line 417
    .restart local v31    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 418
    if-eqz v31, :cond_12

    const/4 v4, 0x1

    :goto_13
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 419
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 418
    :cond_12
    const/4 v4, 0x0

    goto :goto_13

    .line 423
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":I
    .end local v31    # "_result":Z
    :sswitch_18
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 425
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 427
    .restart local v5    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 428
    .restart local v6    # "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v6}, Lcom/lge/internal/telephony/ISmsEx$Stub;->disableGsmBroadcastRange(II)Z

    move-result v31

    .line 429
    .restart local v31    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 430
    if-eqz v31, :cond_13

    const/4 v4, 0x1

    :goto_14
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 431
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 430
    :cond_13
    const/4 v4, 0x0

    goto :goto_14

    .line 435
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":I
    .end local v31    # "_result":Z
    :sswitch_19
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 437
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 439
    .restart local v5    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v6

    .line 441
    .local v6, "_arg1":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v7

    .line 443
    .local v7, "_arg2":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v24

    .local v24, "_arg3":J
    move-object/from16 v20, p0

    move/from16 v21, v5

    move-object/from16 v22, v6

    move-object/from16 v23, v7

    .line 444
    invoke-virtual/range {v20 .. v25}, Lcom/lge/internal/telephony/ISmsEx$Stub;->copySmsToIccEfForSubscriber(I[B[BJ)I

    move-result v31

    .line 445
    .local v31, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 446
    move-object/from16 v0, p3

    move/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 447
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 451
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":[B
    .end local v7    # "_arg2":[B
    .end local v24    # "_arg3":J
    .end local v31    # "_result":I
    :sswitch_1a
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 453
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v32

    .line 454
    .local v32, "_arg0":J
    move-object/from16 v0, p0

    move-wide/from16 v1, v32

    invoke-virtual {v0, v1, v2}, Lcom/lge/internal/telephony/ISmsEx$Stub;->getMaxEfSmsForSubscriber(J)I

    move-result v31

    .line 455
    .restart local v31    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 456
    move-object/from16 v0, p3

    move/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 457
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 461
    .end local v31    # "_result":I
    .end local v32    # "_arg0":J
    :sswitch_1b
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 463
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 465
    .restart local v5    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-eqz v4, :cond_14

    const/4 v6, 0x1

    .line 467
    .local v6, "_arg1":Z
    :goto_15
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v36

    .line 468
    .local v36, "_arg2":J
    move-object/from16 v0, p0

    move-wide/from16 v1, v36

    invoke-virtual {v0, v5, v6, v1, v2}, Lcom/lge/internal/telephony/ISmsEx$Stub;->updateSmsOnSimReadStatusForSubscriber(IZJ)Z

    move-result v31

    .line 469
    .local v31, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 470
    if-eqz v31, :cond_15

    const/4 v4, 0x1

    :goto_16
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 471
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 465
    .end local v6    # "_arg1":Z
    .end local v31    # "_result":Z
    .end local v36    # "_arg2":J
    :cond_14
    const/4 v6, 0x0

    goto :goto_15

    .line 470
    .restart local v6    # "_arg1":Z
    .restart local v31    # "_result":Z
    .restart local v36    # "_arg2":J
    :cond_15
    const/4 v4, 0x0

    goto :goto_16

    .line 475
    .end local v5    # "_arg0":I
    .end local v6    # "_arg1":Z
    .end local v31    # "_result":Z
    .end local v36    # "_arg2":J
    :sswitch_1c
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 477
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v32

    .line 478
    .restart local v32    # "_arg0":J
    move-object/from16 v0, p0

    move-wide/from16 v1, v32

    invoke-virtual {v0, v1, v2}, Lcom/lge/internal/telephony/ISmsEx$Stub;->getSmscenterAddressForSubscriber(J)Ljava/lang/String;

    move-result-object v31

    .line 479
    .local v31, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 480
    move-object/from16 v0, p3

    move-object/from16 v1, v31

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 481
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 485
    .end local v31    # "_result":Ljava/lang/String;
    .end local v32    # "_arg0":J
    :sswitch_1d
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 487
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 489
    .local v5, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v34

    .line 490
    .local v34, "_arg1":J
    move-object/from16 v0, p0

    move-wide/from16 v1, v34

    invoke-virtual {v0, v5, v1, v2}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setSmscenterAddressForSubscriber(Ljava/lang/String;J)Z

    move-result v31

    .line 491
    .local v31, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 492
    if-eqz v31, :cond_16

    const/4 v4, 0x1

    :goto_17
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 493
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 492
    :cond_16
    const/4 v4, 0x0

    goto :goto_17

    .line 497
    .end local v5    # "_arg0":Ljava/lang/String;
    .end local v31    # "_result":Z
    .end local v34    # "_arg1":J
    :sswitch_1e
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 499
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v32

    .line 500
    .restart local v32    # "_arg0":J
    move-object/from16 v0, p0

    move-wide/from16 v1, v32

    invoke-virtual {v0, v1, v2}, Lcom/lge/internal/telephony/ISmsEx$Stub;->isFdnEnabledOnSubscription(J)Z

    move-result v31

    .line 501
    .restart local v31    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 502
    if-eqz v31, :cond_17

    const/4 v4, 0x1

    :goto_18
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 503
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 502
    :cond_17
    const/4 v4, 0x0

    goto :goto_18

    .line 507
    .end local v31    # "_result":Z
    .end local v32    # "_arg0":J
    :sswitch_1f
    const-string v4, "com.lge.internal.telephony.ISmsEx"

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 509
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 511
    .local v5, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v34

    .line 512
    .restart local v34    # "_arg1":J
    move-object/from16 v0, p0

    move-wide/from16 v1, v34

    invoke-virtual {v0, v5, v1, v2}, Lcom/lge/internal/telephony/ISmsEx$Stub;->setMultipartTextValidityPeriodForSubscriber(IJ)V

    .line 513
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 514
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 51
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
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
