.class public abstract Lcom/lge/internal/telephony/ITelephonyEx$Stub;
.super Landroid/os/Binder;
.source "ITelephonyEx.java"

# interfaces
.implements Lcom/lge/internal/telephony/ITelephonyEx;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/telephony/ITelephonyEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/internal/telephony/ITelephonyEx$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.internal.telephony.ITelephony"

.field static final TRANSACTION_calculateAkaResponse:I = 0x272e

.field static final TRANSACTION_calculateGbaBootstrappingResponse:I = 0x272f

.field static final TRANSACTION_calculateNafExternalKey:I = 0x2730

.field static final TRANSACTION_checkDataProfileEx:I = 0x272b

.field static final TRANSACTION_clearDataDisabledFlag:I = 0x2713

.field static final TRANSACTION_endAllCall:I = 0x2718

.field static final TRANSACTION_getAPNList:I = 0x272d

.field static final TRANSACTION_getCurrentLine:I = 0x2716

.field static final TRANSACTION_getDebugInfo:I = 0x272a

.field static final TRANSACTION_getIccFdnEnabled:I = 0x2710

.field static final TRANSACTION_getMipErrorCode:I = 0x272c

.field static final TRANSACTION_getMobileQualityInformation:I = 0x2728

.field static final TRANSACTION_getRoamingCountryUpdate:I = 0x271d

.field static final TRANSACTION_handleDataInterface:I = 0x2729

.field static final TRANSACTION_isBluetoothAudioOn:I = 0x271b

.field static final TRANSACTION_isDialingOrRinging:I = 0x2719

.field static final TRANSACTION_isHeadsetPlugged:I = 0x271a

.field static final TRANSACTION_isReservedCall:I = 0x2714

.field static final TRANSACTION_isSKTPhone20RelaxationRingingMode:I = 0x2742

.field static final TRANSACTION_isTwoLineSupported:I = 0x2717

.field static final TRANSACTION_mocaAlarmEvent:I = 0x273b

.field static final TRANSACTION_mocaAlarmEventReg:I = 0x273c

.field static final TRANSACTION_mocaCheckMem:I = 0x2741

.field static final TRANSACTION_mocaGetData:I = 0x273d

.field static final TRANSACTION_mocaGetMisc:I = 0x273f

.field static final TRANSACTION_mocaGetRFParameter:I = 0x273e

.field static final TRANSACTION_mocaSetEvent:I = 0x273a

.field static final TRANSACTION_mocaSetLog:I = 0x2739

.field static final TRANSACTION_mocaSetMem:I = 0x2740

.field static final TRANSACTION_oemSsaAlarmEvent:I = 0x2734

.field static final TRANSACTION_oemSsaCheckMem:I = 0x2738

.field static final TRANSACTION_oemSsaGetData:I = 0x2736

.field static final TRANSACTION_oemSsaHdvAlarmEvent:I = 0x2735

.field static final TRANSACTION_oemSsaSetEvent:I = 0x2733

.field static final TRANSACTION_oemSsaSetLog:I = 0x2732

.field static final TRANSACTION_oemSsaSetMem:I = 0x2737

.field static final TRANSACTION_releaseRoamingCountryUpdate:I = 0x271e

.field static final TRANSACTION_resetVoiceMessageCount:I = 0x2711

.field static final TRANSACTION_setDataDisabledFlag:I = 0x2712

.field static final TRANSACTION_setGbaBootstrappingParams:I = 0x2731

.field static final TRANSACTION_setRoamingCountryUpdate:I = 0x271c

.field static final TRANSACTION_startMobileQualityInformation:I = 0x2726

.field static final TRANSACTION_startRoamingCountryUpdate:I = 0x271f

.field static final TRANSACTION_stopMobileQualityInformation:I = 0x2727

.field static final TRANSACTION_toggleCurrentLine:I = 0x2715

.field static final TRANSACTION_uknightEventSet:I = 0x2721

.field static final TRANSACTION_uknightGetData:I = 0x2724

.field static final TRANSACTION_uknightLogSet:I = 0x2720

.field static final TRANSACTION_uknightMemCheck:I = 0x2725

.field static final TRANSACTION_uknightMemSet:I = 0x2723

.field static final TRANSACTION_uknightStateChangeSet:I = 0x2722


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "android.internal.telephony.ITelephony"

    invoke-virtual {p0, p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "android.internal.telephony.ITelephony"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/internal/telephony/ITelephonyEx;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/internal/telephony/ITelephonyEx;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/internal/telephony/ITelephonyEx$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/internal/telephony/ITelephonyEx$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method

.method public static onTransact(Lcom/lge/internal/telephony/ITelephonyEx;ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 7
    .param p0, "server"    # Lcom/lge/internal/telephony/ITelephonyEx;
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

    const/4 v5, 0x1

    sparse-switch p1, :sswitch_data_0

    move v5, v4

    :goto_0
    return v5

    :sswitch_0
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->getIccFdnEnabled()Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_0

    move v4, v5

    :cond_0
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v3    # "_result":Z
    :sswitch_2
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->resetVoiceMessageCount()V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    :sswitch_3
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "_arg1":I
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->setDataDisabledFlag(II)I

    move-result v3

    .local v3, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":I
    .end local v3    # "_result":I
    :sswitch_4
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->clearDataDisabledFlag(I)I

    move-result v3

    .restart local v3    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":I
    :sswitch_5
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->isReservedCall()Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_1

    move v4, v5

    :cond_1
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v3    # "_result":Z
    :sswitch_6
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->toggleCurrentLine()I

    move-result v3

    .local v3, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .end local v3    # "_result":I
    :sswitch_7
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->getCurrentLine()I

    move-result v3

    .restart local v3    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":I
    :sswitch_8
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->isTwoLineSupported()Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_2

    move v4, v5

    :cond_2
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":Z
    :sswitch_9
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->endAllCall()Z

    move-result v3

    .restart local v3    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_3

    move v4, v5

    :cond_3
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":Z
    :sswitch_a
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->isDialingOrRinging()Z

    move-result v3

    .restart local v3    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_4

    move v4, v5

    :cond_4
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":Z
    :sswitch_b
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->isHeadsetPlugged()Z

    move-result v3

    .restart local v3    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_5

    move v4, v5

    :cond_5
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":Z
    :sswitch_c
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->isBluetoothAudioOn()Z

    move-result v3

    .restart local v3    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_6

    move v4, v5

    :cond_6
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":Z
    :sswitch_d
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    if-eqz v6, :cond_7

    move v0, v5

    .local v0, "_arg0":Z
    :goto_1
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->setRoamingCountryUpdate(Z)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Z
    :cond_7
    move v0, v4

    goto :goto_1

    :sswitch_e
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->getRoamingCountryUpdate()Z

    move-result v3

    .restart local v3    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_8

    move v4, v5

    :cond_8
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":Z
    :sswitch_f
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->releaseRoamingCountryUpdate()V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    :sswitch_10
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .local v0, "_arg0":Ljava/lang/String;
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->startRoamingCountryUpdate(Ljava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_11
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .local v0, "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightLogSet([B)[B

    move-result-object v3

    .local v3, "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_12
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightEventSet([B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_13
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightStateChangeSet(I)Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_9

    move v4, v5

    :cond_9
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Z
    :sswitch_14
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightMemSet(I)Z

    move-result v3

    .restart local v3    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_a

    move v4, v5

    :cond_a
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Z
    :sswitch_15
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v3

    .local v3, "_result":Lcom/lge/internal/telephony/KNDataResponse;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_b

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Lcom/lge/internal/telephony/KNDataResponse;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_b
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Lcom/lge/internal/telephony/KNDataResponse;
    :sswitch_16
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightMemCheck()[I

    move-result-object v3

    .local v3, "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .end local v3    # "_result":[I
    :sswitch_17
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->startMobileQualityInformation()V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    :sswitch_18
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->stopMobileQualityInformation()V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    :sswitch_19
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->getMobileQualityInformation()Ljava/util/Map;

    move-result-object v3

    .local v3, "_result":Ljava/util/Map;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeMap(Ljava/util/Map;)V

    goto/16 :goto_0

    .end local v3    # "_result":Ljava/util/Map;
    :sswitch_1a
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .local v0, "_arg0":Ljava/lang/String;
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I

    move-result v3

    .local v3, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v3    # "_result":I
    :sswitch_1b
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg1":I
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->getDebugInfo(II)[I

    move-result-object v3

    .local v3, "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":I
    .end local v3    # "_result":[I
    :sswitch_1c
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg1":I
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->checkDataProfileEx(II)Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_c

    move v4, v5

    :cond_c
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":I
    .end local v3    # "_result":Z
    :sswitch_1d
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->getMipErrorCode()I

    move-result v3

    .local v3, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v3    # "_result":I
    :sswitch_1e
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->getAPNList()Ljava/lang/String;

    move-result-object v3

    .local v3, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v3    # "_result":Ljava/lang/String;
    :sswitch_1f
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .local v0, "_arg0":[B
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v1

    .local v1, "_arg1":[B
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->calculateAkaResponse([B[B)Landroid/os/Bundle;

    move-result-object v3

    .local v3, "_result":Landroid/os/Bundle;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_d

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Landroid/os/Bundle;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_d
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v1    # "_arg1":[B
    .end local v3    # "_result":Landroid/os/Bundle;
    :sswitch_20
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v1

    .restart local v1    # "_arg1":[B
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->calculateGbaBootstrappingResponse([B[B)Landroid/os/Bundle;

    move-result-object v3

    .restart local v3    # "_result":Landroid/os/Bundle;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_e

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Landroid/os/Bundle;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_e
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v1    # "_arg1":[B
    .end local v3    # "_result":Landroid/os/Bundle;
    :sswitch_21
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->calculateNafExternalKey([B)[B

    move-result-object v3

    .local v3, "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_22
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .local v1, "_arg1":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .local v2, "_arg2":Ljava/lang/String;
    invoke-interface {p0, v0, v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->setGbaBootstrappingParams([BLjava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v1    # "_arg1":Ljava/lang/String;
    .end local v2    # "_arg2":Ljava/lang/String;
    :sswitch_23
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v1

    .local v1, "_arg1":[B
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetLog([B[B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v1    # "_arg1":[B
    .end local v3    # "_result":[B
    :sswitch_24
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetEvent([B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_25
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaAlarmEvent([B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_26
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaHdvAlarmEvent([B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_27
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v3

    .local v3, "_result":Lcom/lge/internal/telephony/OEMSSADataResponse;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_f

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Lcom/lge/internal/telephony/OEMSSADataResponse;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_f
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Lcom/lge/internal/telephony/OEMSSADataResponse;
    :sswitch_28
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetMem(I)Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_10

    move v4, v5

    :cond_10
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Z
    :sswitch_29
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaCheckMem()[I

    move-result-object v3

    .local v3, "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .end local v3    # "_result":[I
    :sswitch_2a
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .local v0, "_arg0":[B
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v1

    .restart local v1    # "_arg1":[B
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetLog([B[B)[B

    move-result-object v3

    .local v3, "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v1    # "_arg1":[B
    .end local v3    # "_result":[B
    :sswitch_2b
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetEvent([B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_2c
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .restart local v0    # "_arg0":[B
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEvent([B)[B

    move-result-object v3

    .restart local v3    # "_result":[B
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .end local v0    # "_arg0":[B
    .end local v3    # "_result":[B
    :sswitch_2d
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEventReg(I)Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_11

    move v4, v5

    :cond_11
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Z
    :sswitch_2e
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v3

    .local v3, "_result":Lcom/lge/internal/telephony/MOCADataResponse;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_12

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Lcom/lge/internal/telephony/MOCADataResponse;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_12
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Lcom/lge/internal/telephony/MOCADataResponse;
    :sswitch_2f
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "_arg1":I
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v3

    .local v3, "_result":Lcom/lge/internal/telephony/MOCARFParameterResponse;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_13

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Lcom/lge/internal/telephony/MOCARFParameterResponse;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_13
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":I
    .end local v3    # "_result":Lcom/lge/internal/telephony/MOCARFParameterResponse;
    :sswitch_30
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .restart local v1    # "_arg1":I
    invoke-interface {p0, v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v3

    .local v3, "_result":Lcom/lge/internal/telephony/MOCAMiscResponse;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_14

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3, p3, v5}, Lcom/lge/internal/telephony/MOCAMiscResponse;->writeToParcel(Landroid/os/Parcel;I)V

    goto/16 :goto_0

    :cond_14
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v1    # "_arg1":I
    .end local v3    # "_result":Lcom/lge/internal/telephony/MOCAMiscResponse;
    :sswitch_31
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .restart local v0    # "_arg0":I
    invoke-interface {p0, v0}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetMem(I)Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_15

    move v4, v5

    :cond_15
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .end local v0    # "_arg0":I
    .end local v3    # "_result":Z
    :sswitch_32
    const-string v4, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v4}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaCheckMem()[I

    move-result-object v3

    .local v3, "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .end local v3    # "_result":[I
    :sswitch_33
    const-string v6, "android.internal.telephony.ITelephony"

    invoke-virtual {p2, v6}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-interface {p0}, Lcom/lge/internal/telephony/ITelephonyEx;->isSKTPhone20RelaxationRingingMode()Z

    move-result v3

    .local v3, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v3, :cond_16

    move v4, v5

    :cond_16
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

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
        0x271d -> :sswitch_e
        0x271e -> :sswitch_f
        0x271f -> :sswitch_10
        0x2720 -> :sswitch_11
        0x2721 -> :sswitch_12
        0x2722 -> :sswitch_13
        0x2723 -> :sswitch_14
        0x2724 -> :sswitch_15
        0x2725 -> :sswitch_16
        0x2726 -> :sswitch_17
        0x2727 -> :sswitch_18
        0x2728 -> :sswitch_19
        0x2729 -> :sswitch_1a
        0x272a -> :sswitch_1b
        0x272b -> :sswitch_1c
        0x272c -> :sswitch_1d
        0x272d -> :sswitch_1e
        0x272e -> :sswitch_1f
        0x272f -> :sswitch_20
        0x2730 -> :sswitch_21
        0x2731 -> :sswitch_22
        0x2732 -> :sswitch_23
        0x2733 -> :sswitch_24
        0x2734 -> :sswitch_25
        0x2735 -> :sswitch_26
        0x2736 -> :sswitch_27
        0x2737 -> :sswitch_28
        0x2738 -> :sswitch_29
        0x2739 -> :sswitch_2a
        0x273a -> :sswitch_2b
        0x273b -> :sswitch_2c
        0x273c -> :sswitch_2d
        0x273d -> :sswitch_2e
        0x273e -> :sswitch_2f
        0x273f -> :sswitch_30
        0x2740 -> :sswitch_31
        0x2741 -> :sswitch_32
        0x2742 -> :sswitch_33
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method
