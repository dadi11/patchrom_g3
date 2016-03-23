.class public Lcom/android/server/ePDGTracker;
.super Landroid/os/Handler;
.source "ePDGTracker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/ePDGTracker$WFCPreferObserver;,
        Lcom/android/server/ePDGTracker$WFCSettingObserver;,
        Lcom/android/server/ePDGTracker$ePDGNetworkAgent;
    }
.end annotation


# static fields
.field static final DELAYED_HO_EVENT:I = 0x4

.field public static final DISCONNECTED_DONE:I = 0x3e4

.field static final EPDG_ALREADY_ACTIVE:I = 0x0

.field static final EPDG_ALREADY_INACTIVE:I = 0x6

.field static final EPDG_DISCONNECT_STARTED:I = 0x8

.field static final EPDG_FAIL_MANAGER_NOT_READY:I = 0x4

.field static final EPDG_FAIL_NO_NETWORK:I = 0x3

.field static final EPDG_FAIL_SIM_NOT_READY:I = 0x5

.field static final EPDG_NETWORK_FAIL:I = 0x7

.field static final EPDG_REQUEST_STARTED:I = 0x1

.field static final EPDG_TYPE_NOT_AVAILABLE:I = 0x2

.field static final EVENT_CALLSTATE_CH:I = 0x6

.field static final EVENT_CONNECTION_LOST:I = 0x2

.field static final EVENT_CONNECTION_RSP:I = 0x1

.field public static final EVENT_DEBUG_TYPE:I = 0x2

.field static final EVENT_GET_WIFISIG:I = 0x3

.field static final EVENT_SERVICE_CHANGE:I = 0x5

.field static final IPSEC_SERVICESTATUS_CHANGE:I = 0x0

.field static final IPSEC_SERVICE_START:I = 0x1

.field static final IPSEC_SERVICE_STOP:I = 0x0

.field public static final IPTYPE_IPV4:I = 0x1

.field public static final IPTYPE_IPV4V6:I = 0x3

.field public static final IPTYPE_IPV6:I = 0x2

.field static final LOG_TAG:Ljava/lang/String; = "ePDGTracker"

.field public static final PCS_CH:I = 0x3e5

.field public static final PCS_INFO:I = 0x3e6

.field static final PDN_CONNECTED_LTE:I = 0x5

.field static final PDN_CONNECTED_ePDG:I = 0x6

.field public static final QOS_INFO:I = 0x3e7

.field static final SCAN_FAIL:I = 0x270f

.field public static final SIGNAL_DEBUG_TYPE:I = 0x1

.field private static final TCP_SIZES_EPDG_DEFAULT:Ljava/lang/String; = "524288,1048576,2097152,262144,524288,1048576"

.field static final TEMP_TEMP_TEMP:I = 0x309

.field static final WIFI_CONNECTED_EVENT:I = 0x5

.field static final WIFI_DISCONNECTED_EVENT:I = 0x6

.field static final ePDG_PDN_CONNECTED:I = 0x0

.field static final ePDG_PDN_DISCONNECTED:I = 0x2

.field static final ePDG_PDN_DISCONNECTING:I = 0x4

.field static final ePDG_PDN_FAILED:I = 0x3

.field static final ePDG_PDN_REQUESTING:I = 0x1

.field static final numofpdn:I = 0x2


# instance fields
.field public DataState:I

.field public FQDNForEPDG:Ljava/lang/String;

.field private FQDNForTestApp:Ljava/lang/String;

.field private FQDNStaticFlag:Z

.field public MobileTech:I

.field public WFC_setting:I

.field private WiFi_Offload_gw_addr:Ljava/lang/String;

.field public call_status:I

.field private ePDGAddrForTestApp:Ljava/lang/String;

.field private ePDGAddrStaticFlag:Z

.field public ePDGAddrofThisnetwork:Ljava/lang/String;

.field public iLTEIPType:[I

.field public iLTEPDN4Addr:[Ljava/lang/String;

.field public iLTEPDN6Addr:[Ljava/lang/String;

.field public iPsecAddr:[Ljava/lang/String;

.field public iPsecDNS:[Ljava/lang/String;

.field public iPsecGW:[Ljava/lang/String;

.field public iPsecIf:[Ljava/lang/String;

.field public identity:Ljava/lang/String;

.field public isFeatureStatus:[I

.field public isFeatureSwitch:[Z

.field public isbeforeSigstat:Z

.field public isgood:Z

.field private mContext:Landroid/content/Context;

.field protected mIMSLinkProperties:Landroid/net/LinkProperties;

.field mIMS_HO_avail:Z

.field public mLastfailreason:[I

.field private mMgrStatus:I

.field private mNetworkAgent:[Landroid/net/NetworkAgent;

.field private mNetworkInfo:[Landroid/net/NetworkInfo;

.field private final mPhoneStateListener:Landroid/telephony/PhoneStateListener;

.field protected mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

.field private mTarget:Landroid/os/Handler;

.field protected mVZWAPPLinkProperties:Landroid/net/LinkProperties;

.field private final mWFCDataSettingObserver:Lcom/android/server/ePDGTracker$WFCSettingObserver;

.field private final mWFCPreferObserver:Lcom/android/server/ePDGTracker$WFCPreferObserver;

.field public mWifiConnected:Z

.field private mWifiManager:Landroid/net/wifi/WifiManager;

.field public mcallstate:I

.field public mcc:Ljava/lang/String;

.field protected mePDGConnections:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Lcom/android/server/ePDGConnection;",
            ">;"
        }
    .end annotation
.end field

.field private mePDGNotifier:Lcom/android/server/ePDGNotifier;

.field public mnc:Ljava/lang/String;

.field public mobile_avail:Z

.field public myServiceState:Landroid/telephony/ServiceState;

.field public myfeature:I

.field public needtoChangeInitialPri:Z

.field public oldBad:I

.field public oldGood:I

.field public thre:I

.field tm:Landroid/telephony/TelephonyManager;

.field public tmushandoutthre:I

.field private vzwappRef:Z

.field private vzwcbsRef:Z

.field private vzwmmsRef:Z

.field public wfcprefer:I

.field public wifidetailstatus:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "target"    # Landroid/os/Handler;

    .prologue
    const/4 v7, 0x2

    const/4 v6, 0x5

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 400
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 103
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    .line 106
    iput v4, p0, Lcom/android/server/ePDGTracker;->mMgrStatus:I

    .line 108
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    .line 115
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    .line 116
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    .line 118
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    .line 129
    new-array v1, v6, [Z

    fill-array-data v1, :array_0

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    .line 130
    new-array v1, v6, [I

    fill-array-data v1, :array_1

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    .line 132
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iLTEPDN4Addr:[Ljava/lang/String;

    .line 133
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iLTEPDN6Addr:[Ljava/lang/String;

    .line 134
    new-array v1, v6, [I

    fill-array-data v1, :array_2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iLTEIPType:[I

    .line 135
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    .line 136
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    .line 137
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    .line 138
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    .line 140
    new-instance v1, Landroid/net/LinkProperties;

    invoke-direct {v1}, Landroid/net/LinkProperties;-><init>()V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    .line 144
    new-instance v1, Landroid/net/LinkProperties;

    invoke-direct {v1}, Landroid/net/LinkProperties;-><init>()V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    .line 149
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    .line 201
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    .line 202
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->FQDNForEPDG:Ljava/lang/String;

    .line 205
    new-array v1, v6, [I

    fill-array-data v1, :array_3

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    .line 211
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    .line 212
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    .line 213
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    .line 214
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    .line 215
    const-string v1, "fe80::e291:f5ff:fecc:5dd7"

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->WiFi_Offload_gw_addr:Ljava/lang/String;

    .line 244
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    .line 245
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    .line 246
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    .line 253
    iput-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    .line 255
    iput v4, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    .line 256
    iput v4, p0, Lcom/android/server/ePDGTracker;->oldGood:I

    .line 257
    iput v4, p0, Lcom/android/server/ePDGTracker;->oldBad:I

    .line 259
    iput v7, p0, Lcom/android/server/ePDGTracker;->thre:I

    .line 260
    const/16 v1, -0x55

    iput v1, p0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

    .line 262
    iput-boolean v5, p0, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    .line 265
    iput v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    .line 269
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->needtoChangeInitialPri:Z

    .line 271
    iput-object v3, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    .line 272
    iput v4, p0, Lcom/android/server/ePDGTracker;->mcallstate:I

    .line 276
    iput v4, p0, Lcom/android/server/ePDGTracker;->DataState:I

    .line 277
    iput v4, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    .line 291
    iput v4, p0, Lcom/android/server/ePDGTracker;->call_status:I

    .line 293
    iput v5, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    .line 294
    iput v4, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    .line 296
    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    .line 326
    new-instance v1, Lcom/android/server/ePDGTracker$WFCSettingObserver;

    invoke-direct {v1, p0, p0}, Lcom/android/server/ePDGTracker$WFCSettingObserver;-><init>(Lcom/android/server/ePDGTracker;Landroid/os/Handler;)V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCDataSettingObserver:Lcom/android/server/ePDGTracker$WFCSettingObserver;

    .line 356
    new-instance v1, Lcom/android/server/ePDGTracker$WFCPreferObserver;

    invoke-direct {v1, p0, p0}, Lcom/android/server/ePDGTracker$WFCPreferObserver;-><init>(Lcom/android/server/ePDGTracker;Landroid/os/Handler;)V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCPreferObserver:Lcom/android/server/ePDGTracker$WFCPreferObserver;

    .line 384
    new-instance v1, Lcom/android/server/ePDGTracker$1;

    invoke-direct {v1, p0}, Lcom/android/server/ePDGTracker$1;-><init>(Lcom/android/server/ePDGTracker;)V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    .line 402
    iput-object p1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    .line 403
    iput-object p2, p0, Lcom/android/server/ePDGTracker;->mTarget:Landroid/os/Handler;

    .line 410
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v1

    iget v1, v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    iput v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    .line 414
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/TelephonyManager;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->tm:Landroid/telephony/TelephonyManager;

    .line 416
    const-string v1, "telephony.registry"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/ITelephonyRegistry$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephonyRegistry;

    move-result-object v1

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    .line 419
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v1, v5, :cond_2

    .line 421
    const-string v1, "net.loss"

    const-string v2, "2"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 422
    const-string v1, "net.wifisigmon"

    const-string v2, "yes"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 442
    :cond_0
    :goto_0
    new-array v1, v7, [Landroid/net/NetworkInfo;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    .line 443
    new-array v1, v7, [Landroid/net/NetworkAgent;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    .line 452
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v2, "wifi"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/wifi/WifiManager;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 456
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_1

    .line 458
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCDataSettingObserver:Lcom/android/server/ePDGTracker$WFCSettingObserver;

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGTracker$WFCSettingObserver;->register(Landroid/content/Context;)V

    .line 459
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCPreferObserver:Lcom/android/server/ePDGTracker$WFCPreferObserver;

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGTracker$WFCPreferObserver;->register(Landroid/content/Context;)V

    .line 464
    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 467
    .local v0, "tm":Landroid/telephony/TelephonyManager;
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    const/16 v2, 0x21

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 469
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ePDGTracker start!! with feature"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " wfcprefer : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " WFC settings : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 472
    return-void

    .line 424
    .end local v0    # "tm":Landroid/telephony/TelephonyManager;
    :cond_2
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_0

    .line 426
    const-string v1, "net.loss"

    const-string v2, "85"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 427
    const-string v1, "net.wifisigmon"

    const-string v2, "yes"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 129
    nop

    :array_0
    .array-data 1
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
    .end array-data

    .line 130
    nop

    :array_1
    .array-data 4
        0x2
        0x2
        0x2
        0x2
        0x2
    .end array-data

    .line 134
    :array_2
    .array-data 4
        0x0
        0x0
        0x0
        0x0
        0x0
    .end array-data

    .line 205
    :array_3
    .array-data 4
        0x0
        0x0
        0x0
        0x0
        0x0
    .end array-data
.end method

.method private createPDGConnection(I)Lcom/android/server/ePDGConnection;
    .locals 5
    .param p1, "fid"    # I

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 1789
    const-string v1, "createPDGConnection E"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1793
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_0

    .line 1795
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "PREFERRED_OPTION"

    invoke-static {v1, v2, v3}, Lcom/movial/ipphone/IPPhoneSettings;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    iput v1, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    .line 1797
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "CELL_ONLY"

    invoke-static {v1, v2, v4}, Lcom/movial/ipphone/IPPhoneSettings;->getBoolean(Landroid/content/ContentResolver;Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1799
    iput v3, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    .line 1806
    :cond_0
    :goto_0
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->isDualType(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1808
    invoke-static {p1}, Lcom/android/server/ePDGDualTypeConn;->makePDGConnection(I)Lcom/android/server/ePDGDualTypeConn;

    move-result-object v0

    .line 1809
    .local v0, "conn":Lcom/android/server/ePDGDualTypeConn;
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->setContext(Landroid/content/Context;)V

    .line 1810
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1811
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createDualPDGConnection() X id="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " wfcprefer : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " WFC settings : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1819
    .end local v0    # "conn":Lcom/android/server/ePDGDualTypeConn;
    :goto_1
    return-object v0

    .line 1803
    :cond_1
    iput v4, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    goto :goto_0

    .line 1815
    :cond_2
    invoke-static {p1}, Lcom/android/server/ePDGSTypeConnection;->makePDGConnection(I)Lcom/android/server/ePDGSTypeConnection;

    move-result-object v0

    .line 1816
    .local v0, "conn":Lcom/android/server/ePDGSTypeConnection;
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1818
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createPDGConnection() X id="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private findePDGConnection(I)Lcom/android/server/ePDGConnection;
    .locals 3
    .param p1, "fid"    # I

    .prologue
    .line 1824
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 1825
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    invoke-virtual {v0}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v2

    if-ne v2, p1, :cond_0

    .line 1828
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private findePDGConnectionbyCid(I)Lcom/android/server/ePDGConnection;
    .locals 3
    .param p1, "cid"    # I

    .prologue
    .line 1834
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 1835
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget v2, v0, Lcom/android/server/ePDGConnection;->cid:I

    if-ne v2, p1, :cond_0

    .line 1838
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isDualType(I)Z
    .locals 2
    .param p1, "fid"    # I

    .prologue
    .line 1780
    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    .line 1782
    const/4 v0, 0x1

    .line 1784
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private log(Ljava/lang/String;)V
    .locals 1
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 3381
    const-string v0, "ePDGTracker"

    invoke-static {v0, p1}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3382
    return-void
.end method

.method private makeNetworkCapabilities(I)Landroid/net/NetworkCapabilities;
    .locals 8
    .param p1, "mid"    # I

    .prologue
    const/4 v7, 0x5

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 789
    new-instance v1, Landroid/net/NetworkCapabilities;

    invoke-direct {v1}, Landroid/net/NetworkCapabilities;-><init>()V

    .line 790
    .local v1, "result":Landroid/net/NetworkCapabilities;
    invoke-virtual {v1, v5}, Landroid/net/NetworkCapabilities;->addTransportType(I)Landroid/net/NetworkCapabilities;

    .line 792
    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    .line 794
    if-nez p1, :cond_0

    .line 796
    const/4 v3, 0x4

    invoke-virtual {v1, v3}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    .line 821
    :goto_0
    const v2, 0xc800

    .line 822
    .local v2, "up":I
    const/16 v0, 0x1399

    .line 824
    .local v0, "down":I
    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->setLinkUpstreamBandwidthKbps(I)V

    .line 825
    invoke-virtual {v1, v0}, Landroid/net/NetworkCapabilities;->setLinkDownstreamBandwidthKbps(I)V

    .line 826
    const-string v3, "ePDG"

    invoke-virtual {v1, v3}, Landroid/net/NetworkCapabilities;->setNetworkSpecifier(Ljava/lang/String;)V

    .line 827
    .end local v0    # "down":I
    .end local v1    # "result":Landroid/net/NetworkCapabilities;
    .end local v2    # "up":I
    :goto_1
    return-object v1

    .line 800
    .restart local v1    # "result":Landroid/net/NetworkCapabilities;
    :cond_0
    invoke-virtual {v1, v7}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    goto :goto_0

    .line 803
    :cond_1
    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v3, v6, :cond_3

    .line 805
    if-eq p1, v6, :cond_2

    .line 807
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unknown pdn id!! is vowif start?? : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 809
    :cond_2
    invoke-virtual {v1, v7}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    .line 810
    invoke-virtual {v1, v5}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    goto :goto_0

    .line 816
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unknown feature : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 817
    const/4 v1, 0x0

    goto :goto_1
.end method

.method private makeidentity()Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v3, 0x0

    const/4 v6, 0x6

    const/4 v5, 0x3

    .line 1718
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    if-eqz v4, :cond_1

    .line 1720
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    .line 1756
    :cond_0
    :goto_0
    return-object v3

    .line 1723
    :cond_1
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->tm:Landroid/telephony/TelephonyManager;

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v0

    .line 1725
    .local v0, "imsi":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 1728
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 1730
    .local v1, "length":I
    if-ge v1, v6, :cond_2

    .line 1732
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "imsi is strange just return"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1737
    :cond_2
    const/4 v2, 0x3

    .line 1745
    .local v2, "mnc_len":I
    const/4 v3, 0x0

    invoke-virtual {v0, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    .line 1746
    invoke-virtual {v0, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    .line 1749
    const/4 v3, 0x2

    if-ne v2, v3, :cond_3

    .line 1750
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "0"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    .line 1752
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "0"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "@wlan.mnc"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".mcc"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".3gppnetwork.org"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    .line 1754
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "imsi: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1756
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    goto/16 :goto_0
.end method

.method private onConnectionRsp(Lcom/android/server/ePDGConnInfo;)V
    .locals 7
    .param p1, "rsp"    # Lcom/android/server/ePDGConnInfo;

    .prologue
    const/4 v2, 0x6

    const/4 v6, 0x0

    const/4 v5, 0x3

    const/4 v4, 0x1

    const/4 v3, 0x2

    .line 834
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-le v0, v3, :cond_0

    .line 836
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "What???? Bad SMi id = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1106
    :goto_0
    return-void

    .line 840
    :cond_0
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-nez v0, :cond_7

    .line 843
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Data Connect Success!! "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 844
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    if-ne v0, v4, :cond_4

    .line 846
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x5

    aput v2, v0, v1

    .line 858
    :goto_1
    iget-object v0, p1, Lcom/android/server/ePDGConnInfo;->ConnectedGWAddr:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    .line 860
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    aput-object v2, v0, v1

    .line 861
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    aput-object v2, v0, v1

    .line 862
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    aput-object v2, v0, v1

    .line 863
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    aput-object v2, v0, v1

    .line 866
    iget-object v0, p1, Lcom/android/server/ePDGConnInfo;->mFQDN:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 868
    iget-object v0, p1, Lcom/android/server/ePDGConnInfo;->mFQDN:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGTracker;->FQDNForEPDG:Ljava/lang/String;

    .line 870
    :cond_1
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_6

    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_6

    .line 872
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 873
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v2, v0, v2

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v3, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v3, v0, v3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    iget v4, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v4, v0, v4

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    iget v5, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v5, v0, v5

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    .line 875
    invoke-direct {p0, v6}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->requestpcscfaddr(Lcom/android/server/ePDGConnection;)V

    .line 876
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    .line 891
    :cond_2
    :goto_2
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 893
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    .line 894
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyonConnectionParam(I)V

    .line 1103
    :cond_3
    :goto_3
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    goto/16 :goto_0

    .line 848
    :cond_4
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    if-ne v0, v3, :cond_5

    .line 850
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v2, v0, v1

    goto/16 :goto_1

    .line 854
    :cond_5
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v6, v0, v1

    goto/16 :goto_1

    .line 885
    :cond_6
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-ne v0, v4, :cond_2

    .line 887
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 888
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v2, v0, v2

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v3, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v3, v0, v3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    iget v4, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v4, v0, v4

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    iget v5, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget-object v5, v0, v5

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    .line 889
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    goto :goto_2

    .line 899
    :cond_7
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0xa

    if-ne v0, v1, :cond_8

    .line 901
    const-string v0, "Exit Fail status, we set status disconnect"

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 902
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v3, v0, v1

    .line 903
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    goto :goto_3

    .line 905
    :cond_8
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v3, :cond_c

    .line 907
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v3, v0, v1

    .line 910
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x0

    aput-object v2, v0, v1

    .line 913
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_a

    .line 915
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    .line 925
    :cond_9
    :goto_4
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 928
    iget-boolean v0, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-eqz v0, :cond_b

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_b

    .line 931
    const/4 v0, 0x4

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0, v1, v6}, Lcom/android/server/ePDGTracker;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    const-wide/16 v2, 0x7d0

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_3

    .line 917
    :cond_a
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-ne v0, v4, :cond_9

    .line 919
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    goto :goto_4

    .line 936
    :cond_b
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    .line 937
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 941
    :cond_c
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v4, :cond_e

    .line 943
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    aput v2, v0, v1

    .line 944
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    .line 946
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_d

    .line 948
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    .line 954
    :cond_d
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    goto/16 :goto_3

    .line 959
    :cond_e
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v5, :cond_14

    .line 961
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    aput v2, v0, v1

    .line 962
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ePDG] CON_LOST "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 963
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget v0, v0, v1

    const/16 v1, 0x138c

    if-eq v0, v1, :cond_f

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget v0, v0, v1

    const/16 v1, 0x138d

    if-ne v0, v1, :cond_10

    .line 965
    :cond_f
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    .line 966
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 967
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    .line 970
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 974
    :cond_10
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v3, v0, v1

    .line 978
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x0

    aput-object v2, v0, v1

    .line 981
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_12

    .line 983
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    .line 990
    :cond_11
    :goto_5
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 993
    iget-boolean v0, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-eqz v0, :cond_13

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_13

    .line 996
    const/4 v0, 0x4

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0, v1, v6}, Lcom/android/server/ePDGTracker;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    const-wide/16 v2, 0x7d0

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_3

    .line 985
    :cond_12
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-ne v0, v4, :cond_11

    .line 987
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    goto :goto_5

    .line 1000
    :cond_13
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    .line 1001
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    .line 1002
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 1010
    :cond_14
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x3e8

    if-ne v0, v1, :cond_15

    .line 1012
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/16 v2, 0x3e8

    aput v2, v0, v1

    .line 1013
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    .line 1015
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 1017
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    .line 1018
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 1038
    :cond_15
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x3e9

    if-ne v0, v1, :cond_16

    .line 1040
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/16 v2, 0x3e9

    aput v2, v0, v1

    .line 1041
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    .line 1043
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 1045
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    .line 1046
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 1051
    :cond_16
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x138d

    if-ne v0, v1, :cond_17

    .line 1053
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/16 v2, 0x138d

    aput v2, v0, v1

    .line 1054
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ePDG]Handover Fail "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1055
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 1056
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 1058
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    goto/16 :goto_3

    .line 1061
    :cond_17
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x8

    if-ne v0, v1, :cond_18

    .line 1063
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    aput v2, v0, v1

    .line 1064
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ePDG]Connectivity Fail "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aget v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1065
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 1066
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 1068
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    goto/16 :goto_3

    .line 1071
    :cond_18
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v2, :cond_19

    .line 1073
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x5

    aput v2, v0, v1

    .line 1074
    const-string v0, "[ePDG]Handover success to LTE "

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1075
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 1076
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 1078
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    .line 1079
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 1083
    :cond_19
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_1a

    .line 1085
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v2, v0, v1

    .line 1086
    const-string v0, "[ePDG]Handover success to ePDG "

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1087
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    .line 1088
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    .line 1090
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    .line 1091
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    .line 1096
    :cond_1a
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ePDG]unknown type "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_3
.end method

.method private sendLOSnotification(I)V
    .locals 12
    .param p1, "mid"    # I

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 678
    if-le p1, v4, :cond_0

    .line 680
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mid is wrong : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 785
    :goto_0
    return-void

    .line 684
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sendLOSnotification !! "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " state :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 686
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    if-nez v0, :cond_1

    .line 688
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "myServiceState is null: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 693
    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getDataNetworkType()I

    move-result v9

    .line 694
    .local v9, "networkType":I
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->DISCONNECTED:Landroid/net/NetworkInfo$DetailedState;

    .line 696
    .local v10, "thisstate":Landroid/net/NetworkInfo$DetailedState;
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    if-nez v0, :cond_2

    .line 698
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    new-instance v1, Landroid/net/NetworkInfo;

    const-string v2, "MOBILE"

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v5, v9, v2, v3}, Landroid/net/NetworkInfo;-><init>(IILjava/lang/String;Ljava/lang/String;)V

    aput-object v1, v0, p1

    .line 700
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-virtual {v0, v5}, Landroid/net/NetworkInfo;->setRoaming(Z)V

    .line 710
    :goto_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    const/4 v1, 0x5

    if-ne v0, v1, :cond_3

    .line 712
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->CONNECTED:Landroid/net/NetworkInfo$DetailedState;

    .line 714
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/net/NetworkInfo;->setExtraInfo(Ljava/lang/String;)V

    .line 715
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-virtual {v0, v4}, Landroid/net/NetworkInfo;->setIsAvailable(Z)V

    .line 738
    :goto_2
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    const-string v1, "ePDG"

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v2, v2, p1

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getExtraInfo()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v10, v1, v2}, Landroid/net/NetworkInfo;->setDetailedState(Landroid/net/NetworkInfo$DetailedState;Ljava/lang/String;Ljava/lang/String;)V

    .line 745
    if-nez p1, :cond_7

    .line 747
    iget-object v7, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    .line 754
    .local v7, "mLinkProperties":Landroid/net/LinkProperties;
    :goto_3
    const-string v0, "524288,1048576,2097152,262144,524288,1048576"

    invoke-virtual {v7, v0}, Landroid/net/LinkProperties;->setTcpBufferSizes(Ljava/lang/String;)V

    .line 756
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, p1

    if-nez v0, :cond_8

    .line 759
    iget-object v11, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    new-instance v0, Lcom/android/server/ePDGTracker$ePDGNetworkAgent;

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/server/ePDGConnection;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v4, "ePDGNetworkAgent"

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v5, v1, p1

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->makeNetworkCapabilities(I)Landroid/net/NetworkCapabilities;

    move-result-object v6

    const/16 v8, 0x32

    move-object v1, p0

    invoke-direct/range {v0 .. v8}, Lcom/android/server/ePDGTracker$ePDGNetworkAgent;-><init>(Lcom/android/server/ePDGTracker;Landroid/os/Looper;Landroid/content/Context;Ljava/lang/String;Landroid/net/NetworkInfo;Landroid/net/NetworkCapabilities;Landroid/net/LinkProperties;I)V

    aput-object v0, v11, p1

    goto/16 :goto_0

    .line 705
    .end local v7    # "mLinkProperties":Landroid/net/LinkProperties;
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mNetworkInfo is not null: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " set networktype "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 706
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v9, v1}, Landroid/net/NetworkInfo;->setSubtype(ILjava/lang/String;)V

    goto/16 :goto_1

    .line 717
    :cond_3
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    const/4 v1, 0x6

    if-eq v0, v1, :cond_4

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    if-nez v0, :cond_5

    .line 719
    :cond_4
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->CONNECTED:Landroid/net/NetworkInfo$DetailedState;

    .line 720
    const/16 v9, 0x12

    .line 721
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v9, v1}, Landroid/net/NetworkInfo;->setSubtype(ILjava/lang/String;)V

    .line 723
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/net/NetworkInfo;->setExtraInfo(Ljava/lang/String;)V

    .line 724
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-virtual {v0, v4}, Landroid/net/NetworkInfo;->setIsAvailable(Z)V

    goto/16 :goto_2

    .line 726
    :cond_5
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_6

    .line 728
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->FAILED:Landroid/net/NetworkInfo$DetailedState;

    goto/16 :goto_2

    .line 733
    :cond_6
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->DISCONNECTED:Landroid/net/NetworkInfo$DetailedState;

    goto/16 :goto_2

    .line 751
    :cond_7
    iget-object v7, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    .restart local v7    # "mLinkProperties":Landroid/net/LinkProperties;
    goto/16 :goto_3

    .line 770
    :cond_8
    sget-object v0, Landroid/net/NetworkInfo$DetailedState;->CONNECTED:Landroid/net/NetworkInfo$DetailedState;

    if-ne v10, v0, :cond_9

    .line 772
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, p1

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendNetworkInfo(Landroid/net/NetworkInfo;)V

    goto/16 :goto_0

    .line 778
    :cond_9
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, p1

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendNetworkInfo(Landroid/net/NetworkInfo;)V

    .line 780
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    const/4 v1, 0x0

    aput-object v1, v0, p1

    goto/16 :goto_0
.end method

.method private setAlldcStop()V
    .locals 3

    .prologue
    .line 1842
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 1843
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGConnection;->setManagerStatus(Z)V

    goto :goto_0

    .line 1845
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_0
    return-void
.end method


# virtual methods
.method public checkdcandrequestagain()V
    .locals 3

    .prologue
    .line 1949
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/4 v1, 0x2

    if-ge v0, v1, :cond_3

    .line 1951
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aget-boolean v1, v1, v0

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 1953
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, v0

    const/4 v2, 0x3

    if-eq v1, v2, :cond_2

    .line 1955
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "checkdcandrequestagain start self start, fid= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1956
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    .line 1964
    :cond_0
    :goto_1
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aget-boolean v1, v1, v0

    if-nez v1, :cond_1

    .line 1965
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    .line 1949
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1960
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "checkdcandrequestagain it is on but fail so do not retry, fid= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 1970
    :cond_3
    return-void
.end method

.method public checkdcandsetfeature()V
    .locals 3

    .prologue
    const/4 v2, 0x2

    .line 1939
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    .line 1941
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v2, v1, v0

    .line 1939
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1944
    :cond_0
    return-void
.end method

.method public determineTMUSRSSI(Z)I
    .locals 26
    .param p1, "isfist"    # Z

    .prologue
    .line 2149
    const/4 v14, 0x0

    .line 2152
    .local v14, "ret":I
    const-string v22, "net.wifisigmon"

    invoke-static/range {v22 .. v22}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 2153
    .local v13, "operator":Ljava/lang/String;
    const/4 v8, 0x0

    .line 2155
    .local v8, "isCheckPLoss":Z
    if-nez v13, :cond_1

    .line 2157
    const-string v22, "[ePDG] packet loss check is disabled"

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2158
    const/4 v8, 0x0

    .line 2170
    :cond_0
    :goto_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->mWifiManager:Landroid/net/wifi/WifiManager;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Landroid/net/wifi/WifiManager;->getWifiRSSIandLoss()[I

    move-result-object v12

    .line 2173
    .local v12, "myWifiinfo":[I
    if-nez v12, :cond_3

    .line 2175
    const-string v22, "[ePDG] WiFi info is null. So it will be skipped this time."

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2176
    const/16 v22, 0x3

    move-object/from16 v0, p0

    move/from16 v1, v22

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v22

    const-wide/16 v24, 0x7d0

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    move-wide/from16 v2, v24

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    move v15, v14

    .line 2248
    .end local v14    # "ret":I
    .local v15, "ret":I
    :goto_1
    return v15

    .line 2160
    .end local v12    # "myWifiinfo":[I
    .end local v15    # "ret":I
    .restart local v14    # "ret":I
    :cond_1
    const-string v22, "yes"

    move-object/from16 v0, v22

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v22

    if-eqz v22, :cond_0

    .line 2162
    if-eqz p1, :cond_2

    .line 2164
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[ePDG] packet loss check is enabled!! "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2166
    :cond_2
    const/4 v8, 0x1

    goto :goto_0

    .line 2179
    .restart local v12    # "myWifiinfo":[I
    :cond_3
    const-wide/16 v10, 0x0

    .line 2180
    .local v10, "loss":D
    const/16 v22, 0x1

    aget v7, v12, v22

    .line 2181
    .local v7, "good":I
    const/16 v22, 0x2

    aget v4, v12, v22

    .line 2182
    .local v4, "bad":I
    const-wide/16 v18, 0x0

    .line 2183
    .local v18, "term_loss":D
    new-instance v6, Ljava/text/DecimalFormat;

    const-string v22, "###.##"

    move-object/from16 v0, v22

    invoke-direct {v6, v0}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    .line 2185
    .local v6, "df":Ljava/text/DecimalFormat;
    const/16 v22, 0x0

    aget v5, v12, v22

    .line 2187
    .local v5, "currentRssi":I
    add-int v22, v7, v4

    if-eqz v22, :cond_4

    .line 2189
    int-to-double v0, v4

    move-wide/from16 v22, v0

    add-int v24, v7, v4

    move/from16 v0, v24

    int-to-double v0, v0

    move-wide/from16 v24, v0

    div-double v22, v22, v24

    const-wide/high16 v24, 0x4059000000000000L    # 100.0

    mul-double v10, v22, v24

    .line 2192
    :cond_4
    if-eqz p1, :cond_5

    .line 2194
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[ePDG] Start TMUS monitoring!! RSSI="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const/16 v23, 0x0

    aget v23, v12, v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " Good!! = "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const/16 v23, 0x1

    aget v23, v12, v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, ", Bad!! = "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const/16 v23, 0x2

    aget v23, v12, v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, ", Loss = "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2195
    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldGood:I

    .line 2196
    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldBad:I

    .line 2200
    :cond_5
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move/from16 v22, v0

    sub-int v17, v7, v22

    .line 2201
    .local v17, "term_good":I
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    move/from16 v22, v0

    sub-int v16, v4, v22

    .line 2203
    .local v16, "term_bad":I
    add-int v22, v17, v16

    if-eqz v22, :cond_6

    .line 2205
    move/from16 v0, v16

    int-to-double v0, v0

    move-wide/from16 v22, v0

    add-int v24, v17, v16

    move/from16 v0, v24

    int-to-double v0, v0

    move-wide/from16 v24, v0

    div-double v22, v22, v24

    const-wide/high16 v24, 0x4059000000000000L    # 100.0

    mul-double v18, v22, v24

    .line 2208
    :cond_6
    move-object/from16 v0, p0

    iput v7, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    .line 2209
    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    .line 2211
    const/4 v9, 0x0

    .line 2212
    .local v9, "isPacketBAD":Z
    const-wide/high16 v20, 0x4000000000000000L    # 2.0

    .line 2214
    .local v20, "tmuspacketthre":D
    const/16 v22, 0xa

    move/from16 v0, v16

    move/from16 v1, v22

    if-le v0, v1, :cond_7

    cmpl-double v22, v18, v20

    if-lez v22, :cond_7

    .line 2216
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "BAD LOSS detect term loss"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-wide/from16 v0, v18

    invoke-virtual {v6, v0, v1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " bad="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2217
    if-eqz v8, :cond_7

    .line 2219
    const/4 v9, 0x1

    .line 2223
    :cond_7
    if-eqz v9, :cond_8

    .line 2225
    const/4 v14, 0x2

    .line 2246
    :goto_2
    const/16 v22, 0x3

    move-object/from16 v0, p0

    move/from16 v1, v22

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v22

    const-wide/16 v24, 0x7d0

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    move-wide/from16 v2, v24

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    move v15, v14

    .line 2248
    .end local v14    # "ret":I
    .restart local v15    # "ret":I
    goto/16 :goto_1

    .line 2229
    .end local v15    # "ret":I
    .restart local v14    # "ret":I
    :cond_8
    const/16 v22, -0x4b

    move/from16 v0, v22

    if-le v5, v0, :cond_9

    .line 2231
    const/4 v14, 0x0

    goto :goto_2

    .line 2233
    :cond_9
    const/16 v22, -0x4b

    move/from16 v0, v22

    if-gt v5, v0, :cond_a

    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

    move/from16 v22, v0

    move/from16 v0, v22

    if-lt v5, v0, :cond_a

    .line 2235
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[ePDG] RSSI is mid, rssi= "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " average Loss : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2236
    const/4 v14, 0x1

    goto :goto_2

    .line 2240
    :cond_a
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[ePDG] RSSI is BAD, rssi= "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " average Loss : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2241
    const/4 v14, 0x2

    goto/16 :goto_2
.end method

.method public ePDGHandOverStatus(I)V
    .locals 9
    .param p1, "extendedRAT"    # I

    .prologue
    .line 3222
    const/4 v8, 0x0

    .line 3224
    .local v8, "apnfid":I
    const/16 v1, 0x12c

    if-ne p1, v1, :cond_0

    .line 3226
    const/4 v8, 0x1

    .line 3230
    :cond_0
    invoke-direct {p0, v8}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 3233
    .local v0, "mydc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_2

    .line 3236
    const/16 v1, 0x68

    if-eq p1, v1, :cond_1

    const/16 v1, 0x69

    if-ne p1, v1, :cond_4

    .line 3238
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mydc is null!! : extendedRAT="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " so create it "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3239
    invoke-direct {p0, v8}, Lcom/android/server/ePDGTracker;->createPDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 3240
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setFQDNByTestApp(ZLjava/lang/String;)V

    .line 3241
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setEPDGAddrByTestApp(ZLjava/lang/String;)V

    .line 3243
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_3

    .line 3245
    iget v1, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget v3, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget v6, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v7, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGConnection;->setinitialvalue(IIIZZII)V

    .line 3261
    :cond_2
    :goto_0
    invoke-virtual {v0, p1}, Lcom/android/server/ePDGConnection;->ePDGHandOverStatus(I)V

    .line 3263
    :goto_1
    return-void

    .line 3249
    :cond_3
    const/4 v1, 0x1

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_0

    .line 3254
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mydc is null!! : extendedRAT="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " just go out "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public ePDGHandvoertriggering(Ljava/lang/String;Z)I
    .locals 5
    .param p1, "feature"    # Ljava/lang/String;
    .param p2, "req"    # Z

    .prologue
    .line 1689
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "ePDGHandvoertriggering is called!! myfeature : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1690
    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    .line 1692
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v2

    .line 1693
    .local v2, "fid":I
    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    .line 1694
    .local v1, "dc":Lcom/android/server/ePDGConnection;
    const/4 v0, 0x0

    .line 1696
    .local v0, "PRi":I
    if-eqz p2, :cond_0

    .line 1697
    const/4 v0, 0x0

    .line 1701
    :goto_0
    invoke-virtual {v1, v0}, Lcom/android/server/ePDGConnection;->setinitPrichange(I)V

    .line 1703
    const/4 v3, 0x1

    .line 1710
    .end local v0    # "PRi":I
    .end local v1    # "dc":Lcom/android/server/ePDGConnection;
    .end local v2    # "fid":I
    :goto_1
    return v3

    .line 1699
    .restart local v0    # "PRi":I
    .restart local v1    # "dc":Lcom/android/server/ePDGConnection;
    .restart local v2    # "fid":I
    :cond_0
    const/4 v0, 0x2

    goto :goto_0

    .line 1707
    .end local v0    # "PRi":I
    .end local v1    # "dc":Lcom/android/server/ePDGConnection;
    .end local v2    # "fid":I
    :cond_1
    if-eqz p2, :cond_2

    .line 1708
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->ePDGStart(Ljava/lang/String;)I

    move-result v3

    goto :goto_1

    .line 1710
    :cond_2
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->ePDGStop(Ljava/lang/String;)I

    move-result v3

    goto :goto_1
.end method

.method public ePDGLosStart(I)I
    .locals 4
    .param p1, "type"    # I

    .prologue
    const/4 v3, 0x7

    const/4 v2, 0x1

    .line 1436
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getEPDGID(I)I

    move-result v0

    .line 1437
    .local v0, "fid":I
    if-le v0, v3, :cond_0

    .line 1438
    const/4 v1, 0x2

    .line 1459
    :goto_0
    return v1

    .line 1442
    :cond_0
    if-ne v0, v2, :cond_2

    .line 1444
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    .line 1459
    :cond_1
    :goto_1
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    move-result v1

    goto :goto_0

    .line 1446
    :cond_2
    const/4 v1, 0x6

    if-ne v0, v1, :cond_3

    .line 1448
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    .line 1449
    const/4 v0, 0x1

    goto :goto_1

    .line 1451
    :cond_3
    if-ne v0, v3, :cond_1

    .line 1453
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    .line 1454
    const/4 v0, 0x1

    goto :goto_1
.end method

.method public ePDGLosStop(I)I
    .locals 6
    .param p1, "type"    # I

    .prologue
    const/4 v5, 0x7

    const/4 v1, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 1125
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getEPDGID(I)I

    move-result v0

    .line 1128
    .local v0, "fid":I
    if-le v0, v5, :cond_1

    .line 1171
    :cond_0
    :goto_0
    return v1

    .line 1144
    :cond_1
    if-ne v0, v4, :cond_4

    .line 1146
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    .line 1160
    :cond_2
    :goto_1
    if-ne v0, v4, :cond_3

    .line 1162
    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    if-nez v2, :cond_0

    .line 1171
    :cond_3
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    move-result v1

    goto :goto_0

    .line 1148
    :cond_4
    const/4 v2, 0x6

    if-ne v0, v2, :cond_5

    .line 1150
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    .line 1151
    const/4 v0, 0x1

    goto :goto_1

    .line 1153
    :cond_5
    if-ne v0, v5, :cond_2

    .line 1155
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    .line 1156
    const/4 v0, 0x1

    goto :goto_1
.end method

.method public ePDGPrefTechdone(I)V
    .locals 2
    .param p1, "result"    # I

    .prologue
    .line 3202
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ePDGPrefTechdone: result="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3205
    return-void
.end method

.method public ePDGStart(I)I
    .locals 11
    .param p1, "fid"    # I

    .prologue
    const/4 v3, 0x5

    const/4 v10, 0x1

    .line 1509
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "ePDGStart is called!! "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->fidtoString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1511
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aput-boolean v10, v4, p1

    .line 1514
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->isInitialAttachtype(I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1518
    :try_start_0
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    invoke-interface {v4, v5, v6}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyEPDGControl(Ljava/lang/String;Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1525
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v9, v4, p1

    .line 1527
    .local v9, "status":I
    if-eqz v9, :cond_1

    if-eq v9, v3, :cond_1

    const/4 v4, 0x6

    if-ne v9, v4, :cond_2

    .line 1531
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Aleady connected!! "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->fidtoString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1532
    const/4 v3, 0x0

    .line 1656
    :goto_1
    return v3

    .line 1534
    :cond_2
    if-ne v9, v10, :cond_3

    .line 1536
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Aleady connecting state "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->fidtoString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    move v3, v10

    .line 1537
    goto :goto_1

    .line 1550
    :cond_3
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-nez v4, :cond_4

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->isUsingOnlyWifi(I)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 1552
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "NO network "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->fidtoString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1553
    const/4 v3, 0x3

    goto :goto_1

    .line 1577
    :cond_4
    invoke-direct {p0}, Lcom/android/server/ePDGTracker;->makeidentity()Ljava/lang/String;

    move-result-object v8

    .line 1580
    .local v8, "identity":Ljava/lang/String;
    if-nez v8, :cond_5

    .line 1582
    const-string v4, "SIM is not ready so just go out"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 1600
    :cond_5
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 1602
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_6

    .line 1604
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->createPDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 1605
    iget-boolean v3, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lcom/android/server/ePDGConnection;->setFQDNByTestApp(ZLjava/lang/String;)V

    .line 1606
    iget-boolean v3, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lcom/android/server/ePDGConnection;->setEPDGAddrByTestApp(ZLjava/lang/String;)V

    .line 1609
    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_7

    .line 1611
    iget v1, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget v3, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget v6, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v7, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGConnection;->setinitialvalue(IIIZZII)V

    .line 1638
    :cond_6
    :goto_2
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .line 1639
    .local v1, "msg_connect":Landroid/os/Message;
    iput v10, v1, Landroid/os/Message;->what:I

    .line 1642
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v2

    .line 1643
    .local v2, "msg_lost":Landroid/os/Message;
    const/4 v3, 0x2

    iput v3, v2, Landroid/os/Message;->what:I

    .line 1647
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    move v5, p1

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGConnection;->ePDGbringUp(Landroid/os/Message;Landroid/os/Message;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 1649
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v10, v3, p1

    :goto_3
    move v3, v10

    .line 1656
    goto/16 :goto_1

    .line 1615
    .end local v1    # "msg_connect":Landroid/os/Message;
    .end local v2    # "msg_lost":Landroid/os/Message;
    :cond_7
    iget-boolean v3, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, v10, v3}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_2

    .line 1653
    .restart local v1    # "msg_connect":Landroid/os/Message;
    .restart local v2    # "msg_lost":Landroid/os/Message;
    :cond_8
    const-string v3, "connection req Error"

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_3

    .line 1520
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    .end local v1    # "msg_connect":Landroid/os/Message;
    .end local v2    # "msg_lost":Landroid/os/Message;
    .end local v8    # "identity":Ljava/lang/String;
    .end local v9    # "status":I
    :catch_0
    move-exception v4

    goto/16 :goto_0
.end method

.method public ePDGStart(Ljava/lang/String;)I
    .locals 4
    .param p1, "feature"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x7

    const/4 v2, 0x1

    .line 1465
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v0

    .line 1466
    .local v0, "fid":I
    if-le v0, v3, :cond_0

    .line 1467
    const/4 v1, 0x2

    .line 1488
    :goto_0
    return v1

    .line 1471
    :cond_0
    if-ne v0, v2, :cond_2

    .line 1473
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    .line 1488
    :cond_1
    :goto_1
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    move-result v1

    goto :goto_0

    .line 1475
    :cond_2
    const/4 v1, 0x6

    if-ne v0, v1, :cond_3

    .line 1477
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    .line 1478
    const/4 v0, 0x1

    goto :goto_1

    .line 1480
    :cond_3
    if-ne v0, v3, :cond_1

    .line 1482
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    .line 1483
    const/4 v0, 0x1

    goto :goto_1
.end method

.method public ePDGStop(I)I
    .locals 10
    .param p1, "fid"    # I

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v7, 0x4

    const/4 v6, 0x0

    const/4 v3, 0x6

    .line 1239
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "ePDGStop is called!! "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->fidtoString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1240
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aput-boolean v6, v4, p1

    .line 1242
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v2, v4, p1

    .line 1245
    .local v2, "status":I
    if-eq v2, v9, :cond_0

    if-ne v2, v7, :cond_1

    .line 1344
    :cond_0
    :goto_0
    return v3

    .line 1249
    :cond_1
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v8, :cond_2

    .line 1251
    const/4 v4, 0x3

    if-ne v2, v4, :cond_2

    if-nez p1, :cond_0

    .line 1260
    :cond_2
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v4, :cond_0

    .line 1269
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 1271
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_3

    .line 1273
    const-string v4, "something wrong!! no dc but status is connected?? anyway return inactive"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1289
    :cond_3
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .line 1290
    .local v1, "msg":Landroid/os/Message;
    iput v8, v1, Landroid/os/Message;->what:I

    .line 1291
    invoke-virtual {v0, v1}, Lcom/android/server/ePDGConnection;->ePDGteardown(Landroid/os/Message;)Z

    move-result v4

    if-nez v4, :cond_4

    .line 1293
    const-string v4, "something wrong!! SM and status is mismatched?? anyway return inactive"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1298
    :cond_4
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v8, :cond_9

    .line 1300
    if-eqz p1, :cond_6

    .line 1302
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v7, v4, p1

    .line 1330
    :cond_5
    :goto_1
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v4, p1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    .line 1332
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->isInitialAttachtype(I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1336
    :try_start_0
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-interface {v4, v5, v6}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyEPDGControl(Ljava/lang/String;Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1338
    :catch_0
    move-exception v4

    goto :goto_0

    .line 1306
    :cond_6
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v4, v4, p1

    if-nez v4, :cond_8

    .line 1308
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v7, v3, p1

    .line 1309
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v3, :cond_7

    .line 1311
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v3, p1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    .line 1313
    :cond_7
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v6, v6}, Lcom/android/server/ePDGConnection;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 1316
    const/16 v3, 0x8

    goto :goto_0

    .line 1320
    :cond_8
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v9, v4, p1

    goto :goto_1

    .line 1324
    :cond_9
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v5, 0xb

    if-ne v4, v5, :cond_5

    .line 1326
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v7, v4, p1

    goto :goto_1
.end method

.method public ePDGStop(Ljava/lang/String;)I
    .locals 6
    .param p1, "feature"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x7

    const/4 v1, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 1179
    const-string v2, "APPALL"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1181
    const-string v1, "APPALL Called"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1182
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    .line 1183
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    .line 1184
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    .line 1185
    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    move-result v1

    .line 1232
    :cond_0
    :goto_0
    return v1

    .line 1188
    :cond_1
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v0

    .line 1189
    .local v0, "fid":I
    if-gt v0, v5, :cond_0

    .line 1205
    if-ne v0, v4, :cond_4

    .line 1207
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    .line 1221
    :cond_2
    :goto_1
    if-ne v0, v4, :cond_3

    .line 1223
    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    if-nez v2, :cond_0

    .line 1232
    :cond_3
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    move-result v1

    goto :goto_0

    .line 1209
    :cond_4
    const/4 v2, 0x6

    if-ne v0, v2, :cond_5

    .line 1211
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    .line 1212
    const/4 v0, 0x1

    goto :goto_1

    .line 1214
    :cond_5
    if-ne v0, v5, :cond_2

    .line 1216
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    .line 1217
    const/4 v0, 0x1

    goto :goto_1
.end method

.method public fidtoString(I)Ljava/lang/String;
    .locals 1
    .param p1, "fid"    # I

    .prologue
    .line 3306
    packed-switch p1, :pswitch_data_0

    .line 3311
    const-string v0, "UnKnow"

    :goto_0
    return-object v0

    .line 3307
    :pswitch_0
    const-string v0, "IMS"

    goto :goto_0

    .line 3308
    :pswitch_1
    const-string v0, "VZWAPP"

    goto :goto_0

    .line 3309
    :pswitch_2
    const-string v0, "CF"

    goto :goto_0

    .line 3310
    :pswitch_3
    const-string v0, "STATIC"

    goto :goto_0

    .line 3306
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public getAPNwithFid(I)Ljava/lang/String;
    .locals 2
    .param p1, "fid"    # I

    .prologue
    .line 1770
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 1771
    .local v0, "mydc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_0

    .line 1772
    const-string v1, "unknown"

    .line 1774
    :goto_0
    return-object v1

    :cond_0
    iget-object v1, v0, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;

    goto :goto_0
.end method

.method public getDebugInfo(II)[D
    .locals 1
    .param p1, "infotype"    # I
    .param p2, "itemnum"    # I

    .prologue
    .line 3297
    const/4 v0, 0x0

    return-object v0
.end method

.method public getEPDGID(I)I
    .locals 2
    .param p1, "type"    # I

    .prologue
    .line 1419
    sparse-switch p1, :sswitch_data_0

    .line 1429
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "wrong feature type : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1430
    const/16 v0, 0xa

    :goto_0
    return v0

    .line 1421
    :sswitch_0
    const/4 v0, 0x0

    goto :goto_0

    .line 1423
    :sswitch_1
    const/4 v0, 0x1

    goto :goto_0

    .line 1425
    :sswitch_2
    const/4 v0, 0x6

    goto :goto_0

    .line 1427
    :sswitch_3
    const/4 v0, 0x7

    goto :goto_0

    .line 1419
    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_3
        0xb -> :sswitch_0
        0xc -> :sswitch_2
        0x13 -> :sswitch_1
    .end sparse-switch
.end method

.method public getEPDGfeatureID(Ljava/lang/String;)I
    .locals 1
    .param p1, "feature"    # Ljava/lang/String;

    .prologue
    .line 1996
    const-string v0, "VZWIMS"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1997
    const/4 v0, 0x0

    .line 2005
    :goto_0
    return v0

    .line 1998
    :cond_0
    const-string v0, "VZWAPP"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1999
    const/4 v0, 0x1

    goto :goto_0

    .line 2000
    :cond_1
    const-string v0, "CF"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 2001
    const/4 v0, 0x2

    goto :goto_0

    .line 2002
    :cond_2
    const-string v0, "Static"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 2003
    const/4 v0, 0x3

    goto :goto_0

    .line 2005
    :cond_3
    const/16 v0, 0x3e7

    goto :goto_0
.end method

.method public getIpv4(I)Ljava/net/InetAddress;
    .locals 6
    .param p1, "mid"    # I

    .prologue
    .line 2859
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getLinkpro(I)Landroid/net/LinkProperties;

    move-result-object v4

    .line 2861
    .local v4, "mylink":Landroid/net/LinkProperties;
    invoke-virtual {v4}, Landroid/net/LinkProperties;->getAddresses()Ljava/util/List;

    move-result-object v1

    .line 2863
    .local v1, "addresses":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/net/InetAddress;>;"
    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/net/InetAddress;

    .line 2864
    .local v0, "addr":Ljava/net/InetAddress;
    instance-of v5, v0, Ljava/net/Inet4Address;

    if-eqz v5, :cond_0

    move-object v3, v0

    .line 2865
    check-cast v3, Ljava/net/Inet4Address;

    .line 2866
    .local v3, "i4addr":Ljava/net/Inet4Address;
    invoke-virtual {v3}, Ljava/net/Inet4Address;->isAnyLocalAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet4Address;->isLinkLocalAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet4Address;->isLoopbackAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet4Address;->isMulticastAddress()Z

    move-result v5

    if-nez v5, :cond_0

    .line 2872
    .end local v0    # "addr":Ljava/net/InetAddress;
    .end local v3    # "i4addr":Ljava/net/Inet4Address;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getLinkpro(I)Landroid/net/LinkProperties;
    .locals 1
    .param p1, "mid"    # I

    .prologue
    .line 3017
    packed-switch p1, :pswitch_data_0

    .line 3024
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    :goto_0
    return-object v0

    .line 3020
    :pswitch_0
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    goto :goto_0

    .line 3022
    :pswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    goto :goto_0

    .line 3017
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public getNetPrefer(Ljava/lang/String;)I
    .locals 9
    .param p1, "reqtype"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x1

    .line 3346
    const-string v1, "MMS"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 3348
    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 3350
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_0

    .line 3352
    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->createPDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 3353
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setFQDNByTestApp(ZLjava/lang/String;)V

    .line 3354
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setEPDGAddrByTestApp(ZLjava/lang/String;)V

    .line 3357
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_1

    .line 3359
    iget v1, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget v3, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget v6, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v7, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGConnection;->setinitialvalue(IIIZZII)V

    .line 3367
    :cond_0
    :goto_0
    invoke-virtual {v0}, Lcom/android/server/ePDGConnection;->getprefer()I

    move-result v8

    .line 3375
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :goto_1
    return v8

    .line 3363
    .restart local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_1
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_0

    .line 3374
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_2
    const-string v1, "getNetPrefer: wrong string"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3375
    const/4 v8, 0x2

    goto :goto_1
.end method

.method public getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;
    .locals 1
    .param p1, "ipv"    # Ljava/lang/String;

    .prologue
    .line 3339
    const-string v0, "ims"

    invoke-virtual {p0, p1, v0}, Lcom/android/server/ePDGTracker;->getPcscfAddress(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPcscfAddress(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .locals 3
    .param p1, "ipv"    # Ljava/lang/String;
    .param p2, "apnType"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 3319
    invoke-virtual {p0, p2}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v2

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 3320
    .local v0, "mydc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_0

    .line 3331
    :goto_0
    return-object v1

    .line 3323
    :cond_0
    const-string v2, "INET"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 3324
    iget-object v1, v0, Lcom/android/server/ePDGConnection;->pcscfAddr_ipv4:[Ljava/lang/String;

    goto :goto_0

    .line 3326
    :cond_1
    const-string v2, "INET6"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 3327
    iget-object v1, v0, Lcom/android/server/ePDGConnection;->pcscfAddr_ipv6:[Ljava/lang/String;

    goto :goto_0

    .line 3330
    :cond_2
    const-string v2, " ipv is not matched"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public getapntypewithfid(I)Ljava/lang/String;
    .locals 2
    .param p1, "id"    # I

    .prologue
    .line 2011
    packed-switch p1, :pswitch_data_0

    .line 2035
    :pswitch_0
    const/4 v0, 0x0

    :goto_0
    return-object v0

    .line 2015
    :pswitch_1
    const-string v0, "ims"

    goto :goto_0

    .line 2019
    :pswitch_2
    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    .line 2021
    const-string v0, "cbs"

    goto :goto_0

    .line 2024
    :cond_0
    const-string v0, "vzwapp"

    goto :goto_0

    .line 2027
    :pswitch_3
    const-string v0, "CF"

    goto :goto_0

    .line 2029
    :pswitch_4
    const-string v0, "static"

    goto :goto_0

    .line 2031
    :pswitch_5
    const-string v0, "cbs"

    goto :goto_0

    .line 2033
    :pswitch_6
    const-string v0, "mms"

    goto :goto_0

    .line 2011
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method

.method public getePDGLinkProp(I)Landroid/net/LinkProperties;
    .locals 7
    .param p1, "epdgtypeid"    # I

    .prologue
    const/4 v0, 0x0

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 2644
    packed-switch p1, :pswitch_data_0

    .line 2675
    :goto_0
    :pswitch_0
    return-object v0

    .line 2650
    :pswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->getInterfaceName()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    .line 2652
    :cond_0
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    aget-object v2, v0, v5

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v3, v0, v5

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    aget-object v4, v0, v5

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    aget-object v5, v0, v5

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    .line 2653
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mkae ims LinkProperties: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v1}, Landroid/net/LinkProperties;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2655
    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    goto :goto_0

    .line 2661
    :pswitch_2
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->getInterfaceName()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_3

    .line 2663
    :cond_2
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    aget-object v2, v0, v6

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v3, v0, v6

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    aget-object v4, v0, v6

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    aget-object v5, v0, v6

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    .line 2664
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "make cbs LinkProperties: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v1}, Landroid/net/LinkProperties;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2666
    :cond_3
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    goto/16 :goto_0

    .line 2644
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public getePDGPDNStatus(I)I
    .locals 2
    .param p1, "networktype"    # I

    .prologue
    const/4 v0, 0x2

    .line 2621
    sparse-switch p1, :sswitch_data_0

    .line 2636
    :goto_0
    return v0

    .line 2625
    :sswitch_0
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    goto :goto_0

    .line 2628
    :sswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v1, 0x1

    aget v0, v0, v1

    goto :goto_0

    .line 2630
    :sswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v1, v0

    goto :goto_0

    .line 2633
    :sswitch_3
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v1, 0x3

    aget v0, v0, v1

    goto :goto_0

    .line 2621
    :sswitch_data_0
    .sparse-switch
        0xb -> :sswitch_0
        0x13 -> :sswitch_1
        0x18 -> :sswitch_2
        0x19 -> :sswitch_3
    .end sparse-switch
.end method

.method public getePDGstatuswithfid(I)I
    .locals 2
    .param p1, "fid"    # I

    .prologue
    .line 2608
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v1, p1

    .line 2610
    .local v0, "mMyIMSstatus":I
    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 2612
    const/4 v0, 0x2

    .line 2615
    :cond_0
    return v0
.end method

.method public getfeatureID(Ljava/lang/String;)I
    .locals 1
    .param p1, "feature"    # Ljava/lang/String;

    .prologue
    .line 1975
    const-string v0, "ims"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1976
    const/4 v0, 0x0

    .line 1990
    :goto_0
    return v0

    .line 1977
    :cond_0
    const-string v0, "vzwapp"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1978
    const/4 v0, 0x1

    goto :goto_0

    .line 1979
    :cond_1
    const-string v0, "CF"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1980
    const/4 v0, 0x2

    goto :goto_0

    .line 1981
    :cond_2
    const-string v0, "Static"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1982
    const/4 v0, 0x3

    goto :goto_0

    .line 1983
    :cond_3
    const-string v0, "cbs"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1984
    const/4 v0, 0x6

    goto :goto_0

    .line 1985
    :cond_4
    const-string v0, "mms"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 1986
    const/4 v0, 0x7

    goto :goto_0

    .line 1987
    :cond_5
    const-string v0, "APPALL"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 1988
    const/16 v0, 0x3e6

    goto :goto_0

    .line 1990
    :cond_6
    const/16 v0, 0x3e7

    goto :goto_0
.end method

.method public getisMobileavail()Z
    .locals 1

    .prologue
    .line 1762
    iget-boolean v0, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    return v0
.end method

.method public handleConnect(Landroid/net/NetworkInfo;)V
    .locals 8
    .param p1, "info"    # Landroid/net/NetworkInfo;

    .prologue
    const/16 v7, 0xb

    const/4 v4, 0x1

    .line 2056
    iget v5, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v5, v4, :cond_1

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v5

    if-ne v5, v7, :cond_1

    .line 2059
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v5

    const/16 v6, 0xd

    if-ne v5, v6, :cond_2

    move v1, v4

    .line 2060
    .local v1, "newstatus":Z
    :goto_0
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-nez v5, :cond_0

    if-ne v1, v4, :cond_0

    .line 2062
    iput-boolean v1, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    .line 2063
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    .line 2066
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "is Handover possible= "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2070
    .end local v1    # "newstatus":Z
    :cond_1
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v5

    if-eq v5, v4, :cond_3

    .line 2142
    :goto_1
    return-void

    .line 2059
    :cond_2
    const/4 v1, 0x0

    goto :goto_0

    .line 2075
    :cond_3
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v5

    if-nez v5, :cond_4

    .line 2077
    const-string v4, "handle connected call but state is not connected"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2088
    :cond_4
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-ne v5, v4, :cond_5

    .line 2090
    const-string v4, "[ePDG] wifi is connected!!! - aleady check go out"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2095
    :cond_5
    const-string v5, "[ePDG] wifi is connected!!!"

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2098
    const-string v5, "net.loss"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 2099
    .local v3, "threshold":Ljava/lang/String;
    if-nez v3, :cond_6

    .line 2101
    const/16 v5, 0x63

    iput v5, p0, Lcom/android/server/ePDGTracker;->thre:I

    .line 2127
    :goto_2
    iget v5, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v5, v7, :cond_8

    .line 2129
    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->determineTMUSRSSI(Z)I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    .line 2130
    iget v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    invoke-virtual {p0, v4, v5}, Lcom/android/server/ePDGTracker;->setTWiFistatus(ZI)V

    goto :goto_1

    .line 2103
    :cond_6
    iget v5, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v5, v7, :cond_7

    .line 2105
    const/4 v2, 0x1

    .line 2108
    .local v2, "sysvalue":I
    :try_start_0
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 2112
    :goto_3
    mul-int/lit8 v5, v2, -0x1

    iput v5, p0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

    .line 2114
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[ePDG] get TMUS handout threshold "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "chvalue"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_2

    .line 2109
    :catch_0
    move-exception v0

    .line 2110
    .local v0, "e":Ljava/lang/Exception;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "threshold exception "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_3

    .line 2120
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v2    # "sysvalue":I
    :cond_7
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[ePDG] get packet loss threshold "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2122
    :try_start_1
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->thre:I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    .line 2123
    :catch_1
    move-exception v0

    .line 2124
    .restart local v0    # "e":Ljava/lang/Exception;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "threshold exception "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 2135
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_8
    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->startmonitoring(Z)Z

    move-result v5

    iput-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    .line 2137
    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->setWIFIstatus(Z)V

    goto/16 :goto_1
.end method

.method public handleDisconnect(Landroid/net/NetworkInfo;)V
    .locals 6
    .param p1, "info"    # Landroid/net/NetworkInfo;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 2424
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v2, :cond_0

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v4

    const/16 v5, 0xb

    if-ne v4, v5, :cond_0

    .line 2426
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v4

    const/16 v5, 0xd

    if-ne v4, v5, :cond_1

    move v1, v2

    .line 2427
    .local v1, "newstatus":Z
    :goto_0
    iput-boolean v1, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    .line 2429
    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 2430
    .local v0, "imsdc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_0

    .line 2432
    const-string v4, "we lost IMS PDN so will set lost "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2433
    invoke-virtual {v0, v3}, Lcom/android/server/ePDGConnection;->ePDGHandOverStatus(I)V

    .line 2438
    .end local v0    # "imsdc":Lcom/android/server/ePDGConnection;
    .end local v1    # "newstatus":Z
    :cond_0
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v4

    if-eq v4, v2, :cond_2

    .line 2460
    :goto_1
    return-void

    :cond_1
    move v1, v3

    .line 2426
    goto :goto_0

    .line 2441
    :cond_2
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 2443
    const-string v2, "handle Disconnected call but state is connected!!"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2447
    :cond_3
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-nez v4, :cond_4

    .line 2449
    const-string v2, "[ePDG] wifi is Disconnected!!! - aleady check go out"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2454
    :cond_4
    const-string v4, "[ePDG] wifi is Disconnected!!!"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2457
    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    .line 2458
    invoke-virtual {p0, v3}, Lcom/android/server/ePDGTracker;->setWIFIstatus(Z)V

    .line 2459
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->stopmonitoring()V

    goto :goto_1
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 7
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v6, 0xb

    const/4 v5, 0x0

    .line 478
    iget v4, p1, Landroid/os/Message;->what:I

    sparse-switch v4, :sswitch_data_0

    .line 557
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "unhandled msg: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->what:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 561
    :cond_0
    :goto_0
    return-void

    .line 499
    :sswitch_0
    const-string v4, "we start temp code!!! "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 500
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->temptestcode()V

    goto :goto_0

    .line 504
    :sswitch_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "we get rsp!! rsp type : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->what:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 505
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 506
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v3, Lcom/android/server/ePDGConnInfo;

    .line 507
    .local v3, "sendingResult":Lcom/android/server/ePDGConnInfo;
    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->onConnectionRsp(Lcom/android/server/ePDGConnInfo;)V

    goto :goto_0

    .line 511
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v3    # "sendingResult":Lcom/android/server/ePDGConnInfo;
    :sswitch_2
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-eqz v4, :cond_0

    .line 514
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v6, :cond_1

    .line 516
    invoke-virtual {p0, v5}, Lcom/android/server/ePDGTracker;->determineTMUSRSSI(Z)I

    move-result v2

    .line 517
    .local v2, "currentstat":I
    iget v4, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    if-eq v4, v2, :cond_0

    .line 519
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[ePDG] sig status changed!! currend = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " OLD="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 520
    iput v2, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    .line 521
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    invoke-virtual {p0, v4, v5}, Lcom/android/server/ePDGTracker;->setTWiFistatus(ZI)V

    goto :goto_0

    .line 527
    .end local v2    # "currentstat":I
    :cond_1
    invoke-virtual {p0, v5}, Lcom/android/server/ePDGTracker;->startmonitoring(Z)Z

    move-result v1

    .line 528
    .local v1, "currenloss":Z
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    if-eq v4, v1, :cond_0

    .line 530
    iput-boolean v1, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    .line 531
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->setWIFIstatus(Z)V

    goto :goto_0

    .line 538
    .end local v1    # "currenloss":Z
    :sswitch_3
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "delayed rsp "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 539
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v5, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_0

    .line 544
    :sswitch_4
    const-string v4, "EVENT_SERVICE_CHANGE "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 545
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->onServiceStateChange()V

    goto/16 :goto_0

    .line 549
    :sswitch_5
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v6, :cond_0

    .line 551
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_CALLSTATE_CH : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/server/ePDGTracker;->mcallstate:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 552
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->onCallStateChange(I)V

    goto/16 :goto_0

    .line 478
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0x4 -> :sswitch_3
        0x5 -> :sswitch_4
        0x6 -> :sswitch_5
        0x309 -> :sswitch_0
    .end sparse-switch
.end method

.method handleWFCPreferChange(Z)V
    .locals 5
    .param p1, "change"    # Z

    .prologue
    .line 620
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "PREFERRED_OPTION"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Lcom/movial/ipphone/IPPhoneSettings;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    .line 622
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleWFCPreferChange : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 633
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 634
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGConnection;->setWFCPreferChange(I)V

    goto :goto_0

    .line 637
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_0
    return-void
.end method

.method handleWFCSettingChange(Z)V
    .locals 6
    .param p1, "change"    # Z

    .prologue
    const/4 v5, 0x1

    .line 643
    const/4 v2, 0x1

    .line 645
    .local v2, "isCellonly":Z
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "CELL_ONLY"

    invoke-static {v3, v4, v5}, Lcom/movial/ipphone/IPPhoneSettings;->getBoolean(Landroid/content/ContentResolver;Ljava/lang/String;Z)Z

    move-result v2

    .line 648
    if-eqz v2, :cond_0

    .line 649
    const/4 v3, 0x0

    iput v3, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    .line 653
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleWFCSettingChange : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 657
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 658
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget v3, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    invoke-virtual {v0, v3}, Lcom/android/server/ePDGConnection;->setWFCsettingChange(I)V

    goto :goto_1

    .line 651
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_0
    iput v5, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    goto :goto_0

    .line 668
    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_1
    return-void
.end method

.method public isAnyConnecting()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    .line 1376
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/4 v3, 0x2

    if-ge v0, v3, :cond_2

    .line 1378
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v3, v0

    .line 1380
    .local v1, "status":I
    if-eq v1, v2, :cond_0

    const/4 v3, 0x4

    if-ne v1, v3, :cond_1

    .line 1386
    .end local v1    # "status":I
    :cond_0
    :goto_1
    return v2

    .line 1376
    .restart local v1    # "status":I
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1386
    .end local v1    # "status":I
    :cond_2
    const/4 v2, 0x0

    goto :goto_1
.end method

.method public isConnection(I)Z
    .locals 3
    .param p1, "id"    # I

    .prologue
    const/4 v0, 0x1

    .line 3277
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, p1

    if-eq v1, v0, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, p1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, p1

    const/4 v2, 0x5

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, p1

    const/4 v2, 0x6

    if-ne v1, v2, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isConnection(Ljava/lang/String;)Z
    .locals 2
    .param p1, "feature"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 3267
    const-string v1, "ims"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 3268
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->isConnection(I)Z

    move-result v0

    .line 3272
    :cond_0
    :goto_0
    return v0

    .line 3269
    :cond_1
    const-string v1, "vzwapp"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 3270
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->isConnection(I)Z

    move-result v0

    goto :goto_0
.end method

.method public isControlType(ILjava/lang/String;)Z
    .locals 6
    .param p1, "version"    # I
    .param p2, "type"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 2915
    const/16 v5, 0x3e4

    if-ne p1, v5, :cond_2

    .line 2917
    invoke-virtual {p0, p2}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v0

    .line 2918
    .local v0, "fid":I
    const/4 v5, 0x6

    if-eq v0, v5, :cond_0

    const/4 v5, 0x7

    if-ne v0, v5, :cond_1

    .line 2920
    :cond_0
    const/4 v0, 0x1

    .line 2922
    :cond_1
    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v2

    .line 2929
    .end local v0    # "fid":I
    .local v2, "mycon":Lcom/android/server/ePDGConnection;
    :goto_0
    packed-switch p1, :pswitch_data_0

    move v3, v4

    .line 2982
    :goto_1
    return v3

    .line 2926
    .end local v2    # "mycon":Lcom/android/server/ePDGConnection;
    :cond_2
    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v2

    .restart local v2    # "mycon":Lcom/android/server/ePDGConnection;
    goto :goto_0

    .line 2932
    :pswitch_0
    if-eqz v2, :cond_3

    .line 2934
    invoke-virtual {v2, p2}, Lcom/android/server/ePDGConnection;->setQosInfo(Ljava/lang/String;)Z

    goto :goto_1

    .line 2938
    :cond_3
    const-string v4, "[ePDG] get qos but no ims dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2944
    :pswitch_1
    if-eqz v2, :cond_4

    .line 2946
    invoke-virtual {p0, v2}, Lcom/android/server/ePDGTracker;->requestpcscfaddr(Lcom/android/server/ePDGConnection;)V

    goto :goto_1

    .line 2951
    :cond_4
    const-string v4, "[ePDG] get pcs_ch but no ims dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2957
    :pswitch_2
    if-eqz v2, :cond_5

    .line 2959
    invoke-virtual {v2, p2}, Lcom/android/server/ePDGConnection;->setPCSInfo(Ljava/lang/String;)Z

    goto :goto_1

    .line 2963
    :cond_5
    const-string v4, "[ePDG] get qos but no ims dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2969
    :pswitch_3
    if-eqz v2, :cond_6

    .line 2971
    const-string v5, "[ePDG] DISCONNECTED_DONE "

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2972
    const v5, 0x40006

    invoke-virtual {v2, v5, v4}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v1

    .line 2973
    .local v1, "msg":Landroid/os/Message;
    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    goto :goto_1

    .line 2977
    .end local v1    # "msg":Landroid/os/Message;
    :cond_6
    const-string v4, "[ePDG] get DISCONNECTED_DONE no dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 2929
    nop

    :pswitch_data_0
    .packed-switch 0x3e4
        :pswitch_3
        :pswitch_1
        :pswitch_2
        :pswitch_0
    .end packed-switch
.end method

.method public isHandoverPossible(I)Z
    .locals 2
    .param p1, "fid"    # I

    .prologue
    const/4 v0, 0x1

    .line 1392
    if-eqz p1, :cond_1

    .line 1398
    :cond_0
    :goto_0
    return v0

    .line 1395
    :cond_1
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-nez v1, :cond_0

    .line 1398
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isInitialAttachtype(I)Z
    .locals 4
    .param p1, "fid"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 1405
    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_1

    .line 1413
    :cond_0
    :goto_0
    return v0

    .line 1408
    :cond_1
    if-ne p1, v1, :cond_0

    move v0, v1

    .line 1410
    goto :goto_0
.end method

.method public isIpv4Connected()Z
    .locals 6

    .prologue
    .line 2877
    const/4 v4, 0x0

    .line 2878
    .local v4, "ret":Z
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v5}, Landroid/net/LinkProperties;->getAddresses()Ljava/util/List;

    move-result-object v1

    .line 2880
    .local v1, "addresses":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/net/InetAddress;>;"
    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/net/InetAddress;

    .line 2881
    .local v0, "addr":Ljava/net/InetAddress;
    instance-of v5, v0, Ljava/net/Inet4Address;

    if-eqz v5, :cond_0

    move-object v3, v0

    .line 2882
    check-cast v3, Ljava/net/Inet4Address;

    .line 2883
    .local v3, "i4addr":Ljava/net/Inet4Address;
    invoke-virtual {v3}, Ljava/net/Inet4Address;->isAnyLocalAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet4Address;->isLinkLocalAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet4Address;->isLoopbackAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet4Address;->isMulticastAddress()Z

    move-result v5

    if-nez v5, :cond_0

    .line 2885
    const/4 v4, 0x1

    .line 2890
    .end local v0    # "addr":Ljava/net/InetAddress;
    .end local v3    # "i4addr":Ljava/net/Inet4Address;
    :cond_1
    return v4
.end method

.method public isIpv6Connected()Z
    .locals 6

    .prologue
    .line 2894
    const/4 v4, 0x0

    .line 2895
    .local v4, "ret":Z
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v5}, Landroid/net/LinkProperties;->getAddresses()Ljava/util/List;

    move-result-object v1

    .line 2897
    .local v1, "addresses":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/net/InetAddress;>;"
    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/net/InetAddress;

    .line 2898
    .local v0, "addr":Ljava/net/InetAddress;
    instance-of v5, v0, Ljava/net/Inet6Address;

    if-eqz v5, :cond_0

    move-object v3, v0

    .line 2899
    check-cast v3, Ljava/net/Inet6Address;

    .line 2900
    .local v3, "i6addr":Ljava/net/Inet6Address;
    invoke-virtual {v3}, Ljava/net/Inet6Address;->isAnyLocalAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet6Address;->isLinkLocalAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet6Address;->isLoopbackAddress()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v3}, Ljava/net/Inet6Address;->isMulticastAddress()Z

    move-result v5

    if-nez v5, :cond_0

    .line 2902
    const/4 v4, 0x1

    .line 2907
    .end local v0    # "addr":Ljava/net/InetAddress;
    .end local v3    # "i6addr":Ljava/net/Inet6Address;
    :cond_1
    return v4
.end method

.method public isUsingOnlyWifi(I)Z
    .locals 2
    .param p1, "fid"    # I

    .prologue
    .line 1493
    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    if-nez p1, :cond_0

    .line 1495
    const/4 v0, 0x0

    .line 1499
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public issameaddr(ILjava/lang/String;)Z
    .locals 3
    .param p1, "mid"    # I
    .param p2, "newaddr"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 2841
    const/4 v2, 0x4

    if-le p1, v2, :cond_1

    .line 2853
    :cond_0
    :goto_0
    return v0

    .line 2844
    :cond_1
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v2, v2, p1

    if-nez v2, :cond_2

    .line 2846
    const-string v0, "dc is connected but addr is not set, so just think it is same addr"

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    move v0, v1

    .line 2847
    goto :goto_0

    .line 2850
    :cond_2
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v2, v2, p1

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

    .line 2851
    goto :goto_0
.end method

.method public notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .locals 17
    .param p1, "version"    # I
    .param p2, "status"    # I
    .param p3, "cid"    # I
    .param p4, "active"    # I
    .param p5, "type"    # Ljava/lang/String;
    .param p6, "ifname"    # Ljava/lang/String;
    .param p7, "addresses"    # Ljava/lang/String;
    .param p8, "dnses"    # Ljava/lang/String;
    .param p9, "gateways"    # Ljava/lang/String;
    .param p10, "suggestedRetryTime"    # I
    .param p11, "apntype"    # Ljava/lang/String;

    .prologue
    .line 3036
    move-object/from16 v0, p0

    move/from16 v1, p1

    move-object/from16 v2, p5

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGTracker;->isControlType(ILjava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 3146
    :goto_0
    return-void

    .line 3041
    :cond_0
    const-string v4, "[ePDG] notifyEPDGCallResult start "

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3044
    const/16 v16, 0x0

    .line 3045
    .local v16, "pdnNum":I
    const/4 v14, 0x0

    .line 3046
    .local v14, "msg":Landroid/os/Message;
    new-instance v3, Lcom/android/server/ePDGConnInfo;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-direct/range {v3 .. v12}, Lcom/android/server/ePDGConnInfo;-><init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 3048
    .local v3, "sendingResult":Lcom/android/server/ePDGConnInfo;
    const/4 v13, 0x0

    .line 3050
    .local v13, "dc":Lcom/android/server/ePDGConnection;
    const/4 v5, 0x0

    .line 3053
    .local v5, "mid":I
    if-nez p11, :cond_6

    .line 3055
    move-object/from16 v0, p0

    move/from16 v1, p3

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->findePDGConnectionbyCid(I)Lcom/android/server/ePDGConnection;

    move-result-object v13

    .line 3056
    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v5

    .line 3059
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/android/server/ePDGTracker;->getLinkpro(I)Landroid/net/LinkProperties;

    move-result-object v15

    .line 3062
    .local v15, "oldlink":Landroid/net/LinkProperties;
    if-nez v13, :cond_1

    .line 3064
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "no dc has this cid "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, p3

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 3068
    :cond_1
    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->isConnected()Z

    move-result v4

    if-nez v4, :cond_2

    .line 3070
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "not connected "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 3075
    :cond_2
    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v4

    move-object/from16 v0, p0

    move-object/from16 v1, p7

    invoke-virtual {v0, v4, v1}, Lcom/android/server/ePDGTracker;->issameaddr(ILjava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 3077
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "same addr so return mid="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " addr :  "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p7

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 3083
    :cond_3
    invoke-virtual {v15}, Landroid/net/LinkProperties;->hasIPv4Address()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-virtual {v15}, Landroid/net/LinkProperties;->hasGlobalIPv6Address()Z

    move-result v4

    if-nez v4, :cond_5

    move-object/from16 v4, p0

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p9

    move-object/from16 v9, p8

    .line 3085
    invoke-virtual/range {v4 .. v9}, Lcom/android/server/ePDGTracker;->setLinkp(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 3088
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/android/server/ePDGTracker;->getLinkpro(I)Landroid/net/LinkProperties;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/LinkProperties;->hasGlobalIPv6Address()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 3090
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "connected & update ipv6 addr= "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3091
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v6

    invoke-virtual {v4, v6}, Lcom/android/server/ePDGNotifier;->notifyADDRChange(I)V

    goto/16 :goto_0

    .line 3095
    :cond_4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "connected & ipv4 addr change, mid= "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " addr"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p7

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3096
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v13}, Lcom/android/server/ePDGTracker;->resetCurrentConnection(ILcom/android/server/ePDGConnection;)Z

    goto/16 :goto_0

    .line 3103
    :cond_5
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v13}, Lcom/android/server/ePDGTracker;->resetCurrentConnection(ILcom/android/server/ePDGConnection;)Z

    goto/16 :goto_0

    .line 3111
    .end local v15    # "oldlink":Landroid/net/LinkProperties;
    :cond_6
    move-object/from16 v0, p0

    move-object/from16 v1, p11

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v16

    .line 3113
    const/4 v4, 0x6

    move/from16 v0, v16

    if-eq v0, v4, :cond_7

    const/4 v4, 0x7

    move/from16 v0, v16

    if-ne v0, v4, :cond_8

    .line 3115
    :cond_7
    const/16 v16, 0x1

    .line 3118
    :cond_8
    move-object/from16 v0, p0

    move/from16 v1, v16

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v13

    .line 3120
    if-nez v13, :cond_9

    .line 3121
    const-string v4, "[ePDG] Error. notifyEPDGCallResult : ePDGConnection is null "

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 3124
    :cond_9
    move-object/from16 v0, p7

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    .line 3125
    move-object/from16 v0, p6

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    .line 3126
    move-object/from16 v0, p9

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    .line 3127
    move-object/from16 v0, p8

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    .line 3129
    if-eqz p2, :cond_a

    .line 3131
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[ePDG] notifyEPDGCallResult status error: "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, p2

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3132
    const v4, 0x40006

    move/from16 v0, p2

    invoke-virtual {v13, v4, v0}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v14

    .line 3135
    invoke-virtual {v14}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    .line 3139
    :cond_a
    move/from16 v0, p3

    iput v0, v13, Lcom/android/server/ePDGConnection;->cid:I

    .line 3140
    const v4, 0x40005

    invoke-virtual {v13, v4}, Lcom/android/server/ePDGConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    .line 3141
    const/4 v4, 0x0

    invoke-static {v14, v3, v4}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    .line 3142
    invoke-virtual {v14}, Landroid/os/Message;->sendToTarget()V

    .line 3143
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[ePDG] notifyEPDGCallResult send success => type = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p5

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ] ,ifname = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p6

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ] ,addresses = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p7

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ] ,dnses = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p8

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ] ,gateways = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p9

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ] ,suggestedRetryTime = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, p10

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ] ,apntype = [ "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p11

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ]"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method public notifyEPDGPDNStatus(IIILjava/lang/String;)V
    .locals 5
    .param p1, "status"    # I
    .param p2, "cid"    # I
    .param p3, "active"    # I
    .param p4, "newaddr"    # Ljava/lang/String;

    .prologue
    .line 3150
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[ePDG] notifyEPDGPDNStatus receive: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " new addr "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3152
    const/4 v2, 0x0

    .line 3153
    .local v2, "pdnNum":I
    const/4 v1, 0x0

    .line 3159
    .local v1, "msg":Landroid/os/Message;
    invoke-direct {p0, p2}, Lcom/android/server/ePDGTracker;->findePDGConnectionbyCid(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 3161
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_1

    .line 3196
    :cond_0
    :goto_0
    return-void

    .line 3164
    :cond_1
    if-nez p3, :cond_0

    .line 3166
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "we lost PDN!! cid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ,"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, v0, Lcom/android/server/ePDGConnection;->mFid:I

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->fidtoString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 3167
    const v3, 0x40006

    const/16 v4, 0x1392

    invoke-virtual {v0, v3, v4}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v1

    .line 3170
    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method onCallStateChange(I)V
    .locals 3
    .param p1, "callstate"    # I

    .prologue
    .line 604
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "call state change : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 606
    iput p1, p0, Lcom/android/server/ePDGTracker;->call_status:I

    .line 608
    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 610
    .local v0, "imsdc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_0

    .line 612
    invoke-virtual {v0, p1}, Lcom/android/server/ePDGConnection;->setCallStatus(I)V

    .line 615
    :cond_0
    return-void
.end method

.method onServiceStateChange()V
    .locals 7

    .prologue
    const/4 v4, 0x1

    .line 565
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    if-nez v5, :cond_1

    .line 599
    :cond_0
    return-void

    .line 568
    :cond_1
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->DataState:I

    .line 569
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    .line 573
    iget v5, p0, Lcom/android/server/ePDGTracker;->DataState:I

    if-nez v5, :cond_3

    iget v5, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    const/16 v6, 0xe

    if-ne v5, v6, :cond_3

    move v3, v4

    .line 575
    .local v3, "newmobile_avail":Z
    :goto_0
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    if-eq v5, v3, :cond_4

    .line 577
    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    .line 579
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mobile Network is changed, now!!  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 581
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    const/4 v5, 0x2

    if-ge v1, v5, :cond_4

    .line 583
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v5, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    .line 585
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aget-boolean v5, v5, v1

    if-ne v5, v4, :cond_2

    .line 587
    invoke-virtual {p0, v1}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    .line 581
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 573
    .end local v1    # "i":I
    .end local v3    # "newmobile_avail":Z
    :cond_3
    const/4 v3, 0x0

    goto :goto_0

    .line 594
    .restart local v3    # "newmobile_avail":Z
    :cond_4
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_5
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 595
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_5

    .line 596
    iget v4, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v5, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual {v0, v4, v5}, Lcom/android/server/ePDGConnection;->setNetworkstate(II)V

    goto :goto_2
.end method

.method public requestpcscfaddr(Lcom/android/server/ePDGConnection;)V
    .locals 2
    .param p1, "mycon"    # Lcom/android/server/ePDGConnection;

    .prologue
    .line 2992
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv4Connected()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv6Connected()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 2994
    const-string v0, "IPV4V6"

    .line 3011
    .local v0, "ipvtype":Ljava/lang/String;
    :goto_0
    invoke-virtual {p1, v0}, Lcom/android/server/ePDGConnection;->pcsch(Ljava/lang/String;)Z

    .line 3012
    return-void

    .line 2997
    .end local v0    # "ipvtype":Ljava/lang/String;
    :cond_0
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv4Connected()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2999
    const-string v0, "IP"

    .restart local v0    # "ipvtype":Ljava/lang/String;
    goto :goto_0

    .line 3001
    .end local v0    # "ipvtype":Ljava/lang/String;
    :cond_1
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv6Connected()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 3003
    const-string v0, "IPV6"

    .restart local v0    # "ipvtype":Ljava/lang/String;
    goto :goto_0

    .line 3007
    .end local v0    # "ipvtype":Ljava/lang/String;
    :cond_2
    const-string v0, "IPV6"

    .line 3009
    .restart local v0    # "ipvtype":Ljava/lang/String;
    const-string v1, "maybe not connected yet, so just set ipv6 for default"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public resetCB(I)V
    .locals 4
    .param p1, "mid"    # I

    .prologue
    .line 1111
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 1112
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_0

    .line 1114
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .line 1115
    .local v1, "msg_connect":Landroid/os/Message;
    const/4 v3, 0x1

    iput v3, v1, Landroid/os/Message;->what:I

    .line 1116
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v2

    .line 1117
    .local v2, "msg_lost":Landroid/os/Message;
    const/4 v3, 0x2

    iput v3, v2, Landroid/os/Message;->what:I

    .line 1118
    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->resetCBLooper(Landroid/os/Message;Landroid/os/Message;)V

    .line 1120
    .end local v1    # "msg_connect":Landroid/os/Message;
    .end local v2    # "msg_lost":Landroid/os/Message;
    :cond_0
    return-void
.end method

.method public resetCurrentConnection(ILcom/android/server/ePDGConnection;)Z
    .locals 4
    .param p1, "fid"    # I
    .param p2, "dc"    # Lcom/android/server/ePDGConnection;

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 1351
    const-string v3, "resetCurrentConnection called!! "

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1352
    if-nez p2, :cond_0

    .line 1354
    const-string v2, "something wrong!! no dc but status is connected?? "

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 1368
    :goto_0
    return v1

    .line 1358
    :cond_0
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .line 1359
    .local v0, "msg":Landroid/os/Message;
    iput v2, v0, Landroid/os/Message;->what:I

    .line 1360
    invoke-virtual {p2, v0}, Lcom/android/server/ePDGConnection;->ePDGteardown(Landroid/os/Message;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 1362
    const-string v2, "something wrong!! SM and status is mismatched?? anyway return inactive"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1367
    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v3, 0x4

    aput v3, v1, p1

    move v1, v2

    .line 1368
    goto :goto_0
.end method

.method public setEPDGAddrByTestApp(ZLjava/lang/String;)V
    .locals 0
    .param p1, "enable"    # Z
    .param p2, "ePDGAddr"    # Ljava/lang/String;

    .prologue
    .line 2474
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    .line 2475
    iput-object p2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    .line 2476
    return-void
.end method

.method public setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 17
    .param p1, "linkProperties"    # Landroid/net/LinkProperties;
    .param p2, "ifname"    # Ljava/lang/String;
    .param p3, "addrlist"    # Ljava/lang/String;
    .param p4, "gatewaylist"    # Ljava/lang/String;
    .param p5, "dnsslist"    # Ljava/lang/String;

    .prologue
    .line 2684
    const/4 v3, 0x0

    .line 2685
    .local v3, "addresses":[Ljava/lang/String;
    const/4 v6, 0x0

    .line 2686
    .local v6, "dnses":[Ljava/lang/String;
    const/4 v8, 0x0

    .line 2691
    .local v8, "gateways":[Ljava/lang/String;
    if-nez p1, :cond_2

    .line 2692
    new-instance p1, Landroid/net/LinkProperties;

    .end local p1    # "linkProperties":Landroid/net/LinkProperties;
    invoke-direct/range {p1 .. p1}, Landroid/net/LinkProperties;-><init>()V

    .line 2698
    .restart local p1    # "linkProperties":Landroid/net/LinkProperties;
    :goto_0
    :try_start_0
    invoke-virtual/range {p1 .. p2}, Landroid/net/LinkProperties;->setInterfaceName(Ljava/lang/String;)V

    .line 2700
    if-eqz p3, :cond_0

    .line 2702
    const-string v14, ","

    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 2705
    :cond_0
    if-eqz v3, :cond_8

    array-length v14, v3

    if-lez v14, :cond_8

    .line 2706
    move-object v5, v3

    .local v5, "arr$":[Ljava/lang/String;
    array-length v12, v5

    .local v12, "len$":I
    const/4 v9, 0x0

    .local v9, "i$":I
    :goto_1
    if-ge v9, v12, :cond_9

    aget-object v1, v5, v9

    .line 2707
    .local v1, "addr":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 2708
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v14

    if-eqz v14, :cond_3

    .line 2706
    :cond_1
    :goto_2
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 2694
    .end local v1    # "addr":Ljava/lang/String;
    .end local v5    # "arr$":[Ljava/lang/String;
    .end local v9    # "i$":I
    .end local v12    # "len$":I
    :cond_2
    invoke-virtual/range {p1 .. p1}, Landroid/net/LinkProperties;->clear()V

    goto :goto_0

    .line 2712
    .restart local v1    # "addr":Ljava/lang/String;
    .restart local v5    # "arr$":[Ljava/lang/String;
    .restart local v9    # "i$":I
    .restart local v12    # "len$":I
    :cond_3
    :try_start_1
    const-string v14, "/"

    invoke-virtual {v1, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 2713
    .local v4, "ap":[Ljava/lang/String;
    array-length v14, v4

    const/4 v15, 0x2

    if-ne v14, v15, :cond_6

    .line 2714
    const/4 v14, 0x0

    aget-object v1, v4, v14

    .line 2715
    const/4 v14, 0x1

    aget-object v14, v4, v14

    invoke-static {v14}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_0

    move-result v2

    .line 2721
    .local v2, "addrPrefixLen":I
    :goto_3
    :try_start_2
    invoke-static {v1}, Landroid/net/NetworkUtils;->numericToInetAddress(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_0

    move-result-object v10

    .line 2725
    .local v10, "ia":Ljava/net/InetAddress;
    :try_start_3
    invoke-virtual {v10}, Ljava/net/InetAddress;->isAnyLocalAddress()Z

    move-result v14

    if-nez v14, :cond_1

    .line 2726
    if-nez v2, :cond_4

    .line 2728
    instance-of v14, v10, Ljava/net/Inet4Address;

    if-eqz v14, :cond_7

    const/16 v2, 0x20

    .line 2730
    :cond_4
    :goto_4
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "addr/pl="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "/"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2731
    new-instance v11, Landroid/net/LinkAddress;

    invoke-direct {v11, v10, v2}, Landroid/net/LinkAddress;-><init>(Ljava/net/InetAddress;I)V

    .line 2732
    .local v11, "la":Landroid/net/LinkAddress;
    move-object/from16 v0, p1

    invoke-virtual {v0, v11}, Landroid/net/LinkProperties;->addLinkAddress(Landroid/net/LinkAddress;)Z
    :try_end_3
    .catch Ljava/net/UnknownHostException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

    .line 2795
    .end local v1    # "addr":Ljava/lang/String;
    .end local v2    # "addrPrefixLen":I
    .end local v4    # "ap":[Ljava/lang/String;
    .end local v5    # "arr$":[Ljava/lang/String;
    .end local v9    # "i$":I
    .end local v10    # "ia":Ljava/net/InetAddress;
    .end local v11    # "la":Landroid/net/LinkAddress;
    .end local v12    # "len$":I
    :catch_0
    move-exception v7

    .line 2796
    .local v7, "e":Ljava/net/UnknownHostException;
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "setLinkProperties: UnknownHostException "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2797
    const/4 v13, 0x0

    .line 2802
    .end local v7    # "e":Ljava/net/UnknownHostException;
    .local v13, "result":Z
    :goto_5
    if-nez v13, :cond_5

    .line 2806
    invoke-virtual/range {p1 .. p1}, Landroid/net/LinkProperties;->clear()V

    .line 2809
    :cond_5
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "setLinkProperties: result="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2811
    return v13

    .line 2717
    .end local v13    # "result":Z
    .restart local v1    # "addr":Ljava/lang/String;
    .restart local v4    # "ap":[Ljava/lang/String;
    .restart local v5    # "arr$":[Ljava/lang/String;
    .restart local v9    # "i$":I
    .restart local v12    # "len$":I
    :cond_6
    const/4 v2, 0x0

    .restart local v2    # "addrPrefixLen":I
    goto :goto_3

    .line 2722
    :catch_1
    move-exception v7

    .line 2723
    .local v7, "e":Ljava/lang/IllegalArgumentException;
    :try_start_4
    new-instance v14, Ljava/net/UnknownHostException;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "Non-numeric ip addr="

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Ljava/net/UnknownHostException;-><init>(Ljava/lang/String;)V

    throw v14

    .line 2728
    .end local v7    # "e":Ljava/lang/IllegalArgumentException;
    .restart local v10    # "ia":Ljava/net/InetAddress;
    :cond_7
    const/16 v2, 0x80

    goto/16 :goto_4

    .line 2736
    .end local v1    # "addr":Ljava/lang/String;
    .end local v2    # "addrPrefixLen":I
    .end local v4    # "ap":[Ljava/lang/String;
    .end local v5    # "arr$":[Ljava/lang/String;
    .end local v9    # "i$":I
    .end local v10    # "ia":Ljava/net/InetAddress;
    .end local v12    # "len$":I
    :cond_8
    new-instance v14, Ljava/net/UnknownHostException;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "no address for ifname="

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p2

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Ljava/net/UnknownHostException;-><init>(Ljava/lang/String;)V

    throw v14

    .line 2740
    .restart local v5    # "arr$":[Ljava/lang/String;
    .restart local v9    # "i$":I
    .restart local v12    # "len$":I
    :cond_9
    if-eqz p5, :cond_a

    .line 2742
    const-string v14, ","

    move-object/from16 v0, p5

    invoke-virtual {v0, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    .line 2746
    :cond_a
    if-eqz v6, :cond_e

    array-length v14, v6

    if-lez v14, :cond_e

    .line 2747
    move-object v5, v6

    array-length v12, v5

    const/4 v9, 0x0

    :goto_6
    if-ge v9, v12, :cond_e

    aget-object v1, v5, v9

    .line 2748
    .restart local v1    # "addr":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 2749
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    :try_end_4
    .catch Ljava/net/UnknownHostException; {:try_start_4 .. :try_end_4} :catch_0

    move-result v14

    if-eqz v14, :cond_c

    .line 2747
    :cond_b
    :goto_7
    add-int/lit8 v9, v9, 0x1

    goto :goto_6

    .line 2752
    :cond_c
    :try_start_5
    invoke-static {v1}, Landroid/net/NetworkUtils;->numericToInetAddress(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_5
    .catch Ljava/lang/IllegalArgumentException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_0

    move-result-object v10

    .line 2756
    .restart local v10    # "ia":Ljava/net/InetAddress;
    if-nez v10, :cond_d

    .line 2758
    :try_start_6
    const-string v14, "null!!"

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_7

    .line 2753
    .end local v10    # "ia":Ljava/net/InetAddress;
    :catch_2
    move-exception v7

    .line 2754
    .restart local v7    # "e":Ljava/lang/IllegalArgumentException;
    new-instance v14, Ljava/net/UnknownHostException;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "Non-numeric dns addr="

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Ljava/net/UnknownHostException;-><init>(Ljava/lang/String;)V

    throw v14

    .line 2762
    .end local v7    # "e":Ljava/lang/IllegalArgumentException;
    .restart local v10    # "ia":Ljava/net/InetAddress;
    :cond_d
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "not null!! "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2763
    invoke-virtual {v10}, Ljava/net/InetAddress;->isAnyLocalAddress()Z

    move-result v14

    if-nez v14, :cond_b

    .line 2764
    move-object/from16 v0, p1

    invoke-virtual {v0, v10}, Landroid/net/LinkProperties;->addDnsServer(Ljava/net/InetAddress;)Z

    goto :goto_7

    .line 2770
    .end local v1    # "addr":Ljava/lang/String;
    .end local v10    # "ia":Ljava/net/InetAddress;
    :cond_e
    if-eqz p4, :cond_f

    .line 2772
    const-string v14, ","

    move-object/from16 v0, p4

    invoke-virtual {v0, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v8

    .line 2776
    :cond_f
    if-eqz v8, :cond_10

    array-length v14, v8

    if-nez v14, :cond_11

    .line 2777
    :cond_10
    const/4 v14, 0x0

    new-array v8, v14, [Ljava/lang/String;

    .line 2780
    :cond_11
    move-object v5, v8

    array-length v12, v5

    const/4 v9, 0x0

    :goto_8
    if-ge v9, v12, :cond_13

    aget-object v1, v5, v9

    .line 2781
    .restart local v1    # "addr":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 2782
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    :try_end_6
    .catch Ljava/net/UnknownHostException; {:try_start_6 .. :try_end_6} :catch_0

    move-result v14

    if-eqz v14, :cond_12

    .line 2780
    :goto_9
    add-int/lit8 v9, v9, 0x1

    goto :goto_8

    .line 2785
    :cond_12
    :try_start_7
    invoke-static {v1}, Landroid/net/NetworkUtils;->numericToInetAddress(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_7
    .catch Ljava/lang/IllegalArgumentException; {:try_start_7 .. :try_end_7} :catch_3
    .catch Ljava/net/UnknownHostException; {:try_start_7 .. :try_end_7} :catch_0

    move-result-object v10

    .line 2790
    .restart local v10    # "ia":Ljava/net/InetAddress;
    :try_start_8
    new-instance v14, Landroid/net/RouteInfo;

    invoke-direct {v14, v10}, Landroid/net/RouteInfo;-><init>(Ljava/net/InetAddress;)V

    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Landroid/net/LinkProperties;->addRoute(Landroid/net/RouteInfo;)Z

    goto :goto_9

    .line 2786
    .end local v10    # "ia":Ljava/net/InetAddress;
    :catch_3
    move-exception v7

    .line 2787
    .restart local v7    # "e":Ljava/lang/IllegalArgumentException;
    new-instance v14, Ljava/net/UnknownHostException;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "Non-numeric gateway addr="

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Ljava/net/UnknownHostException;-><init>(Ljava/lang/String;)V

    throw v14
    :try_end_8
    .catch Ljava/net/UnknownHostException; {:try_start_8 .. :try_end_8} :catch_0

    .line 2794
    .end local v1    # "addr":Ljava/lang/String;
    .end local v7    # "e":Ljava/lang/IllegalArgumentException;
    :cond_13
    const/4 v13, 0x1

    .restart local v13    # "result":Z
    goto/16 :goto_5
.end method

.method public setFQDNByTestApp(ZLjava/lang/String;)V
    .locals 0
    .param p1, "enable"    # Z
    .param p2, "fqdn"    # Ljava/lang/String;

    .prologue
    .line 2469
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    .line 2470
    iput-object p2, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    .line 2471
    return-void
.end method

.method public setLinkp(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "mid"    # I
    .param p2, "ifname"    # Ljava/lang/String;
    .param p3, "addrlist"    # Ljava/lang/String;
    .param p4, "gatewaylist"    # Ljava/lang/String;
    .param p5, "dnsslist"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 2816
    if-ne p1, v6, :cond_1

    .line 2818
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    move-object v0, p0

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    .line 2819
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v6

    if-eqz v0, :cond_0

    .line 2821
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v6

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendLinkProperties(Landroid/net/LinkProperties;)V

    .line 2836
    :cond_0
    :goto_0
    return-void

    .line 2824
    :cond_1
    if-nez p1, :cond_2

    .line 2826
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    move-object v0, p0

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    .line 2827
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v7

    if-eqz v0, :cond_0

    .line 2829
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v7

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendLinkProperties(Landroid/net/LinkProperties;)V

    goto :goto_0

    .line 2834
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "not supported id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public setNotifier(Lcom/android/server/ePDGNotifier;)V
    .locals 0
    .param p1, "Notifier"    # Lcom/android/server/ePDGNotifier;

    .prologue
    .line 2464
    iput-object p1, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    .line 2465
    return-void
.end method

.method public setTWiFistatus(ZI)V
    .locals 4
    .param p1, "wifistatus"    # Z
    .param p2, "detailstatus"    # I

    .prologue
    const/4 v3, 0x1

    .line 1850
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v2, :cond_0

    .line 1852
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v2}, Lcom/android/server/ePDGNotifier;->notifyWIFIStatus()V

    .line 1855
    :cond_0
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    .line 1858
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 1859
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    invoke-virtual {v0, p1, p2}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZI)V

    goto :goto_0

    .line 1861
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_1
    if-ne p1, v3, :cond_2

    .line 1863
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    .line 1890
    :goto_1
    return-void

    .line 1868
    :cond_2
    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v2, v3, :cond_3

    .line 1870
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandsetfeature()V

    .line 1875
    :cond_3
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    goto :goto_1
.end method

.method public setWIFIstatus(Z)V
    .locals 4
    .param p1, "wifistatus"    # Z

    .prologue
    const/4 v3, 0x1

    .line 1894
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v2, :cond_0

    .line 1896
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v2}, Lcom/android/server/ePDGNotifier;->notifyWIFIStatus()V

    .line 1899
    :cond_0
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    .line 1902
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/ePDGConnection;

    .line 1903
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, p1, v2}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_0

    .line 1905
    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_1
    if-ne p1, v3, :cond_2

    .line 1907
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    .line 1934
    :goto_1
    return-void

    .line 1912
    :cond_2
    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v2, v3, :cond_3

    .line 1914
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandsetfeature()V

    .line 1919
    :cond_3
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    goto :goto_1
.end method

.method public startmonitoring(Z)Z
    .locals 22
    .param p1, "isfist"    # Z

    .prologue
    .line 2255
    const/4 v13, 0x0

    .line 2256
    .local v13, "ret":Z
    const-string v18, "net.wifisigmon"

    invoke-static/range {v18 .. v18}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 2257
    .local v12, "operator":Ljava/lang/String;
    if-nez v12, :cond_0

    .line 2259
    const-string v18, "[ePDG] packet loss check is disabled"

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2260
    const/16 v18, 0x1

    .line 2388
    :goto_0
    return v18

    .line 2262
    :cond_0
    const-string v18, "yes"

    move-object/from16 v0, v18

    invoke-virtual {v12, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v18

    if-nez v18, :cond_1

    .line 2264
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "[ePDG] packet loss check is disabled "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2265
    const/16 v18, 0x1

    goto :goto_0

    .line 2275
    :cond_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->mWifiManager:Landroid/net/wifi/WifiManager;

    move-object/from16 v18, v0

    invoke-virtual/range {v18 .. v18}, Landroid/net/wifi/WifiManager;->getWifiRSSIandLoss()[I

    move-result-object v9

    .line 2276
    .local v9, "myWifiinfo":[I
    if-nez v9, :cond_2

    .line 2278
    const-string v18, "[ePDG] WiFi info is null. So it will be skipped this time."

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2279
    const/16 v18, 0x0

    goto :goto_0

    .line 2281
    :cond_2
    const-wide/16 v10, 0x0

    .line 2282
    .local v10, "loss":D
    const/16 v18, 0x1

    aget v7, v9, v18

    .line 2283
    .local v7, "good":I
    const/16 v18, 0x2

    aget v4, v9, v18

    .line 2284
    .local v4, "bad":I
    const-wide/16 v16, 0x0

    .line 2285
    .local v16, "term_loss":D
    new-instance v6, Ljava/text/DecimalFormat;

    const-string v18, "###.##"

    move-object/from16 v0, v18

    invoke-direct {v6, v0}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    .line 2287
    .local v6, "df":Ljava/text/DecimalFormat;
    const/16 v18, 0x0

    aget v5, v9, v18

    .line 2288
    .local v5, "currentRssi":I
    add-int v18, v7, v4

    if-eqz v18, :cond_3

    .line 2290
    int-to-double v0, v4

    move-wide/from16 v18, v0

    add-int v20, v7, v4

    move/from16 v0, v20

    int-to-double v0, v0

    move-wide/from16 v20, v0

    div-double v18, v18, v20

    const-wide/high16 v20, 0x4059000000000000L    # 100.0

    mul-double v10, v18, v20

    .line 2293
    :cond_3
    if-eqz p1, :cond_4

    .line 2295
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "[ePDG] Start monitoring!! RSSI="

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const/16 v19, 0x0

    aget v19, v9, v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " Good!! = "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const/16 v19, 0x1

    aget v19, v9, v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, ", Bad!! = "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const/16 v19, 0x2

    aget v19, v9, v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, ", Loss = "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2296
    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldGood:I

    .line 2297
    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldBad:I

    .line 2303
    :cond_4
    const/16 v18, -0x4b

    move/from16 v0, v18

    if-ge v5, v0, :cond_5

    .line 2305
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "[ePDG] RSSI is too weak!! rssi= "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " so just report bad wifi status!! "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2306
    move-object/from16 v0, p0

    iput v7, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    .line 2307
    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    .line 2308
    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    .line 2309
    const/4 v13, 0x0

    .line 2379
    :goto_1
    if-eqz v13, :cond_e

    .line 2381
    const/16 v18, 0x3

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v18

    const-wide/16 v20, 0x7d0

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    move-wide/from16 v2, v20

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    :goto_2
    move/from16 v18, v13

    .line 2388
    goto/16 :goto_0

    .line 2313
    :cond_5
    const/4 v8, 0x0

    .line 2315
    .local v8, "isweak":Z
    const/16 v18, -0x46

    move/from16 v0, v18

    if-ge v5, v0, :cond_6

    .line 2318
    const/4 v8, 0x1

    .line 2321
    :cond_6
    add-int v18, v7, v4

    if-eqz v18, :cond_7

    .line 2323
    int-to-double v0, v4

    move-wide/from16 v18, v0

    add-int v20, v7, v4

    move/from16 v0, v20

    int-to-double v0, v0

    move-wide/from16 v20, v0

    div-double v18, v18, v20

    const-wide/high16 v20, 0x4059000000000000L    # 100.0

    mul-double v10, v18, v20

    .line 2325
    :cond_7
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move/from16 v18, v0

    sub-int v15, v7, v18

    .line 2326
    .local v15, "term_good":I
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    move/from16 v18, v0

    sub-int v14, v4, v18

    .line 2328
    .local v14, "term_bad":I
    add-int v18, v15, v14

    if-eqz v18, :cond_8

    .line 2330
    int-to-double v0, v14

    move-wide/from16 v18, v0

    add-int v20, v15, v14

    move/from16 v0, v20

    int-to-double v0, v0

    move-wide/from16 v20, v0

    div-double v18, v18, v20

    const-wide/high16 v20, 0x4059000000000000L    # 100.0

    mul-double v16, v18, v20

    .line 2333
    :cond_8
    move-object/from16 v0, p0

    iput v7, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    .line 2334
    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    .line 2336
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aget-boolean v18, v18, v19

    if-eqz v18, :cond_9

    .line 2342
    :cond_9
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->thre:I

    move/from16 v18, v0

    move/from16 v0, v18

    int-to-double v0, v0

    move-wide/from16 v18, v0

    cmpg-double v18, v16, v18

    if-gez v18, :cond_a

    .line 2344
    const/16 v18, 0x1

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    .line 2345
    const/4 v13, 0x1

    goto/16 :goto_1

    .line 2351
    :cond_a
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    move/from16 v18, v0

    if-nez v18, :cond_b

    .line 2353
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "[ePDG] we get low level sig, loss ="

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-wide/from16 v0, v16

    invoke-virtual {v6, v0, v1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " eve loss = "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2354
    const/4 v13, 0x0

    goto/16 :goto_1

    .line 2359
    :cond_b
    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    .line 2361
    const/16 v18, 0x14

    move/from16 v0, v18

    if-gt v14, v0, :cond_c

    if-eqz v8, :cond_d

    .line 2363
    :cond_c
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "[ePDG] we get low level sig, loss ="

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-wide/from16 v0, v16

    invoke-virtual {v6, v0, v1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " eve loss = "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " isWeek? "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " 1st time but many packet so report"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2364
    const/4 v13, 0x0

    goto/16 :goto_1

    .line 2369
    :cond_d
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "[ePDG] we get low level sig, loss ="

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-wide/from16 v0, v16

    invoke-virtual {v6, v0, v1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " eve loss = "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual {v6, v10, v11}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, " but just 1 time so not report it "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2370
    const/4 v13, 0x1

    goto/16 :goto_1

    .line 2385
    .end local v8    # "isweak":Z
    .end local v14    # "term_bad":I
    .end local v15    # "term_good":I
    :cond_e
    const/16 v18, 0x3

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v18

    const-wide/16 v20, 0x2ee0

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    move-wide/from16 v2, v20

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_2
.end method

.method public stopmonitoring()V
    .locals 3

    .prologue
    .line 2394
    const-string v1, "net.wifisigmon"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 2395
    .local v0, "operator":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 2397
    const-string v1, "[ePDG] packet loss check is disabled"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2414
    :goto_0
    return-void

    .line 2400
    :cond_0
    const-string v1, "yes"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 2402
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] packet loss check is disabled "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 2411
    :cond_1
    const-string v1, "[ePDG] Stop monitoring!!"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    .line 2412
    const/4 v1, 0x3

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGTracker;->removeMessages(I)V

    goto :goto_0
.end method

.method public temptestcode()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    .line 1664
    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .line 1666
    .local v0, "dc":Lcom/android/server/ePDGConnection;
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .line 1667
    .local v1, "msg_connect":Landroid/os/Message;
    iput v5, v1, Landroid/os/Message;->what:I

    .line 1670
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v2

    .line 1671
    .local v2, "msg_lost":Landroid/os/Message;
    const/4 v3, 0x2

    iput v3, v2, Landroid/os/Message;->what:I

    .line 1675
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGConnection;->ePDGbringUp(Landroid/os/Message;Landroid/os/Message;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 1677
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v5, v3, v5

    .line 1684
    :goto_0
    return-void

    .line 1681
    :cond_0
    const-string v3, "connection req Error"

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method
