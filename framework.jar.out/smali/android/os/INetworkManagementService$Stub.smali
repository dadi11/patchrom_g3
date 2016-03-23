.class public abstract Landroid/os/INetworkManagementService$Stub;
.super Landroid/os/Binder;
.source "INetworkManagementService.java"

# interfaces
.implements Landroid/os/INetworkManagementService;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/os/INetworkManagementService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/os/INetworkManagementService$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "android.os.INetworkManagementService"

.field static final TRANSACTION_acceptPacket:I = 0x62

.field static final TRANSACTION_addIdleTimer:I = 0x36

.field static final TRANSACTION_addInterfaceToLocalNetwork:I = 0x69

.field static final TRANSACTION_addInterfaceToNetwork:I = 0x4c

.field static final TRANSACTION_addLegacyRouteForNetId:I = 0x4e

.field static final TRANSACTION_addRoute:I = 0xf

.field static final TRANSACTION_addUpstreamV6Interface:I = 0x20

.field static final TRANSACTION_addVpnUidRanges:I = 0x41

.field static final TRANSACTION_allowProtect:I = 0x54

.field static final TRANSACTION_appendRouteWithMetric:I = 0x5f

.field static final TRANSACTION_attachPppd:I = 0x23

.field static final TRANSACTION_clearDefaultNetId:I = 0x50

.field static final TRANSACTION_clearInterfaceAddresses:I = 0x8

.field static final TRANSACTION_clearPermission:I = 0x53

.field static final TRANSACTION_clearRouteIpv6:I = 0x5b

.field static final TRANSACTION_clearSourceRouteIpv6:I = 0x5d

.field static final TRANSACTION_createPhysicalNetwork:I = 0x49

.field static final TRANSACTION_createVirtualNetwork:I = 0x4a

.field static final TRANSACTION_denyProtect:I = 0x55

.field static final TRANSACTION_detachPppd:I = 0x24

.field static final TRANSACTION_disableIpv6:I = 0xc

.field static final TRANSACTION_disableNat:I = 0x1f

.field static final TRANSACTION_disableNatIpv6:I = 0x57

.field static final TRANSACTION_dropPacket:I = 0x61

.field static final TRANSACTION_enableIpv6:I = 0xd

.field static final TRANSACTION_enableNat:I = 0x1e

.field static final TRANSACTION_enableNatIpv6:I = 0x56

.field static final TRANSACTION_flushNetworkDnsCache:I = 0x39

.field static final TRANSACTION_getDnsForwarders:I = 0x1d

.field static final TRANSACTION_getInterfaceConfig:I = 0x6

.field static final TRANSACTION_getIpForwardingEnabled:I = 0x14

.field static final TRANSACTION_getIpv6ForwardingEnabled:I = 0x59

.field static final TRANSACTION_getMtu:I = 0x12

.field static final TRANSACTION_getNetworkStatsDetail:I = 0x2b

.field static final TRANSACTION_getNetworkStatsSummaryDev:I = 0x29

.field static final TRANSACTION_getNetworkStatsSummaryXt:I = 0x2a

.field static final TRANSACTION_getNetworkStatsTethering:I = 0x2e

.field static final TRANSACTION_getNetworkStatsUidDetail:I = 0x2c

.field static final TRANSACTION_getNetworkStatsUidInterface:I = 0x2d

.field static final TRANSACTION_getRouteList_debug:I = 0x66

.field static final TRANSACTION_getRoutes:I = 0xe

.field static final TRANSACTION_isBandwidthControlEnabled:I = 0x35

.field static final TRANSACTION_isClatdStarted:I = 0x45

.field static final TRANSACTION_isFirewallEnabled:I = 0x3c

.field static final TRANSACTION_isNetworkActive:I = 0x48

.field static final TRANSACTION_isTetheringStarted:I = 0x18

.field static final TRANSACTION_listInterfaces:I = 0x5

.field static final TRANSACTION_listTetheredInterfaces:I = 0x1b

.field static final TRANSACTION_listTtys:I = 0x22

.field static final TRANSACTION_packetList_Indrop:I = 0x65

.field static final TRANSACTION_packetList_Indrop_view:I = 0x67

.field static final TRANSACTION_registerNetworkActivityListener:I = 0x46

.field static final TRANSACTION_registerObserver:I = 0x1

.field static final TRANSACTION_registerObserverEx:I = 0x3

.field static final TRANSACTION_removeIdleTimer:I = 0x37

.field static final TRANSACTION_removeInterfaceAlert:I = 0x32

.field static final TRANSACTION_removeInterfaceFromLocalNetwork:I = 0x6a

.field static final TRANSACTION_removeInterfaceFromNetwork:I = 0x4d

.field static final TRANSACTION_removeInterfaceQuota:I = 0x30

.field static final TRANSACTION_removeLegacyRouteForNetId:I = 0x64

.field static final TRANSACTION_removeNetwork:I = 0x4b

.field static final TRANSACTION_removeRoute:I = 0x10

.field static final TRANSACTION_removeUpstreamV6Interface:I = 0x21

.field static final TRANSACTION_removeVpnUidRanges:I = 0x42

.field static final TRANSACTION_resetPacketDrop:I = 0x63

.field static final TRANSACTION_runShellCommand:I = 0x3a

.field static final TRANSACTION_setAccessPoint:I = 0x28

.field static final TRANSACTION_setDefaultNetId:I = 0x4f

.field static final TRANSACTION_setDhcpv6Enabled:I = 0x5e

.field static final TRANSACTION_setDnsForwarders:I = 0x1c

.field static final TRANSACTION_setDnsServersForNetwork:I = 0x38

.field static final TRANSACTION_setFirewallEgressDestRule:I = 0x3f

.field static final TRANSACTION_setFirewallEgressSourceRule:I = 0x3e

.field static final TRANSACTION_setFirewallEnabled:I = 0x3b

.field static final TRANSACTION_setFirewallInterfaceRule:I = 0x3d

.field static final TRANSACTION_setFirewallUidRule:I = 0x40

.field static final TRANSACTION_setGlobalAlert:I = 0x33

.field static final TRANSACTION_setInterfaceAlert:I = 0x31

.field static final TRANSACTION_setInterfaceAlias:I = 0x60

.field static final TRANSACTION_setInterfaceConfig:I = 0x7

.field static final TRANSACTION_setInterfaceDown:I = 0x9

.field static final TRANSACTION_setInterfaceIpv6PrivacyExtensions:I = 0xb

.field static final TRANSACTION_setInterfaceQuota:I = 0x2f

.field static final TRANSACTION_setInterfaceUp:I = 0xa

.field static final TRANSACTION_setIpForwardingEnabled:I = 0x15

.field static final TRANSACTION_setIpv6ForwardingEnabled:I = 0x58

.field static final TRANSACTION_setMtu:I = 0x11

.field static final TRANSACTION_setNetworkPermission:I = 0x51

.field static final TRANSACTION_setPermission:I = 0x52

.field static final TRANSACTION_setRouteIpv6:I = 0x5a

.field static final TRANSACTION_setSourceRouteIpv6:I = 0x5c

.field static final TRANSACTION_setTcpWindowScaling:I = 0x68

.field static final TRANSACTION_setUidNetworkRules:I = 0x34

.field static final TRANSACTION_setWifiHighTrafficMode:I = 0x6b

.field static final TRANSACTION_shutdown:I = 0x13

.field static final TRANSACTION_startAccessPoint:I = 0x26

.field static final TRANSACTION_startClatd:I = 0x43

.field static final TRANSACTION_startTethering:I = 0x16

.field static final TRANSACTION_stopAccessPoint:I = 0x27

.field static final TRANSACTION_stopClatd:I = 0x44

.field static final TRANSACTION_stopTethering:I = 0x17

.field static final TRANSACTION_tetherInterface:I = 0x19

.field static final TRANSACTION_unregisterNetworkActivityListener:I = 0x47

.field static final TRANSACTION_unregisterObserver:I = 0x2

.field static final TRANSACTION_unregisterObserverEx:I = 0x4

.field static final TRANSACTION_untetherInterface:I = 0x1a

.field static final TRANSACTION_wifiFirmwareReload:I = 0x25


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 19
    const-string v0, "android.os.INetworkManagementService"

    invoke-virtual {p0, p0, v0}, Landroid/os/INetworkManagementService$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    .line 20
    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Landroid/os/INetworkManagementService;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    .line 27
    if-nez p0, :cond_0

    .line 28
    const/4 v0, 0x0

    .line 34
    :goto_0
    return-object v0

    .line 30
    :cond_0
    const-string v1, "android.os.INetworkManagementService"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .line 31
    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Landroid/os/INetworkManagementService;

    if-eqz v1, :cond_1

    .line 32
    check-cast v0, Landroid/os/INetworkManagementService;

    goto :goto_0

    .line 34
    :cond_1
    new-instance v0, Landroid/os/INetworkManagementService$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Landroid/os/INetworkManagementService$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    .line 38
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 16
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
    .line 42
    sparse-switch p1, :sswitch_data_0

    .line 1180
    invoke-super/range {p0 .. p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v2

    :goto_0
    return v2

    .line 46
    :sswitch_0
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 47
    const/4 v2, 0x1

    goto :goto_0

    .line 51
    :sswitch_1
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 53
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/net/INetworkManagementEventObserver$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/INetworkManagementEventObserver;

    move-result-object v3

    .line 54
    .local v3, "_arg0":Landroid/net/INetworkManagementEventObserver;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->registerObserver(Landroid/net/INetworkManagementEventObserver;)V

    .line 55
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 56
    const/4 v2, 0x1

    goto :goto_0

    .line 60
    .end local v3    # "_arg0":Landroid/net/INetworkManagementEventObserver;
    :sswitch_2
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 62
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/net/INetworkManagementEventObserver$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/INetworkManagementEventObserver;

    move-result-object v3

    .line 63
    .restart local v3    # "_arg0":Landroid/net/INetworkManagementEventObserver;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->unregisterObserver(Landroid/net/INetworkManagementEventObserver;)V

    .line 64
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 65
    const/4 v2, 0x1

    goto :goto_0

    .line 69
    .end local v3    # "_arg0":Landroid/net/INetworkManagementEventObserver;
    :sswitch_3
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 71
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/net/INetworkManagementEventObserverEx$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/INetworkManagementEventObserverEx;

    move-result-object v3

    .line 72
    .local v3, "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->registerObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V

    .line 73
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 74
    const/4 v2, 0x1

    goto :goto_0

    .line 78
    .end local v3    # "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    :sswitch_4
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 80
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/net/INetworkManagementEventObserverEx$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/INetworkManagementEventObserverEx;

    move-result-object v3

    .line 81
    .restart local v3    # "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->unregisterObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V

    .line 82
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 83
    const/4 v2, 0x1

    goto :goto_0

    .line 87
    .end local v3    # "_arg0":Landroid/net/INetworkManagementEventObserverEx;
    :sswitch_5
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 88
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->listInterfaces()[Ljava/lang/String;

    move-result-object v14

    .line 89
    .local v14, "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 90
    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 91
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 95
    .end local v14    # "_result":[Ljava/lang/String;
    :sswitch_6
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 97
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 98
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->getInterfaceConfig(Ljava/lang/String;)Landroid/net/InterfaceConfiguration;

    move-result-object v14

    .line 99
    .local v14, "_result":Landroid/net/InterfaceConfiguration;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 100
    if-eqz v14, :cond_0

    .line 101
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 102
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v14, v0, v2}, Landroid/net/InterfaceConfiguration;->writeToParcel(Landroid/os/Parcel;I)V

    .line 107
    :goto_1
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 105
    :cond_0
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_1

    .line 111
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v14    # "_result":Landroid/net/InterfaceConfiguration;
    :sswitch_7
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 113
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 115
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_1

    .line 116
    sget-object v2, Landroid/net/InterfaceConfiguration;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/InterfaceConfiguration;

    .line 121
    .local v4, "_arg1":Landroid/net/InterfaceConfiguration;
    :goto_2
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setInterfaceConfig(Ljava/lang/String;Landroid/net/InterfaceConfiguration;)V

    .line 122
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 123
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 119
    .end local v4    # "_arg1":Landroid/net/InterfaceConfiguration;
    :cond_1
    const/4 v4, 0x0

    .restart local v4    # "_arg1":Landroid/net/InterfaceConfiguration;
    goto :goto_2

    .line 127
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Landroid/net/InterfaceConfiguration;
    :sswitch_8
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 129
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 130
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->clearInterfaceAddresses(Ljava/lang/String;)V

    .line 131
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 132
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 136
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_9
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 138
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 139
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setInterfaceDown(Ljava/lang/String;)V

    .line 140
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 141
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 145
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 147
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 148
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setInterfaceUp(Ljava/lang/String;)V

    .line 149
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 150
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 154
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 156
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 158
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_2

    const/4 v4, 0x1

    .line 159
    .local v4, "_arg1":Z
    :goto_3
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setInterfaceIpv6PrivacyExtensions(Ljava/lang/String;Z)V

    .line 160
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 161
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 158
    .end local v4    # "_arg1":Z
    :cond_2
    const/4 v4, 0x0

    goto :goto_3

    .line 165
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_c
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 167
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 168
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->disableIpv6(Ljava/lang/String;)V

    .line 169
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 170
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 174
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_d
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 176
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 177
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->enableIpv6(Ljava/lang/String;)V

    .line 178
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 179
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 183
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_e
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 185
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 186
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->getRoutes(Ljava/lang/String;)[Landroid/net/RouteInfo;

    move-result-object v14

    .line 187
    .local v14, "_result":[Landroid/net/RouteInfo;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 188
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v14, v2}, Landroid/os/Parcel;->writeTypedArray([Landroid/os/Parcelable;I)V

    .line 189
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 193
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v14    # "_result":[Landroid/net/RouteInfo;
    :sswitch_f
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 195
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 197
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_3

    .line 198
    sget-object v2, Landroid/net/RouteInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/RouteInfo;

    .line 203
    .local v4, "_arg1":Landroid/net/RouteInfo;
    :goto_4
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->addRoute(ILandroid/net/RouteInfo;)V

    .line 204
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 205
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 201
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    :cond_3
    const/4 v4, 0x0

    .restart local v4    # "_arg1":Landroid/net/RouteInfo;
    goto :goto_4

    .line 209
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    :sswitch_10
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 211
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 213
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_4

    .line 214
    sget-object v2, Landroid/net/RouteInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/RouteInfo;

    .line 219
    .restart local v4    # "_arg1":Landroid/net/RouteInfo;
    :goto_5
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->removeRoute(ILandroid/net/RouteInfo;)V

    .line 220
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 221
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 217
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    :cond_4
    const/4 v4, 0x0

    .restart local v4    # "_arg1":Landroid/net/RouteInfo;
    goto :goto_5

    .line 225
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    :sswitch_11
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 227
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 229
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 230
    .local v4, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setMtu(Ljava/lang/String;I)V

    .line 231
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 232
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 236
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":I
    :sswitch_12
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 238
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 239
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->getMtu(Ljava/lang/String;)I

    move-result v14

    .line 240
    .local v14, "_result":I
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 241
    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Landroid/os/Parcel;->writeInt(I)V

    .line 242
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 246
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v14    # "_result":I
    :sswitch_13
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 247
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->shutdown()V

    .line 248
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 249
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 253
    :sswitch_14
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 254
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getIpForwardingEnabled()Z

    move-result v14

    .line 255
    .local v14, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 256
    if-eqz v14, :cond_5

    const/4 v2, 0x1

    :goto_6
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 257
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 256
    :cond_5
    const/4 v2, 0x0

    goto :goto_6

    .line 261
    .end local v14    # "_result":Z
    :sswitch_15
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 263
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_6

    const/4 v3, 0x1

    .line 264
    .local v3, "_arg0":Z
    :goto_7
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setIpForwardingEnabled(Z)V

    .line 265
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 266
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 263
    .end local v3    # "_arg0":Z
    :cond_6
    const/4 v3, 0x0

    goto :goto_7

    .line 270
    :sswitch_16
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 272
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createStringArray()[Ljava/lang/String;

    move-result-object v3

    .line 273
    .local v3, "_arg0":[Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->startTethering([Ljava/lang/String;)V

    .line 274
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 275
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 279
    .end local v3    # "_arg0":[Ljava/lang/String;
    :sswitch_17
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 280
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->stopTethering()V

    .line 281
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 282
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 286
    :sswitch_18
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 287
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->isTetheringStarted()Z

    move-result v14

    .line 288
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 289
    if-eqz v14, :cond_7

    const/4 v2, 0x1

    :goto_8
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 290
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 289
    :cond_7
    const/4 v2, 0x0

    goto :goto_8

    .line 294
    .end local v14    # "_result":Z
    :sswitch_19
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 296
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 297
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->tetherInterface(Ljava/lang/String;)V

    .line 298
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 299
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 303
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_1a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 305
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 306
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->untetherInterface(Ljava/lang/String;)V

    .line 307
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 308
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 312
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_1b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 313
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->listTetheredInterfaces()[Ljava/lang/String;

    move-result-object v14

    .line 314
    .local v14, "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 315
    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 316
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 320
    .end local v14    # "_result":[Ljava/lang/String;
    :sswitch_1c
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 322
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_8

    .line 323
    sget-object v2, Landroid/net/Network;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/Network;

    .line 329
    .local v3, "_arg0":Landroid/net/Network;
    :goto_9
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createStringArray()[Ljava/lang/String;

    move-result-object v4

    .line 330
    .local v4, "_arg1":[Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setDnsForwarders(Landroid/net/Network;[Ljava/lang/String;)V

    .line 331
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 332
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 326
    .end local v3    # "_arg0":Landroid/net/Network;
    .end local v4    # "_arg1":[Ljava/lang/String;
    :cond_8
    const/4 v3, 0x0

    .restart local v3    # "_arg0":Landroid/net/Network;
    goto :goto_9

    .line 336
    .end local v3    # "_arg0":Landroid/net/Network;
    :sswitch_1d
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 337
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getDnsForwarders()[Ljava/lang/String;

    move-result-object v14

    .line 338
    .restart local v14    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 339
    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 340
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 344
    .end local v14    # "_result":[Ljava/lang/String;
    :sswitch_1e
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 346
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 348
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 349
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->enableNat(Ljava/lang/String;Ljava/lang/String;)V

    .line 350
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 351
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 355
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_1f
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 357
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 359
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 360
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->disableNat(Ljava/lang/String;Ljava/lang/String;)V

    .line 361
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 362
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 366
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_20
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 368
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 369
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->addUpstreamV6Interface(Ljava/lang/String;)V

    .line 370
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 371
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 375
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_21
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 377
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 378
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->removeUpstreamV6Interface(Ljava/lang/String;)V

    .line 379
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 380
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 384
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_22
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 385
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->listTtys()[Ljava/lang/String;

    move-result-object v14

    .line 386
    .restart local v14    # "_result":[Ljava/lang/String;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 387
    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    .line 388
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 392
    .end local v14    # "_result":[Ljava/lang/String;
    :sswitch_23
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 394
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 396
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 398
    .restart local v4    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 400
    .local v5, "_arg2":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .line 402
    .local v6, "_arg3":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .local v7, "_arg4":Ljava/lang/String;
    move-object/from16 v2, p0

    .line 403
    invoke-virtual/range {v2 .. v7}, Landroid/os/INetworkManagementService$Stub;->attachPppd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 404
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 405
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 409
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v5    # "_arg2":Ljava/lang/String;
    .end local v6    # "_arg3":Ljava/lang/String;
    .end local v7    # "_arg4":Ljava/lang/String;
    :sswitch_24
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 411
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 412
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->detachPppd(Ljava/lang/String;)V

    .line 413
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 414
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 418
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_25
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 420
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 422
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 423
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->wifiFirmwareReload(Ljava/lang/String;Ljava/lang/String;)V

    .line 424
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 425
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 429
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_26
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 431
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_9

    .line 432
    sget-object v2, Landroid/net/wifi/WifiConfiguration;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/wifi/WifiConfiguration;

    .line 438
    .local v3, "_arg0":Landroid/net/wifi/WifiConfiguration;
    :goto_a
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 439
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->startAccessPoint(Landroid/net/wifi/WifiConfiguration;Ljava/lang/String;)V

    .line 440
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 441
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 435
    .end local v3    # "_arg0":Landroid/net/wifi/WifiConfiguration;
    .end local v4    # "_arg1":Ljava/lang/String;
    :cond_9
    const/4 v3, 0x0

    .restart local v3    # "_arg0":Landroid/net/wifi/WifiConfiguration;
    goto :goto_a

    .line 445
    .end local v3    # "_arg0":Landroid/net/wifi/WifiConfiguration;
    :sswitch_27
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 447
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 448
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->stopAccessPoint(Ljava/lang/String;)V

    .line 449
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 450
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 454
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_28
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 456
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_a

    .line 457
    sget-object v2, Landroid/net/wifi/WifiConfiguration;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/wifi/WifiConfiguration;

    .line 463
    .local v3, "_arg0":Landroid/net/wifi/WifiConfiguration;
    :goto_b
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 464
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setAccessPoint(Landroid/net/wifi/WifiConfiguration;Ljava/lang/String;)V

    .line 465
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 466
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 460
    .end local v3    # "_arg0":Landroid/net/wifi/WifiConfiguration;
    .end local v4    # "_arg1":Ljava/lang/String;
    :cond_a
    const/4 v3, 0x0

    .restart local v3    # "_arg0":Landroid/net/wifi/WifiConfiguration;
    goto :goto_b

    .line 470
    .end local v3    # "_arg0":Landroid/net/wifi/WifiConfiguration;
    :sswitch_29
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 471
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getNetworkStatsSummaryDev()Landroid/net/NetworkStats;

    move-result-object v14

    .line 472
    .local v14, "_result":Landroid/net/NetworkStats;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 473
    if-eqz v14, :cond_b

    .line 474
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 475
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v14, v0, v2}, Landroid/net/NetworkStats;->writeToParcel(Landroid/os/Parcel;I)V

    .line 480
    :goto_c
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 478
    :cond_b
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_c

    .line 484
    .end local v14    # "_result":Landroid/net/NetworkStats;
    :sswitch_2a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 485
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getNetworkStatsSummaryXt()Landroid/net/NetworkStats;

    move-result-object v14

    .line 486
    .restart local v14    # "_result":Landroid/net/NetworkStats;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 487
    if-eqz v14, :cond_c

    .line 488
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 489
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v14, v0, v2}, Landroid/net/NetworkStats;->writeToParcel(Landroid/os/Parcel;I)V

    .line 494
    :goto_d
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 492
    :cond_c
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_d

    .line 498
    .end local v14    # "_result":Landroid/net/NetworkStats;
    :sswitch_2b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 499
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getNetworkStatsDetail()Landroid/net/NetworkStats;

    move-result-object v14

    .line 500
    .restart local v14    # "_result":Landroid/net/NetworkStats;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 501
    if-eqz v14, :cond_d

    .line 502
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 503
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v14, v0, v2}, Landroid/net/NetworkStats;->writeToParcel(Landroid/os/Parcel;I)V

    .line 508
    :goto_e
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 506
    :cond_d
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_e

    .line 512
    .end local v14    # "_result":Landroid/net/NetworkStats;
    :sswitch_2c
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 514
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 515
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->getNetworkStatsUidDetail(I)Landroid/net/NetworkStats;

    move-result-object v14

    .line 516
    .restart local v14    # "_result":Landroid/net/NetworkStats;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 517
    if-eqz v14, :cond_e

    .line 518
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 519
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v14, v0, v2}, Landroid/net/NetworkStats;->writeToParcel(Landroid/os/Parcel;I)V

    .line 524
    :goto_f
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 522
    :cond_e
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_f

    .line 528
    .end local v3    # "_arg0":I
    .end local v14    # "_result":Landroid/net/NetworkStats;
    :sswitch_2d
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 530
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 532
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 534
    .restart local v4    # "_arg1":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 535
    .local v5, "_arg2":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->getNetworkStatsUidInterface(ILjava/lang/String;I)J

    move-result-wide v14

    .line 536
    .local v14, "_result":J
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 537
    move-object/from16 v0, p3

    invoke-virtual {v0, v14, v15}, Landroid/os/Parcel;->writeLong(J)V

    .line 538
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 542
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Ljava/lang/String;
    .end local v5    # "_arg2":I
    .end local v14    # "_result":J
    :sswitch_2e
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 543
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getNetworkStatsTethering()Landroid/net/NetworkStats;

    move-result-object v14

    .line 544
    .local v14, "_result":Landroid/net/NetworkStats;
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 545
    if-eqz v14, :cond_f

    .line 546
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 547
    const/4 v2, 0x1

    move-object/from16 v0, p3

    invoke-virtual {v14, v0, v2}, Landroid/net/NetworkStats;->writeToParcel(Landroid/os/Parcel;I)V

    .line 552
    :goto_10
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 550
    :cond_f
    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    goto :goto_10

    .line 556
    .end local v14    # "_result":Landroid/net/NetworkStats;
    :sswitch_2f
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 558
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 560
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v10

    .line 561
    .local v10, "_arg1":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v10, v11}, Landroid/os/INetworkManagementService$Stub;->setInterfaceQuota(Ljava/lang/String;J)V

    .line 562
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 563
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 567
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v10    # "_arg1":J
    :sswitch_30
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 569
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 570
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->removeInterfaceQuota(Ljava/lang/String;)V

    .line 571
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 572
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 576
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_31
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 578
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 580
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v10

    .line 581
    .restart local v10    # "_arg1":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v10, v11}, Landroid/os/INetworkManagementService$Stub;->setInterfaceAlert(Ljava/lang/String;J)V

    .line 582
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 583
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 587
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v10    # "_arg1":J
    :sswitch_32
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 589
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 590
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->removeInterfaceAlert(Ljava/lang/String;)V

    .line 591
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 592
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 596
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_33
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 598
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v8

    .line 599
    .local v8, "_arg0":J
    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v9}, Landroid/os/INetworkManagementService$Stub;->setGlobalAlert(J)V

    .line 600
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 601
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 605
    .end local v8    # "_arg0":J
    :sswitch_34
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 607
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 609
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_10

    const/4 v4, 0x1

    .line 610
    .local v4, "_arg1":Z
    :goto_11
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setUidNetworkRules(IZ)V

    .line 611
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 612
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 609
    .end local v4    # "_arg1":Z
    :cond_10
    const/4 v4, 0x0

    goto :goto_11

    .line 616
    .end local v3    # "_arg0":I
    :sswitch_35
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 617
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->isBandwidthControlEnabled()Z

    move-result v14

    .line 618
    .local v14, "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 619
    if-eqz v14, :cond_11

    const/4 v2, 0x1

    :goto_12
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 620
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 619
    :cond_11
    const/4 v2, 0x0

    goto :goto_12

    .line 624
    .end local v14    # "_result":Z
    :sswitch_36
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 626
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 628
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 630
    .local v4, "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 631
    .restart local v5    # "_arg2":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->addIdleTimer(Ljava/lang/String;II)V

    .line 632
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 633
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 637
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":I
    :sswitch_37
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 639
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 640
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->removeIdleTimer(Ljava/lang/String;)V

    .line 641
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 642
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 646
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_38
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 648
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 650
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createStringArray()[Ljava/lang/String;

    move-result-object v4

    .line 652
    .local v4, "_arg1":[Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .line 653
    .local v5, "_arg2":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->setDnsServersForNetwork(I[Ljava/lang/String;Ljava/lang/String;)V

    .line 654
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 655
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 659
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":[Ljava/lang/String;
    .end local v5    # "_arg2":Ljava/lang/String;
    :sswitch_39
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 661
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 662
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->flushNetworkDnsCache(I)V

    .line 663
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 664
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 668
    .end local v3    # "_arg0":I
    :sswitch_3a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 670
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 671
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->runShellCommand(Ljava/lang/String;)V

    .line 672
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 673
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 677
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_3b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 679
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_12

    const/4 v3, 0x1

    .line 680
    .local v3, "_arg0":Z
    :goto_13
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setFirewallEnabled(Z)V

    .line 681
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 682
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 679
    .end local v3    # "_arg0":Z
    :cond_12
    const/4 v3, 0x0

    goto :goto_13

    .line 686
    :sswitch_3c
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 687
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->isFirewallEnabled()Z

    move-result v14

    .line 688
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 689
    if-eqz v14, :cond_13

    const/4 v2, 0x1

    :goto_14
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 690
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 689
    :cond_13
    const/4 v2, 0x0

    goto :goto_14

    .line 694
    .end local v14    # "_result":Z
    :sswitch_3d
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 696
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 698
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_14

    const/4 v4, 0x1

    .line 699
    .local v4, "_arg1":Z
    :goto_15
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setFirewallInterfaceRule(Ljava/lang/String;Z)V

    .line 700
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 701
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 698
    .end local v4    # "_arg1":Z
    :cond_14
    const/4 v4, 0x0

    goto :goto_15

    .line 705
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_3e
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 707
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 709
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_15

    const/4 v4, 0x1

    .line 710
    .restart local v4    # "_arg1":Z
    :goto_16
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setFirewallEgressSourceRule(Ljava/lang/String;Z)V

    .line 711
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 712
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 709
    .end local v4    # "_arg1":Z
    :cond_15
    const/4 v4, 0x0

    goto :goto_16

    .line 716
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_3f
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 718
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 720
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 722
    .local v4, "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_16

    const/4 v5, 0x1

    .line 723
    .local v5, "_arg2":Z
    :goto_17
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->setFirewallEgressDestRule(Ljava/lang/String;IZ)V

    .line 724
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 725
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 722
    .end local v5    # "_arg2":Z
    :cond_16
    const/4 v5, 0x0

    goto :goto_17

    .line 729
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":I
    :sswitch_40
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 731
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 733
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_17

    const/4 v4, 0x1

    .line 734
    .local v4, "_arg1":Z
    :goto_18
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setFirewallUidRule(IZ)V

    .line 735
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 736
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 733
    .end local v4    # "_arg1":Z
    :cond_17
    const/4 v4, 0x0

    goto :goto_18

    .line 740
    .end local v3    # "_arg0":I
    :sswitch_41
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 742
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 744
    .restart local v3    # "_arg0":I
    sget-object v2, Landroid/net/UidRange;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->createTypedArray(Landroid/os/Parcelable$Creator;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Landroid/net/UidRange;

    .line 745
    .local v4, "_arg1":[Landroid/net/UidRange;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->addVpnUidRanges(I[Landroid/net/UidRange;)V

    .line 746
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 747
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 751
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":[Landroid/net/UidRange;
    :sswitch_42
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 753
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 755
    .restart local v3    # "_arg0":I
    sget-object v2, Landroid/net/UidRange;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->createTypedArray(Landroid/os/Parcelable$Creator;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Landroid/net/UidRange;

    .line 756
    .restart local v4    # "_arg1":[Landroid/net/UidRange;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->removeVpnUidRanges(I[Landroid/net/UidRange;)V

    .line 757
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 758
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 762
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":[Landroid/net/UidRange;
    :sswitch_43
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 764
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 765
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->startClatd(Ljava/lang/String;)V

    .line 766
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 767
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 771
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_44
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 772
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->stopClatd()V

    .line 773
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 774
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 778
    :sswitch_45
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 779
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->isClatdStarted()Z

    move-result v14

    .line 780
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 781
    if-eqz v14, :cond_18

    const/4 v2, 0x1

    :goto_19
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 782
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 781
    :cond_18
    const/4 v2, 0x0

    goto :goto_19

    .line 786
    .end local v14    # "_result":Z
    :sswitch_46
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 788
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/os/INetworkActivityListener$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/INetworkActivityListener;

    move-result-object v3

    .line 789
    .local v3, "_arg0":Landroid/os/INetworkActivityListener;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->registerNetworkActivityListener(Landroid/os/INetworkActivityListener;)V

    .line 790
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 791
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 795
    .end local v3    # "_arg0":Landroid/os/INetworkActivityListener;
    :sswitch_47
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 797
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/os/INetworkActivityListener$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/INetworkActivityListener;

    move-result-object v3

    .line 798
    .restart local v3    # "_arg0":Landroid/os/INetworkActivityListener;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->unregisterNetworkActivityListener(Landroid/os/INetworkActivityListener;)V

    .line 799
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 800
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 804
    .end local v3    # "_arg0":Landroid/os/INetworkActivityListener;
    :sswitch_48
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 805
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->isNetworkActive()Z

    move-result v14

    .line 806
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 807
    if-eqz v14, :cond_19

    const/4 v2, 0x1

    :goto_1a
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 808
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 807
    :cond_19
    const/4 v2, 0x0

    goto :goto_1a

    .line 812
    .end local v14    # "_result":Z
    :sswitch_49
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 814
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 816
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 817
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->createPhysicalNetwork(ILjava/lang/String;)V

    .line 818
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 819
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 823
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_4a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 825
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 827
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_1a

    const/4 v4, 0x1

    .line 829
    .local v4, "_arg1":Z
    :goto_1b
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_1b

    const/4 v5, 0x1

    .line 830
    .restart local v5    # "_arg2":Z
    :goto_1c
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->createVirtualNetwork(IZZ)V

    .line 831
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 832
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 827
    .end local v4    # "_arg1":Z
    .end local v5    # "_arg2":Z
    :cond_1a
    const/4 v4, 0x0

    goto :goto_1b

    .line 829
    .restart local v4    # "_arg1":Z
    :cond_1b
    const/4 v5, 0x0

    goto :goto_1c

    .line 836
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Z
    :sswitch_4b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 838
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 839
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->removeNetwork(I)V

    .line 840
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 841
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 845
    .end local v3    # "_arg0":I
    :sswitch_4c
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 847
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 849
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 850
    .local v4, "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->addInterfaceToNetwork(Ljava/lang/String;I)V

    .line 851
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 852
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 856
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":I
    :sswitch_4d
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 858
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 860
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 861
    .restart local v4    # "_arg1":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->removeInterfaceFromNetwork(Ljava/lang/String;I)V

    .line 862
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 863
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 867
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":I
    :sswitch_4e
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 869
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 871
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_1c

    .line 872
    sget-object v2, Landroid/net/RouteInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/RouteInfo;

    .line 878
    .local v4, "_arg1":Landroid/net/RouteInfo;
    :goto_1d
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 879
    .local v5, "_arg2":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->addLegacyRouteForNetId(ILandroid/net/RouteInfo;I)V

    .line 880
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 881
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 875
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    .end local v5    # "_arg2":I
    :cond_1c
    const/4 v4, 0x0

    .restart local v4    # "_arg1":Landroid/net/RouteInfo;
    goto :goto_1d

    .line 885
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    :sswitch_4f
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 887
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 888
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setDefaultNetId(I)V

    .line 889
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 890
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 894
    .end local v3    # "_arg0":I
    :sswitch_50
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 895
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->clearDefaultNetId()V

    .line 896
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 897
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 901
    :sswitch_51
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 903
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 905
    .restart local v3    # "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 906
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setNetworkPermission(ILjava/lang/String;)V

    .line 907
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 908
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 912
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_52
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 914
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 916
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v4

    .line 917
    .local v4, "_arg1":[I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setPermission(Ljava/lang/String;[I)V

    .line 918
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 919
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 923
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":[I
    :sswitch_53
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 925
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v3

    .line 926
    .local v3, "_arg0":[I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->clearPermission([I)V

    .line 927
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 928
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 932
    .end local v3    # "_arg0":[I
    :sswitch_54
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 934
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 935
    .local v3, "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->allowProtect(I)V

    .line 936
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 937
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 941
    .end local v3    # "_arg0":I
    :sswitch_55
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 943
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 944
    .restart local v3    # "_arg0":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->denyProtect(I)V

    .line 945
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 946
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 950
    .end local v3    # "_arg0":I
    :sswitch_56
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 952
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 954
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 955
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->enableNatIpv6(Ljava/lang/String;Ljava/lang/String;)V

    .line 956
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 957
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 961
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_57
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 963
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 965
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 966
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->disableNatIpv6(Ljava/lang/String;Ljava/lang/String;)V

    .line 967
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 968
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 972
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_58
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 974
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_1d

    const/4 v3, 0x1

    .line 975
    .local v3, "_arg0":Z
    :goto_1e
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setIpv6ForwardingEnabled(Z)V

    .line 976
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 977
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 974
    .end local v3    # "_arg0":Z
    :cond_1d
    const/4 v3, 0x0

    goto :goto_1e

    .line 981
    :sswitch_59
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 982
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->getIpv6ForwardingEnabled()Z

    move-result v14

    .line 983
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 984
    if-eqz v14, :cond_1e

    const/4 v2, 0x1

    :goto_1f
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 985
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 984
    :cond_1e
    const/4 v2, 0x0

    goto :goto_1f

    .line 989
    .end local v14    # "_result":Z
    :sswitch_5a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 991
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 993
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 994
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setRouteIpv6(Ljava/lang/String;Ljava/lang/String;)V

    .line 995
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 996
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1000
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_5b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1002
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1004
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1005
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->clearRouteIpv6(Ljava/lang/String;Ljava/lang/String;)V

    .line 1006
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1007
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1011
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_5c
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1013
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1015
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1016
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setSourceRouteIpv6(Ljava/lang/String;Ljava/lang/String;)V

    .line 1017
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1018
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1022
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_5d
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1024
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1026
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1027
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->clearSourceRouteIpv6(Ljava/lang/String;Ljava/lang/String;)V

    .line 1028
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1029
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1033
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_5e
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1035
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_1f

    const/4 v3, 0x1

    .line 1037
    .local v3, "_arg0":Z
    :goto_20
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1038
    .restart local v4    # "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setDhcpv6Enabled(ZLjava/lang/String;)V

    .line 1039
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1040
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1035
    .end local v3    # "_arg0":Z
    .end local v4    # "_arg1":Ljava/lang/String;
    :cond_1f
    const/4 v3, 0x0

    goto :goto_20

    .line 1044
    :sswitch_5f
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1046
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1048
    .local v3, "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .line 1050
    .local v4, "_arg1":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_20

    .line 1051
    sget-object v2, Landroid/net/RouteInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/RouteInfo;

    .line 1056
    .local v5, "_arg2":Landroid/net/RouteInfo;
    :goto_21
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->appendRouteWithMetric(Ljava/lang/String;ILandroid/net/RouteInfo;)Z

    move-result v14

    .line 1057
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1058
    if-eqz v14, :cond_21

    const/4 v2, 0x1

    :goto_22
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1059
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1054
    .end local v5    # "_arg2":Landroid/net/RouteInfo;
    .end local v14    # "_result":Z
    :cond_20
    const/4 v5, 0x0

    .restart local v5    # "_arg2":Landroid/net/RouteInfo;
    goto :goto_21

    .line 1058
    .restart local v14    # "_result":Z
    :cond_21
    const/4 v2, 0x0

    goto :goto_22

    .line 1063
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":I
    .end local v5    # "_arg2":Landroid/net/RouteInfo;
    .end local v14    # "_result":Z
    :sswitch_60
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1065
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1067
    .restart local v3    # "_arg0":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    .line 1068
    .local v4, "_arg1":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setInterfaceAlias(Ljava/lang/String;Ljava/lang/String;)V

    .line 1069
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1070
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1074
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v4    # "_arg1":Ljava/lang/String;
    :sswitch_61
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1076
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1077
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->dropPacket(Ljava/lang/String;)V

    .line 1078
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1079
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1083
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_62
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1085
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1086
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->acceptPacket(Ljava/lang/String;)V

    .line 1087
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1088
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1092
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_63
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1093
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->resetPacketDrop()V

    .line 1094
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1095
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1099
    :sswitch_64
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1101
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .line 1103
    .local v3, "_arg0":I
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_22

    .line 1104
    sget-object v2, Landroid/net/RouteInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-interface {v2, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/RouteInfo;

    .line 1110
    .local v4, "_arg1":Landroid/net/RouteInfo;
    :goto_23
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .line 1111
    .local v5, "_arg2":I
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/INetworkManagementService$Stub;->removeLegacyRouteForNetId(ILandroid/net/RouteInfo;I)V

    .line 1112
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1113
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1107
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    .end local v5    # "_arg2":I
    :cond_22
    const/4 v4, 0x0

    .restart local v4    # "_arg1":Landroid/net/RouteInfo;
    goto :goto_23

    .line 1117
    .end local v3    # "_arg0":I
    .end local v4    # "_arg1":Landroid/net/RouteInfo;
    :sswitch_65
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1118
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->packetList_Indrop()Z

    move-result v14

    .line 1119
    .restart local v14    # "_result":Z
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1120
    if-eqz v14, :cond_23

    const/4 v2, 0x1

    :goto_24
    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 1121
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1120
    :cond_23
    const/4 v2, 0x0

    goto :goto_24

    .line 1125
    .end local v14    # "_result":Z
    :sswitch_66
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1127
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1128
    .local v3, "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->getRouteList_debug(Ljava/lang/String;)V

    .line 1129
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1130
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1134
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_67
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1135
    invoke-virtual/range {p0 .. p0}, Landroid/os/INetworkManagementService$Stub;->packetList_Indrop_view()V

    .line 1136
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1137
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1141
    :sswitch_68
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1143
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_24

    const/4 v3, 0x1

    .line 1144
    .local v3, "_arg0":Z
    :goto_25
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->setTcpWindowScaling(Z)V

    .line 1145
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1146
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1143
    .end local v3    # "_arg0":Z
    :cond_24
    const/4 v3, 0x0

    goto :goto_25

    .line 1150
    :sswitch_69
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1152
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1154
    .local v3, "_arg0":Ljava/lang/String;
    sget-object v2, Landroid/net/RouteInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v12

    .line 1155
    .local v12, "_arg1":Ljava/util/List;, "Ljava/util/List<Landroid/net/RouteInfo;>;"
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v12}, Landroid/os/INetworkManagementService$Stub;->addInterfaceToLocalNetwork(Ljava/lang/String;Ljava/util/List;)V

    .line 1156
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1157
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1161
    .end local v3    # "_arg0":Ljava/lang/String;
    .end local v12    # "_arg1":Ljava/util/List;, "Ljava/util/List<Landroid/net/RouteInfo;>;"
    :sswitch_6a
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1163
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 1164
    .restart local v3    # "_arg0":Ljava/lang/String;
    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Landroid/os/INetworkManagementService$Stub;->removeInterfaceFromLocalNetwork(Ljava/lang/String;)V

    .line 1165
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1166
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1170
    .end local v3    # "_arg0":Ljava/lang/String;
    :sswitch_6b
    const-string v2, "android.os.INetworkManagementService"

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    .line 1172
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_25

    const/4 v3, 0x1

    .line 1174
    .local v3, "_arg0":Z
    :goto_26
    invoke-virtual/range {p2 .. p2}, Landroid/os/Parcel;->readInt()I

    move-result v2

    if-eqz v2, :cond_26

    const/4 v4, 0x1

    .line 1175
    .local v4, "_arg1":Z
    :goto_27
    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Landroid/os/INetworkManagementService$Stub;->setWifiHighTrafficMode(ZZ)V

    .line 1176
    invoke-virtual/range {p3 .. p3}, Landroid/os/Parcel;->writeNoException()V

    .line 1177
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 1172
    .end local v3    # "_arg0":Z
    .end local v4    # "_arg1":Z
    :cond_25
    const/4 v3, 0x0

    goto :goto_26

    .line 1174
    .restart local v3    # "_arg0":Z
    :cond_26
    const/4 v4, 0x0

    goto :goto_27

    .line 42
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
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
