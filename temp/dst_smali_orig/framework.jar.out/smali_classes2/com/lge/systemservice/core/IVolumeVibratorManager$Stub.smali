.class public abstract Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;
.super Landroid/os/Binder;
.source "IVolumeVibratorManager.java"

# interfaces
.implements Lcom/lge/systemservice/core/IVolumeVibratorManager;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/IVolumeVibratorManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.systemservice.core.IVolumeVibratorManager"

.field static final TRANSACTION_cancelVibrate:I = 0x5

.field static final TRANSACTION_getCurrentVibratorVolume:I = 0xa

.field static final TRANSACTION_getVibrateVolume:I = 0x7

.field static final TRANSACTION_getVibrateVolumeType:I = 0x9

.field static final TRANSACTION_onCancel:I = 0x2

.field static final TRANSACTION_onVibratorExcuted:I = 0x1

.field static final TRANSACTION_setVibrateMute:I = 0xb

.field static final TRANSACTION_setVibrateVolume:I = 0x6

.field static final TRANSACTION_setVibrateVolumeType:I = 0x8

.field static final TRANSACTION_vibrate:I = 0x3

.field static final TRANSACTION_vibratePattern:I = 0x4


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "com.lge.systemservice.core.IVolumeVibratorManager"

    invoke-virtual {p0, p0, v0}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IVolumeVibratorManager;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "com.lge.systemservice.core.IVolumeVibratorManager"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/systemservice/core/IVolumeVibratorManager;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/systemservice/core/IVolumeVibratorManager;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 19
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
    sparse-switch p1, :sswitch_data_0

    invoke-super/range {p0 .. p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v3

    :goto_0
    return v3

    :sswitch_0
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p3

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    const/4 v3, 0x1

    goto :goto_0

    :sswitch_1
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->onVibratorExcuted(I)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto :goto_0

    .end local v4    # "_arg0":I
    :sswitch_2
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->onCancel()V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto :goto_0

    :sswitch_3
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .restart local v4    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .local v5, "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v6

    .local v6, "_arg2":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .local v8, "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v9

    .local v9, "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v10

    .local v10, "_arg5":Landroid/os/IBinder;
    move-object/from16 v3, p0

    invoke-virtual/range {v3 .. v10}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->vibrate(ILjava/lang/String;JIILandroid/os/IBinder;)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto :goto_0

    .end local v4    # "_arg0":I
    .end local v5    # "_arg1":Ljava/lang/String;
    .end local v6    # "_arg2":J
    .end local v8    # "_arg3":I
    .end local v9    # "_arg4":I
    .end local v10    # "_arg5":Landroid/os/IBinder;
    :sswitch_4
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .restart local v4    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .restart local v5    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createLongArray()[J

    move-result-object v6

    .local v6, "_arg2":[J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .restart local v8    # "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v9

    .local v9, "_arg4":[I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v10

    .local v10, "_arg5":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v18

    .local v18, "_arg6":Landroid/os/IBinder;
    move-object/from16 v11, p0

    move v12, v4

    move-object v13, v5

    move-object v14, v6

    move v15, v8

    move-object/from16 v16, v9

    move/from16 v17, v10

    invoke-virtual/range {v11 .. v18}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->vibratePattern(ILjava/lang/String;[JI[IILandroid/os/IBinder;)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v4    # "_arg0":I
    .end local v5    # "_arg1":Ljava/lang/String;
    .end local v6    # "_arg2":[J
    .end local v8    # "_arg3":I
    .end local v9    # "_arg4":[I
    .end local v10    # "_arg5":I
    .end local v18    # "_arg6":Landroid/os/IBinder;
    :sswitch_5
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v4

    .local v4, "_arg0":Landroid/os/IBinder;
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->cancelVibrate(Landroid/os/IBinder;)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v4    # "_arg0":Landroid/os/IBinder;
    :sswitch_6
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->setVibrateVolume(I)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v4    # "_arg0":I
    :sswitch_7
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->getVibrateVolume()I

    move-result v2

    .local v2, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v2    # "_result":I
    :sswitch_8
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .restart local v4    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .local v5, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->setVibrateVolumeType(II)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v4    # "_arg0":I
    .end local v5    # "_arg1":I
    :sswitch_9
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .restart local v4    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->getVibrateVolumeType(I)I

    move-result v2

    .restart local v2    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v2    # "_result":I
    .end local v4    # "_arg0":I
    :sswitch_a
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .restart local v4    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->getCurrentVibratorVolume(I)I

    move-result v2

    .restart local v2    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v2    # "_result":I
    .end local v4    # "_arg0":I
    :sswitch_b
    const-string v3, "com.lge.systemservice.core.IVolumeVibratorManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    if-eqz v3, :cond_0

    const/4 v4, 0x1

    .local v4, "_arg0":Z
    :goto_1
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .local v5, "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v6

    .local v6, "_arg2":Landroid/os/IBinder;
    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5, v6}, Lcom/lge/systemservice/core/IVolumeVibratorManager$Stub;->setVibrateMute(ZLjava/lang/String;Landroid/os/IBinder;)V

    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    const/4 v3, 0x1

    goto/16 :goto_0

    .end local v4    # "_arg0":Z
    .end local v5    # "_arg1":Ljava/lang/String;
    .end local v6    # "_arg2":Landroid/os/IBinder;
    :cond_0
    const/4 v4, 0x0

    goto :goto_1

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
        0xa -> :sswitch_a
        0xb -> :sswitch_b
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
