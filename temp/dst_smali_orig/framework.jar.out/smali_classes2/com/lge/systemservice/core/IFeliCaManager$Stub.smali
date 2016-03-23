.class public abstract Lcom/lge/systemservice/core/IFeliCaManager$Stub;
.super Landroid/os/Binder;
.source "IFeliCaManager.java"

# interfaces
.implements Lcom/lge/systemservice/core/IFeliCaManager;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/IFeliCaManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/IFeliCaManager$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.systemservice.core.IFeliCaManager"

.field static final TRANSACTION_cmdEXTIDM:I = 0x1

.field static final TRANSACTION_cmdFreqCalRange:I = 0x9

.field static final TRANSACTION_cmdFreqCalRead:I = 0x8

.field static final TRANSACTION_cmdFreqCalWrite:I = 0x7

.field static final TRANSACTION_cmdIDM:I = 0x2

.field static final TRANSACTION_cmdRFIDCK:I = 0x3

.field static final TRANSACTION_cmdRFRegCalCheck:I = 0xb

.field static final TRANSACTION_cmdRFRegCalLoad:I = 0xa

.field static final TRANSACTION_cmdSwitchRange:I = 0x4

.field static final TRANSACTION_cmdSwitchRead:I = 0x6

.field static final TRANSACTION_cmdSwitchWrite:I = 0x5


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p0, p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IFeliCaManager;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "com.lge.systemservice.core.IFeliCaManager"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/systemservice/core/IFeliCaManager;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/systemservice/core/IFeliCaManager;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/systemservice/core/IFeliCaManager$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

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
    const-string v3, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "_arg0_length":I
    if-gez v1, :cond_1

    const/4 v0, 0x0

    .local v0, "_arg0":[B
    :goto_1
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdEXTIDM([B)Z

    move-result v2

    .local v2, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_0

    move v3, v4

    :cond_0
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto :goto_0

    .end local v0    # "_arg0":[B
    .end local v2    # "_result":Z
    :cond_1
    new-array v0, v1, [B

    .restart local v0    # "_arg0":[B
    goto :goto_1

    .end local v0    # "_arg0":[B
    .end local v1    # "_arg0_length":I
    :sswitch_2
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg0_length":I
    if-gez v1, :cond_3

    const/4 v0, 0x0

    .local v0, "_arg0":[Ljava/lang/String;
    :goto_2
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdIDM([Ljava/lang/String;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_2

    move v3, v4

    :cond_2
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v2    # "_result":Z
    :cond_3
    new-array v0, v1, [Ljava/lang/String;

    .restart local v0    # "_arg0":[Ljava/lang/String;
    goto :goto_2

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v1    # "_arg0_length":I
    :sswitch_3
    const-string v3, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v3}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdRFIDCK()I

    move-result v2

    .local v2, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v2    # "_result":I
    :sswitch_4
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg0_length":I
    if-gez v1, :cond_5

    const/4 v0, 0x0

    .restart local v0    # "_arg0":[Ljava/lang/String;
    :goto_3
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdSwitchRange([Ljava/lang/String;)Z

    move-result v2

    .local v2, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_4

    move v3, v4

    :cond_4
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v2    # "_result":Z
    :cond_5
    new-array v0, v1, [Ljava/lang/String;

    .restart local v0    # "_arg0":[Ljava/lang/String;
    goto :goto_3

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v1    # "_arg0_length":I
    :sswitch_5
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdSwitchWrite(I)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_6

    move v3, v4

    :cond_6
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v2    # "_result":Z
    :sswitch_6
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg0_length":I
    if-gez v1, :cond_8

    const/4 v0, 0x0

    .local v0, "_arg0":[Ljava/lang/String;
    :goto_4
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdSwitchRead([Ljava/lang/String;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_7

    move v3, v4

    :cond_7
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v2    # "_result":Z
    :cond_8
    new-array v0, v1, [Ljava/lang/String;

    .restart local v0    # "_arg0":[Ljava/lang/String;
    goto :goto_4

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v1    # "_arg0_length":I
    :sswitch_7
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readFloat()F

    move-result v0

    .local v0, "_arg0":F
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdFreqCalWrite(F)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_9

    move v3, v4

    :cond_9
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":F
    .end local v2    # "_result":Z
    :sswitch_8
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg0_length":I
    if-gez v1, :cond_b

    const/4 v0, 0x0

    .local v0, "_arg0":[Ljava/lang/String;
    :goto_5
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdFreqCalRead([Ljava/lang/String;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_a

    move v3, v4

    :cond_a
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v2    # "_result":Z
    :cond_b
    new-array v0, v1, [Ljava/lang/String;

    .restart local v0    # "_arg0":[Ljava/lang/String;
    goto :goto_5

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v1    # "_arg0_length":I
    :sswitch_9
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg0_length":I
    if-gez v1, :cond_d

    const/4 v0, 0x0

    .restart local v0    # "_arg0":[Ljava/lang/String;
    :goto_6
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdFreqCalRange([Ljava/lang/String;)Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_c

    move v3, v4

    :cond_c
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v2    # "_result":Z
    :cond_d
    new-array v0, v1, [Ljava/lang/String;

    .restart local v0    # "_arg0":[Ljava/lang/String;
    goto :goto_6

    .end local v0    # "_arg0":[Ljava/lang/String;
    .end local v1    # "_arg0_length":I
    :sswitch_a
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdRFRegCalLoad()Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_e

    move v3, v4

    :cond_e
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v2    # "_result":Z
    :sswitch_b
    const-string v5, "com.lge.systemservice.core.IFeliCaManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->cmdRFRegCalCheck()Z

    move-result v2

    .restart local v2    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v2, :cond_f

    move v3, v4

    :cond_f
    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

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
