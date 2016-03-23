.class public abstract Lcom/lge/systemservice/core/IAATManager$Stub;
.super Landroid/os/Binder;
.source "IAATManager.java"

# interfaces
.implements Lcom/lge/systemservice/core/IAATManager;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/IAATManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/IAATManager$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.systemservice.core.IAATManager"

.field static final TRANSACTION_AATFinalize:I = 0x2

.field static final TRANSACTION_AATInitialize:I = 0x1

.field static final TRANSACTION_AATsetLCDOnOff:I = 0x35

.field static final TRANSACTION_FolderTest_GetDetailTestSupportValue:I = 0x3b

.field static final TRANSACTION_FolderTest_GetDimOnBacklightValue:I = 0x3d

.field static final TRANSACTION_FolderTest_GetFilePath:I = 0x3c

.field static final TRANSACTION_FolderTest_GetSupportedMenuList:I = 0x3a

.field static final TRANSACTION_GetUsbOnOffValue:I = 0x3f

.field static final TRANSACTION_IsFMRadio:I = 0x29

.field static final TRANSACTION_IsSupportAutoFocus:I = 0x37

.field static final TRANSACTION_IsSupportBarometer:I = 0x19

.field static final TRANSACTION_IsSupportGLOTestGps:I = 0x8

.field static final TRANSACTION_IsSupportHookKeyTest:I = 0x48

.field static final TRANSACTION_IsSupportInvalidAATSet:I = 0x57

.field static final TRANSACTION_IsSupportMura:I = 0x28

.field static final TRANSACTION_IsSupportProximityCalibration:I = 0x18

.field static final TRANSACTION_IsSupportShowInternalMemoryCapacity:I = 0x52

.field static final TRANSACTION_IsSupportSubMic:I = 0x38

.field static final TRANSACTION_IsSupportUSIM:I = 0x27

.field static final TRANSACTION_NFC_Disable:I = 0xc

.field static final TRANSACTION_NFC_Enable:I = 0xb

.field static final TRANSACTION_NFC_Off:I = 0xe

.field static final TRANSACTION_NFC_On:I = 0xd

.field static final TRANSACTION_NFC_Reader:I = 0x11

.field static final TRANSACTION_NFC_SmartMX:I = 0x10

.field static final TRANSACTION_NFC_Swp:I = 0xf

.field static final TRANSACTION_QwertyLedOff:I = 0x1c

.field static final TRANSACTION_QwertyLedOn:I = 0x1b

.field static final TRANSACTION_RebootforModeChange:I = 0x21

.field static final TRANSACTION_SetLoopbackParam:I = 0x6

.field static final TRANSACTION_Start_AccCalibration:I = 0x15

.field static final TRANSACTION_Start_GyroCalibration:I = 0x16

.field static final TRANSACTION_Start_ProximityCalibration:I = 0x17

.field static final TRANSACTION_Start_SmartFactoryReset:I = 0x20

.field static final TRANSACTION_ThresholdALC:I = 0x13

.field static final TRANSACTION_camcorder_submic:I = 0x12

.field static final TRANSACTION_createFmRadioMgrFMRadio:I = 0x2c

.field static final TRANSACTION_disableMTS:I = 0x54

.field static final TRANSACTION_disableOisProp:I = 0x4d

.field static final TRANSACTION_disableTouchPoint:I = 0x5a

.field static final TRANSACTION_enableMTS:I = 0x53

.field static final TRANSACTION_enableOisProp:I = 0x4c

.field static final TRANSACTION_enableTDMBTestActivity:I = 0x4f

.field static final TRANSACTION_enableTouchPoint:I = 0x59

.field static final TRANSACTION_felicacmdEXTIDM:I = 0x31

.field static final TRANSACTION_finalizeGps:I = 0xa

.field static final TRANSACTION_finalizeLoopback:I = 0x5

.field static final TRANSACTION_getAATSWversion:I = 0x49

.field static final TRANSACTION_getAccelCalSleep:I = 0x34

.field static final TRANSACTION_getAccelerometerCalOption:I = 0x33

.field static final TRANSACTION_getBatteryCapacityFilePath:I = 0x45

.field static final TRANSACTION_getBatteryIDFilePath:I = 0x46

.field static final TRANSACTION_getBatteryThermistorFilePath:I = 0x47

.field static final TRANSACTION_getCameraResolution:I = 0x1a

.field static final TRANSACTION_getCountSuppotedSIM:I = 0x23

.field static final TRANSACTION_getHallSensorResult:I = 0x43

.field static final TRANSACTION_getLedVal:I = 0x1f

.field static final TRANSACTION_getLimitBatteryCapacity:I = 0x50

.field static final TRANSACTION_getMaxVolume:I = 0x4b

.field static final TRANSACTION_getQuickMemoKeyCodeValue:I = 0x36

.field static final TRANSACTION_getQwertyStatusValue:I = 0x1d

.field static final TRANSACTION_getSaveVolume:I = 0x4a

.field static final TRANSACTION_getSupportVideoEncorder:I = 0x32

.field static final TRANSACTION_getTestOrderLength:I = 0x41

.field static final TRANSACTION_getTestOrderNumber:I = 0x40

.field static final TRANSACTION_initializeGps:I = 0x9

.field static final TRANSACTION_initializeLoopback:I = 0x4

.field static final TRANSACTION_isDualSIM:I = 0x22

.field static final TRANSACTION_isFactoryTestMode:I = 0x39

.field static final TRANSACTION_requestToCapSensor:I = 0x58

.field static final TRANSACTION_requestToService:I = 0x3

.field static final TRANSACTION_resetData:I = 0x42

.field static final TRANSACTION_sendAATStatus:I = 0x51

.field static final TRANSACTION_setBackLedVal:I = 0x55

.field static final TRANSACTION_setLedVal:I = 0x1e

.field static final TRANSACTION_setProximityCrossTalkValue:I = 0x4e

.field static final TRANSACTION_setRGBLedVal:I = 0x56

.field static final TRANSACTION_setRotationSensor:I = 0x14

.field static final TRANSACTION_setSpeakerState:I = 0x44

.field static final TRANSACTION_setSpeakerphoneOnUse:I = 0x7

.field static final TRANSACTION_startAutoScanFMRadio:I = 0x2d

.field static final TRANSACTION_startBackwardScanFMRadio:I = 0x2e

.field static final TRANSACTION_startForwardScanFMRadio:I = 0x2f

.field static final TRANSACTION_switchUSBMode:I = 0x3e

.field static final TRANSACTION_testDualUSIM1:I = 0x24

.field static final TRANSACTION_testDualUSIM2:I = 0x25

.field static final TRANSACTION_testDualUSIM3:I = 0x26

.field static final TRANSACTION_tuneFrequencyFMRadio:I = 0x30

.field static final TRANSACTION_turnOffFMRadio:I = 0x2b

.field static final TRANSACTION_turnOnFMRadio:I = 0x2a


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 15
    const-string v0, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p0, p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IAATManager;
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
    const-string v1, "com.lge.systemservice.core.IAATManager"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 27
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/systemservice/core/IAATManager;

    if-eqz v1, :cond_1

    .line 28
    check-cast v0, Lcom/lge/systemservice/core/IAATManager;

    goto :goto_0

    .line 30
    :cond_1
    new-instance v0, Lcom/lge/systemservice/core/IAATManager$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/IAATManager$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 34
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

    .line 38
    sparse-switch p1, :sswitch_data_0

    .line 815
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v6

    :goto_0
    return v6

    .line 42
    :sswitch_0
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 47
    :sswitch_1
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 48
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->AATInitialize()V

    .line 49
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 54
    :sswitch_2
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 55
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->AATFinalize()V

    .line 56
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 61
    :sswitch_3
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 63
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 65
    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 66
    .local v2, "_arg1":Ljava/lang/String;
    invoke-virtual {p0, v0, v2}, Lcom/lge/systemservice/core/IAATManager$Stub;->requestToService(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 67
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 68
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 73
    .end local v0    # "_arg0":I
    .end local v2    # "_arg1":Ljava/lang/String;
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_4
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 74
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->initializeLoopback()V

    .line 75
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 80
    :sswitch_5
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 81
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->finalizeLoopback()V

    .line 82
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    .line 87
    :sswitch_6
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 89
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 90
    .restart local v0    # "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->SetLoopbackParam(I)Ljava/lang/String;

    move-result-object v4

    .line 91
    .restart local v4    # "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 92
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    .line 97
    .end local v0    # "_arg0":I
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_7
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 98
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->setSpeakerphoneOnUse()Z

    move-result v4

    .line 99
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 100
    if-eqz v4, :cond_0

    move v5, v6

    :cond_0
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_0

    .line 105
    .end local v4    # "_result":Z
    :sswitch_8
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 106
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportGLOTestGps()Z

    move-result v4

    .line 107
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 108
    if-eqz v4, :cond_1

    move v5, v6

    :cond_1
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 113
    .end local v4    # "_result":Z
    :sswitch_9
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 114
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->initializeGps()V

    .line 115
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 120
    :sswitch_a
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 121
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->finalizeGps()V

    .line 122
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 127
    :sswitch_b
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 128
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_Enable()Z

    move-result v4

    .line 129
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 130
    if-eqz v4, :cond_2

    move v5, v6

    :cond_2
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 135
    .end local v4    # "_result":Z
    :sswitch_c
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 136
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_Disable()Z

    move-result v4

    .line 137
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 138
    if-eqz v4, :cond_3

    move v5, v6

    :cond_3
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 143
    .end local v4    # "_result":Z
    :sswitch_d
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 145
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .line 146
    .local v0, "_arg0":[B
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_On([B)I

    move-result v4

    .line 147
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 148
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 149
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 154
    .end local v0    # "_arg0":[B
    .end local v4    # "_result":I
    :sswitch_e
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 156
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .line 157
    .restart local v0    # "_arg0":[B
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_Off([B)I

    move-result v4

    .line 158
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 159
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 160
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 165
    .end local v0    # "_arg0":[B
    .end local v4    # "_result":I
    :sswitch_f
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 167
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .line 168
    .restart local v0    # "_arg0":[B
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_Swp([B)I

    move-result v4

    .line 169
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 170
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 171
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 176
    .end local v0    # "_arg0":[B
    .end local v4    # "_result":I
    :sswitch_10
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 178
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .line 179
    .restart local v0    # "_arg0":[B
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_SmartMX([B)I

    move-result v4

    .line 180
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 181
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 182
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 187
    .end local v0    # "_arg0":[B
    .end local v4    # "_result":I
    :sswitch_11
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 189
    invoke-virtual {p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v0

    .line 190
    .restart local v0    # "_arg0":[B
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->NFC_Reader([B)I

    move-result v4

    .line 191
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 192
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 193
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 198
    .end local v0    # "_arg0":[B
    .end local v4    # "_result":I
    :sswitch_12
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 200
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_4

    move v0, v6

    .line 201
    .local v0, "_arg0":Z
    :goto_1
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->camcorder_submic(Z)V

    .line 202
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Z
    :cond_4
    move v0, v5

    .line 200
    goto :goto_1

    .line 207
    :sswitch_13
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 208
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->ThresholdALC()F

    move-result v4

    .line 209
    .local v4, "_result":F
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 210
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeFloat(F)V

    goto/16 :goto_0

    .line 215
    .end local v4    # "_result":F
    :sswitch_14
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 217
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_5

    move v0, v6

    .line 218
    .restart local v0    # "_arg0":Z
    :goto_2
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->setRotationSensor(Z)V

    .line 219
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Z
    :cond_5
    move v0, v5

    .line 217
    goto :goto_2

    .line 224
    :sswitch_15
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 226
    invoke-virtual {p2}, Landroid/os/Parcel;->createFloatArray()[F

    move-result-object v0

    .line 227
    .local v0, "_arg0":[F
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->Start_AccCalibration([F)I

    move-result v4

    .line 228
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 229
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    .line 230
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeFloatArray([F)V

    goto/16 :goto_0

    .line 235
    .end local v0    # "_arg0":[F
    .end local v4    # "_result":I
    :sswitch_16
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 236
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->Start_GyroCalibration()I

    move-result v4

    .line 237
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 238
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 243
    .end local v4    # "_result":I
    :sswitch_17
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 244
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->Start_ProximityCalibration()I

    move-result v4

    .line 245
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 246
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 251
    .end local v4    # "_result":I
    :sswitch_18
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 252
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportProximityCalibration()Z

    move-result v4

    .line 253
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 254
    if-eqz v4, :cond_6

    move v5, v6

    :cond_6
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 259
    .end local v4    # "_result":Z
    :sswitch_19
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 260
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportBarometer()Z

    move-result v4

    .line 261
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 262
    if-eqz v4, :cond_7

    move v5, v6

    :cond_7
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 267
    .end local v4    # "_result":Z
    :sswitch_1a
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 268
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getCameraResolution()[I

    move-result-object v4

    .line 269
    .local v4, "_result":[I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 270
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeIntArray([I)V

    goto/16 :goto_0

    .line 275
    .end local v4    # "_result":[I
    :sswitch_1b
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 276
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->QwertyLedOn()V

    .line 277
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 282
    :sswitch_1c
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 283
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->QwertyLedOff()V

    .line 284
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 289
    :sswitch_1d
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 290
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getQwertyStatusValue()Ljava/lang/String;

    move-result-object v4

    .line 291
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 292
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 297
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_1e
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 299
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 301
    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 303
    .restart local v2    # "_arg1":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 304
    .local v3, "_arg2":Ljava/lang/String;
    invoke-virtual {p0, v0, v2, v3}, Lcom/lge/systemservice/core/IAATManager$Stub;->setLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 305
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 310
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v2    # "_arg1":Ljava/lang/String;
    .end local v3    # "_arg2":Ljava/lang/String;
    :sswitch_1f
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 311
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getLedVal()[Ljava/lang/String;

    move-result-object v4

    .line 312
    .local v4, "_result":[Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 313
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto/16 :goto_0

    .line 318
    .end local v4    # "_result":[Ljava/lang/String;
    :sswitch_20
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 319
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->Start_SmartFactoryReset()V

    .line 320
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 325
    :sswitch_21
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 327
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 329
    .local v0, "_arg0":I
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 330
    .local v2, "_arg1":I
    invoke-virtual {p0, v0, v2}, Lcom/lge/systemservice/core/IAATManager$Stub;->RebootforModeChange(II)V

    .line 331
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 336
    .end local v0    # "_arg0":I
    .end local v2    # "_arg1":I
    :sswitch_22
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 337
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->isDualSIM()Z

    move-result v4

    .line 338
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 339
    if-eqz v4, :cond_8

    move v5, v6

    :cond_8
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 344
    .end local v4    # "_result":Z
    :sswitch_23
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 345
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getCountSuppotedSIM()I

    move-result v4

    .line 346
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 347
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 352
    .end local v4    # "_result":I
    :sswitch_24
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 353
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->testDualUSIM1()I

    move-result v4

    .line 354
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 355
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 360
    .end local v4    # "_result":I
    :sswitch_25
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 361
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->testDualUSIM2()I

    move-result v4

    .line 362
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 363
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 368
    .end local v4    # "_result":I
    :sswitch_26
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 369
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->testDualUSIM3()I

    move-result v4

    .line 370
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 371
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 376
    .end local v4    # "_result":I
    :sswitch_27
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 377
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportUSIM()Z

    move-result v4

    .line 378
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 379
    if-eqz v4, :cond_9

    move v5, v6

    :cond_9
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 384
    .end local v4    # "_result":Z
    :sswitch_28
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 385
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportMura()Z

    move-result v4

    .line 386
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 387
    if-eqz v4, :cond_a

    move v5, v6

    :cond_a
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 392
    .end local v4    # "_result":Z
    :sswitch_29
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 393
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsFMRadio()Z

    move-result v4

    .line 394
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 395
    if-eqz v4, :cond_b

    move v5, v6

    :cond_b
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 400
    .end local v4    # "_result":Z
    :sswitch_2a
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 401
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->turnOnFMRadio()Z

    move-result v4

    .line 402
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 403
    if-eqz v4, :cond_c

    move v5, v6

    :cond_c
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 408
    .end local v4    # "_result":Z
    :sswitch_2b
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 409
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->turnOffFMRadio()Z

    move-result v4

    .line 410
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 411
    if-eqz v4, :cond_d

    move v5, v6

    :cond_d
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 416
    .end local v4    # "_result":Z
    :sswitch_2c
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 417
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->createFmRadioMgrFMRadio()V

    .line 418
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 423
    :sswitch_2d
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 424
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->startAutoScanFMRadio()Z

    move-result v4

    .line 425
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 426
    if-eqz v4, :cond_e

    move v5, v6

    :cond_e
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 431
    .end local v4    # "_result":Z
    :sswitch_2e
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 432
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->startBackwardScanFMRadio()Z

    move-result v4

    .line 433
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 434
    if-eqz v4, :cond_f

    move v5, v6

    :cond_f
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 439
    .end local v4    # "_result":Z
    :sswitch_2f
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 440
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->startForwardScanFMRadio()Z

    move-result v4

    .line 441
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 442
    if-eqz v4, :cond_10

    move v5, v6

    :cond_10
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 447
    .end local v4    # "_result":Z
    :sswitch_30
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 449
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 450
    .restart local v0    # "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->tuneFrequencyFMRadio(I)Z

    move-result v4

    .line 451
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 452
    if-eqz v4, :cond_11

    move v5, v6

    :cond_11
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 457
    .end local v0    # "_arg0":I
    .end local v4    # "_result":Z
    :sswitch_31
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 459
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 460
    .local v1, "_arg0_length":I
    if-gez v1, :cond_13

    .line 461
    const/4 v0, 0x0

    .line 466
    .local v0, "_arg0":[B
    :goto_3
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->felicacmdEXTIDM([B)Z

    move-result v4

    .line 467
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 468
    if-eqz v4, :cond_12

    move v5, v6

    :cond_12
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    .line 469
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    goto/16 :goto_0

    .line 464
    .end local v0    # "_arg0":[B
    .end local v4    # "_result":Z
    :cond_13
    new-array v0, v1, [B

    .restart local v0    # "_arg0":[B
    goto :goto_3

    .line 474
    .end local v0    # "_arg0":[B
    .end local v1    # "_arg0_length":I
    :sswitch_32
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 475
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getSupportVideoEncorder()Ljava/lang/String;

    move-result-object v4

    .line 476
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 477
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 482
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_33
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 483
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getAccelerometerCalOption()Ljava/lang/String;

    move-result-object v4

    .line 484
    .restart local v4    # "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 485
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 490
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_34
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 491
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getAccelCalSleep()Z

    move-result v4

    .line 492
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 493
    if-eqz v4, :cond_14

    move v5, v6

    :cond_14
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 498
    .end local v4    # "_result":Z
    :sswitch_35
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 500
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    if-eqz v7, :cond_15

    move v0, v6

    .line 501
    .local v0, "_arg0":Z
    :goto_4
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->AATsetLCDOnOff(Z)V

    .line 502
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .end local v0    # "_arg0":Z
    :cond_15
    move v0, v5

    .line 500
    goto :goto_4

    .line 507
    :sswitch_36
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 508
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getQuickMemoKeyCodeValue()I

    move-result v4

    .line 509
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 510
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 515
    .end local v4    # "_result":I
    :sswitch_37
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 516
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportAutoFocus()Z

    move-result v4

    .line 517
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 518
    if-eqz v4, :cond_16

    move v5, v6

    :cond_16
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 523
    .end local v4    # "_result":Z
    :sswitch_38
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 524
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportSubMic()Z

    move-result v4

    .line 525
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 526
    if-eqz v4, :cond_17

    move v5, v6

    :cond_17
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 531
    .end local v4    # "_result":Z
    :sswitch_39
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 532
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->isFactoryTestMode()Z

    move-result v4

    .line 533
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 534
    if-eqz v4, :cond_18

    move v5, v6

    :cond_18
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 539
    .end local v4    # "_result":Z
    :sswitch_3a
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 540
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->FolderTest_GetSupportedMenuList()[Z

    move-result-object v4

    .line 541
    .local v4, "_result":[Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 542
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeBooleanArray([Z)V

    goto/16 :goto_0

    .line 547
    .end local v4    # "_result":[Z
    :sswitch_3b
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 549
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 550
    .local v0, "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->FolderTest_GetDetailTestSupportValue(I)Z

    move-result v4

    .line 551
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 552
    if-eqz v4, :cond_19

    move v5, v6

    :cond_19
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 557
    .end local v0    # "_arg0":I
    .end local v4    # "_result":Z
    :sswitch_3c
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 559
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 560
    .restart local v0    # "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->FolderTest_GetFilePath(I)Ljava/lang/String;

    move-result-object v4

    .line 561
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 562
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 567
    .end local v0    # "_arg0":I
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_3d
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 568
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->FolderTest_GetDimOnBacklightValue()F

    move-result v4

    .line 569
    .local v4, "_result":F
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 570
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeFloat(F)V

    goto/16 :goto_0

    .line 575
    .end local v4    # "_result":F
    :sswitch_3e
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 577
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 578
    .restart local v0    # "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->switchUSBMode(I)V

    .line 579
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 584
    .end local v0    # "_arg0":I
    :sswitch_3f
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 585
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->GetUsbOnOffValue()I

    move-result v4

    .line 586
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 587
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 592
    .end local v4    # "_result":I
    :sswitch_40
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 593
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getTestOrderNumber()Ljava/lang/String;

    move-result-object v4

    .line 594
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 595
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 600
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_41
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 601
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getTestOrderLength()I

    move-result v4

    .line 602
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 603
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 608
    .end local v4    # "_result":I
    :sswitch_42
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 609
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->resetData()V

    .line 610
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 615
    :sswitch_43
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 616
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getHallSensorResult()[Ljava/lang/String;

    move-result-object v4

    .line 617
    .local v4, "_result":[Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 618
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto/16 :goto_0

    .line 623
    .end local v4    # "_result":[Ljava/lang/String;
    :sswitch_44
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 625
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 626
    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->setSpeakerState(Ljava/lang/String;)V

    .line 627
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 632
    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_45
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 633
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getBatteryCapacityFilePath()Ljava/lang/String;

    move-result-object v4

    .line 634
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 635
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 640
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_46
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 641
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getBatteryIDFilePath()Ljava/lang/String;

    move-result-object v4

    .line 642
    .restart local v4    # "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 643
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 648
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_47
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 649
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getBatteryThermistorFilePath()Ljava/lang/String;

    move-result-object v4

    .line 650
    .restart local v4    # "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 651
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 656
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_48
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 657
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportHookKeyTest()Z

    move-result v4

    .line 658
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 659
    if-eqz v4, :cond_1a

    move v5, v6

    :cond_1a
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 664
    .end local v4    # "_result":Z
    :sswitch_49
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 665
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getAATSWversion()Ljava/lang/String;

    move-result-object v4

    .line 666
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 667
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 672
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_4a
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 674
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 675
    .local v0, "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getSaveVolume(I)I

    move-result v4

    .line 676
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 677
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 682
    .end local v0    # "_arg0":I
    .end local v4    # "_result":I
    :sswitch_4b
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 684
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 685
    .restart local v0    # "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getMaxVolume(I)I

    move-result v4

    .line 686
    .restart local v4    # "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 687
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 692
    .end local v0    # "_arg0":I
    .end local v4    # "_result":I
    :sswitch_4c
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 693
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->enableOisProp()V

    .line 694
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 699
    :sswitch_4d
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 700
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->disableOisProp()V

    .line 701
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 706
    :sswitch_4e
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 708
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .line 709
    .restart local v0    # "_arg0":I
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->setProximityCrossTalkValue(I)V

    .line 710
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 715
    .end local v0    # "_arg0":I
    :sswitch_4f
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 716
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->enableTDMBTestActivity()Z

    move-result v4

    .line 717
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 718
    if-eqz v4, :cond_1b

    move v5, v6

    :cond_1b
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 723
    .end local v4    # "_result":Z
    :sswitch_50
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 724
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->getLimitBatteryCapacity()I

    move-result v4

    .line 725
    .local v4, "_result":I
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 726
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 731
    .end local v4    # "_result":I
    :sswitch_51
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 733
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 734
    .local v0, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->sendAATStatus(Ljava/lang/String;)V

    .line 735
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 740
    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_52
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 741
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportShowInternalMemoryCapacity()Z

    move-result v4

    .line 742
    .local v4, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 743
    if-eqz v4, :cond_1c

    move v5, v6

    :cond_1c
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 748
    .end local v4    # "_result":Z
    :sswitch_53
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 749
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->enableMTS()V

    .line 750
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 755
    :sswitch_54
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 756
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->disableMTS()V

    .line 757
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 762
    :sswitch_55
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 764
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 766
    .restart local v0    # "_arg0":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 768
    .local v2, "_arg1":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 769
    .restart local v3    # "_arg2":Ljava/lang/String;
    invoke-virtual {p0, v0, v2, v3}, Lcom/lge/systemservice/core/IAATManager$Stub;->setBackLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 770
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 775
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v2    # "_arg1":Ljava/lang/String;
    .end local v3    # "_arg2":Ljava/lang/String;
    :sswitch_56
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 777
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 778
    .restart local v0    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->setRGBLedVal(Ljava/lang/String;)V

    .line 779
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 784
    .end local v0    # "_arg0":Ljava/lang/String;
    :sswitch_57
    const-string v7, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v7}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 785
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->IsSupportInvalidAATSet()Z

    move-result v4

    .line 786
    .restart local v4    # "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 787
    if-eqz v4, :cond_1d

    move v5, v6

    :cond_1d
    invoke-virtual {p3, v5}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_0

    .line 792
    .end local v4    # "_result":Z
    :sswitch_58
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 794
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 795
    .restart local v0    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/lge/systemservice/core/IAATManager$Stub;->requestToCapSensor(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 796
    .local v4, "_result":Ljava/lang/String;
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 797
    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 802
    .end local v0    # "_arg0":Ljava/lang/String;
    .end local v4    # "_result":Ljava/lang/String;
    :sswitch_59
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 803
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->enableTouchPoint()V

    .line 804
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 809
    :sswitch_5a
    const-string v5, "com.lge.systemservice.core.IAATManager"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 810
    invoke-virtual {p0}, Lcom/lge/systemservice/core/IAATManager$Stub;->disableTouchPoint()V

    .line 811
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_0

    .line 38
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
        0x20 -> :sswitch_20
        0x21 -> :sswitch_21
        0x22 -> :sswitch_22
        0x23 -> :sswitch_23
        0x24 -> :sswitch_24
        0x25 -> :sswitch_25
        0x26 -> :sswitch_26
        0x27 -> :sswitch_27
        0x28 -> :sswitch_28
        0x29 -> :sswitch_29
        0x2a -> :sswitch_2a
        0x2b -> :sswitch_2b
        0x2c -> :sswitch_2c
        0x2d -> :sswitch_2d
        0x2e -> :sswitch_2e
        0x2f -> :sswitch_2f
        0x30 -> :sswitch_30
        0x31 -> :sswitch_31
        0x32 -> :sswitch_32
        0x33 -> :sswitch_33
        0x34 -> :sswitch_34
        0x35 -> :sswitch_35
        0x36 -> :sswitch_36
        0x37 -> :sswitch_37
        0x38 -> :sswitch_38
        0x39 -> :sswitch_39
        0x3a -> :sswitch_3a
        0x3b -> :sswitch_3b
        0x3c -> :sswitch_3c
        0x3d -> :sswitch_3d
        0x3e -> :sswitch_3e
        0x3f -> :sswitch_3f
        0x40 -> :sswitch_40
        0x41 -> :sswitch_41
        0x42 -> :sswitch_42
        0x43 -> :sswitch_43
        0x44 -> :sswitch_44
        0x45 -> :sswitch_45
        0x46 -> :sswitch_46
        0x47 -> :sswitch_47
        0x48 -> :sswitch_48
        0x49 -> :sswitch_49
        0x4a -> :sswitch_4a
        0x4b -> :sswitch_4b
        0x4c -> :sswitch_4c
        0x4d -> :sswitch_4d
        0x4e -> :sswitch_4e
        0x4f -> :sswitch_4f
        0x50 -> :sswitch_50
        0x51 -> :sswitch_51
        0x52 -> :sswitch_52
        0x53 -> :sswitch_53
        0x54 -> :sswitch_54
        0x55 -> :sswitch_55
        0x56 -> :sswitch_56
        0x57 -> :sswitch_57
        0x58 -> :sswitch_58
        0x59 -> :sswitch_59
        0x5a -> :sswitch_5a
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
