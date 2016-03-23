.class public abstract Landroid/net/IConnectivityManager$Stub;
.super Landroid/os/Binder;
.source "IConnectivityManager.java"

# interfaces
.implements Landroid/net/IConnectivityManager;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/net/IConnectivityManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/net/IConnectivityManager$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.net.IConnectivityManager"

.field static final TRANSACTION_addVpnAddress:I = 0x58

.field static final TRANSACTION_captivePortalCheckCompleted:I = 0x2d

.field static final TRANSACTION_checkLteConnectState:I = 0x49

.field static final TRANSACTION_checkMobileProvisioning:I = 0x30

.field static final TRANSACTION_checkVzwNetType:I = 0x46

.field static final TRANSACTION_ePDGHandOverStatus:I = 0x51

.field static final TRANSACTION_ePDGPrefTechdone:I = 0x50

.field static final TRANSACTION_ePDGlisten:I = 0x4e

.field static final TRANSACTION_establishVpn:I = 0x28

.field static final TRANSACTION_findConnectionTypeForIface:I = 0x2f

.field static final TRANSACTION_getActiveLinkProperties:I = 0xa

.field static final TRANSACTION_getActiveLinkQualityInfo:I = 0x34

.field static final TRANSACTION_getActiveNetworkInfo:I = 0x1

.field static final TRANSACTION_getActiveNetworkInfoForUid:I = 0x2

.field static final TRANSACTION_getActiveNetworkQuotaInfo:I = 0xf

.field static final TRANSACTION_getAllLinkQualityInfo:I = 0x35

.field static final TRANSACTION_getAllNetworkInfo:I = 0x5

.field static final TRANSACTION_getAllNetworkState:I = 0xe

.field static final TRANSACTION_getAllNetworks:I = 0x7

.field static final TRANSACTION_getDebugInfo:I = 0x54

.field static final TRANSACTION_getGlobalProxy:I = 0x22

.field static final TRANSACTION_getIPpcscAddress:I = 0x56

.field static final TRANSACTION_getLastTetherError:I = 0x15

.field static final TRANSACTION_getLegacyVpnInfo:I = 0x2b

.field static final TRANSACTION_getLinkProperties:I = 0xc

.field static final TRANSACTION_getLinkPropertiesForType:I = 0xb

.field static final TRANSACTION_getLinkQualityInfo:I = 0x33

.field static final TRANSACTION_getMobileProvisioningUrl:I = 0x31

.field static final TRANSACTION_getMobileRedirectedProvisioningUrl:I = 0x32

.field static final TRANSACTION_getNetPrefer:I = 0x57

.field static final TRANSACTION_getNetworkCapabilities:I = 0xd

.field static final TRANSACTION_getNetworkForType:I = 0x6

.field static final TRANSACTION_getNetworkInfo:I = 0x3

.field static final TRANSACTION_getNetworkInfoForNetwork:I = 0x4

.field static final TRANSACTION_getNetworkStatus_for_kt_kaf:I = 0x5a

.field static final TRANSACTION_getPcscfAddress:I = 0x55

.field static final TRANSACTION_getProvisioningOrActiveNetworkInfo:I = 0x8

.field static final TRANSACTION_getProxy:I = 0x24

.field static final TRANSACTION_getRestoreDefaultNetworkDelay:I = 0x4b

.field static final TRANSACTION_getTetherConnectedSta:I = 0x1f

.field static final TRANSACTION_getTetherableBluetoothRegexs:I = 0x1d

.field static final TRANSACTION_getTetherableIfaces:I = 0x17

.field static final TRANSACTION_getTetherableUsbRegexs:I = 0x1b

.field static final TRANSACTION_getTetherableWifiRegexs:I = 0x1c

.field static final TRANSACTION_getTetheredDhcpRanges:I = 0x1a

.field static final TRANSACTION_getTetheredIfaces:I = 0x18

.field static final TRANSACTION_getTetheringErroredIfaces:I = 0x19

.field static final TRANSACTION_getVpnConfig:I = 0x29

.field static final TRANSACTION_isActiveNetworkMetered:I = 0x10

.field static final TRANSACTION_isContainVzwAppApn_MetaTag:I = 0x44

.field static final TRANSACTION_isNetworkSupported:I = 0x9

.field static final TRANSACTION_isSignedFromVZW:I = 0x45

.field static final TRANSACTION_isSystemImage:I = 0x43

.field static final TRANSACTION_isTetheringSupported:I = 0x16

.field static final TRANSACTION_listenForNetwork:I = 0x3d

.field static final TRANSACTION_mobileDataPdpReset:I = 0x4a

.field static final TRANSACTION_notifyEPDGCallResult:I = 0x52

.field static final TRANSACTION_notifyEPDGPDNStatus:I = 0x53

.field static final TRANSACTION_pendingListenForNetwork:I = 0x3e

.field static final TRANSACTION_pendingRequestForNetwork:I = 0x3c

.field static final TRANSACTION_prepareVpn:I = 0x26

.field static final TRANSACTION_registerNetworkAgent:I = 0x3a

.field static final TRANSACTION_registerNetworkFactory:I = 0x38

.field static final TRANSACTION_releaseNetworkRequest:I = 0x3f

.field static final TRANSACTION_removeVpnAddress:I = 0x59

.field static final TRANSACTION_reportBadNetwork:I = 0x21

.field static final TRANSACTION_reportInetCondition:I = 0x20

.field static final TRANSACTION_requestNetwork:I = 0x3b

.field static final TRANSACTION_requestRemRouteToHostAddress:I = 0x41

.field static final TRANSACTION_requestRemoveImsRoute:I = 0x42

.field static final TRANSACTION_requestRouteToHostAddress:I = 0x11

.field static final TRANSACTION_setAirplaneMode:I = 0x37

.field static final TRANSACTION_setDataConnectionMessanger:I = 0x40

.field static final TRANSACTION_setDataDependency:I = 0x25

.field static final TRANSACTION_setFQDN:I = 0x4f

.field static final TRANSACTION_setGlobalProxy:I = 0x23

.field static final TRANSACTION_setLteMobileDataEnabled:I = 0x48

.field static final TRANSACTION_setPolicyDataEnable:I = 0x12

.field static final TRANSACTION_setProvisioningNotificationVisible:I = 0x36

.field static final TRANSACTION_setRoamingDataEnabled_RILCMD:I = 0x47

.field static final TRANSACTION_setUsbTethering:I = 0x1e

.field static final TRANSACTION_setVpnPackageAuthorization:I = 0x27

.field static final TRANSACTION_startLegacyVpn:I = 0x2a

.field static final TRANSACTION_startusingEPDGFeature:I = 0x4c

.field static final TRANSACTION_stopusingEPDGFeature:I = 0x4d

.field static final TRANSACTION_supplyMessenger:I = 0x2e

.field static final TRANSACTION_tether:I = 0x13

.field static final TRANSACTION_unregisterNetworkFactory:I = 0x39

.field static final TRANSACTION_untether:I = 0x14

.field static final TRANSACTION_updateLockdownVpn:I = 0x2c


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 19
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 20
    const-string v0, "android.net.IConnectivityManager"

    invoke-virtual {p0, p0, v0}, Landroid/net/IConnectivityManager$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 21
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/net/IConnectivityManager;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 28
    if-nez p0, :cond_0

    .line 29
    const/4 v0, 0x0

    .line 35
    :goto_0
    return-object v0

    .line 31
    :cond_0
    const-string v1, "android.net.IConnectivityManager"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 32
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/net/IConnectivityManager;

    if-eqz v1, :cond_1

    .line 33
    check-cast v0, Landroid/net/IConnectivityManager;

    goto :goto_0

    .line 35
    :cond_1
    new-instance v0, Landroid/net/IConnectivityManager$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Landroid/net/IConnectivityManager$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 39
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 15
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
    .line 43
    sparse-switch p1, :sswitch_data_0

    .line 1207
    invoke-super/range {p0 .. p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v1

    :goto_0
    return v1

    .line 47
    :sswitch_0
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 48
    const/4 v1, 0x1

    goto :goto_0

    .line 52
    :sswitch_1
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 53
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v13

    .line 54
    .local v13, "_result":Landroid/net/NetworkInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 55
    if-eqz v13, :cond_0

    .line 56
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 57
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 62
    :goto_1
    const/4 v1, 0x1

    goto :goto_0

    .line 60
    :cond_0
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_1

    .line 66
    .end local v13    # "_result":Landroid/net/NetworkInfo;
    :sswitch_2
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 68
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 69
    .local v2, "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getActiveNetworkInfoForUid(I)Landroid/net/NetworkInfo;

    move-result-object v13

    .line 70
    .restart local v13    # "_result":Landroid/net/NetworkInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 71
    if-eqz v13, :cond_1

    .line 72
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 73
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 78
    :goto_2
    const/4 v1, 0x1

    goto :goto_0

    .line 76
    :cond_1
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_2

    .line 82
    .end local v2    # "_arg0":I
    .end local v13    # "_result":Landroid/net/NetworkInfo;
    :sswitch_3
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 84
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 85
    .restart local v2    # "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v13

    .line 86
    .restart local v13    # "_result":Landroid/net/NetworkInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 87
    if-eqz v13, :cond_2

    .line 88
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 89
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 94
    :goto_3
    const/4 v1, 0x1

    goto :goto_0

    .line 92
    :cond_2
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_3

    .line 98
    .end local v2    # "_arg0":I
    .end local v13    # "_result":Landroid/net/NetworkInfo;
    :sswitch_4
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 100
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_3

    .line 101
    sget-object v1, Landroid/net/Network;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/Network;

    .line 106
    .local v2, "_arg0":Landroid/net/Network;
    :goto_4
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getNetworkInfoForNetwork(Landroid/net/Network;)Landroid/net/NetworkInfo;

    move-result-object v13

    .line 107
    .restart local v13    # "_result":Landroid/net/NetworkInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 108
    if-eqz v13, :cond_4

    .line 109
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 110
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 115
    :goto_5
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 104
    .end local v2    # "_arg0":Landroid/net/Network;
    .end local v13    # "_result":Landroid/net/NetworkInfo;
    :cond_3
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/Network;
    goto :goto_4

    .line 113
    .restart local v13    # "_result":Landroid/net/NetworkInfo;
    :cond_4
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_5

    .line 119
    .end local v2    # "_arg0":Landroid/net/Network;
    .end local v13    # "_result":Landroid/net/NetworkInfo;
    :sswitch_5
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 120
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getAllNetworkInfo()[Landroid/net/NetworkInfo;

    move-result-object v13

    .line 121
    .local v13, "_result":[Landroid/net/NetworkInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 122
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v13, v1}, Landroid/os/Parcel;->writeTypedArray([Landroid/os/Parcelable;I)V

    .line 123
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 127
    .end local v13    # "_result":[Landroid/net/NetworkInfo;
    :sswitch_6
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 129
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 130
    .local v2, "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getNetworkForType(I)Landroid/net/Network;

    move-result-object v13

    .line 131
    .local v13, "_result":Landroid/net/Network;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 132
    if-eqz v13, :cond_5

    .line 133
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 134
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/Network;->writeToParcel(Landroid/os/Parcel;I)V

    .line 139
    :goto_6
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 137
    :cond_5
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_6

    .line 143
    .end local v2    # "_arg0":I
    .end local v13    # "_result":Landroid/net/Network;
    :sswitch_7
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 144
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getAllNetworks()[Landroid/net/Network;

    move-result-object v13

    .line 145
    .local v13, "_result":[Landroid/net/Network;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 146
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v13, v1}, Landroid/os/Parcel;->writeTypedArray([Landroid/os/Parcelable;I)V

    .line 147
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 151
    .end local v13    # "_result":[Landroid/net/Network;
    :sswitch_8
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 152
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getProvisioningOrActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v13

    .line 153
    .local v13, "_result":Landroid/net/NetworkInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 154
    if-eqz v13, :cond_6

    .line 155
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 156
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 161
    :goto_7
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 159
    :cond_6
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_7

    .line 165
    .end local v13    # "_result":Landroid/net/NetworkInfo;
    :sswitch_9
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 167
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 168
    .restart local v2    # "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->isNetworkSupported(I)Z

    move-result v13

    .line 169
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 170
    if-eqz v13, :cond_7

    const/4 v1, 0x1

    :goto_8
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 171
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 170
    :cond_7
    const/4 v1, 0x0

    goto :goto_8

    .line 175
    .end local v2    # "_arg0":I
    .end local v13    # "_result":Z
    :sswitch_a
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 176
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getActiveLinkProperties()Landroid/net/LinkProperties;

    move-result-object v13

    .line 177
    .local v13, "_result":Landroid/net/LinkProperties;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 178
    if-eqz v13, :cond_8

    .line 179
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 180
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/LinkProperties;->writeToParcel(Landroid/os/Parcel;I)V

    .line 185
    :goto_9
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 183
    :cond_8
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_9

    .line 189
    .end local v13    # "_result":Landroid/net/LinkProperties;
    :sswitch_b
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 191
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 192
    .restart local v2    # "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getLinkPropertiesForType(I)Landroid/net/LinkProperties;

    move-result-object v13

    .line 193
    .restart local v13    # "_result":Landroid/net/LinkProperties;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 194
    if-eqz v13, :cond_9

    .line 195
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 196
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/LinkProperties;->writeToParcel(Landroid/os/Parcel;I)V

    .line 201
    :goto_a
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 199
    :cond_9
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_a

    .line 205
    .end local v2    # "_arg0":I
    .end local v13    # "_result":Landroid/net/LinkProperties;
    :sswitch_c
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 207
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_a

    .line 208
    sget-object v1, Landroid/net/Network;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/Network;

    .line 213
    .local v2, "_arg0":Landroid/net/Network;
    :goto_b
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getLinkProperties(Landroid/net/Network;)Landroid/net/LinkProperties;

    move-result-object v13

    .line 214
    .restart local v13    # "_result":Landroid/net/LinkProperties;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 215
    if-eqz v13, :cond_b

    .line 216
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 217
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/LinkProperties;->writeToParcel(Landroid/os/Parcel;I)V

    .line 222
    :goto_c
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 211
    .end local v2    # "_arg0":Landroid/net/Network;
    .end local v13    # "_result":Landroid/net/LinkProperties;
    :cond_a
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/Network;
    goto :goto_b

    .line 220
    .restart local v13    # "_result":Landroid/net/LinkProperties;
    :cond_b
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_c

    .line 226
    .end local v2    # "_arg0":Landroid/net/Network;
    .end local v13    # "_result":Landroid/net/LinkProperties;
    :sswitch_d
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 228
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_c

    .line 229
    sget-object v1, Landroid/net/Network;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/Network;

    .line 234
    .restart local v2    # "_arg0":Landroid/net/Network;
    :goto_d
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v13

    .line 235
    .local v13, "_result":Landroid/net/NetworkCapabilities;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 236
    if-eqz v13, :cond_d

    .line 237
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 238
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkCapabilities;->writeToParcel(Landroid/os/Parcel;I)V

    .line 243
    :goto_e
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 232
    .end local v2    # "_arg0":Landroid/net/Network;
    .end local v13    # "_result":Landroid/net/NetworkCapabilities;
    :cond_c
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/Network;
    goto :goto_d

    .line 241
    .restart local v13    # "_result":Landroid/net/NetworkCapabilities;
    :cond_d
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_e

    .line 247
    .end local v2    # "_arg0":Landroid/net/Network;
    .end local v13    # "_result":Landroid/net/NetworkCapabilities;
    :sswitch_e
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 248
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getAllNetworkState()[Landroid/net/NetworkState;

    move-result-object v13

    .line 249
    .local v13, "_result":[Landroid/net/NetworkState;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 250
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v13, v1}, Landroid/os/Parcel;->writeTypedArray([Landroid/os/Parcelable;I)V

    .line 251
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 255
    .end local v13    # "_result":[Landroid/net/NetworkState;
    :sswitch_f
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 256
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getActiveNetworkQuotaInfo()Landroid/net/NetworkQuotaInfo;

    move-result-object v13

    .line 257
    .local v13, "_result":Landroid/net/NetworkQuotaInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 258
    if-eqz v13, :cond_e

    .line 259
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 260
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkQuotaInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 265
    :goto_f
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 263
    :cond_e
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_f

    .line 269
    .end local v13    # "_result":Landroid/net/NetworkQuotaInfo;
    :sswitch_10
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 270
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->isActiveNetworkMetered()Z

    move-result v13

    .line 271
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 272
    if-eqz v13, :cond_f

    const/4 v1, 0x1

    :goto_10
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 273
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 272
    :cond_f
    const/4 v1, 0x0

    goto :goto_10

    .line 277
    .end local v13    # "_result":Z
    :sswitch_11
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 279
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 281
    .local v2, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v3

    .line 282
    .local v3, "_arg1":[B
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->requestRouteToHostAddress(I[B)Z

    move-result v13

    .line 283
    .restart local v13    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 284
    if-eqz v13, :cond_10

    const/4 v1, 0x1

    :goto_11
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 285
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 284
    :cond_10
    const/4 v1, 0x0

    goto :goto_11

    .line 289
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":[B
    .end local v13    # "_result":Z
    :sswitch_12
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 291
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 293
    .restart local v2    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_11

    const/4 v3, 0x1

    .line 294
    .local v3, "_arg1":Z
    :goto_12
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->setPolicyDataEnable(IZ)V

    .line 295
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 296
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 293
    .end local v3    # "_arg1":Z
    :cond_11
    const/4 v3, 0x0

    goto :goto_12

    .line 300
    .end local v2    # "_arg0":I
    :sswitch_13
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 302
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 303
    .local v2, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->tether(Ljava/lang/String;)I

    move-result v13

    .line 304
    .local v13, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 305
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 306
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 310
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_14
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 312
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 313
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->untether(Ljava/lang/String;)I

    move-result v13

    .line 314
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 315
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 316
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 320
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_15
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 322
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 323
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getLastTetherError(Ljava/lang/String;)I

    move-result v13

    .line 324
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 325
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 326
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 330
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_16
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 331
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->isTetheringSupported()Z

    move-result v13

    .line 332
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 333
    if-eqz v13, :cond_12

    const/4 v1, 0x1

    :goto_13
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 334
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 333
    :cond_12
    const/4 v1, 0x0

    goto :goto_13

    .line 338
    .end local v13    # "_result":Z
    :sswitch_17
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 339
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetherableIfaces()[Ljava/lang/String;

    move-result-object v13

    .line 340
    .local v13, "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 341
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 342
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 346
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_18
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 347
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetheredIfaces()[Ljava/lang/String;

    move-result-object v13

    .line 348
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 349
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 350
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 354
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_19
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 355
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetheringErroredIfaces()[Ljava/lang/String;

    move-result-object v13

    .line 356
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 357
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 358
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 362
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_1a
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 363
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetheredDhcpRanges()[Ljava/lang/String;

    move-result-object v13

    .line 364
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 365
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 366
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 370
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_1b
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 371
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetherableUsbRegexs()[Ljava/lang/String;

    move-result-object v13

    .line 372
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 373
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 374
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 378
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_1c
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 379
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetherableWifiRegexs()[Ljava/lang/String;

    move-result-object v13

    .line 380
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 381
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 382
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 386
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_1d
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 387
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetherableBluetoothRegexs()[Ljava/lang/String;

    move-result-object v13

    .line 388
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 389
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 390
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 394
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_1e
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 396
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_13

    const/4 v2, 0x1

    .line 397
    .local v2, "_arg0":Z
    :goto_14
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setUsbTethering(Z)I

    move-result v13

    .line 398
    .local v13, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 399
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 400
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 396
    .end local v2    # "_arg0":Z
    .end local v13    # "_result":I
    :cond_13
    const/4 v2, 0x0

    goto :goto_14

    .line 404
    :sswitch_1f
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 405
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getTetherConnectedSta()Ljava/util/List;

    move-result-object v14

    .line 406
    .local v14, "_result":Ljava/util/List;, "Ljava/util/List<Landroid/net/wifi/WifiDevice;>;"
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 407
    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    .line 408
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 412
    .end local v14    # "_result":Ljava/util/List;, "Ljava/util/List<Landroid/net/wifi/WifiDevice;>;"
    :sswitch_20
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 414
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 416
    .local v2, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 417
    .local v3, "_arg1":I
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->reportInetCondition(II)V

    .line 418
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 419
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 423
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":I
    :sswitch_21
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 425
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_14

    .line 426
    sget-object v1, Landroid/net/Network;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/Network;

    .line 431
    .local v2, "_arg0":Landroid/net/Network;
    :goto_15
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->reportBadNetwork(Landroid/net/Network;)V

    .line 432
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 433
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 429
    .end local v2    # "_arg0":Landroid/net/Network;
    :cond_14
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/Network;
    goto :goto_15

    .line 437
    .end local v2    # "_arg0":Landroid/net/Network;
    :sswitch_22
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 438
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getGlobalProxy()Landroid/net/ProxyInfo;

    move-result-object v13

    .line 439
    .local v13, "_result":Landroid/net/ProxyInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 440
    if-eqz v13, :cond_15

    .line 441
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 442
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/ProxyInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 447
    :goto_16
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 445
    :cond_15
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_16

    .line 451
    .end local v13    # "_result":Landroid/net/ProxyInfo;
    :sswitch_23
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 453
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_16

    .line 454
    sget-object v1, Landroid/net/ProxyInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/ProxyInfo;

    .line 459
    .local v2, "_arg0":Landroid/net/ProxyInfo;
    :goto_17
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setGlobalProxy(Landroid/net/ProxyInfo;)V

    .line 460
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 461
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 457
    .end local v2    # "_arg0":Landroid/net/ProxyInfo;
    :cond_16
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/ProxyInfo;
    goto :goto_17

    .line 465
    .end local v2    # "_arg0":Landroid/net/ProxyInfo;
    :sswitch_24
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 466
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getProxy()Landroid/net/ProxyInfo;

    move-result-object v13

    .line 467
    .restart local v13    # "_result":Landroid/net/ProxyInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 468
    if-eqz v13, :cond_17

    .line 469
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 470
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/ProxyInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 475
    :goto_18
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 473
    :cond_17
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_18

    .line 479
    .end local v13    # "_result":Landroid/net/ProxyInfo;
    :sswitch_25
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 481
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 483
    .local v2, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_18

    const/4 v3, 0x1

    .line 484
    .local v3, "_arg1":Z
    :goto_19
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->setDataDependency(IZ)V

    .line 485
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 486
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 483
    .end local v3    # "_arg1":Z
    :cond_18
    const/4 v3, 0x0

    goto :goto_19

    .line 490
    .end local v2    # "_arg0":I
    :sswitch_26
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 492
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 494
    .local v2, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 495
    .local v3, "_arg1":Ljava/lang/String;
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->prepareVpn(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v13

    .line 496
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 497
    if-eqz v13, :cond_19

    const/4 v1, 0x1

    :goto_1a
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 498
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 497
    :cond_19
    const/4 v1, 0x0

    goto :goto_1a

    .line 502
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v3    # "_arg1":Ljava/lang/String;
    .end local v13    # "_result":Z
    :sswitch_27
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 504
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_1a

    const/4 v2, 0x1

    .line 505
    .local v2, "_arg0":Z
    :goto_1b
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setVpnPackageAuthorization(Z)V

    .line 506
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 507
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 504
    .end local v2    # "_arg0":Z
    :cond_1a
    const/4 v2, 0x0

    goto :goto_1b

    .line 511
    :sswitch_28
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 513
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_1b

    .line 514
    sget-object v1, Lcom/android/internal/net/VpnConfig;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/internal/net/VpnConfig;

    .line 519
    .local v2, "_arg0":Lcom/android/internal/net/VpnConfig;
    :goto_1c
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->establishVpn(Lcom/android/internal/net/VpnConfig;)Landroid/os/ParcelFileDescriptor;

    move-result-object v13

    .line 520
    .local v13, "_result":Landroid/os/ParcelFileDescriptor;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 521
    if-eqz v13, :cond_1c

    .line 522
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 523
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/os/ParcelFileDescriptor;->writeToParcel(Landroid/os/Parcel;I)V

    .line 528
    :goto_1d
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 517
    .end local v2    # "_arg0":Lcom/android/internal/net/VpnConfig;
    .end local v13    # "_result":Landroid/os/ParcelFileDescriptor;
    :cond_1b
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Lcom/android/internal/net/VpnConfig;
    goto :goto_1c

    .line 526
    .restart local v13    # "_result":Landroid/os/ParcelFileDescriptor;
    :cond_1c
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_1d

    .line 532
    .end local v2    # "_arg0":Lcom/android/internal/net/VpnConfig;
    .end local v13    # "_result":Landroid/os/ParcelFileDescriptor;
    :sswitch_29
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 533
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getVpnConfig()Lcom/android/internal/net/VpnConfig;

    move-result-object v13

    .line 534
    .local v13, "_result":Lcom/android/internal/net/VpnConfig;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 535
    if-eqz v13, :cond_1d

    .line 536
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 537
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Lcom/android/internal/net/VpnConfig;->writeToParcel(Landroid/os/Parcel;I)V

    .line 542
    :goto_1e
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 540
    :cond_1d
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_1e

    .line 546
    .end local v13    # "_result":Lcom/android/internal/net/VpnConfig;
    :sswitch_2a
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 548
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_1e

    .line 549
    sget-object v1, Lcom/android/internal/net/VpnProfile;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/internal/net/VpnProfile;

    .line 554
    .local v2, "_arg0":Lcom/android/internal/net/VpnProfile;
    :goto_1f
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->startLegacyVpn(Lcom/android/internal/net/VpnProfile;)V

    .line 555
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 556
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 552
    .end local v2    # "_arg0":Lcom/android/internal/net/VpnProfile;
    :cond_1e
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Lcom/android/internal/net/VpnProfile;
    goto :goto_1f

    .line 560
    .end local v2    # "_arg0":Lcom/android/internal/net/VpnProfile;
    :sswitch_2b
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 561
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getLegacyVpnInfo()Lcom/android/internal/net/LegacyVpnInfo;

    move-result-object v13

    .line 562
    .local v13, "_result":Lcom/android/internal/net/LegacyVpnInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 563
    if-eqz v13, :cond_1f

    .line 564
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 565
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Lcom/android/internal/net/LegacyVpnInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 570
    :goto_20
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 568
    :cond_1f
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_20

    .line 574
    .end local v13    # "_result":Lcom/android/internal/net/LegacyVpnInfo;
    :sswitch_2c
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 575
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->updateLockdownVpn()Z

    move-result v13

    .line 576
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 577
    if-eqz v13, :cond_20

    const/4 v1, 0x1

    :goto_21
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 578
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 577
    :cond_20
    const/4 v1, 0x0

    goto :goto_21

    .line 582
    .end local v13    # "_result":Z
    :sswitch_2d
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 584
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_21

    .line 585
    sget-object v1, Landroid/net/NetworkInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/NetworkInfo;

    .line 591
    .local v2, "_arg0":Landroid/net/NetworkInfo;
    :goto_22
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_22

    const/4 v3, 0x1

    .line 592
    .local v3, "_arg1":Z
    :goto_23
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->captivePortalCheckCompleted(Landroid/net/NetworkInfo;Z)V

    .line 593
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 594
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 588
    .end local v2    # "_arg0":Landroid/net/NetworkInfo;
    .end local v3    # "_arg1":Z
    :cond_21
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/NetworkInfo;
    goto :goto_22

    .line 591
    :cond_22
    const/4 v3, 0x0

    goto :goto_23

    .line 598
    .end local v2    # "_arg0":Landroid/net/NetworkInfo;
    :sswitch_2e
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 600
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 602
    .local v2, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_23

    .line 603
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/os/Messenger;

    .line 608
    .local v3, "_arg1":Landroid/os/Messenger;
    :goto_24
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->supplyMessenger(ILandroid/os/Messenger;)V

    .line 609
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 610
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 606
    .end local v3    # "_arg1":Landroid/os/Messenger;
    :cond_23
    const/4 v3, 0x0

    .restart local v3    # "_arg1":Landroid/os/Messenger;
    goto :goto_24

    .line 614
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":Landroid/os/Messenger;
    :sswitch_2f
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 616
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 617
    .local v2, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->findConnectionTypeForIface(Ljava/lang/String;)I

    move-result v13

    .line 618
    .local v13, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 619
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 620
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 624
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_30
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 626
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 627
    .local v2, "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->checkMobileProvisioning(I)I

    move-result v13

    .line 628
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 629
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 630
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 634
    .end local v2    # "_arg0":I
    .end local v13    # "_result":I
    :sswitch_31
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 635
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getMobileProvisioningUrl()Ljava/lang/String;

    move-result-object v13

    .line 636
    .local v13, "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 637
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 638
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 642
    .end local v13    # "_result":Ljava/lang/String;
    :sswitch_32
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 643
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getMobileRedirectedProvisioningUrl()Ljava/lang/String;

    move-result-object v13

    .line 644
    .restart local v13    # "_result":Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 645
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 646
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 650
    .end local v13    # "_result":Ljava/lang/String;
    :sswitch_33
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 652
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 653
    .restart local v2    # "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getLinkQualityInfo(I)Landroid/net/LinkQualityInfo;

    move-result-object v13

    .line 654
    .local v13, "_result":Landroid/net/LinkQualityInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 655
    if-eqz v13, :cond_24

    .line 656
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 657
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/LinkQualityInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 662
    :goto_25
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 660
    :cond_24
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_25

    .line 666
    .end local v2    # "_arg0":I
    .end local v13    # "_result":Landroid/net/LinkQualityInfo;
    :sswitch_34
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 667
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getActiveLinkQualityInfo()Landroid/net/LinkQualityInfo;

    move-result-object v13

    .line 668
    .restart local v13    # "_result":Landroid/net/LinkQualityInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 669
    if-eqz v13, :cond_25

    .line 670
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 671
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/LinkQualityInfo;->writeToParcel(Landroid/os/Parcel;I)V

    .line 676
    :goto_26
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 674
    :cond_25
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_26

    .line 680
    .end local v13    # "_result":Landroid/net/LinkQualityInfo;
    :sswitch_35
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 681
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->getAllLinkQualityInfo()[Landroid/net/LinkQualityInfo;

    move-result-object v13

    .line 682
    .local v13, "_result":[Landroid/net/LinkQualityInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 683
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v13, v1}, Landroid/os/Parcel;->writeTypedArray([Landroid/os/Parcelable;I)V

    .line 684
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 688
    .end local v13    # "_result":[Landroid/net/LinkQualityInfo;
    :sswitch_36
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 690
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_26

    const/4 v2, 0x1

    .line 692
    .local v2, "_arg0":Z
    :goto_27
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 694
    .local v3, "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 695
    .local v4, "_arg2":Ljava/lang/String;
    invoke-virtual {p0, v2, v3, v4}, Landroid/net/IConnectivityManager$Stub;->setProvisioningNotificationVisible(ZILjava/lang/String;)V

    .line 696
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 697
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 690
    .end local v2    # "_arg0":Z
    .end local v3    # "_arg1":I
    .end local v4    # "_arg2":Ljava/lang/String;
    :cond_26
    const/4 v2, 0x0

    goto :goto_27

    .line 701
    :sswitch_37
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 703
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_27

    const/4 v2, 0x1

    .line 704
    .restart local v2    # "_arg0":Z
    :goto_28
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setAirplaneMode(Z)V

    .line 705
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 706
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 703
    .end local v2    # "_arg0":Z
    :cond_27
    const/4 v2, 0x0

    goto :goto_28

    .line 710
    :sswitch_38
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 712
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_28

    .line 713
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/Messenger;

    .line 719
    .local v2, "_arg0":Landroid/os/Messenger;
    :goto_29
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 720
    .local v3, "_arg1":Ljava/lang/String;
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->registerNetworkFactory(Landroid/os/Messenger;Ljava/lang/String;)V

    .line 721
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 722
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 716
    .end local v2    # "_arg0":Landroid/os/Messenger;
    .end local v3    # "_arg1":Ljava/lang/String;
    :cond_28
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/os/Messenger;
    goto :goto_29

    .line 726
    .end local v2    # "_arg0":Landroid/os/Messenger;
    :sswitch_39
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 728
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_29

    .line 729
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/Messenger;

    .line 734
    .restart local v2    # "_arg0":Landroid/os/Messenger;
    :goto_2a
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->unregisterNetworkFactory(Landroid/os/Messenger;)V

    .line 735
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 736
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 732
    .end local v2    # "_arg0":Landroid/os/Messenger;
    :cond_29
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/os/Messenger;
    goto :goto_2a

    .line 740
    .end local v2    # "_arg0":Landroid/os/Messenger;
    :sswitch_3a
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 742
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_2a

    .line 743
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/Messenger;

    .line 749
    .restart local v2    # "_arg0":Landroid/os/Messenger;
    :goto_2b
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_2b

    .line 750
    sget-object v1, Landroid/net/NetworkInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/NetworkInfo;

    .line 756
    .local v3, "_arg1":Landroid/net/NetworkInfo;
    :goto_2c
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_2c

    .line 757
    sget-object v1, Landroid/net/LinkProperties;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/LinkProperties;

    .line 763
    .local v4, "_arg2":Landroid/net/LinkProperties;
    :goto_2d
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_2d

    .line 764
    sget-object v1, Landroid/net/NetworkCapabilities;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/NetworkCapabilities;

    .line 770
    .local v5, "_arg3":Landroid/net/NetworkCapabilities;
    :goto_2e
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 772
    .local v6, "_arg4":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_2e

    .line 773
    sget-object v1, Landroid/net/NetworkMisc;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/net/NetworkMisc;

    .local v7, "_arg5":Landroid/net/NetworkMisc;
    :goto_2f
    move-object v1, p0

    .line 778
    invoke-virtual/range {v1 .. v7}, Landroid/net/IConnectivityManager$Stub;->registerNetworkAgent(Landroid/os/Messenger;Landroid/net/NetworkInfo;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;ILandroid/net/NetworkMisc;)V

    .line 779
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 780
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 746
    .end local v2    # "_arg0":Landroid/os/Messenger;
    .end local v3    # "_arg1":Landroid/net/NetworkInfo;
    .end local v4    # "_arg2":Landroid/net/LinkProperties;
    .end local v5    # "_arg3":Landroid/net/NetworkCapabilities;
    .end local v6    # "_arg4":I
    .end local v7    # "_arg5":Landroid/net/NetworkMisc;
    :cond_2a
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/os/Messenger;
    goto :goto_2b

    .line 753
    :cond_2b
    const/4 v3, 0x0

    .restart local v3    # "_arg1":Landroid/net/NetworkInfo;
    goto :goto_2c

    .line 760
    :cond_2c
    const/4 v4, 0x0

    .restart local v4    # "_arg2":Landroid/net/LinkProperties;
    goto :goto_2d

    .line 767
    :cond_2d
    const/4 v5, 0x0

    .restart local v5    # "_arg3":Landroid/net/NetworkCapabilities;
    goto :goto_2e

    .line 776
    .restart local v6    # "_arg4":I
    :cond_2e
    const/4 v7, 0x0

    .restart local v7    # "_arg5":Landroid/net/NetworkMisc;
    goto :goto_2f

    .line 784
    .end local v2    # "_arg0":Landroid/os/Messenger;
    .end local v3    # "_arg1":Landroid/net/NetworkInfo;
    .end local v4    # "_arg2":Landroid/net/LinkProperties;
    .end local v5    # "_arg3":Landroid/net/NetworkCapabilities;
    .end local v6    # "_arg4":I
    .end local v7    # "_arg5":Landroid/net/NetworkMisc;
    :sswitch_3b
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 786
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_2f

    .line 787
    sget-object v1, Landroid/net/NetworkCapabilities;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/NetworkCapabilities;

    .line 793
    .local v2, "_arg0":Landroid/net/NetworkCapabilities;
    :goto_30
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_30

    .line 794
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/os/Messenger;

    .line 800
    .local v3, "_arg1":Landroid/os/Messenger;
    :goto_31
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 802
    .local v4, "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v5

    .line 804
    .local v5, "_arg3":Landroid/os/IBinder;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .restart local v6    # "_arg4":I
    move-object v1, p0

    .line 805
    invoke-virtual/range {v1 .. v6}, Landroid/net/IConnectivityManager$Stub;->requestNetwork(Landroid/net/NetworkCapabilities;Landroid/os/Messenger;ILandroid/os/IBinder;I)Landroid/net/NetworkRequest;

    move-result-object v13

    .line 806
    .local v13, "_result":Landroid/net/NetworkRequest;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 807
    if-eqz v13, :cond_31

    .line 808
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 809
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkRequest;->writeToParcel(Landroid/os/Parcel;I)V

    .line 814
    :goto_32
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 790
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/os/Messenger;
    .end local v4    # "_arg2":I
    .end local v5    # "_arg3":Landroid/os/IBinder;
    .end local v6    # "_arg4":I
    .end local v13    # "_result":Landroid/net/NetworkRequest;
    :cond_2f
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    goto :goto_30

    .line 797
    :cond_30
    const/4 v3, 0x0

    .restart local v3    # "_arg1":Landroid/os/Messenger;
    goto :goto_31

    .line 812
    .restart local v4    # "_arg2":I
    .restart local v5    # "_arg3":Landroid/os/IBinder;
    .restart local v6    # "_arg4":I
    .restart local v13    # "_result":Landroid/net/NetworkRequest;
    :cond_31
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_32

    .line 818
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/os/Messenger;
    .end local v4    # "_arg2":I
    .end local v5    # "_arg3":Landroid/os/IBinder;
    .end local v6    # "_arg4":I
    .end local v13    # "_result":Landroid/net/NetworkRequest;
    :sswitch_3c
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 820
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_32

    .line 821
    sget-object v1, Landroid/net/NetworkCapabilities;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/NetworkCapabilities;

    .line 827
    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    :goto_33
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_33

    .line 828
    sget-object v1, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/PendingIntent;

    .line 833
    .local v3, "_arg1":Landroid/app/PendingIntent;
    :goto_34
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->pendingRequestForNetwork(Landroid/net/NetworkCapabilities;Landroid/app/PendingIntent;)Landroid/net/NetworkRequest;

    move-result-object v13

    .line 834
    .restart local v13    # "_result":Landroid/net/NetworkRequest;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 835
    if-eqz v13, :cond_34

    .line 836
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 837
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkRequest;->writeToParcel(Landroid/os/Parcel;I)V

    .line 842
    :goto_35
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 824
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/app/PendingIntent;
    .end local v13    # "_result":Landroid/net/NetworkRequest;
    :cond_32
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    goto :goto_33

    .line 831
    :cond_33
    const/4 v3, 0x0

    .restart local v3    # "_arg1":Landroid/app/PendingIntent;
    goto :goto_34

    .line 840
    .restart local v13    # "_result":Landroid/net/NetworkRequest;
    :cond_34
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_35

    .line 846
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/app/PendingIntent;
    .end local v13    # "_result":Landroid/net/NetworkRequest;
    :sswitch_3d
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 848
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_35

    .line 849
    sget-object v1, Landroid/net/NetworkCapabilities;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/NetworkCapabilities;

    .line 855
    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    :goto_36
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_36

    .line 856
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/os/Messenger;

    .line 862
    .local v3, "_arg1":Landroid/os/Messenger;
    :goto_37
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v4

    .line 863
    .local v4, "_arg2":Landroid/os/IBinder;
    invoke-virtual {p0, v2, v3, v4}, Landroid/net/IConnectivityManager$Stub;->listenForNetwork(Landroid/net/NetworkCapabilities;Landroid/os/Messenger;Landroid/os/IBinder;)Landroid/net/NetworkRequest;

    move-result-object v13

    .line 864
    .restart local v13    # "_result":Landroid/net/NetworkRequest;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 865
    if-eqz v13, :cond_37

    .line 866
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 867
    const/4 v1, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v13, v0, v1}, Landroid/net/NetworkRequest;->writeToParcel(Landroid/os/Parcel;I)V

    .line 872
    :goto_38
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 852
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/os/Messenger;
    .end local v4    # "_arg2":Landroid/os/IBinder;
    .end local v13    # "_result":Landroid/net/NetworkRequest;
    :cond_35
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    goto :goto_36

    .line 859
    :cond_36
    const/4 v3, 0x0

    .restart local v3    # "_arg1":Landroid/os/Messenger;
    goto :goto_37

    .line 870
    .restart local v4    # "_arg2":Landroid/os/IBinder;
    .restart local v13    # "_result":Landroid/net/NetworkRequest;
    :cond_37
    const/4 v1, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_38

    .line 876
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/os/Messenger;
    .end local v4    # "_arg2":Landroid/os/IBinder;
    .end local v13    # "_result":Landroid/net/NetworkRequest;
    :sswitch_3e
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 878
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_38

    .line 879
    sget-object v1, Landroid/net/NetworkCapabilities;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/NetworkCapabilities;

    .line 885
    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    :goto_39
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_39

    .line 886
    sget-object v1, Landroid/app/PendingIntent;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/PendingIntent;

    .line 891
    .local v3, "_arg1":Landroid/app/PendingIntent;
    :goto_3a
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->pendingListenForNetwork(Landroid/net/NetworkCapabilities;Landroid/app/PendingIntent;)V

    .line 892
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 893
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 882
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/app/PendingIntent;
    :cond_38
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    goto :goto_39

    .line 889
    :cond_39
    const/4 v3, 0x0

    .restart local v3    # "_arg1":Landroid/app/PendingIntent;
    goto :goto_3a

    .line 897
    .end local v2    # "_arg0":Landroid/net/NetworkCapabilities;
    .end local v3    # "_arg1":Landroid/app/PendingIntent;
    :sswitch_3f
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 899
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_3a

    .line 900
    sget-object v1, Landroid/net/NetworkRequest;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/NetworkRequest;

    .line 905
    .local v2, "_arg0":Landroid/net/NetworkRequest;
    :goto_3b
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->releaseNetworkRequest(Landroid/net/NetworkRequest;)V

    .line 906
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 907
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 903
    .end local v2    # "_arg0":Landroid/net/NetworkRequest;
    :cond_3a
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/net/NetworkRequest;
    goto :goto_3b

    .line 911
    .end local v2    # "_arg0":Landroid/net/NetworkRequest;
    :sswitch_40
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 913
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_3b

    .line 914
    sget-object v1, Landroid/os/Messenger;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/Messenger;

    .line 919
    .local v2, "_arg0":Landroid/os/Messenger;
    :goto_3c
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setDataConnectionMessanger(Landroid/os/Messenger;)V

    .line 920
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 921
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 917
    .end local v2    # "_arg0":Landroid/os/Messenger;
    :cond_3b
    const/4 v2, 0x0

    .restart local v2    # "_arg0":Landroid/os/Messenger;
    goto :goto_3c

    .line 925
    .end local v2    # "_arg0":Landroid/os/Messenger;
    :sswitch_41
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 927
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 929
    .local v2, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v3

    .line 930
    .local v3, "_arg1":[B
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->requestRemRouteToHostAddress(I[B)Z

    move-result v13

    .line 931
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 932
    if-eqz v13, :cond_3c

    const/4 v1, 0x1

    :goto_3d
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 933
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 932
    :cond_3c
    const/4 v1, 0x0

    goto :goto_3d

    .line 937
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":[B
    .end local v13    # "_result":Z
    :sswitch_42
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 939
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 941
    .restart local v2    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v3

    .line 942
    .restart local v3    # "_arg1":[B
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->requestRemoveImsRoute(I[B)Z

    move-result v13

    .line 943
    .restart local v13    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 944
    if-eqz v13, :cond_3d

    const/4 v1, 0x1

    :goto_3e
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 945
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 944
    :cond_3d
    const/4 v1, 0x0

    goto :goto_3e

    .line 949
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":[B
    .end local v13    # "_result":Z
    :sswitch_43
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 950
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->isSystemImage()Z

    move-result v13

    .line 951
    .restart local v13    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 952
    if-eqz v13, :cond_3e

    const/4 v1, 0x1

    :goto_3f
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 953
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 952
    :cond_3e
    const/4 v1, 0x0

    goto :goto_3f

    .line 957
    .end local v13    # "_result":Z
    :sswitch_44
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 958
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->isContainVzwAppApn_MetaTag()Z

    move-result v13

    .line 959
    .restart local v13    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 960
    if-eqz v13, :cond_3f

    const/4 v1, 0x1

    :goto_40
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 961
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 960
    :cond_3f
    const/4 v1, 0x0

    goto :goto_40

    .line 965
    .end local v13    # "_result":Z
    :sswitch_45
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 966
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->isSignedFromVZW()Z

    move-result v13

    .line 967
    .restart local v13    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 968
    if-eqz v13, :cond_40

    const/4 v1, 0x1

    :goto_41
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 969
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 968
    :cond_40
    const/4 v1, 0x0

    goto :goto_41

    .line 973
    .end local v13    # "_result":Z
    :sswitch_46
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 975
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 976
    .restart local v2    # "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->checkVzwNetType(I)I

    move-result v13

    .line 977
    .local v13, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 978
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 979
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 983
    .end local v2    # "_arg0":I
    .end local v13    # "_result":I
    :sswitch_47
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 985
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_41

    const/4 v2, 0x1

    .line 986
    .local v2, "_arg0":Z
    :goto_42
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setRoamingDataEnabled_RILCMD(Z)V

    .line 987
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 988
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 985
    .end local v2    # "_arg0":Z
    :cond_41
    const/4 v2, 0x0

    goto :goto_42

    .line 992
    :sswitch_48
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 994
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_42

    const/4 v2, 0x1

    .line 995
    .restart local v2    # "_arg0":Z
    :goto_43
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->setLteMobileDataEnabled(Z)V

    .line 996
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 997
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 994
    .end local v2    # "_arg0":Z
    :cond_42
    const/4 v2, 0x0

    goto :goto_43

    .line 1001
    :sswitch_49
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1002
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->checkLteConnectState()I

    move-result v13

    .line 1003
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1004
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 1005
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1009
    .end local v13    # "_result":I
    :sswitch_4a
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1010
    invoke-virtual {p0}, Landroid/net/IConnectivityManager$Stub;->mobileDataPdpReset()V

    .line 1011
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1012
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1016
    :sswitch_4b
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1018
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1019
    .local v2, "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getRestoreDefaultNetworkDelay(I)I

    move-result v13

    .line 1020
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1021
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 1022
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1026
    .end local v2    # "_arg0":I
    .end local v13    # "_result":I
    :sswitch_4c
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1028
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1029
    .local v2, "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->startusingEPDGFeature(Ljava/lang/String;)I

    move-result v13

    .line 1030
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1031
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 1032
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1036
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_4d
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1038
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1039
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->stopusingEPDGFeature(Ljava/lang/String;)I

    move-result v13

    .line 1040
    .restart local v13    # "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1041
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 1042
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1046
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_4e
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1048
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Landroid/net/IePDGStateListener$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/IePDGStateListener;

    move-result-object v2

    .line 1050
    .local v2, "_arg0":Landroid/net/IePDGStateListener;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1051
    .local v3, "_arg1":I
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->ePDGlisten(Landroid/net/IePDGStateListener;I)V

    .line 1052
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1053
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1057
    .end local v2    # "_arg0":Landroid/net/IePDGStateListener;
    .end local v3    # "_arg1":I
    :sswitch_4f
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1059
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-eqz v1, :cond_43

    const/4 v2, 0x1

    .line 1061
    .local v2, "_arg0":Z
    :goto_44
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1062
    .local v3, "_arg1":Ljava/lang/String;
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->setFQDN(ZLjava/lang/String;)V

    .line 1063
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1064
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1059
    .end local v2    # "_arg0":Z
    .end local v3    # "_arg1":Ljava/lang/String;
    :cond_43
    const/4 v2, 0x0

    goto :goto_44

    .line 1068
    :sswitch_50
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1070
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1071
    .local v2, "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->ePDGPrefTechdone(I)V

    .line 1072
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1073
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1077
    .end local v2    # "_arg0":I
    :sswitch_51
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1079
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1080
    .restart local v2    # "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->ePDGHandOverStatus(I)V

    .line 1081
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1082
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1086
    .end local v2    # "_arg0":I
    :sswitch_52
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1088
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1090
    .restart local v2    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1092
    .local v3, "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 1094
    .local v4, "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 1096
    .local v5, "_arg3":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 1098
    .local v6, "_arg4":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 1100
    .local v7, "_arg5":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .line 1102
    .local v8, "_arg6":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v9

    .line 1104
    .local v9, "_arg7":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v10

    .line 1106
    .local v10, "_arg8":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v11

    .line 1108
    .local v11, "_arg9":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v12

    .local v12, "_arg10":Ljava/lang/String;
    move-object v1, p0

    .line 1109
    invoke-virtual/range {v1 .. v12}, Landroid/net/IConnectivityManager$Stub;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    .line 1110
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1111
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1115
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":I
    .end local v4    # "_arg2":I
    .end local v5    # "_arg3":I
    .end local v6    # "_arg4":Ljava/lang/String;
    .end local v7    # "_arg5":Ljava/lang/String;
    .end local v8    # "_arg6":Ljava/lang/String;
    .end local v9    # "_arg7":Ljava/lang/String;
    .end local v10    # "_arg8":Ljava/lang/String;
    .end local v11    # "_arg9":I
    .end local v12    # "_arg10":Ljava/lang/String;
    :sswitch_53
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1117
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1119
    .restart local v2    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1121
    .restart local v3    # "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 1123
    .restart local v4    # "_arg2":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 1124
    .local v5, "_arg3":Ljava/lang/String;
    invoke-virtual {p0, v2, v3, v4, v5}, Landroid/net/IConnectivityManager$Stub;->notifyEPDGPDNStatus(IIILjava/lang/String;)V

    .line 1125
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1126
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1130
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":I
    .end local v4    # "_arg2":I
    .end local v5    # "_arg3":Ljava/lang/String;
    :sswitch_54
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1132
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1134
    .restart local v2    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1135
    .restart local v3    # "_arg1":I
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->getDebugInfo(II)[D

    move-result-object v13

    .line 1136
    .local v13, "_result":[D
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1137
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeDoubleArray([D)V

    .line 1138
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1142
    .end local v2    # "_arg0":I
    .end local v3    # "_arg1":I
    .end local v13    # "_result":[D
    :sswitch_55
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1144
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1146
    .local v2, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1147
    .local v3, "_arg1":Ljava/lang/String;
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->getPcscfAddress(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v13

    .line 1148
    .local v13, "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1149
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 1150
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1154
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v3    # "_arg1":Ljava/lang/String;
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_56
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1156
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1157
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getIPpcscAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v13

    .line 1158
    .restart local v13    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1159
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 1160
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1164
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":[Ljava/lang/String;
    :sswitch_57
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1166
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1167
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getNetPrefer(Ljava/lang/String;)I

    move-result v13

    .line 1168
    .local v13, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1169
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 1170
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1174
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v13    # "_result":I
    :sswitch_58
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1176
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1178
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1179
    .local v3, "_arg1":I
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->addVpnAddress(Ljava/lang/String;I)Z

    move-result v13

    .line 1180
    .local v13, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1181
    if-eqz v13, :cond_44

    const/4 v1, 0x1

    :goto_45
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1182
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1181
    :cond_44
    const/4 v1, 0x0

    goto :goto_45

    .line 1186
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v3    # "_arg1":I
    .end local v13    # "_result":Z
    :sswitch_59
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1188
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 1190
    .restart local v2    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1191
    .restart local v3    # "_arg1":I
    invoke-virtual {p0, v2, v3}, Landroid/net/IConnectivityManager$Stub;->removeVpnAddress(Ljava/lang/String;I)Z

    move-result v13

    .line 1192
    .restart local v13    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1193
    if-eqz v13, :cond_45

    const/4 v1, 0x1

    :goto_46
    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 1194
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 1193
    :cond_45
    const/4 v1, 0x0

    goto :goto_46

    .line 1198
    .end local v2    # "_arg0":Ljava/lang/String;
    .end local v3    # "_arg1":I
    .end local v13    # "_result":Z
    :sswitch_5a
    const-string v1, "android.net.IConnectivityManager"

    move-object/from16 v0, p2

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1200
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .line 1201
    .local v2, "_arg0":I
    invoke-virtual {p0, v2}, Landroid/net/IConnectivityManager$Stub;->getNetworkStatus_for_kt_kaf(I)I

    move-result v13

    .line 1202
    .local v13, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1203
    move-object/from16 v0, p3

    invoke-virtual {v0, v13}, Landroid/os/Parcel;->writeInt(I)V

    .line 1204
    const/4 v1, 0x1

    goto/16 :goto_0

    .line 43
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