.class public abstract Lcom/android/internal/telephony/ITelephony$Stub;
.super Landroid/os/Binder;
.source "ITelephony.java"

# interfaces
.implements Lcom/android/internal/telephony/ITelephony;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/ITelephony;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/ITelephony$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.android.internal.telephony.ITelephony"

.field static final TRANSACTION_answerRingingCall:I = 0x5

.field static final TRANSACTION_busyCall:I = 0x75

.field static final TRANSACTION_call:I = 0x2

.field static final TRANSACTION_checkCarrierPrivilegesForPackage:I = 0x63

.field static final TRANSACTION_clearDataDisabledFlag:I = 0x7b

.field static final TRANSACTION_dial:I = 0x1

.field static final TRANSACTION_disableDataConnectivity:I = 0x26

.field static final TRANSACTION_disableLocationUpdates:I = 0x23

.field static final TRANSACTION_disableLocationUpdatesForSubscriber:I = 0x24

.field static final TRANSACTION_disableStatusBarforVoIP:I = 0x74

.field static final TRANSACTION_enableDataConnectivity:I = 0x25

.field static final TRANSACTION_enableLocationUpdates:I = 0x21

.field static final TRANSACTION_enableLocationUpdatesForSubscriber:I = 0x22

.field static final TRANSACTION_enableSimplifiedNetworkSettingsForSubscriber:I = 0x65

.field static final TRANSACTION_endCall:I = 0x3

.field static final TRANSACTION_endCallForSubscriber:I = 0x4

.field static final TRANSACTION_getActivePhoneType:I = 0x2f

.field static final TRANSACTION_getActivePhoneTypeForSubscriber:I = 0x30

.field static final TRANSACTION_getAllCellInfo:I = 0x45

.field static final TRANSACTION_getAllCellInfoUsingSubId:I = 0x46

.field static final TRANSACTION_getAtr:I = 0x7d

.field static final TRANSACTION_getAtrUsingSubId:I = 0x7e

.field static final TRANSACTION_getCalculatedPreferredNetworkType:I = 0x58

.field static final TRANSACTION_getCallState:I = 0x2a

.field static final TRANSACTION_getCallStateForSubscriber:I = 0x2b

.field static final TRANSACTION_getCarrierPackageNamesForIntent:I = 0x64

.field static final TRANSACTION_getCdmaEriIconIndex:I = 0x31

.field static final TRANSACTION_getCdmaEriIconIndexForSubscriber:I = 0x32

.field static final TRANSACTION_getCdmaEriIconMode:I = 0x33

.field static final TRANSACTION_getCdmaEriIconModeForSubscriber:I = 0x34

.field static final TRANSACTION_getCdmaEriText:I = 0x35

.field static final TRANSACTION_getCdmaEriTextForSubscriber:I = 0x36

.field static final TRANSACTION_getCdmaMdn:I = 0x60

.field static final TRANSACTION_getCdmaMin:I = 0x61

.field static final TRANSACTION_getCellLocation:I = 0x28

.field static final TRANSACTION_getDataActivity:I = 0x2c

.field static final TRANSACTION_getDataEnabled:I = 0x5d

.field static final TRANSACTION_getDataNetworkType:I = 0x3c

.field static final TRANSACTION_getDataNetworkTypeForSubscriber:I = 0x3d

.field static final TRANSACTION_getDataState:I = 0x2d

.field static final TRANSACTION_getDataStateType:I = 0x2e

.field static final TRANSACTION_getDebugInfo:I = 0x6c

.field static final TRANSACTION_getDefaultSim:I = 0x48

.field static final TRANSACTION_getIccOperatorNumeric:I = 0x40

.field static final TRANSACTION_getLine1AlphaTagForDisplay:I = 0x69

.field static final TRANSACTION_getLine1NumberForDisplay:I = 0x68

.field static final TRANSACTION_getLteOnCdmaMode:I = 0x43

.field static final TRANSACTION_getLteOnCdmaModeForSubscriber:I = 0x44

.field static final TRANSACTION_getMipErrorCode:I = 0x79

.field static final TRANSACTION_getNeighboringCellInfo:I = 0x29

.field static final TRANSACTION_getNetworkType:I = 0x3a

.field static final TRANSACTION_getNetworkTypeForSubscriber:I = 0x3b

.field static final TRANSACTION_getPcscfAddress:I = 0x5e

.field static final TRANSACTION_getPhoneRat:I = 0x82

.field static final TRANSACTION_getPreferredNetworkType:I = 0x59

.field static final TRANSACTION_getSimplifiedNetworkSettingsEnabledForSubscriber:I = 0x66

.field static final TRANSACTION_getVoiceMessageCount:I = 0x38

.field static final TRANSACTION_getVoiceMessageCountForSubscriber:I = 0x39

.field static final TRANSACTION_getVoiceNetworkType:I = 0x3e

.field static final TRANSACTION_getVoiceNetworkTypeForSubscriber:I = 0x3f

.field static final TRANSACTION_handleDataInterface:I = 0x78

.field static final TRANSACTION_handlePinMmi:I = 0x18

.field static final TRANSACTION_handlePinMmiForSubscriber:I = 0x19

.field static final TRANSACTION_hasCarrierPrivileges:I = 0x62

.field static final TRANSACTION_hasIccCard:I = 0x41

.field static final TRANSACTION_hasIccCardUsingSlotId:I = 0x42

.field static final TRANSACTION_iccCloseLogicalChannel:I = 0x4b

.field static final TRANSACTION_iccCloseLogicalChannelUsingSubId:I = 0x4c

.field static final TRANSACTION_iccExchangeSimIO:I = 0x51

.field static final TRANSACTION_iccExchangeSimIOUsingSubId:I = 0x52

.field static final TRANSACTION_iccOpenLogicalChannel:I = 0x49

.field static final TRANSACTION_iccOpenLogicalChannelUsingSubId:I = 0x4a

.field static final TRANSACTION_iccTransmitApduBasicChannel:I = 0x4f

.field static final TRANSACTION_iccTransmitApduBasicChannelUsingSubId:I = 0x50

.field static final TRANSACTION_iccTransmitApduLogicalChannel:I = 0x4d

.field static final TRANSACTION_iccTransmitApduLogicalChannelUsingSubId:I = 0x4e

.field static final TRANSACTION_invokeOemRilRequestRaw:I = 0x6b

.field static final TRANSACTION_isDataConnectivityPossible:I = 0x27

.field static final TRANSACTION_isIdle:I = 0xb

.field static final TRANSACTION_isIdleForSubscriber:I = 0xc

.field static final TRANSACTION_isOemDialing:I = 0x77

.field static final TRANSACTION_isOemRinging:I = 0x76

.field static final TRANSACTION_isOffhook:I = 0x7

.field static final TRANSACTION_isOffhookForSubscriber:I = 0x8

.field static final TRANSACTION_isRadioOn:I = 0xd

.field static final TRANSACTION_isRadioOnForSubscriber:I = 0xe

.field static final TRANSACTION_isRinging:I = 0xa

.field static final TRANSACTION_isRingingForSubscriber:I = 0x9

.field static final TRANSACTION_isSimPinEnabled:I = 0xf

.field static final TRANSACTION_needMobileRadioShutdown:I = 0x7f

.field static final TRANSACTION_needsOtaServiceProvisioning:I = 0x37

.field static final TRANSACTION_nvReadItem:I = 0x54

.field static final TRANSACTION_nvResetConfig:I = 0x57

.field static final TRANSACTION_nvWriteCdmaPrl:I = 0x56

.field static final TRANSACTION_nvWriteItem:I = 0x55

.field static final TRANSACTION_reenableStatusBarforVoIP:I = 0x73

.field static final TRANSACTION_registerForCurrentVoIP:I = 0x6d

.field static final TRANSACTION_sendEnvelopeWithStatus:I = 0x53

.field static final TRANSACTION_setCellInfoListRate:I = 0x47

.field static final TRANSACTION_setDataDisabledFlag:I = 0x7a

.field static final TRANSACTION_setDataEnabled:I = 0x5b

.field static final TRANSACTION_setDataEnabledUsingSubId:I = 0x5c

.field static final TRANSACTION_setImsRegistrationState:I = 0x5f

.field static final TRANSACTION_setLine1NumberForDisplayForSubscriber:I = 0x67

.field static final TRANSACTION_setNetworkModePreference:I = 0x7c

.field static final TRANSACTION_setOperatorBrandOverride:I = 0x6a

.field static final TRANSACTION_setPhoneRat:I = 0x81

.field static final TRANSACTION_setPreferredNetworkType:I = 0x5a

.field static final TRANSACTION_setRadio:I = 0x1c

.field static final TRANSACTION_setRadioForSubscriber:I = 0x1d

.field static final TRANSACTION_setRadioPower:I = 0x1e

.field static final TRANSACTION_setVoIPDialing:I = 0x70

.field static final TRANSACTION_setVoIPIdle:I = 0x72

.field static final TRANSACTION_setVoIPInCall:I = 0x71

.field static final TRANSACTION_setVoIPRining:I = 0x6f

.field static final TRANSACTION_shutdownMobileRadios:I = 0x80

.field static final TRANSACTION_silenceRinger:I = 0x6

.field static final TRANSACTION_supplyPin:I = 0x10

.field static final TRANSACTION_supplyPinForSubscriber:I = 0x11

.field static final TRANSACTION_supplyPinReportResult:I = 0x14

.field static final TRANSACTION_supplyPinReportResultForSubscriber:I = 0x15

.field static final TRANSACTION_supplyPuk:I = 0x12

.field static final TRANSACTION_supplyPukForSubscriber:I = 0x13

.field static final TRANSACTION_supplyPukReportResult:I = 0x16

.field static final TRANSACTION_supplyPukReportResultForSubscriber:I = 0x17

.field static final TRANSACTION_toggleRadioOnOff:I = 0x1a

.field static final TRANSACTION_toggleRadioOnOffForSubscriber:I = 0x1b

.field static final TRANSACTION_unregisterForCurrentVoIP:I = 0x6e

.field static final TRANSACTION_updateServiceLocation:I = 0x1f

.field static final TRANSACTION_updateServiceLocationForSubscriber:I = 0x20


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 21
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 22
    const-string v0, "com.android.internal.telephony.ITelephony"

    invoke-virtual {p0, p0, v0}, Lcom/android/internal/telephony/ITelephony$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 23
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 30
    if-nez p0, :cond_0

    .line 31
    const/4 v0, 0x0

    .line 37
    :goto_0
    return-object v0

    .line 33
    :cond_0
    const-string v1, "com.android.internal.telephony.ITelephony"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 34
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/android/internal/telephony/ITelephony;

    if-eqz v1, :cond_1

    .line 35
    check-cast v0, Lcom/android/internal/telephony/ITelephony;

    goto :goto_0

    .line 37
    :cond_1
    new-instance v0, Lcom/android/internal/telephony/ITelephony$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/android/internal/telephony/ITelephony$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 41
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 25
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
    .line 45
    sparse-switch p1, :sswitch_data_0

    .line 1369
    invoke-super/range {p0 .. p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v2

    :goto_0
    return v2

    .line 49
    :sswitch_0
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 50
    const/4 v2, 0x1

    goto :goto_0

    .line 54
    :sswitch_1
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 56
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 57
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->dial(Ljava/lang/String;)V

    .line 58
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 59
    const/4 v2, 0x1

    goto :goto_0

    .line 63
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_2
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 65
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 67
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 68
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->call(Ljava/lang/String;Ljava/lang/String;)V

    .line 69
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 70
    const/4 v2, 0x1

    goto :goto_0

    .line 74
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_3
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 75
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->endCall()Z

    move-result v21

    .line 76
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 77
    if-eqz v21, :cond_0

    const/4 v2, 0x1

    :goto_1
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 78
    const/4 v2, 0x1

    goto :goto_0

    .line 77
    :cond_0
    const/4 v2, 0x0

    goto :goto_1

    .line 82
    .end local v21    # "_result":Z
    :sswitch_4
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 84
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 85
    .local v12, "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->endCallForSubscriber(J)Z

    move-result v21

    .line 86
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 87
    if-eqz v21, :cond_1

    const/4 v2, 0x1

    :goto_2
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 88
    const/4 v2, 0x1

    goto :goto_0

    .line 87
    :cond_1
    const/4 v2, 0x0

    goto :goto_2

    .line 92
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_5
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 93
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->answerRingingCall()V

    .line 94
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 95
    const/4 v2, 0x1

    goto :goto_0

    .line 99
    :sswitch_6
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 100
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->silenceRinger()V

    .line 101
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 102
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 106
    :sswitch_7
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 107
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isOffhook()Z

    move-result v21

    .line 108
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 109
    if-eqz v21, :cond_2

    const/4 v2, 0x1

    :goto_3
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 110
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 109
    :cond_2
    const/4 v2, 0x0

    goto :goto_3

    .line 114
    .end local v21    # "_result":Z
    :sswitch_8
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 116
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 117
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->isOffhookForSubscriber(J)Z

    move-result v21

    .line 118
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 119
    if-eqz v21, :cond_3

    const/4 v2, 0x1

    :goto_4
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 120
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 119
    :cond_3
    const/4 v2, 0x0

    goto :goto_4

    .line 124
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_9
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 126
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 127
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->isRingingForSubscriber(J)Z

    move-result v21

    .line 128
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 129
    if-eqz v21, :cond_4

    const/4 v2, 0x1

    :goto_5
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 130
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 129
    :cond_4
    const/4 v2, 0x0

    goto :goto_5

    .line 134
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 135
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isRinging()Z

    move-result v21

    .line 136
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 137
    if-eqz v21, :cond_5

    const/4 v2, 0x1

    :goto_6
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 138
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 137
    :cond_5
    const/4 v2, 0x0

    goto :goto_6

    .line 142
    .end local v21    # "_result":Z
    :sswitch_b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 143
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isIdle()Z

    move-result v21

    .line 144
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 145
    if-eqz v21, :cond_6

    const/4 v2, 0x1

    :goto_7
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 146
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 145
    :cond_6
    const/4 v2, 0x0

    goto :goto_7

    .line 150
    .end local v21    # "_result":Z
    :sswitch_c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 152
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 153
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->isIdleForSubscriber(J)Z

    move-result v21

    .line 154
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 155
    if-eqz v21, :cond_7

    const/4 v2, 0x1

    :goto_8
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 156
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 155
    :cond_7
    const/4 v2, 0x0

    goto :goto_8

    .line 160
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 161
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isRadioOn()Z

    move-result v21

    .line 162
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 163
    if-eqz v21, :cond_8

    const/4 v2, 0x1

    :goto_9
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 164
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 163
    :cond_8
    const/4 v2, 0x0

    goto :goto_9

    .line 168
    .end local v21    # "_result":Z
    :sswitch_e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 170
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 171
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->isRadioOnForSubscriber(J)Z

    move-result v21

    .line 172
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 173
    if-eqz v21, :cond_9

    const/4 v2, 0x1

    :goto_a
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 174
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 173
    :cond_9
    const/4 v2, 0x0

    goto :goto_a

    .line 178
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 179
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isSimPinEnabled()Z

    move-result v21

    .line 180
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 181
    if-eqz v21, :cond_a

    const/4 v2, 0x1

    :goto_b
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 182
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 181
    :cond_a
    const/4 v2, 0x0

    goto :goto_b

    .line 186
    .end local v21    # "_result":Z
    :sswitch_10
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 188
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 189
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPin(Ljava/lang/String;)Z

    move-result v21

    .line 190
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 191
    if-eqz v21, :cond_b

    const/4 v2, 0x1

    :goto_c
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 192
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 191
    :cond_b
    const/4 v2, 0x0

    goto :goto_c

    .line 196
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":Z
    :sswitch_11
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 198
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 200
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 201
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPinForSubscriber(JLjava/lang/String;)Z

    move-result v21

    .line 202
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 203
    if-eqz v21, :cond_c

    const/4 v2, 0x1

    :goto_d
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 204
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 203
    :cond_c
    const/4 v2, 0x0

    goto :goto_d

    .line 208
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_12
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 210
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 212
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 213
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPuk(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v21

    .line 214
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 215
    if-eqz v21, :cond_d

    const/4 v2, 0x1

    :goto_e
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 216
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 215
    :cond_d
    const/4 v2, 0x0

    goto :goto_e

    .line 220
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v21    # "_result":Z
    :sswitch_13
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 222
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 224
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 226
    .restart local v4    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 227
    .local v5, "_arg2":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4, v5}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPukForSubscriber(JLjava/lang/String;Ljava/lang/String;)Z

    move-result v21

    .line 228
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 229
    if-eqz v21, :cond_e

    const/4 v2, 0x1

    :goto_f
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 230
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 229
    :cond_e
    const/4 v2, 0x0

    goto :goto_f

    .line 234
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v5    # "_arg2":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_14
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 236
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 237
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPinReportResult(Ljava/lang/String;)[I

    move-result-object v21

    .line 238
    .local v21, "_result":[I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 239
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeIntArray([I)V

    .line 240
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 244
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":[I
    :sswitch_15
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 246
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 248
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 249
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPinReportResultForSubscriber(JLjava/lang/String;)[I

    move-result-object v21

    .line 250
    .restart local v21    # "_result":[I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 251
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeIntArray([I)V

    .line 252
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 256
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":[I
    :sswitch_16
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 258
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 260
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 261
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPukReportResult(Ljava/lang/String;Ljava/lang/String;)[I

    move-result-object v21

    .line 262
    .restart local v21    # "_result":[I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 263
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeIntArray([I)V

    .line 264
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 268
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v21    # "_result":[I
    :sswitch_17
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 270
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 272
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 274
    .restart local v4    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 275
    .restart local v5    # "_arg2":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4, v5}, Lcom/android/internal/telephony/ITelephony$Stub;->supplyPukReportResultForSubscriber(JLjava/lang/String;Ljava/lang/String;)[I

    move-result-object v21

    .line 276
    .restart local v21    # "_result":[I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 277
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeIntArray([I)V

    .line 278
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 282
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v5    # "_arg2":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":[I
    :sswitch_18
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 284
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 285
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->handlePinMmi(Ljava/lang/String;)Z

    move-result v21

    .line 286
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 287
    if-eqz v21, :cond_f

    const/4 v2, 0x1

    :goto_10
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 288
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 287
    :cond_f
    const/4 v2, 0x0

    goto :goto_10

    .line 292
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":Z
    :sswitch_19
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 294
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 296
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 297
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->handlePinMmiForSubscriber(JLjava/lang/String;)Z

    move-result v21

    .line 298
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 299
    if-eqz v21, :cond_10

    const/4 v2, 0x1

    :goto_11
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 300
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 299
    :cond_10
    const/4 v2, 0x0

    goto :goto_11

    .line 304
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_1a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 305
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->toggleRadioOnOff()V

    .line 306
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 307
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 311
    :sswitch_1b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 313
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 314
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->toggleRadioOnOffForSubscriber(J)V

    .line 315
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 316
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 320
    .end local v12    # "_arg0":J
    :sswitch_1c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 322
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_11

    const/4 v3, 0x1

    .line 323
    .local v3, "_arg0":Z
    :goto_12
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setRadio(Z)Z

    move-result v21

    .line 324
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 325
    if-eqz v21, :cond_12

    const/4 v2, 0x1

    :goto_13
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 326
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 322
    .end local v3    # "_arg0":Z
    .end local v21    # "_result":Z
    :cond_11
    const/4 v3, 0x0

    goto :goto_12

    .line 325
    .restart local v3    # "_arg0":Z
    .restart local v21    # "_result":Z
    :cond_12
    const/4 v2, 0x0

    goto :goto_13

    .line 330
    .end local v3    # "_arg0":Z
    .end local v21    # "_result":Z
    :sswitch_1d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 332
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 334
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_13

    const/4 v4, 0x1

    .line 335
    .local v4, "_arg1":Z
    :goto_14
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->setRadioForSubscriber(JZ)Z

    move-result v21

    .line 336
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 337
    if-eqz v21, :cond_14

    const/4 v2, 0x1

    :goto_15
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 338
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 334
    .end local v4    # "_arg1":Z
    .end local v21    # "_result":Z
    :cond_13
    const/4 v4, 0x0

    goto :goto_14

    .line 337
    .restart local v4    # "_arg1":Z
    .restart local v21    # "_result":Z
    :cond_14
    const/4 v2, 0x0

    goto :goto_15

    .line 342
    .end local v4    # "_arg1":Z
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_1e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 344
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_15

    const/4 v3, 0x1

    .line 345
    .restart local v3    # "_arg0":Z
    :goto_16
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setRadioPower(Z)Z

    move-result v21

    .line 346
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 347
    if-eqz v21, :cond_16

    const/4 v2, 0x1

    :goto_17
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 348
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 344
    .end local v3    # "_arg0":Z
    .end local v21    # "_result":Z
    :cond_15
    const/4 v3, 0x0

    goto :goto_16

    .line 347
    .restart local v3    # "_arg0":Z
    .restart local v21    # "_result":Z
    :cond_16
    const/4 v2, 0x0

    goto :goto_17

    .line 352
    .end local v3    # "_arg0":Z
    .end local v21    # "_result":Z
    :sswitch_1f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 353
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->updateServiceLocation()V

    .line 354
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 355
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 359
    :sswitch_20
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 361
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 362
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->updateServiceLocationForSubscriber(J)V

    .line 363
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 364
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 368
    .end local v12    # "_arg0":J
    :sswitch_21
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 369
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->enableLocationUpdates()V

    .line 370
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 371
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 375
    :sswitch_22
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 377
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 378
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->enableLocationUpdatesForSubscriber(J)V

    .line 379
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 380
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 384
    .end local v12    # "_arg0":J
    :sswitch_23
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 385
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->disableLocationUpdates()V

    .line 386
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 387
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 391
    :sswitch_24
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 393
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 394
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->disableLocationUpdatesForSubscriber(J)V

    .line 395
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 396
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 400
    .end local v12    # "_arg0":J
    :sswitch_25
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 401
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->enableDataConnectivity()Z

    move-result v21

    .line 402
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 403
    if-eqz v21, :cond_17

    const/4 v2, 0x1

    :goto_18
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 404
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 403
    :cond_17
    const/4 v2, 0x0

    goto :goto_18

    .line 408
    .end local v21    # "_result":Z
    :sswitch_26
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 409
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->disableDataConnectivity()Z

    move-result v21

    .line 410
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 411
    if-eqz v21, :cond_18

    const/4 v2, 0x1

    :goto_19
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 412
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 411
    :cond_18
    const/4 v2, 0x0

    goto :goto_19

    .line 416
    .end local v21    # "_result":Z
    :sswitch_27
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 417
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isDataConnectivityPossible()Z

    move-result v21

    .line 418
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 419
    if-eqz v21, :cond_19

    const/4 v2, 0x1

    :goto_1a
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 420
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 419
    :cond_19
    const/4 v2, 0x0

    goto :goto_1a

    .line 424
    .end local v21    # "_result":Z
    :sswitch_28
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 425
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getCellLocation()Landroid/os/Bundle;

    move-result-object v21

    .line 426
    .local v21, "_result":Landroid/os/Bundle;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 427
    if-eqz v21, :cond_1a

    .line 428
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 429
    const/4 v2, 0x1

    move-object/from16 v0, v21

    move-object/from16 v1, p3

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->writeToParcel(Landroid/os/Parcel;I)V

    .line 434
    :goto_1b
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 432
    :cond_1a
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_1b

    .line 438
    .end local v21    # "_result":Landroid/os/Bundle;
    :sswitch_29
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 440
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 441
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->getNeighboringCellInfo(Ljava/lang/String;)Ljava/util/List;

    move-result-object v23

    .line 442
    .local v23, "_result":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/NeighboringCellInfo;>;"
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 443
    move-object/from16 v0, p3

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    .line 444
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 448
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v23    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/NeighboringCellInfo;>;"
    :sswitch_2a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 449
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getCallState()I

    move-result v21

    .line 450
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 451
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 452
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 456
    .end local v21    # "_result":I
    :sswitch_2b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 458
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 459
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getCallStateForSubscriber(J)I

    move-result v21

    .line 460
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 461
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 462
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 466
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_2c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 467
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getDataActivity()I

    move-result v21

    .line 468
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 469
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 470
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 474
    .end local v21    # "_result":I
    :sswitch_2d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 475
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getDataState()I

    move-result v21

    .line 476
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 477
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 478
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 482
    .end local v21    # "_result":I
    :sswitch_2e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 484
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 485
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->getDataStateType(Ljava/lang/String;)I

    move-result v21

    .line 486
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 487
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 488
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 492
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":I
    :sswitch_2f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 493
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getActivePhoneType()I

    move-result v21

    .line 494
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 495
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 496
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 500
    .end local v21    # "_result":I
    :sswitch_30
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 502
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 503
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getActivePhoneTypeForSubscriber(J)I

    move-result v21

    .line 504
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 505
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 506
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 510
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_31
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 511
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaEriIconIndex()I

    move-result v21

    .line 512
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 513
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 514
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 518
    .end local v21    # "_result":I
    :sswitch_32
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 520
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 521
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaEriIconIndexForSubscriber(J)I

    move-result v21

    .line 522
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 523
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 524
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 528
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_33
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 529
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaEriIconMode()I

    move-result v21

    .line 530
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 531
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 532
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 536
    .end local v21    # "_result":I
    :sswitch_34
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 538
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 539
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaEriIconModeForSubscriber(J)I

    move-result v21

    .line 540
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 541
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 542
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 546
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_35
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 547
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaEriText()Ljava/lang/String;

    move-result-object v21

    .line 548
    .local v21, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 549
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 550
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 554
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_36
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 556
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 557
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaEriTextForSubscriber(J)Ljava/lang/String;

    move-result-object v21

    .line 558
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 559
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 560
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 564
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_37
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 565
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->needsOtaServiceProvisioning()Z

    move-result v21

    .line 566
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 567
    if-eqz v21, :cond_1b

    const/4 v2, 0x1

    :goto_1c
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 568
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 567
    :cond_1b
    const/4 v2, 0x0

    goto :goto_1c

    .line 572
    .end local v21    # "_result":Z
    :sswitch_38
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 573
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getVoiceMessageCount()I

    move-result v21

    .line 574
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 575
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 576
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 580
    .end local v21    # "_result":I
    :sswitch_39
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 582
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 583
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getVoiceMessageCountForSubscriber(J)I

    move-result v21

    .line 584
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 585
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 586
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 590
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_3a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 591
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getNetworkType()I

    move-result v21

    .line 592
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 593
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 594
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 598
    .end local v21    # "_result":I
    :sswitch_3b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 600
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 601
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getNetworkTypeForSubscriber(J)I

    move-result v21

    .line 602
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 603
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 604
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 608
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_3c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 609
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getDataNetworkType()I

    move-result v21

    .line 610
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 611
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 612
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 616
    .end local v21    # "_result":I
    :sswitch_3d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 618
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 619
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getDataNetworkTypeForSubscriber(J)I

    move-result v21

    .line 620
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 621
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 622
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 626
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_3e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 627
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getVoiceNetworkType()I

    move-result v21

    .line 628
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 629
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 630
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 634
    .end local v21    # "_result":I
    :sswitch_3f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 636
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 637
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getVoiceNetworkTypeForSubscriber(J)I

    move-result v21

    .line 638
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 639
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 640
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 644
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_40
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 646
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 647
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getIccOperatorNumeric(J)Ljava/lang/String;

    move-result-object v21

    .line 648
    .local v21, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 649
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 650
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 654
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_41
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 655
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->hasIccCard()Z

    move-result v21

    .line 656
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 657
    if-eqz v21, :cond_1c

    const/4 v2, 0x1

    :goto_1d
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 658
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 657
    :cond_1c
    const/4 v2, 0x0

    goto :goto_1d

    .line 662
    .end local v21    # "_result":Z
    :sswitch_42
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 664
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 665
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->hasIccCardUsingSlotId(I)Z

    move-result v21

    .line 666
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 667
    if-eqz v21, :cond_1d

    const/4 v2, 0x1

    :goto_1e
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 668
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 667
    :cond_1d
    const/4 v2, 0x0

    goto :goto_1e

    .line 672
    .end local v3    # "_arg0":I
    .end local v21    # "_result":Z
    :sswitch_43
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 673
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getLteOnCdmaMode()I

    move-result v21

    .line 674
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 675
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 676
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 680
    .end local v21    # "_result":I
    :sswitch_44
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 682
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 683
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getLteOnCdmaModeForSubscriber(J)I

    move-result v21

    .line 684
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 685
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 686
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 690
    .end local v12    # "_arg0":J
    .end local v21    # "_result":I
    :sswitch_45
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 691
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getAllCellInfo()Ljava/util/List;

    move-result-object v22

    .line 692
    .local v22, "_result":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/CellInfo;>;"
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 693
    move-object/from16 v0, p3

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    .line 694
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 698
    .end local v22    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/CellInfo;>;"
    :sswitch_46
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 700
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 701
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getAllCellInfoUsingSubId(J)Ljava/util/List;

    move-result-object v22

    .line 702
    .restart local v22    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/CellInfo;>;"
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 703
    move-object/from16 v0, p3

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    .line 704
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 708
    .end local v12    # "_arg0":J
    .end local v22    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/CellInfo;>;"
    :sswitch_47
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 710
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 711
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setCellInfoListRate(I)V

    .line 712
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 713
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 717
    .end local v3    # "_arg0":I
    :sswitch_48
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 718
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getDefaultSim()I

    move-result v21

    .line 719
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 720
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 721
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 725
    .end local v21    # "_result":I
    :sswitch_49
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 727
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 728
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->iccOpenLogicalChannel(Ljava/lang/String;)Landroid/telephony/IccOpenLogicalChannelResponse;

    move-result-object v21

    .line 729
    .local v21, "_result":Landroid/telephony/IccOpenLogicalChannelResponse;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 730
    if-eqz v21, :cond_1e

    .line 731
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 732
    const/4 v2, 0x1

    move-object/from16 v0, v21

    move-object/from16 v1, p3

    invoke-virtual {v0, v1, v2}, Landroid/telephony/IccOpenLogicalChannelResponse;->writeToParcel(Landroid/os/Parcel;I)V

    .line 737
    :goto_1f
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 735
    :cond_1e
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_1f

    .line 741
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":Landroid/telephony/IccOpenLogicalChannelResponse;
    :sswitch_4a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 743
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 745
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 746
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->iccOpenLogicalChannelUsingSubId(JLjava/lang/String;)Landroid/telephony/IccOpenLogicalChannelResponse;

    move-result-object v21

    .line 747
    .restart local v21    # "_result":Landroid/telephony/IccOpenLogicalChannelResponse;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 748
    if-eqz v21, :cond_1f

    .line 749
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 750
    const/4 v2, 0x1

    move-object/from16 v0, v21

    move-object/from16 v1, p3

    invoke-virtual {v0, v1, v2}, Landroid/telephony/IccOpenLogicalChannelResponse;->writeToParcel(Landroid/os/Parcel;I)V

    .line 755
    :goto_20
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 753
    :cond_1f
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_20

    .line 759
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Landroid/telephony/IccOpenLogicalChannelResponse;
    :sswitch_4b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 761
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 762
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->iccCloseLogicalChannel(I)Z

    move-result v21

    .line 763
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 764
    if-eqz v21, :cond_20

    const/4 v2, 0x1

    :goto_21
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 765
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 764
    :cond_20
    const/4 v2, 0x0

    goto :goto_21

    .line 769
    .end local v3    # "_arg0":I
    .end local v21    # "_result":Z
    :sswitch_4c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 771
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 773
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 774
    .local v4, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->iccCloseLogicalChannelUsingSubId(JI)Z

    move-result v21

    .line 775
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 776
    if-eqz v21, :cond_21

    const/4 v2, 0x1

    :goto_22
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 777
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 776
    :cond_21
    const/4 v2, 0x0

    goto :goto_22

    .line 781
    .end local v4    # "_arg1":I
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_4d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 783
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 785
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 787
    .restart local v4    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 789
    .local v5, "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 791
    .local v6, "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 793
    .local v7, "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .line 795
    .local v8, "_arg5":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v9

    .local v9, "_arg6":Ljava/lang/String;
    move-object/from16 v2, p0

    .line 796
    invoke-virtual/range {v2 .. v9}, Lcom/android/internal/telephony/ITelephony$Stub;->iccTransmitApduLogicalChannel(IIIIIILjava/lang/String;)Ljava/lang/String;

    move-result-object v21

    .line 797
    .local v21, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 798
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 799
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 803
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    .end local v6    # "_arg3":I
    .end local v7    # "_arg4":I
    .end local v8    # "_arg5":I
    .end local v9    # "_arg6":Ljava/lang/String;
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_4e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 805
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 807
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 809
    .restart local v4    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 811
    .restart local v5    # "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 813
    .restart local v6    # "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 815
    .restart local v7    # "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .line 817
    .restart local v8    # "_arg5":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v9

    .line 819
    .local v9, "_arg6":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v20

    .local v20, "_arg7":Ljava/lang/String;
    move-object/from16 v11, p0

    move v14, v4

    move v15, v5

    move/from16 v16, v6

    move/from16 v17, v7

    move/from16 v18, v8

    move/from16 v19, v9

    .line 820
    invoke-virtual/range {v11 .. v20}, Lcom/android/internal/telephony/ITelephony$Stub;->iccTransmitApduLogicalChannelUsingSubId(JIIIIIILjava/lang/String;)Ljava/lang/String;

    move-result-object v21

    .line 821
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 822
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 823
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 827
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    .end local v6    # "_arg3":I
    .end local v7    # "_arg4":I
    .end local v8    # "_arg5":I
    .end local v9    # "_arg6":I
    .end local v12    # "_arg0":J
    .end local v20    # "_arg7":Ljava/lang/String;
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_4f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 829
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 831
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 833
    .restart local v4    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 835
    .restart local v5    # "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 837
    .restart local v6    # "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 839
    .restart local v7    # "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .local v8, "_arg5":Ljava/lang/String;
    move-object/from16 v2, p0

    .line 840
    invoke-virtual/range {v2 .. v8}, Lcom/android/internal/telephony/ITelephony$Stub;->iccTransmitApduBasicChannel(IIIIILjava/lang/String;)Ljava/lang/String;

    move-result-object v21

    .line 841
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 842
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 843
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 847
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    .end local v6    # "_arg3":I
    .end local v7    # "_arg4":I
    .end local v8    # "_arg5":Ljava/lang/String;
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_50
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 849
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 851
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 853
    .restart local v4    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 855
    .restart local v5    # "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 857
    .restart local v6    # "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 859
    .restart local v7    # "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .line 861
    .local v8, "_arg5":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v9

    .local v9, "_arg6":Ljava/lang/String;
    move-object/from16 v11, p0

    move v14, v4

    move v15, v5

    move/from16 v16, v6

    move/from16 v17, v7

    move/from16 v18, v8

    move-object/from16 v19, v9

    .line 862
    invoke-virtual/range {v11 .. v19}, Lcom/android/internal/telephony/ITelephony$Stub;->iccTransmitApduBasicChannelUsingSubId(JIIIIILjava/lang/String;)Ljava/lang/String;

    move-result-object v21

    .line 863
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 864
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 865
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 869
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    .end local v6    # "_arg3":I
    .end local v7    # "_arg4":I
    .end local v8    # "_arg5":I
    .end local v9    # "_arg6":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_51
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 871
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 873
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 875
    .restart local v4    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 877
    .restart local v5    # "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 879
    .restart local v6    # "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 881
    .restart local v7    # "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .local v8, "_arg5":Ljava/lang/String;
    move-object/from16 v2, p0

    .line 882
    invoke-virtual/range {v2 .. v8}, Lcom/android/internal/telephony/ITelephony$Stub;->iccExchangeSimIO(IIIIILjava/lang/String;)[B

    move-result-object v21

    .line 883
    .local v21, "_result":[B
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 884
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeByteArray([B)V

    .line 885
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 889
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    .end local v6    # "_arg3":I
    .end local v7    # "_arg4":I
    .end local v8    # "_arg5":Ljava/lang/String;
    .end local v21    # "_result":[B
    :sswitch_52
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 891
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 893
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 895
    .restart local v4    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 897
    .restart local v5    # "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 899
    .restart local v6    # "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .line 901
    .restart local v7    # "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .line 903
    .local v8, "_arg5":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v9

    .restart local v9    # "_arg6":Ljava/lang/String;
    move-object/from16 v11, p0

    move v14, v4

    move v15, v5

    move/from16 v16, v6

    move/from16 v17, v7

    move/from16 v18, v8

    move-object/from16 v19, v9

    .line 904
    invoke-virtual/range {v11 .. v19}, Lcom/android/internal/telephony/ITelephony$Stub;->iccExchangeSimIOUsingSubId(JIIIIILjava/lang/String;)[B

    move-result-object v21

    .line 905
    .restart local v21    # "_result":[B
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 906
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeByteArray([B)V

    .line 907
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 911
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    .end local v6    # "_arg3":I
    .end local v7    # "_arg4":I
    .end local v8    # "_arg5":I
    .end local v9    # "_arg6":Ljava/lang/String;
    .end local v12    # "_arg0":J
    .end local v21    # "_result":[B
    :sswitch_53
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 913
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 914
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->sendEnvelopeWithStatus(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    .line 915
    .local v21, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 916
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 917
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 921
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_54
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 923
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 924
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->nvReadItem(I)Ljava/lang/String;

    move-result-object v21

    .line 925
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 926
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 927
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 931
    .end local v3    # "_arg0":I
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_55
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 933
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 935
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 936
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->nvWriteItem(ILjava/lang/String;)Z

    move-result v21

    .line 937
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 938
    if-eqz v21, :cond_22

    const/4 v2, 0x1

    :goto_23
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 939
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 938
    :cond_22
    const/4 v2, 0x0

    goto :goto_23

    .line 943
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v21    # "_result":Z
    :sswitch_56
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 945
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v3

    .line 946
    .local v3, "_arg0":[B
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->nvWriteCdmaPrl([B)Z

    move-result v21

    .line 947
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 948
    if-eqz v21, :cond_23

    const/4 v2, 0x1

    :goto_24
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 949
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 948
    :cond_23
    const/4 v2, 0x0

    goto :goto_24

    .line 953
    .end local v3    # "_arg0":[B
    .end local v21    # "_result":Z
    :sswitch_57
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 955
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 956
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->nvResetConfig(I)Z

    move-result v21

    .line 957
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 958
    if-eqz v21, :cond_24

    const/4 v2, 0x1

    :goto_25
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 959
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 958
    :cond_24
    const/4 v2, 0x0

    goto :goto_25

    .line 963
    .end local v3    # "_arg0":I
    .end local v21    # "_result":Z
    :sswitch_58
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 964
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getCalculatedPreferredNetworkType()I

    move-result v21

    .line 965
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 966
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 967
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 971
    .end local v21    # "_result":I
    :sswitch_59
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 972
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getPreferredNetworkType()I

    move-result v21

    .line 973
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 974
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 975
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 979
    .end local v21    # "_result":I
    :sswitch_5a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 981
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 982
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setPreferredNetworkType(I)Z

    move-result v21

    .line 983
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 984
    if-eqz v21, :cond_25

    const/4 v2, 0x1

    :goto_26
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 985
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 984
    :cond_25
    const/4 v2, 0x0

    goto :goto_26

    .line 989
    .end local v3    # "_arg0":I
    .end local v21    # "_result":Z
    :sswitch_5b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 991
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_26

    const/4 v3, 0x1

    .line 992
    .local v3, "_arg0":Z
    :goto_27
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setDataEnabled(Z)V

    .line 993
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 994
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 991
    .end local v3    # "_arg0":Z
    :cond_26
    const/4 v3, 0x0

    goto :goto_27

    .line 998
    :sswitch_5c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1000
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1002
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_27

    const/4 v4, 0x1

    .line 1003
    .local v4, "_arg1":Z
    :goto_28
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->setDataEnabledUsingSubId(JZ)V

    .line 1004
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1005
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1002
    .end local v4    # "_arg1":Z
    :cond_27
    const/4 v4, 0x0

    goto :goto_28

    .line 1009
    .end local v12    # "_arg0":J
    :sswitch_5d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1010
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getDataEnabled()Z

    move-result v21

    .line 1011
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1012
    if-eqz v21, :cond_28

    const/4 v2, 0x1

    :goto_29
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1013
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1012
    :cond_28
    const/4 v2, 0x0

    goto :goto_29

    .line 1017
    .end local v21    # "_result":Z
    :sswitch_5e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1019
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1020
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v21

    .line 1021
    .local v21, "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1022
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 1023
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1027
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":[Ljava/lang/String;
    :sswitch_5f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1029
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_29

    const/4 v3, 0x1

    .line 1030
    .local v3, "_arg0":Z
    :goto_2a
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setImsRegistrationState(Z)V

    .line 1031
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1032
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1029
    .end local v3    # "_arg0":Z
    :cond_29
    const/4 v3, 0x0

    goto :goto_2a

    .line 1036
    :sswitch_60
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1038
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1039
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaMdn(J)Ljava/lang/String;

    move-result-object v21

    .line 1040
    .local v21, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1041
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1042
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1046
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_61
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1048
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1049
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getCdmaMin(J)Ljava/lang/String;

    move-result-object v21

    .line 1050
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1051
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1052
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1056
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_62
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1057
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->hasCarrierPrivileges()I

    move-result v21

    .line 1058
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1059
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1060
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1064
    .end local v21    # "_result":I
    :sswitch_63
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1066
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1067
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->checkCarrierPrivilegesForPackage(Ljava/lang/String;)I

    move-result v21

    .line 1068
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1069
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1070
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1074
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":I
    :sswitch_64
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1076
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_2a

    .line 1077
    sget-object v2, Landroid/content/Intent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/Intent;

    .line 1082
    .local v3, "_arg0":Landroid/content/Intent;
    :goto_2b
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->getCarrierPackageNamesForIntent(Landroid/content/Intent;)Ljava/util/List;

    move-result-object v24

    .line 1083
    .local v24, "_result":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1084
    move-object/from16 v0, p3

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeStringList(Ljava/util/List;)V

    .line 1085
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1080
    .end local v3    # "_arg0":Landroid/content/Intent;
    .end local v24    # "_result":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_2a
    const/4 v3, 0x0

    .restart local v3    # "_arg0":Landroid/content/Intent;
    goto :goto_2b

    .line 1089
    .end local v3    # "_arg0":Landroid/content/Intent;
    :sswitch_65
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1091
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1093
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_2b

    const/4 v4, 0x1

    .line 1094
    .restart local v4    # "_arg1":Z
    :goto_2c
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->enableSimplifiedNetworkSettingsForSubscriber(JZ)V

    .line 1095
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1096
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1093
    .end local v4    # "_arg1":Z
    :cond_2b
    const/4 v4, 0x0

    goto :goto_2c

    .line 1100
    .end local v12    # "_arg0":J
    :sswitch_66
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1102
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1103
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getSimplifiedNetworkSettingsEnabledForSubscriber(J)Z

    move-result v21

    .line 1104
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1105
    if-eqz v21, :cond_2c

    const/4 v2, 0x1

    :goto_2d
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1106
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1105
    :cond_2c
    const/4 v2, 0x0

    goto :goto_2d

    .line 1110
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Z
    :sswitch_67
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1112
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1114
    .restart local v12    # "_arg0":J
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1116
    .local v4, "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 1117
    .local v5, "_arg2":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13, v4, v5}, Lcom/android/internal/telephony/ITelephony$Stub;->setLine1NumberForDisplayForSubscriber(JLjava/lang/String;Ljava/lang/String;)V

    .line 1118
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1119
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1123
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v5    # "_arg2":Ljava/lang/String;
    .end local v12    # "_arg0":J
    :sswitch_68
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1125
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1126
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getLine1NumberForDisplay(J)Ljava/lang/String;

    move-result-object v21

    .line 1127
    .local v21, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1128
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1129
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1133
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_69
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1135
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1136
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getLine1AlphaTagForDisplay(J)Ljava/lang/String;

    move-result-object v21

    .line 1137
    .restart local v21    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1138
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1139
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1143
    .end local v12    # "_arg0":J
    .end local v21    # "_result":Ljava/lang/String;
    :sswitch_6a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1145
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1146
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setOperatorBrandOverride(Ljava/lang/String;)Z

    move-result v21

    .line 1147
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1148
    if-eqz v21, :cond_2d

    const/4 v2, 0x1

    :goto_2e
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1149
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1148
    :cond_2d
    const/4 v2, 0x0

    goto :goto_2e

    .line 1153
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":Z
    :sswitch_6b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1155
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v3

    .line 1157
    .local v3, "_arg0":[B
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v10

    .line 1158
    .local v10, "_arg1_length":I
    if-gez v10, :cond_2e

    .line 1159
    const/4 v4, 0x0

    .line 1164
    .local v4, "_arg1":[B
    :goto_2f
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->invokeOemRilRequestRaw([B[B)I

    move-result v21

    .line 1165
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1166
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1167
    move-object/from16 v0, p3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeByteArray([B)V

    .line 1168
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1162
    .end local v4    # "_arg1":[B
    .end local v21    # "_result":I
    :cond_2e
    new-array v4, v10, [B

    .restart local v4    # "_arg1":[B
    goto :goto_2f

    .line 1172
    .end local v3    # "_arg0":[B
    .end local v4    # "_arg1":[B
    .end local v10    # "_arg1_length":I
    :sswitch_6c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1174
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1176
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 1177
    .local v4, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->getDebugInfo(II)[I

    move-result-object v21

    .line 1178
    .local v21, "_result":[I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1179
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeIntArray([I)V

    .line 1180
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1184
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":I
    .end local v21    # "_result":[I
    :sswitch_6d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1186
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1188
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1190
    .local v4, "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 1191
    .restart local v5    # "_arg2":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Lcom/android/internal/telephony/ITelephony$Stub;->registerForCurrentVoIP(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1192
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1193
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1197
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v5    # "_arg2":Ljava/lang/String;
    :sswitch_6e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1198
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->unregisterForCurrentVoIP()V

    .line 1199
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1200
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1204
    :sswitch_6f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1205
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->setVoIPRining()V

    .line 1206
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1207
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1211
    :sswitch_70
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1212
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->setVoIPDialing()V

    .line 1213
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1214
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1218
    :sswitch_71
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1219
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->setVoIPInCall()V

    .line 1220
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1221
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1225
    :sswitch_72
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1226
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->setVoIPIdle()V

    .line 1227
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1228
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1232
    :sswitch_73
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1233
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->reenableStatusBarforVoIP()V

    .line 1234
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1235
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1239
    :sswitch_74
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1240
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->disableStatusBarforVoIP()V

    .line 1241
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1242
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1246
    :sswitch_75
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1247
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->busyCall()V

    .line 1248
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1249
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1253
    :sswitch_76
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1254
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isOemRinging()Z

    move-result v21

    .line 1255
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1256
    if-eqz v21, :cond_2f

    const/4 v2, 0x1

    :goto_30
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1257
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1256
    :cond_2f
    const/4 v2, 0x0

    goto :goto_30

    .line 1261
    .end local v21    # "_result":Z
    :sswitch_77
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1262
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->isOemDialing()Z

    move-result v21

    .line 1263
    .restart local v21    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1264
    if-eqz v21, :cond_30

    const/4 v2, 0x1

    :goto_31
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1265
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1264
    :cond_30
    const/4 v2, 0x0

    goto :goto_31

    .line 1269
    .end local v21    # "_result":Z
    :sswitch_78
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1271
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1272
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->handleDataInterface(Ljava/lang/String;)I

    move-result v21

    .line 1273
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1274
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1275
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1279
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v21    # "_result":I
    :sswitch_79
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1280
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getMipErrorCode()I

    move-result v21

    .line 1281
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1282
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1283
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1287
    .end local v21    # "_result":I
    :sswitch_7a
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1289
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1291
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 1292
    .local v4, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/telephony/ITelephony$Stub;->setDataDisabledFlag(II)I

    move-result v21

    .line 1293
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1294
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1295
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1299
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":I
    .end local v21    # "_result":I
    :sswitch_7b
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1301
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1302
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->clearDataDisabledFlag(I)I

    move-result v21

    .line 1303
    .restart local v21    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1304
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1305
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1309
    .end local v3    # "_arg0":I
    .end local v21    # "_result":I
    :sswitch_7c
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1311
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1312
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setNetworkModePreference(I)V

    .line 1313
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1314
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1318
    .end local v3    # "_arg0":I
    :sswitch_7d
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1319
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->getAtr()[B

    move-result-object v21

    .line 1320
    .local v21, "_result":[B
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1321
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeByteArray([B)V

    .line 1322
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1326
    .end local v21    # "_result":[B
    :sswitch_7e
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1328
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v12

    .line 1329
    .restart local v12    # "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v12, v13}, Lcom/android/internal/telephony/ITelephony$Stub;->getAtrUsingSubId(J)[B

    move-result-object v21

    .line 1330
    .restart local v21    # "_result":[B
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1331
    move-object/from16 v0, p3

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeByteArray([B)V

    .line 1332
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1336
    .end local v12    # "_arg0":J
    .end local v21    # "_result":[B
    :sswitch_7f
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1337
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->needMobileRadioShutdown()Z

    move-result v21

    .line 1338
    .local v21, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1339
    if-eqz v21, :cond_31

    const/4 v2, 0x1

    :goto_32
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1340
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1339
    :cond_31
    const/4 v2, 0x0

    goto :goto_32

    .line 1344
    .end local v21    # "_result":Z
    :sswitch_80
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1345
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/ITelephony$Stub;->shutdownMobileRadios()V

    .line 1346
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1347
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1351
    :sswitch_81
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1353
    sget-object v2, Landroid/telephony/PhoneRatFamily;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->createTypedArray(Landroid/os/Parcelable$Creator;)[Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Landroid/telephony/PhoneRatFamily;

    .line 1354
    .local v3, "_arg0":[Landroid/telephony/PhoneRatFamily;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->setPhoneRat([Landroid/telephony/PhoneRatFamily;)V

    .line 1355
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1356
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1360
    .end local v3    # "_arg0":[Landroid/telephony/PhoneRatFamily;
    :sswitch_82
    const-string v2, "com.android.internal.telephony.ITelephony"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1362
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1363
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/ITelephony$Stub;->getPhoneRat(I)I

    move-result v21

    .line 1364
    .local v21, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1365
    move-object/from16 v0, p3

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1366
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 45
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
        0x5b -> :sswitch_5b
        0x5c -> :sswitch_5c
        0x5d -> :sswitch_5d
        0x5e -> :sswitch_5e
        0x5f -> :sswitch_5f
        0x60 -> :sswitch_60
        0x61 -> :sswitch_61
        0x62 -> :sswitch_62
        0x63 -> :sswitch_63
        0x64 -> :sswitch_64
        0x65 -> :sswitch_65
        0x66 -> :sswitch_66
        0x67 -> :sswitch_67
        0x68 -> :sswitch_68
        0x69 -> :sswitch_69
        0x6a -> :sswitch_6a
        0x6b -> :sswitch_6b
        0x6c -> :sswitch_6c
        0x6d -> :sswitch_6d
        0x6e -> :sswitch_6e
        0x6f -> :sswitch_6f
        0x70 -> :sswitch_70
        0x71 -> :sswitch_71
        0x72 -> :sswitch_72
        0x73 -> :sswitch_73
        0x74 -> :sswitch_74
        0x75 -> :sswitch_75
        0x76 -> :sswitch_76
        0x77 -> :sswitch_77
        0x78 -> :sswitch_78
        0x79 -> :sswitch_79
        0x7a -> :sswitch_7a
        0x7b -> :sswitch_7b
        0x7c -> :sswitch_7c
        0x7d -> :sswitch_7d
        0x7e -> :sswitch_7e
        0x7f -> :sswitch_7f
        0x80 -> :sswitch_80
        0x81 -> :sswitch_81
        0x82 -> :sswitch_82
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
