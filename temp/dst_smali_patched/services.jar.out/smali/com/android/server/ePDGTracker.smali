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

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iput v4, p0, Lcom/android/server/ePDGTracker;->mMgrStatus:I

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    new-array v1, v6, [Z

    fill-array-data v1, :array_0

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    new-array v1, v6, [I

    fill-array-data v1, :array_1

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iLTEPDN4Addr:[Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iLTEPDN6Addr:[Ljava/lang/String;

    new-array v1, v6, [I

    fill-array-data v1, :array_2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iLTEIPType:[I

    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v3, v1, v5

    aput-object v3, v1, v7

    const/4 v2, 0x3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    aput-object v3, v1, v2

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    new-instance v1, Landroid/net/LinkProperties;

    invoke-direct {v1}, Landroid/net/LinkProperties;-><init>()V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    new-instance v1, Landroid/net/LinkProperties;

    invoke-direct {v1}, Landroid/net/LinkProperties;-><init>()V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->FQDNForEPDG:Ljava/lang/String;

    new-array v1, v6, [I

    fill-array-data v1, :array_3

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    const-string v1, "fe80::e291:f5ff:fecc:5dd7"

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->WiFi_Offload_gw_addr:Ljava/lang/String;

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    iput-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iput v4, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    iput v4, p0, Lcom/android/server/ePDGTracker;->oldGood:I

    iput v4, p0, Lcom/android/server/ePDGTracker;->oldBad:I

    iput v7, p0, Lcom/android/server/ePDGTracker;->thre:I

    const/16 v1, -0x55

    iput v1, p0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

    iput-boolean v5, p0, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    iput v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->needtoChangeInitialPri:Z

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    iput v4, p0, Lcom/android/server/ePDGTracker;->mcallstate:I

    iput v4, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iput v4, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    iput v4, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iput v5, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iput v4, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iput-boolean v4, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    new-instance v1, Lcom/android/server/ePDGTracker$WFCSettingObserver;

    invoke-direct {v1, p0, p0}, Lcom/android/server/ePDGTracker$WFCSettingObserver;-><init>(Lcom/android/server/ePDGTracker;Landroid/os/Handler;)V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCDataSettingObserver:Lcom/android/server/ePDGTracker$WFCSettingObserver;

    new-instance v1, Lcom/android/server/ePDGTracker$WFCPreferObserver;

    invoke-direct {v1, p0, p0}, Lcom/android/server/ePDGTracker$WFCPreferObserver;-><init>(Lcom/android/server/ePDGTracker;Landroid/os/Handler;)V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCPreferObserver:Lcom/android/server/ePDGTracker$WFCPreferObserver;

    new-instance v1, Lcom/android/server/ePDGTracker$1;

    invoke-direct {v1, p0}, Lcom/android/server/ePDGTracker$1;-><init>(Lcom/android/server/ePDGTracker;)V

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    iput-object p1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/android/server/ePDGTracker;->mTarget:Landroid/os/Handler;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v1

    iget v1, v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    iput v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/TelephonyManager;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->tm:Landroid/telephony/TelephonyManager;

    const-string v1, "telephony.registry"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/ITelephonyRegistry$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephonyRegistry;

    move-result-object v1

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v1, v5, :cond_2

    const-string v1, "net.loss"

    const-string v2, "2"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "net.wifisigmon"

    const-string v2, "yes"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    :goto_0
    new-array v1, v7, [Landroid/net/NetworkInfo;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    new-array v1, v7, [Landroid/net/NetworkAgent;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v2, "wifi"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/wifi/WifiManager;

    iput-object v1, p0, Lcom/android/server/ePDGTracker;->mWifiManager:Landroid/net/wifi/WifiManager;

    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_1

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCDataSettingObserver:Lcom/android/server/ePDGTracker$WFCSettingObserver;

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGTracker$WFCSettingObserver;->register(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mWFCPreferObserver:Lcom/android/server/ePDGTracker$WFCPreferObserver;

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGTracker$WFCPreferObserver;->register(Landroid/content/Context;)V

    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .local v0, "tm":Landroid/telephony/TelephonyManager;
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    const/16 v2, 0x21

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

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

    return-void

    .end local v0    # "tm":Landroid/telephony/TelephonyManager;
    :cond_2
    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_0

    const-string v1, "net.loss"

    const-string v2, "85"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "net.wifisigmon"

    const-string v2, "yes"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    nop

    :array_0
    .array-data 1
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
    .end array-data

    nop

    :array_1
    .array-data 4
        0x2
        0x2
        0x2
        0x2
        0x2
    .end array-data

    :array_2
    .array-data 4
        0x0
        0x0
        0x0
        0x0
        0x0
    .end array-data

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

    const-string v1, "createPDGConnection E"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "PREFERRED_OPTION"

    invoke-static {v1, v2, v3}, Lcom/movial/ipphone/IPPhoneSettings;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    iput v1, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "CELL_ONLY"

    invoke-static {v1, v2, v4}, Lcom/movial/ipphone/IPPhoneSettings;->getBoolean(Landroid/content/ContentResolver;Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_1

    iput v3, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    :cond_0
    :goto_0
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->isDualType(I)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-static {p1}, Lcom/android/server/ePDGDualTypeConn;->makePDGConnection(I)Lcom/android/server/ePDGDualTypeConn;

    move-result-object v0

    .local v0, "conn":Lcom/android/server/ePDGDualTypeConn;
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->setContext(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

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

    .end local v0    # "conn":Lcom/android/server/ePDGDualTypeConn;
    :goto_1
    return-object v0

    :cond_1
    iput v4, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    goto :goto_0

    :cond_2
    invoke-static {p1}, Lcom/android/server/ePDGSTypeConnection;->makePDGConnection(I)Lcom/android/server/ePDGSTypeConnection;

    move-result-object v0

    .local v0, "conn":Lcom/android/server/ePDGSTypeConnection;
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mePDGConnections:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    invoke-virtual {v0}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v2

    if-ne v2, p1, :cond_0

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget v2, v0, Lcom/android/server/ePDGConnection;->cid:I

    if-ne v2, p1, :cond_0

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
    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

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
    const-string v0, "ePDGTracker"

    invoke-static {v0, p1}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private makeNetworkCapabilities(I)Landroid/net/NetworkCapabilities;
    .locals 8
    .param p1, "mid"    # I

    .prologue
    const/4 v7, 0x5

    const/4 v6, 0x1

    const/4 v5, 0x0

    new-instance v1, Landroid/net/NetworkCapabilities;

    invoke-direct {v1}, Landroid/net/NetworkCapabilities;-><init>()V

    .local v1, "result":Landroid/net/NetworkCapabilities;
    invoke-virtual {v1, v5}, Landroid/net/NetworkCapabilities;->addTransportType(I)Landroid/net/NetworkCapabilities;

    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    if-nez p1, :cond_0

    const/4 v3, 0x4

    invoke-virtual {v1, v3}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    :goto_0
    const v2, 0xc800

    .local v2, "up":I
    const/16 v0, 0x1399

    .local v0, "down":I
    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->setLinkUpstreamBandwidthKbps(I)V

    invoke-virtual {v1, v0}, Landroid/net/NetworkCapabilities;->setLinkDownstreamBandwidthKbps(I)V

    const-string v3, "ePDG"

    invoke-virtual {v1, v3}, Landroid/net/NetworkCapabilities;->setNetworkSpecifier(Ljava/lang/String;)V

    .end local v0    # "down":I
    .end local v1    # "result":Landroid/net/NetworkCapabilities;
    .end local v2    # "up":I
    :goto_1
    return-object v1

    .restart local v1    # "result":Landroid/net/NetworkCapabilities;
    :cond_0
    invoke-virtual {v1, v7}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    goto :goto_0

    :cond_1
    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v3, v6, :cond_3

    if-eq p1, v6, :cond_2

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

    :cond_2
    invoke-virtual {v1, v7}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    invoke-virtual {v1, v5}, Landroid/net/NetworkCapabilities;->addCapability(I)Landroid/net/NetworkCapabilities;

    goto :goto_0

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

    const/4 v1, 0x0

    goto :goto_1
.end method

.method private makeidentity()Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v3, 0x0

    const/4 v6, 0x6

    const/4 v5, 0x3

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    if-eqz v4, :cond_1

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    :cond_0
    :goto_0
    return-object v3

    :cond_1
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->tm:Landroid/telephony/TelephonyManager;

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v0

    .local v0, "imsi":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "length":I
    if-ge v1, v6, :cond_2

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

    :cond_2
    const/4 v2, 0x3

    .local v2, "mnc_len":I
    const/4 v3, 0x0

    invoke-virtual {v0, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    invoke-virtual {v0, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    const/4 v3, 0x2

    if-ne v2, v3, :cond_3

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

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-le v0, v3, :cond_0

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

    :goto_0
    return-void

    :cond_0
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-nez v0, :cond_7

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

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    if-ne v0, v4, :cond_4

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x5

    aput v2, v0, v1

    :goto_1
    iget-object v0, p1, Lcom/android/server/ePDGConnInfo;->ConnectedGWAddr:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    aput-object v2, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    aput-object v2, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecDNS:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    aput-object v2, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget-object v2, p1, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    aput-object v2, v0, v1

    iget-object v0, p1, Lcom/android/server/ePDGConnInfo;->mFQDN:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/android/server/ePDGConnInfo;->mFQDN:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGTracker;->FQDNForEPDG:Ljava/lang/String;

    :cond_1
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_6

    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_6

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

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

    invoke-direct {p0, v6}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->requestpcscfaddr(Lcom/android/server/ePDGConnection;)V

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    :cond_2
    :goto_2
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyonConnectionParam(I)V

    :cond_3
    :goto_3
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    goto/16 :goto_0

    :cond_4
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    if-ne v0, v3, :cond_5

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v2, v0, v1

    goto/16 :goto_1

    :cond_5
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v6, v0, v1

    goto/16 :goto_1

    :cond_6
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-ne v0, v4, :cond_2

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

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

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    goto :goto_2

    :cond_7
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0xa

    if-ne v0, v1, :cond_8

    const-string v0, "Exit Fail status, we set status disconnect"

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v3, v0, v1

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    goto :goto_3

    :cond_8
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v3, :cond_c

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v3, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x0

    aput-object v2, v0, v1

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_a

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    :cond_9
    :goto_4
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-eqz v0, :cond_b

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_b

    const/4 v0, 0x4

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0, v1, v6}, Lcom/android/server/ePDGTracker;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    const-wide/16 v2, 0x7d0

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_3

    :cond_a
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-ne v0, v4, :cond_9

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    goto :goto_4

    :cond_b
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    :cond_c
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v4, :cond_e

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    aput v2, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_d

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    :cond_d
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    goto/16 :goto_3

    :cond_e
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v5, :cond_14

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    aput v2, v0, v1

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

    :cond_f
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    :cond_10
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v3, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x0

    aput-object v2, v0, v1

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_12

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    :cond_11
    :goto_5
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-eqz v0, :cond_13

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-nez v0, :cond_13

    const/4 v0, 0x4

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0, v1, v6}, Lcom/android/server/ePDGTracker;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    const-wide/16 v2, 0x7d0

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/server/ePDGTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_3

    :cond_12
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    if-ne v0, v4, :cond_11

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->clear()V

    goto :goto_5

    :cond_13
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    :cond_14
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x3e8

    if-ne v0, v1, :cond_15

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/16 v2, 0x3e8

    aput v2, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    :cond_15
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x3e9

    if-ne v0, v1, :cond_16

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/16 v2, 0x3e9

    aput v2, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v5, v0, v1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    :cond_16
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x138d

    if-ne v0, v1, :cond_17

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/16 v2, 0x138d

    aput v2, v0, v1

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

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    goto/16 :goto_3

    :cond_17
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/16 v1, 0x8

    if-ne v0, v1, :cond_18

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    iget v2, p1, Lcom/android/server/ePDGConnInfo;->reason:I

    aput v2, v0, v1

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

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyErrorStatus(I)V

    goto/16 :goto_3

    :cond_18
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    if-ne v0, v2, :cond_19

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    const/4 v2, 0x5

    aput v2, v0, v1

    const-string v0, "[ePDG]Handover success to LTE "

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

    :cond_19
    iget v0, p1, Lcom/android/server/ePDGConnInfo;->returntype:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_1a

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    aput v2, v0, v1

    const-string v0, "[ePDG]Handover success to ePDG "

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->resetCB(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v0, :cond_3

    iget v0, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->sendLOSnotification(I)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v1, p1, Lcom/android/server/ePDGConnInfo;->mid:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_3

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

    if-le p1, v4, :cond_0

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

    :goto_0
    return-void

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

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    if-nez v0, :cond_1

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

    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getDataNetworkType()I

    move-result v9

    .local v9, "networkType":I
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->DISCONNECTED:Landroid/net/NetworkInfo$DetailedState;

    .local v10, "thisstate":Landroid/net/NetworkInfo$DetailedState;
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    new-instance v1, Landroid/net/NetworkInfo;

    const-string v2, "MOBILE"

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v5, v9, v2, v3}, Landroid/net/NetworkInfo;-><init>(IILjava/lang/String;Ljava/lang/String;)V

    aput-object v1, v0, p1

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-virtual {v0, v5}, Landroid/net/NetworkInfo;->setRoaming(Z)V

    :goto_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    const/4 v1, 0x5

    if-ne v0, v1, :cond_3

    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->CONNECTED:Landroid/net/NetworkInfo$DetailedState;

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/net/NetworkInfo;->setExtraInfo(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-virtual {v0, v4}, Landroid/net/NetworkInfo;->setIsAvailable(Z)V

    :goto_2
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    const-string v1, "ePDG"

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v2, v2, p1

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getExtraInfo()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v10, v1, v2}, Landroid/net/NetworkInfo;->setDetailedState(Landroid/net/NetworkInfo$DetailedState;Ljava/lang/String;Ljava/lang/String;)V

    if-nez p1, :cond_7

    iget-object v7, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    .local v7, "mLinkProperties":Landroid/net/LinkProperties;
    :goto_3
    const-string v0, "524288,1048576,2097152,262144,524288,1048576"

    invoke-virtual {v7, v0}, Landroid/net/LinkProperties;->setTcpBufferSizes(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, p1

    if-nez v0, :cond_8

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

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v9, v1}, Landroid/net/NetworkInfo;->setSubtype(ILjava/lang/String;)V

    goto/16 :goto_1

    :cond_3
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    const/4 v1, 0x6

    if-eq v0, v1, :cond_4

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    if-nez v0, :cond_5

    :cond_4
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->CONNECTED:Landroid/net/NetworkInfo$DetailedState;

    const/16 v9, 0x12

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-static {v9}, Landroid/telephony/TelephonyManager;->getNetworkTypeName(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v9, v1}, Landroid/net/NetworkInfo;->setSubtype(ILjava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/net/NetworkInfo;->setExtraInfo(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v0, v0, p1

    invoke-virtual {v0, v4}, Landroid/net/NetworkInfo;->setIsAvailable(Z)V

    goto/16 :goto_2

    :cond_5
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_6

    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->FAILED:Landroid/net/NetworkInfo$DetailedState;

    goto/16 :goto_2

    :cond_6
    sget-object v10, Landroid/net/NetworkInfo$DetailedState;->DISCONNECTED:Landroid/net/NetworkInfo$DetailedState;

    goto/16 :goto_2

    :cond_7
    iget-object v7, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    .restart local v7    # "mLinkProperties":Landroid/net/LinkProperties;
    goto/16 :goto_3

    :cond_8
    sget-object v0, Landroid/net/NetworkInfo$DetailedState;->CONNECTED:Landroid/net/NetworkInfo$DetailedState;

    if-ne v10, v0, :cond_9

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, p1

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendNetworkInfo(Landroid/net/NetworkInfo;)V

    goto/16 :goto_0

    :cond_9
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, p1

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mNetworkInfo:[Landroid/net/NetworkInfo;

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendNetworkInfo(Landroid/net/NetworkInfo;)V

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    const/4 v1, 0x0

    aput-object v1, v0, p1

    goto/16 :goto_0
.end method

.method private setAlldcStop()V
    .locals 3

    .prologue
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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGConnection;->setManagerStatus(Z)V

    goto :goto_0

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_0
    return-void
.end method


# virtual methods
.method public checkdcandrequestagain()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/4 v1, 0x2

    if-ge v0, v1, :cond_3

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aget-boolean v1, v1, v0

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v1, v0

    const/4 v2, 0x3

    if-eq v1, v2, :cond_2

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

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    :cond_0
    :goto_1
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aget-boolean v1, v1, v0

    if-nez v1, :cond_1

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

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

    :cond_3
    return-void
.end method

.method public checkdcandsetfeature()V
    .locals 3

    .prologue
    const/4 v2, 0x2

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public determineTMUSRSSI(Z)I
    .locals 26
    .param p1, "isfist"    # Z

    .prologue
    const/4 v14, 0x0

    .local v14, "ret":I
    const-string v22, "net.wifisigmon"

    invoke-static/range {v22 .. v22}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .local v13, "operator":Ljava/lang/String;
    const/4 v8, 0x0

    .local v8, "isCheckPLoss":Z
    if-nez v13, :cond_1

    const-string v22, "[ePDG] packet loss check is disabled"

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const/4 v8, 0x0

    :cond_0
    :goto_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->mWifiManager:Landroid/net/wifi/WifiManager;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Landroid/net/wifi/WifiManager;->getWifiRSSIandLoss()[I

    move-result-object v12

    .local v12, "myWifiinfo":[I
    if-nez v12, :cond_3

    const-string v22, "[ePDG] WiFi info is null. So it will be skipped this time."

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

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

    .end local v14    # "ret":I
    .local v15, "ret":I
    :goto_1
    return v15

    .end local v12    # "myWifiinfo":[I
    .end local v15    # "ret":I
    .restart local v14    # "ret":I
    :cond_1
    const-string v22, "yes"

    move-object/from16 v0, v22

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v22

    if-eqz v22, :cond_0

    if-eqz p1, :cond_2

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

    :cond_2
    const/4 v8, 0x1

    goto :goto_0

    .restart local v12    # "myWifiinfo":[I
    :cond_3
    const-wide/16 v10, 0x0

    .local v10, "loss":D
    const/16 v22, 0x1

    aget v7, v12, v22

    .local v7, "good":I
    const/16 v22, 0x2

    aget v4, v12, v22

    .local v4, "bad":I
    const-wide/16 v18, 0x0

    .local v18, "term_loss":D
    new-instance v6, Ljava/text/DecimalFormat;

    const-string v22, "###.##"

    move-object/from16 v0, v22

    invoke-direct {v6, v0}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    .local v6, "df":Ljava/text/DecimalFormat;
    const/16 v22, 0x0

    aget v5, v12, v22

    .local v5, "currentRssi":I
    add-int v22, v7, v4

    if-eqz v22, :cond_4

    int-to-double v0, v4

    move-wide/from16 v22, v0

    add-int v24, v7, v4

    move/from16 v0, v24

    int-to-double v0, v0

    move-wide/from16 v24, v0

    div-double v22, v22, v24

    const-wide/high16 v24, 0x4059000000000000L    # 100.0

    mul-double v10, v22, v24

    :cond_4
    if-eqz p1, :cond_5

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

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldGood:I

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldBad:I

    :cond_5
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move/from16 v22, v0

    sub-int v17, v7, v22

    .local v17, "term_good":I
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    move/from16 v22, v0

    sub-int v16, v4, v22

    .local v16, "term_bad":I
    add-int v22, v17, v16

    if-eqz v22, :cond_6

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

    :cond_6
    move-object/from16 v0, p0

    iput v7, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    const/4 v9, 0x0

    .local v9, "isPacketBAD":Z
    const-wide/high16 v20, 0x4000000000000000L    # 2.0

    .local v20, "tmuspacketthre":D
    const/16 v22, 0xa

    move/from16 v0, v16

    move/from16 v1, v22

    if-le v0, v1, :cond_7

    cmpl-double v22, v18, v20

    if-lez v22, :cond_7

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

    if-eqz v8, :cond_7

    const/4 v9, 0x1

    :cond_7
    if-eqz v9, :cond_8

    const/4 v14, 0x2

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

    .end local v14    # "ret":I
    .restart local v15    # "ret":I
    goto/16 :goto_1

    .end local v15    # "ret":I
    .restart local v14    # "ret":I
    :cond_8
    const/16 v22, -0x4b

    move/from16 v0, v22

    if-le v5, v0, :cond_9

    const/4 v14, 0x0

    goto :goto_2

    :cond_9
    const/16 v22, -0x4b

    move/from16 v0, v22

    if-gt v5, v0, :cond_a

    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

    move/from16 v22, v0

    move/from16 v0, v22

    if-lt v5, v0, :cond_a

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

    const/4 v14, 0x1

    goto :goto_2

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

    const/4 v14, 0x2

    goto/16 :goto_2
.end method

.method public ePDGHandOverStatus(I)V
    .locals 9
    .param p1, "extendedRAT"    # I

    .prologue
    const/4 v8, 0x0

    .local v8, "apnfid":I
    const/16 v1, 0x12c

    if-ne p1, v1, :cond_0

    const/4 v8, 0x1

    :cond_0
    invoke-direct {p0, v8}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "mydc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_2

    const/16 v1, 0x68

    if-eq p1, v1, :cond_1

    const/16 v1, 0x69

    if-ne p1, v1, :cond_4

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

    invoke-direct {p0, v8}, Lcom/android/server/ePDGTracker;->createPDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setFQDNByTestApp(ZLjava/lang/String;)V

    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setEPDGAddrByTestApp(ZLjava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_3

    iget v1, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget v3, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget v6, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v7, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGConnection;->setinitialvalue(IIIZZII)V

    :cond_2
    :goto_0
    invoke-virtual {v0, p1}, Lcom/android/server/ePDGConnection;->ePDGHandOverStatus(I)V

    :goto_1
    return-void

    :cond_3
    const/4 v1, 0x1

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_0

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

    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v2

    .local v2, "fid":I
    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v1

    .local v1, "dc":Lcom/android/server/ePDGConnection;
    const/4 v0, 0x0

    .local v0, "PRi":I
    if-eqz p2, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {v1, v0}, Lcom/android/server/ePDGConnection;->setinitPrichange(I)V

    const/4 v3, 0x1

    .end local v0    # "PRi":I
    .end local v1    # "dc":Lcom/android/server/ePDGConnection;
    .end local v2    # "fid":I
    :goto_1
    return v3

    .restart local v0    # "PRi":I
    .restart local v1    # "dc":Lcom/android/server/ePDGConnection;
    .restart local v2    # "fid":I
    :cond_0
    const/4 v0, 0x2

    goto :goto_0

    .end local v0    # "PRi":I
    .end local v1    # "dc":Lcom/android/server/ePDGConnection;
    .end local v2    # "fid":I
    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->ePDGStart(Ljava/lang/String;)I

    move-result v3

    goto :goto_1

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

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getEPDGID(I)I

    move-result v0

    .local v0, "fid":I
    if-le v0, v3, :cond_0

    const/4 v1, 0x2

    :goto_0
    return v1

    :cond_0
    if-ne v0, v2, :cond_2

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    :cond_1
    :goto_1
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    move-result v1

    goto :goto_0

    :cond_2
    const/4 v1, 0x6

    if-ne v0, v1, :cond_3

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    const/4 v0, 0x1

    goto :goto_1

    :cond_3
    if-ne v0, v3, :cond_1

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

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

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getEPDGID(I)I

    move-result v0

    .local v0, "fid":I
    if-le v0, v5, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    if-ne v0, v4, :cond_4

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    :cond_2
    :goto_1
    if-ne v0, v4, :cond_3

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    if-nez v2, :cond_0

    :cond_3
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    move-result v1

    goto :goto_0

    :cond_4
    const/4 v2, 0x6

    if-ne v0, v2, :cond_5

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    const/4 v0, 0x1

    goto :goto_1

    :cond_5
    if-ne v0, v5, :cond_2

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    const/4 v0, 0x1

    goto :goto_1
.end method

.method public ePDGPrefTechdone(I)V
    .locals 2
    .param p1, "result"    # I

    .prologue
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

    return-void
.end method

.method public ePDGStart(I)I
    .locals 11
    .param p1, "fid"    # I

    .prologue
    const/4 v3, 0x5

    const/4 v10, 0x1

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

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aput-boolean v10, v4, p1

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->isInitialAttachtype(I)Z

    move-result v4

    if-eqz v4, :cond_0

    :try_start_0
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    invoke-interface {v4, v5, v6}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyEPDGControl(Ljava/lang/String;Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v9, v4, p1

    .local v9, "status":I
    if-eqz v9, :cond_1

    if-eq v9, v3, :cond_1

    const/4 v4, 0x6

    if-ne v9, v4, :cond_2

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

    const/4 v3, 0x0

    :goto_1
    return v3

    :cond_2
    if-ne v9, v10, :cond_3

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

    goto :goto_1

    :cond_3
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-nez v4, :cond_4

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->isUsingOnlyWifi(I)Z

    move-result v4

    if-eqz v4, :cond_4

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

    const/4 v3, 0x3

    goto :goto_1

    :cond_4
    invoke-direct {p0}, Lcom/android/server/ePDGTracker;->makeidentity()Ljava/lang/String;

    move-result-object v8

    .local v8, "identity":Ljava/lang/String;
    if-nez v8, :cond_5

    const-string v4, "SIM is not ready so just go out"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_5
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_6

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->createPDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    iget-boolean v3, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lcom/android/server/ePDGConnection;->setFQDNByTestApp(ZLjava/lang/String;)V

    iget-boolean v3, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lcom/android/server/ePDGConnection;->setEPDGAddrByTestApp(ZLjava/lang/String;)V

    iget v3, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_7

    iget v1, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget v3, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget v6, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v7, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGConnection;->setinitialvalue(IIIZZII)V

    :cond_6
    :goto_2
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg_connect":Landroid/os/Message;
    iput v10, v1, Landroid/os/Message;->what:I

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v2

    .local v2, "msg_lost":Landroid/os/Message;
    const/4 v3, 0x2

    iput v3, v2, Landroid/os/Message;->what:I

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    move v5, p1

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGConnection;->ePDGbringUp(Landroid/os/Message;Landroid/os/Message;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_8

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v10, v3, p1

    :goto_3
    move v3, v10

    goto/16 :goto_1

    .end local v1    # "msg_connect":Landroid/os/Message;
    .end local v2    # "msg_lost":Landroid/os/Message;
    :cond_7
    iget-boolean v3, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, v10, v3}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_2

    .restart local v1    # "msg_connect":Landroid/os/Message;
    .restart local v2    # "msg_lost":Landroid/os/Message;
    :cond_8
    const-string v3, "connection req Error"

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_3

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

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v0

    .local v0, "fid":I
    if-le v0, v3, :cond_0

    const/4 v1, 0x2

    :goto_0
    return v1

    :cond_0
    if-ne v0, v2, :cond_2

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    :cond_1
    :goto_1
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    move-result v1

    goto :goto_0

    :cond_2
    const/4 v1, 0x6

    if-ne v0, v1, :cond_3

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    const/4 v0, 0x1

    goto :goto_1

    :cond_3
    if-ne v0, v3, :cond_1

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

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

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aput-boolean v6, v4, p1

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v2, v4, p1

    .local v2, "status":I
    if-eq v2, v9, :cond_0

    if-ne v2, v7, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v8, :cond_2

    const/4 v4, 0x3

    if-ne v2, v4, :cond_2

    if-nez p1, :cond_0

    :cond_2
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v4, :cond_0

    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_3

    const-string v4, "something wrong!! no dc but status is connected?? anyway return inactive"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    iput v8, v1, Landroid/os/Message;->what:I

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGConnection;->ePDGteardown(Landroid/os/Message;)Z

    move-result v4

    if-nez v4, :cond_4

    const-string v4, "something wrong!! SM and status is mismatched?? anyway return inactive"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v8, :cond_9

    if-eqz p1, :cond_6

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v7, v4, p1

    :cond_5
    :goto_1
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v4, p1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->isInitialAttachtype(I)Z

    move-result v4

    if-eqz v4, :cond_0

    :try_start_0
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-interface {v4, v5, v6}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyEPDGControl(Ljava/lang/String;Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v4

    goto :goto_0

    :cond_6
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v4, v4, p1

    if-nez v4, :cond_8

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v7, v3, p1

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v3, :cond_7

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v3, p1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    :cond_7
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v6, v6}, Lcom/android/server/ePDGConnection;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    const/16 v3, 0x8

    goto :goto_0

    :cond_8
    iget-object v4, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v9, v4, p1

    goto :goto_1

    :cond_9
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v5, 0xb

    if-ne v4, v5, :cond_5

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

    const-string v2, "APPALL"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v1, "APPALL Called"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    move-result v1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v0

    .local v0, "fid":I
    if-gt v0, v5, :cond_0

    if-ne v0, v4, :cond_4

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    :cond_2
    :goto_1
    if-ne v0, v4, :cond_3

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwappRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    if-nez v2, :cond_0

    :cond_3
    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->ePDGStop(I)I

    move-result v1

    goto :goto_0

    :cond_4
    const/4 v2, 0x6

    if-ne v0, v2, :cond_5

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwcbsRef:Z

    const/4 v0, 0x1

    goto :goto_1

    :cond_5
    if-ne v0, v5, :cond_2

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->vzwmmsRef:Z

    const/4 v0, 0x1

    goto :goto_1
.end method

.method public fidtoString(I)Ljava/lang/String;
    .locals 1
    .param p1, "fid"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    const-string v0, "UnKnow"

    :goto_0
    return-object v0

    :pswitch_0
    const-string v0, "IMS"

    goto :goto_0

    :pswitch_1
    const-string v0, "VZWAPP"

    goto :goto_0

    :pswitch_2
    const-string v0, "CF"

    goto :goto_0

    :pswitch_3
    const-string v0, "STATIC"

    goto :goto_0

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
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "mydc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_0

    const-string v1, "unknown"

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
    const/4 v0, 0x0

    return-object v0
.end method

.method public getEPDGID(I)I
    .locals 2
    .param p1, "type"    # I

    .prologue
    sparse-switch p1, :sswitch_data_0

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

    const/16 v0, 0xa

    :goto_0
    return v0

    :sswitch_0
    const/4 v0, 0x0

    goto :goto_0

    :sswitch_1
    const/4 v0, 0x1

    goto :goto_0

    :sswitch_2
    const/4 v0, 0x6

    goto :goto_0

    :sswitch_3
    const/4 v0, 0x7

    goto :goto_0

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
    const-string v0, "VZWIMS"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const-string v0, "VZWAPP"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const-string v0, "CF"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x2

    goto :goto_0

    :cond_2
    const-string v0, "Static"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x3

    goto :goto_0

    :cond_3
    const/16 v0, 0x3e7

    goto :goto_0
.end method

.method public getIpv4(I)Ljava/net/InetAddress;
    .locals 6
    .param p1, "mid"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGTracker;->getLinkpro(I)Landroid/net/LinkProperties;

    move-result-object v4

    .local v4, "mylink":Landroid/net/LinkProperties;
    invoke-virtual {v4}, Landroid/net/LinkProperties;->getAddresses()Ljava/util/List;

    move-result-object v1

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

    .local v0, "addr":Ljava/net/InetAddress;
    instance-of v5, v0, Ljava/net/Inet4Address;

    if-eqz v5, :cond_0

    move-object v3, v0

    check-cast v3, Ljava/net/Inet4Address;

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
    packed-switch p1, :pswitch_data_0

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    :goto_0
    return-object v0

    :pswitch_0
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    goto :goto_0

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

    const-string v1, "MMS"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_0

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->createPDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setFQDNByTestApp(ZLjava/lang/String;)V

    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->setEPDGAddrByTestApp(ZLjava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_1

    iget v1, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    iget v3, p0, Lcom/android/server/ePDGTracker;->call_status:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget v6, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v7, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGConnection;->setinitialvalue(IIIZZII)V

    :cond_0
    :goto_0
    invoke-virtual {v0}, Lcom/android/server/ePDGConnection;->getprefer()I

    move-result v8

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :goto_1
    return v8

    .restart local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_1
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_0

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_2
    const-string v1, "getNetPrefer: wrong string"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const/4 v8, 0x2

    goto :goto_1
.end method

.method public getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;
    .locals 1
    .param p1, "ipv"    # Ljava/lang/String;

    .prologue
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

    invoke-virtual {p0, p2}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v2

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "mydc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_0

    :goto_0
    return-object v1

    :cond_0
    const-string v2, "INET"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v1, v0, Lcom/android/server/ePDGConnection;->pcscfAddr_ipv4:[Ljava/lang/String;

    goto :goto_0

    :cond_1
    const-string v2, "INET6"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v1, v0, Lcom/android/server/ePDGConnection;->pcscfAddr_ipv6:[Ljava/lang/String;

    goto :goto_0

    :cond_2
    const-string v2, " ipv is not matched"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public getapntypewithfid(I)Ljava/lang/String;
    .locals 2
    .param p1, "id"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const/4 v0, 0x0

    :goto_0
    return-object v0

    :pswitch_1
    const-string v0, "ims"

    goto :goto_0

    :pswitch_2
    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    const-string v0, "cbs"

    goto :goto_0

    :cond_0
    const-string v0, "vzwapp"

    goto :goto_0

    :pswitch_3
    const-string v0, "CF"

    goto :goto_0

    :pswitch_4
    const-string v0, "static"

    goto :goto_0

    :pswitch_5
    const-string v0, "cbs"

    goto :goto_0

    :pswitch_6
    const-string v0, "mms"

    goto :goto_0

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

    packed-switch p1, :pswitch_data_0

    :goto_0
    :pswitch_0
    return-object v0

    :pswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->getInterfaceName()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

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

    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0}, Landroid/net/LinkProperties;->getInterfaceName()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_3

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

    :cond_3
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    goto/16 :goto_0

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

    sparse-switch p1, :sswitch_data_0

    :goto_0
    return v0

    :sswitch_0
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    goto :goto_0

    :sswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v1, 0x1

    aget v0, v0, v1

    goto :goto_0

    :sswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v1, v0

    goto :goto_0

    :sswitch_3
    iget-object v0, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v1, 0x3

    aget v0, v0, v1

    goto :goto_0

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
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v1, p1

    .local v0, "mMyIMSstatus":I
    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x2

    :cond_0
    return v0
.end method

.method public getfeatureID(Ljava/lang/String;)I
    .locals 1
    .param p1, "feature"    # Ljava/lang/String;

    .prologue
    const-string v0, "ims"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const-string v0, "vzwapp"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const-string v0, "CF"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x2

    goto :goto_0

    :cond_2
    const-string v0, "Static"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x3

    goto :goto_0

    :cond_3
    const-string v0, "cbs"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x6

    goto :goto_0

    :cond_4
    const-string v0, "mms"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    const/4 v0, 0x7

    goto :goto_0

    :cond_5
    const-string v0, "APPALL"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const/16 v0, 0x3e6

    goto :goto_0

    :cond_6
    const/16 v0, 0x3e7

    goto :goto_0
.end method

.method public getisMobileavail()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    return v0
.end method

.method public handleConnect(Landroid/net/NetworkInfo;)V
    .locals 8
    .param p1, "info"    # Landroid/net/NetworkInfo;

    .prologue
    const/16 v7, 0xb

    const/4 v4, 0x1

    iget v5, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v5, v4, :cond_1

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v5

    if-ne v5, v7, :cond_1

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v5

    const/16 v6, 0xd

    if-ne v5, v6, :cond_2

    move v1, v4

    .local v1, "newstatus":Z
    :goto_0
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-nez v5, :cond_0

    if-ne v1, v4, :cond_0

    iput-boolean v1, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

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

    .end local v1    # "newstatus":Z
    :cond_1
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v5

    if-eq v5, v4, :cond_3

    :goto_1
    return-void

    :cond_2
    const/4 v1, 0x0

    goto :goto_0

    :cond_3
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v5

    if-nez v5, :cond_4

    const-string v4, "handle connected call but state is not connected"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-ne v5, v4, :cond_5

    const-string v4, "[ePDG] wifi is connected!!! - aleady check go out"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_5
    const-string v5, "[ePDG] wifi is connected!!!"

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const-string v5, "net.loss"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "threshold":Ljava/lang/String;
    if-nez v3, :cond_6

    const/16 v5, 0x63

    iput v5, p0, Lcom/android/server/ePDGTracker;->thre:I

    :goto_2
    iget v5, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v5, v7, :cond_8

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->determineTMUSRSSI(Z)I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    iget v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    invoke-virtual {p0, v4, v5}, Lcom/android/server/ePDGTracker;->setTWiFistatus(ZI)V

    goto :goto_1

    :cond_6
    iget v5, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v5, v7, :cond_7

    const/4 v2, 0x1

    .local v2, "sysvalue":I
    :try_start_0
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_3
    mul-int/lit8 v5, v2, -0x1

    iput v5, p0, Lcom/android/server/ePDGTracker;->tmushandoutthre:I

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

    :catch_0
    move-exception v0

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

    :try_start_1
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->thre:I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    move-exception v0

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

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_8
    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->startmonitoring(Z)Z

    move-result v5

    iput-boolean v5, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->setWIFIstatus(Z)V

    goto/16 :goto_1
.end method

.method public handleDisconnect(Landroid/net/NetworkInfo;)V
    .locals 6
    .param p1, "info"    # Landroid/net/NetworkInfo;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v2, :cond_0

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v4

    const/16 v5, 0xb

    if-ne v4, v5, :cond_0

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v4

    const/16 v5, 0xd

    if-ne v4, v5, :cond_1

    move v1, v2

    .local v1, "newstatus":Z
    :goto_0
    iput-boolean v1, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "imsdc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_0

    const-string v4, "we lost IMS PDN so will set lost "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Lcom/android/server/ePDGConnection;->ePDGHandOverStatus(I)V

    .end local v0    # "imsdc":Lcom/android/server/ePDGConnection;
    .end local v1    # "newstatus":Z
    :cond_0
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->getType()I

    move-result v4

    if-eq v4, v2, :cond_2

    :goto_1
    return-void

    :cond_1
    move v1, v3

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v2, "handle Disconnected call but state is connected!!"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_3
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-nez v4, :cond_4

    const-string v2, "[ePDG] wifi is Disconnected!!! - aleady check go out"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    const-string v4, "[ePDG] wifi is Disconnected!!!"

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    iput-boolean v2, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {p0, v3}, Lcom/android/server/ePDGTracker;->setWIFIstatus(Z)V

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->stopmonitoring()V

    goto :goto_1
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 7
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v6, 0xb

    const/4 v5, 0x0

    iget v4, p1, Landroid/os/Message;->what:I

    sparse-switch v4, :sswitch_data_0

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

    :cond_0
    :goto_0
    return-void

    :sswitch_0
    const-string v4, "we start temp code!!! "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->temptestcode()V

    goto :goto_0

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

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v3, Lcom/android/server/ePDGConnInfo;

    .local v3, "sendingResult":Lcom/android/server/ePDGConnInfo;
    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->onConnectionRsp(Lcom/android/server/ePDGConnInfo;)V

    goto :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v3    # "sendingResult":Lcom/android/server/ePDGConnInfo;
    :sswitch_2
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    if-eqz v4, :cond_0

    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v6, :cond_1

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGTracker;->determineTMUSRSSI(Z)I

    move-result v2

    .local v2, "currentstat":I
    iget v4, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    if-eq v4, v2, :cond_0

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

    iput v2, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    iget v5, p0, Lcom/android/server/ePDGTracker;->wifidetailstatus:I

    invoke-virtual {p0, v4, v5}, Lcom/android/server/ePDGTracker;->setTWiFistatus(ZI)V

    goto :goto_0

    .end local v2    # "currentstat":I
    :cond_1
    invoke-virtual {p0, v5}, Lcom/android/server/ePDGTracker;->startmonitoring(Z)Z

    move-result v1

    .local v1, "currenloss":Z
    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    if-eq v4, v1, :cond_0

    iput-boolean v1, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    iget-boolean v4, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->setWIFIstatus(Z)V

    goto :goto_0

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

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    iget v5, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    goto/16 :goto_0

    :sswitch_4
    const-string v4, "EVENT_SERVICE_CHANGE "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->onServiceStateChange()V

    goto/16 :goto_0

    :sswitch_5
    iget v4, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v4, v6, :cond_0

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

    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGTracker;->onCallStateChange(I)V

    goto/16 :goto_0

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
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "PREFERRED_OPTION"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Lcom/movial/ipphone/IPPhoneSettings;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget v2, p0, Lcom/android/server/ePDGTracker;->wfcprefer:I

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGConnection;->setWFCPreferChange(I)V

    goto :goto_0

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_0
    return-void
.end method

.method handleWFCSettingChange(Z)V
    .locals 6
    .param p1, "change"    # Z

    .prologue
    const/4 v5, 0x1

    const/4 v2, 0x1

    .local v2, "isCellonly":Z
    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "CELL_ONLY"

    invoke-static {v3, v4, v5}, Lcom/movial/ipphone/IPPhoneSettings;->getBoolean(Landroid/content/ContentResolver;Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v3, 0x0

    iput v3, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget v3, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    invoke-virtual {v0, v3}, Lcom/android/server/ePDGConnection;->setWFCsettingChange(I)V

    goto :goto_1

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_0
    iput v5, p0, Lcom/android/server/ePDGTracker;->WFC_setting:I

    goto :goto_0

    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_1
    return-void
.end method

.method public isAnyConnecting()Z
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/4 v3, 0x2

    if-ge v0, v3, :cond_2

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v1, v3, v0

    .local v1, "status":I
    if-eq v1, v2, :cond_0

    const/4 v3, 0x4

    if-ne v1, v3, :cond_1

    .end local v1    # "status":I
    :cond_0
    :goto_1
    return v2

    .restart local v1    # "status":I
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

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

    const-string v1, "ims"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGTracker;->isConnection(I)Z

    move-result v0

    :cond_0
    :goto_0
    return v0

    :cond_1
    const-string v1, "vzwapp"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

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

    const/16 v5, 0x3e4

    if-ne p1, v5, :cond_2

    invoke-virtual {p0, p2}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v0

    .local v0, "fid":I
    const/4 v5, 0x6

    if-eq v0, v5, :cond_0

    const/4 v5, 0x7

    if-ne v0, v5, :cond_1

    :cond_0
    const/4 v0, 0x1

    :cond_1
    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v2

    .end local v0    # "fid":I
    .local v2, "mycon":Lcom/android/server/ePDGConnection;
    :goto_0
    packed-switch p1, :pswitch_data_0

    move v3, v4

    :goto_1
    return v3

    .end local v2    # "mycon":Lcom/android/server/ePDGConnection;
    :cond_2
    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v2

    .restart local v2    # "mycon":Lcom/android/server/ePDGConnection;
    goto :goto_0

    :pswitch_0
    if-eqz v2, :cond_3

    invoke-virtual {v2, p2}, Lcom/android/server/ePDGConnection;->setQosInfo(Ljava/lang/String;)Z

    goto :goto_1

    :cond_3
    const-string v4, "[ePDG] get qos but no ims dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :pswitch_1
    if-eqz v2, :cond_4

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGTracker;->requestpcscfaddr(Lcom/android/server/ePDGConnection;)V

    goto :goto_1

    :cond_4
    const-string v4, "[ePDG] get pcs_ch but no ims dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :pswitch_2
    if-eqz v2, :cond_5

    invoke-virtual {v2, p2}, Lcom/android/server/ePDGConnection;->setPCSInfo(Ljava/lang/String;)Z

    goto :goto_1

    :cond_5
    const-string v4, "[ePDG] get qos but no ims dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

    :pswitch_3
    if-eqz v2, :cond_6

    const-string v5, "[ePDG] DISCONNECTED_DONE "

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const v5, 0x40006

    invoke-virtual {v2, v5, v4}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    goto :goto_1

    .end local v1    # "msg":Landroid/os/Message;
    :cond_6
    const-string v4, "[ePDG] get DISCONNECTED_DONE no dc "

    invoke-direct {p0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_1

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

    if-eqz p1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    iget-boolean v1, p0, Lcom/android/server/ePDGTracker;->mIMS_HO_avail:Z

    if-nez v1, :cond_0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isInitialAttachtype(I)Z
    .locals 4
    .param p1, "fid"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-ne p1, v1, :cond_0

    move v0, v1

    goto :goto_0
.end method

.method public isIpv4Connected()Z
    .locals 6

    .prologue
    const/4 v4, 0x0

    .local v4, "ret":Z
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v5}, Landroid/net/LinkProperties;->getAddresses()Ljava/util/List;

    move-result-object v1

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

    .local v0, "addr":Ljava/net/InetAddress;
    instance-of v5, v0, Ljava/net/Inet4Address;

    if-eqz v5, :cond_0

    move-object v3, v0

    check-cast v3, Ljava/net/Inet4Address;

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

    const/4 v4, 0x1

    .end local v0    # "addr":Ljava/net/InetAddress;
    .end local v3    # "i4addr":Ljava/net/Inet4Address;
    :cond_1
    return v4
.end method

.method public isIpv6Connected()Z
    .locals 6

    .prologue
    const/4 v4, 0x0

    .local v4, "ret":Z
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v5}, Landroid/net/LinkProperties;->getAddresses()Ljava/util/List;

    move-result-object v1

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

    .local v0, "addr":Ljava/net/InetAddress;
    instance-of v5, v0, Ljava/net/Inet6Address;

    if-eqz v5, :cond_0

    move-object v3, v0

    check-cast v3, Ljava/net/Inet6Address;

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

    const/4 v4, 0x1

    .end local v0    # "addr":Ljava/net/InetAddress;
    .end local v3    # "i6addr":Ljava/net/Inet6Address;
    :cond_1
    return v4
.end method

.method public isUsingOnlyWifi(I)Z
    .locals 2
    .param p1, "fid"    # I

    .prologue
    iget v0, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    if-nez p1, :cond_0

    const/4 v0, 0x0

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

    const/4 v2, 0x4

    if-le p1, v2, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v2, v2, p1

    if-nez v2, :cond_2

    const-string v0, "dc is connected but addr is not set, so just think it is same addr"

    invoke-direct {p0, v0}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v2, v2, p1

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v1

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
    move-object/from16 v0, p0

    move/from16 v1, p1

    move-object/from16 v2, p5

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGTracker;->isControlType(ILjava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    :goto_0
    return-void

    :cond_0
    const-string v4, "[ePDG] notifyEPDGCallResult start "

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const/16 v16, 0x0

    .local v16, "pdnNum":I
    const/4 v14, 0x0

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

    .local v3, "sendingResult":Lcom/android/server/ePDGConnInfo;
    const/4 v13, 0x0

    .local v13, "dc":Lcom/android/server/ePDGConnection;
    const/4 v5, 0x0

    .local v5, "mid":I
    if-nez p11, :cond_6

    move-object/from16 v0, p0

    move/from16 v1, p3

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->findePDGConnectionbyCid(I)Lcom/android/server/ePDGConnection;

    move-result-object v13

    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v5

    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/android/server/ePDGTracker;->getLinkpro(I)Landroid/net/LinkProperties;

    move-result-object v15

    .local v15, "oldlink":Landroid/net/LinkProperties;
    if-nez v13, :cond_1

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

    :cond_1
    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->isConnected()Z

    move-result v4

    if-nez v4, :cond_2

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

    :cond_2
    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v4

    move-object/from16 v0, p0

    move-object/from16 v1, p7

    invoke-virtual {v0, v4, v1}, Lcom/android/server/ePDGTracker;->issameaddr(ILjava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

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

    invoke-virtual/range {v4 .. v9}, Lcom/android/server/ePDGTracker;->setLinkp(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/android/server/ePDGTracker;->getLinkpro(I)Landroid/net/LinkProperties;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/LinkProperties;->hasGlobalIPv6Address()Z

    move-result v4

    if-eqz v4, :cond_4

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

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v13}, Lcom/android/server/ePDGConnection;->getConnectionID()I

    move-result v6

    invoke-virtual {v4, v6}, Lcom/android/server/ePDGNotifier;->notifyADDRChange(I)V

    goto/16 :goto_0

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

    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v13}, Lcom/android/server/ePDGTracker;->resetCurrentConnection(ILcom/android/server/ePDGConnection;)Z

    goto/16 :goto_0

    :cond_5
    move-object/from16 v0, p0

    invoke-virtual {v0, v5, v13}, Lcom/android/server/ePDGTracker;->resetCurrentConnection(ILcom/android/server/ePDGConnection;)Z

    goto/16 :goto_0

    .end local v15    # "oldlink":Landroid/net/LinkProperties;
    :cond_6
    move-object/from16 v0, p0

    move-object/from16 v1, p11

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGTracker;->getfeatureID(Ljava/lang/String;)I

    move-result v16

    const/4 v4, 0x6

    move/from16 v0, v16

    if-eq v0, v4, :cond_7

    const/4 v4, 0x7

    move/from16 v0, v16

    if-ne v0, v4, :cond_8

    :cond_7
    const/16 v16, 0x1

    :cond_8
    move-object/from16 v0, p0

    move/from16 v1, v16

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v13

    if-nez v13, :cond_9

    const-string v4, "[ePDG] Error. notifyEPDGCallResult : ePDGConnection is null "

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_9
    move-object/from16 v0, p7

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    move-object/from16 v0, p6

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    move-object/from16 v0, p9

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    move-object/from16 v0, p8

    iput-object v0, v3, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    if-eqz p2, :cond_a

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

    const v4, 0x40006

    move/from16 v0, p2

    invoke-virtual {v13, v4, v0}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/Message;->sendToTarget()V

    goto/16 :goto_0

    :cond_a
    move/from16 v0, p3

    iput v0, v13, Lcom/android/server/ePDGConnection;->cid:I

    const v4, 0x40005

    invoke-virtual {v13, v4}, Lcom/android/server/ePDGConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    const/4 v4, 0x0

    invoke-static {v14, v3, v4}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    invoke-virtual {v14}, Landroid/os/Message;->sendToTarget()V

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

    const/4 v2, 0x0

    .local v2, "pdnNum":I
    const/4 v1, 0x0

    .local v1, "msg":Landroid/os/Message;
    invoke-direct {p0, p2}, Lcom/android/server/ePDGTracker;->findePDGConnectionbyCid(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-nez p3, :cond_0

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

    const v3, 0x40006

    const/16 v4, 0x1392

    invoke-virtual {v0, v3, v4}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0
.end method

.method onCallStateChange(I)V
    .locals 3
    .param p1, "callstate"    # I

    .prologue
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

    iput p1, p0, Lcom/android/server/ePDGTracker;->call_status:I

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "imsdc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/server/ePDGConnection;->setCallStatus(I)V

    :cond_0
    return-void
.end method

.method onServiceStateChange()V
    .locals 7

    .prologue
    const/4 v4, 0x1

    iget-object v5, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    if-nez v5, :cond_1

    :cond_0
    return-void

    :cond_1
    iget-object v5, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget-object v5, p0, Lcom/android/server/ePDGTracker;->myServiceState:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v5

    iput v5, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    iget v5, p0, Lcom/android/server/ePDGTracker;->DataState:I

    if-nez v5, :cond_3

    iget v5, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    const/16 v6, 0xe

    if-ne v5, v6, :cond_3

    move v3, v4

    .local v3, "newmobile_avail":Z
    :goto_0
    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    if-eq v5, v3, :cond_4

    iput-boolean v3, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

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

    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    const/4 v5, 0x2

    if-ge v1, v5, :cond_4

    iget-object v5, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v5, v1}, Lcom/android/server/ePDGNotifier;->notifyPDPState(I)V

    iget-boolean v5, p0, Lcom/android/server/ePDGTracker;->mobile_avail:Z

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    aget-boolean v5, v5, v1

    if-ne v5, v4, :cond_2

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGTracker;->ePDGStart(I)I

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .end local v1    # "i":I
    .end local v3    # "newmobile_avail":Z
    :cond_3
    const/4 v3, 0x0

    goto :goto_0

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_5

    iget v4, p0, Lcom/android/server/ePDGTracker;->DataState:I

    iget v5, p0, Lcom/android/server/ePDGTracker;->MobileTech:I

    invoke-virtual {v0, v4, v5}, Lcom/android/server/ePDGConnection;->setNetworkstate(II)V

    goto :goto_2
.end method

.method public requestpcscfaddr(Lcom/android/server/ePDGConnection;)V
    .locals 2
    .param p1, "mycon"    # Lcom/android/server/ePDGConnection;

    .prologue
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv4Connected()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv6Connected()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "IPV4V6"

    .local v0, "ipvtype":Ljava/lang/String;
    :goto_0
    invoke-virtual {p1, v0}, Lcom/android/server/ePDGConnection;->pcsch(Ljava/lang/String;)Z

    return-void

    .end local v0    # "ipvtype":Ljava/lang/String;
    :cond_0
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv4Connected()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v0, "IP"

    .restart local v0    # "ipvtype":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "ipvtype":Ljava/lang/String;
    :cond_1
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->isIpv6Connected()Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v0, "IPV6"

    .restart local v0    # "ipvtype":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "ipvtype":Ljava/lang/String;
    :cond_2
    const-string v0, "IPV6"

    .restart local v0    # "ipvtype":Ljava/lang/String;
    const-string v1, "maybe not connected yet, so just set ipv6 for default"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public resetCB(I)V
    .locals 4
    .param p1, "mid"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg_connect":Landroid/os/Message;
    const/4 v3, 0x1

    iput v3, v1, Landroid/os/Message;->what:I

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v2

    .local v2, "msg_lost":Landroid/os/Message;
    const/4 v3, 0x2

    iput v3, v2, Landroid/os/Message;->what:I

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGConnection;->resetCBLooper(Landroid/os/Message;Landroid/os/Message;)V

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

    const-string v3, "resetCurrentConnection called!! "

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    if-nez p2, :cond_0

    const-string v2, "something wrong!! no dc but status is connected?? "

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    :goto_0
    return v1

    :cond_0
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iput v2, v0, Landroid/os/Message;->what:I

    invoke-virtual {p2, v0}, Lcom/android/server/ePDGConnection;->ePDGteardown(Landroid/os/Message;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v2, "something wrong!! SM and status is mismatched?? anyway return inactive"

    invoke-direct {p0, v2}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v3, 0x4

    aput v3, v1, p1

    move v1, v2

    goto :goto_0
.end method

.method public setEPDGAddrByTestApp(ZLjava/lang/String;)V
    .locals 0
    .param p1, "enable"    # Z
    .param p2, "ePDGAddr"    # Ljava/lang/String;

    .prologue
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->ePDGAddrStaticFlag:Z

    iput-object p2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrForTestApp:Ljava/lang/String;

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
    const/4 v3, 0x0

    .local v3, "addresses":[Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "dnses":[Ljava/lang/String;
    const/4 v8, 0x0

    .local v8, "gateways":[Ljava/lang/String;
    if-nez p1, :cond_2

    new-instance p1, Landroid/net/LinkProperties;

    .end local p1    # "linkProperties":Landroid/net/LinkProperties;
    invoke-direct/range {p1 .. p1}, Landroid/net/LinkProperties;-><init>()V

    .restart local p1    # "linkProperties":Landroid/net/LinkProperties;
    :goto_0
    :try_start_0
    invoke-virtual/range {p1 .. p2}, Landroid/net/LinkProperties;->setInterfaceName(Ljava/lang/String;)V

    if-eqz p3, :cond_0

    const-string v14, ","

    move-object/from16 v0, p3

    invoke-virtual {v0, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    :cond_0
    if-eqz v3, :cond_8

    array-length v14, v3

    if-lez v14, :cond_8

    move-object v5, v3

    .local v5, "arr$":[Ljava/lang/String;
    array-length v12, v5

    .local v12, "len$":I
    const/4 v9, 0x0

    .local v9, "i$":I
    :goto_1
    if-ge v9, v12, :cond_9

    aget-object v1, v5, v9

    .local v1, "addr":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v14

    if-eqz v14, :cond_3

    :cond_1
    :goto_2
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .end local v1    # "addr":Ljava/lang/String;
    .end local v5    # "arr$":[Ljava/lang/String;
    .end local v9    # "i$":I
    .end local v12    # "len$":I
    :cond_2
    invoke-virtual/range {p1 .. p1}, Landroid/net/LinkProperties;->clear()V

    goto :goto_0

    .restart local v1    # "addr":Ljava/lang/String;
    .restart local v5    # "arr$":[Ljava/lang/String;
    .restart local v9    # "i$":I
    .restart local v12    # "len$":I
    :cond_3
    :try_start_1
    const-string v14, "/"

    invoke-virtual {v1, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .local v4, "ap":[Ljava/lang/String;
    array-length v14, v4

    const/4 v15, 0x2

    if-ne v14, v15, :cond_6

    const/4 v14, 0x0

    aget-object v1, v4, v14

    const/4 v14, 0x1

    aget-object v14, v4, v14

    invoke-static {v14}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_0

    move-result v2

    .local v2, "addrPrefixLen":I
    :goto_3
    :try_start_2
    invoke-static {v1}, Landroid/net/NetworkUtils;->numericToInetAddress(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_0

    move-result-object v10

    .local v10, "ia":Ljava/net/InetAddress;
    :try_start_3
    invoke-virtual {v10}, Ljava/net/InetAddress;->isAnyLocalAddress()Z

    move-result v14

    if-nez v14, :cond_1

    if-nez v2, :cond_4

    instance-of v14, v10, Ljava/net/Inet4Address;

    if-eqz v14, :cond_7

    const/16 v2, 0x20

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

    new-instance v11, Landroid/net/LinkAddress;

    invoke-direct {v11, v10, v2}, Landroid/net/LinkAddress;-><init>(Ljava/net/InetAddress;I)V

    .local v11, "la":Landroid/net/LinkAddress;
    move-object/from16 v0, p1

    invoke-virtual {v0, v11}, Landroid/net/LinkProperties;->addLinkAddress(Landroid/net/LinkAddress;)Z
    :try_end_3
    .catch Ljava/net/UnknownHostException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

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

    const/4 v13, 0x0

    .end local v7    # "e":Ljava/net/UnknownHostException;
    .local v13, "result":Z
    :goto_5
    if-nez v13, :cond_5

    invoke-virtual/range {p1 .. p1}, Landroid/net/LinkProperties;->clear()V

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

    return v13

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

    :catch_1
    move-exception v7

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

    .end local v7    # "e":Ljava/lang/IllegalArgumentException;
    .restart local v10    # "ia":Ljava/net/InetAddress;
    :cond_7
    const/16 v2, 0x80

    goto/16 :goto_4

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

    .restart local v5    # "arr$":[Ljava/lang/String;
    .restart local v9    # "i$":I
    .restart local v12    # "len$":I
    :cond_9
    if-eqz p5, :cond_a

    const-string v14, ","

    move-object/from16 v0, p5

    invoke-virtual {v0, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    :cond_a
    if-eqz v6, :cond_e

    array-length v14, v6

    if-lez v14, :cond_e

    move-object v5, v6

    array-length v12, v5

    const/4 v9, 0x0

    :goto_6
    if-ge v9, v12, :cond_e

    aget-object v1, v5, v9

    .restart local v1    # "addr":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    :try_end_4
    .catch Ljava/net/UnknownHostException; {:try_start_4 .. :try_end_4} :catch_0

    move-result v14

    if-eqz v14, :cond_c

    :cond_b
    :goto_7
    add-int/lit8 v9, v9, 0x1

    goto :goto_6

    :cond_c
    :try_start_5
    invoke-static {v1}, Landroid/net/NetworkUtils;->numericToInetAddress(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_5
    .catch Ljava/lang/IllegalArgumentException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_0

    move-result-object v10

    .restart local v10    # "ia":Ljava/net/InetAddress;
    if-nez v10, :cond_d

    :try_start_6
    const-string v14, "null!!"

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_7

    .end local v10    # "ia":Ljava/net/InetAddress;
    :catch_2
    move-exception v7

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

    invoke-virtual {v10}, Ljava/net/InetAddress;->isAnyLocalAddress()Z

    move-result v14

    if-nez v14, :cond_b

    move-object/from16 v0, p1

    invoke-virtual {v0, v10}, Landroid/net/LinkProperties;->addDnsServer(Ljava/net/InetAddress;)Z

    goto :goto_7

    .end local v1    # "addr":Ljava/lang/String;
    .end local v10    # "ia":Ljava/net/InetAddress;
    :cond_e
    if-eqz p4, :cond_f

    const-string v14, ","

    move-object/from16 v0, p4

    invoke-virtual {v0, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v8

    :cond_f
    if-eqz v8, :cond_10

    array-length v14, v8

    if-nez v14, :cond_11

    :cond_10
    const/4 v14, 0x0

    new-array v8, v14, [Ljava/lang/String;

    :cond_11
    move-object v5, v8

    array-length v12, v5

    const/4 v9, 0x0

    :goto_8
    if-ge v9, v12, :cond_13

    aget-object v1, v5, v9

    .restart local v1    # "addr":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    :try_end_6
    .catch Ljava/net/UnknownHostException; {:try_start_6 .. :try_end_6} :catch_0

    move-result v14

    if-eqz v14, :cond_12

    :goto_9
    add-int/lit8 v9, v9, 0x1

    goto :goto_8

    :cond_12
    :try_start_7
    invoke-static {v1}, Landroid/net/NetworkUtils;->numericToInetAddress(Ljava/lang/String;)Ljava/net/InetAddress;
    :try_end_7
    .catch Ljava/lang/IllegalArgumentException; {:try_start_7 .. :try_end_7} :catch_3
    .catch Ljava/net/UnknownHostException; {:try_start_7 .. :try_end_7} :catch_0

    move-result-object v10

    .restart local v10    # "ia":Ljava/net/InetAddress;
    :try_start_8
    new-instance v14, Landroid/net/RouteInfo;

    invoke-direct {v14, v10}, Landroid/net/RouteInfo;-><init>(Ljava/net/InetAddress;)V

    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Landroid/net/LinkProperties;->addRoute(Landroid/net/RouteInfo;)Z

    goto :goto_9

    .end local v10    # "ia":Ljava/net/InetAddress;
    :catch_3
    move-exception v7

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
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->FQDNStaticFlag:Z

    iput-object p2, p0, Lcom/android/server/ePDGTracker;->FQDNForTestApp:Ljava/lang/String;

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

    if-ne p1, v6, :cond_1

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    move-object v0, p0

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v6

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v6

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mVZWAPPLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendLinkProperties(Landroid/net/LinkProperties;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-nez p1, :cond_2

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    move-object v0, p0

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGTracker;->setEPDGLinkProperties(Landroid/net/LinkProperties;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v7

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGTracker;->mNetworkAgent:[Landroid/net/NetworkAgent;

    aget-object v0, v0, v7

    iget-object v1, p0, Lcom/android/server/ePDGTracker;->mIMSLinkProperties:Landroid/net/LinkProperties;

    invoke-virtual {v0, v1}, Landroid/net/NetworkAgent;->sendLinkProperties(Landroid/net/LinkProperties;)V

    goto :goto_0

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
    iput-object p1, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    return-void
.end method

.method public setTWiFistatus(ZI)V
    .locals 4
    .param p1, "wifistatus"    # Z
    .param p2, "detailstatus"    # I

    .prologue
    const/4 v3, 0x1

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v2}, Lcom/android/server/ePDGNotifier;->notifyWIFIStatus()V

    :cond_0
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    invoke-virtual {v0, p1, p2}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZI)V

    goto :goto_0

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_1
    if-ne p1, v3, :cond_2

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    :goto_1
    return-void

    :cond_2
    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v2, v3, :cond_3

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandsetfeature()V

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

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/server/ePDGTracker;->mePDGNotifier:Lcom/android/server/ePDGNotifier;

    invoke-virtual {v2}, Lcom/android/server/ePDGNotifier;->notifyWIFIStatus()V

    :cond_0
    iput-boolean p1, p0, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

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

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    iget-boolean v2, p0, Lcom/android/server/ePDGTracker;->isgood:Z

    invoke-virtual {v0, p1, v2}, Lcom/android/server/ePDGConnection;->setWIFIStatus(ZZ)V

    goto :goto_0

    .end local v0    # "dc":Lcom/android/server/ePDGConnection;
    :cond_1
    if-ne p1, v3, :cond_2

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandrequestagain()V

    :goto_1
    return-void

    :cond_2
    iget v2, p0, Lcom/android/server/ePDGTracker;->myfeature:I

    if-ne v2, v3, :cond_3

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->checkdcandsetfeature()V

    :cond_3
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    goto :goto_1
.end method

.method public startmonitoring(Z)Z
    .locals 22
    .param p1, "isfist"    # Z

    .prologue
    const/4 v13, 0x0

    .local v13, "ret":Z
    const-string v18, "net.wifisigmon"

    invoke-static/range {v18 .. v18}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .local v12, "operator":Ljava/lang/String;
    if-nez v12, :cond_0

    const-string v18, "[ePDG] packet loss check is disabled"

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const/16 v18, 0x1

    :goto_0
    return v18

    :cond_0
    const-string v18, "yes"

    move-object/from16 v0, v18

    invoke-virtual {v12, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v18

    if-nez v18, :cond_1

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

    const/16 v18, 0x1

    goto :goto_0

    :cond_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->mWifiManager:Landroid/net/wifi/WifiManager;

    move-object/from16 v18, v0

    invoke-virtual/range {v18 .. v18}, Landroid/net/wifi/WifiManager;->getWifiRSSIandLoss()[I

    move-result-object v9

    .local v9, "myWifiinfo":[I
    if-nez v9, :cond_2

    const-string v18, "[ePDG] WiFi info is null. So it will be skipped this time."

    move-object/from16 v0, p0

    move-object/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const/16 v18, 0x0

    goto :goto_0

    :cond_2
    const-wide/16 v10, 0x0

    .local v10, "loss":D
    const/16 v18, 0x1

    aget v7, v9, v18

    .local v7, "good":I
    const/16 v18, 0x2

    aget v4, v9, v18

    .local v4, "bad":I
    const-wide/16 v16, 0x0

    .local v16, "term_loss":D
    new-instance v6, Ljava/text/DecimalFormat;

    const-string v18, "###.##"

    move-object/from16 v0, v18

    invoke-direct {v6, v0}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    .local v6, "df":Ljava/text/DecimalFormat;
    const/16 v18, 0x0

    aget v5, v9, v18

    .local v5, "currentRssi":I
    add-int v18, v7, v4

    if-eqz v18, :cond_3

    int-to-double v0, v4

    move-wide/from16 v18, v0

    add-int v20, v7, v4

    move/from16 v0, v20

    int-to-double v0, v0

    move-wide/from16 v20, v0

    div-double v18, v18, v20

    const-wide/high16 v20, 0x4059000000000000L    # 100.0

    mul-double v10, v18, v20

    :cond_3
    if-eqz p1, :cond_4

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

    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldGood:I

    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/server/ePDGTracker;->oldBad:I

    :cond_4
    const/16 v18, -0x4b

    move/from16 v0, v18

    if-ge v5, v0, :cond_5

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

    move-object/from16 v0, p0

    iput v7, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    const/4 v13, 0x0

    :goto_1
    if-eqz v13, :cond_e

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

    goto/16 :goto_0

    :cond_5
    const/4 v8, 0x0

    .local v8, "isweak":Z
    const/16 v18, -0x46

    move/from16 v0, v18

    if-ge v5, v0, :cond_6

    const/4 v8, 0x1

    :cond_6
    add-int v18, v7, v4

    if-eqz v18, :cond_7

    int-to-double v0, v4

    move-wide/from16 v18, v0

    add-int v20, v7, v4

    move/from16 v0, v20

    int-to-double v0, v0

    move-wide/from16 v20, v0

    div-double v18, v18, v20

    const-wide/high16 v20, 0x4059000000000000L    # 100.0

    mul-double v10, v18, v20

    :cond_7
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move/from16 v18, v0

    sub-int v15, v7, v18

    .local v15, "term_good":I
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    move/from16 v18, v0

    sub-int v14, v4, v18

    .local v14, "term_bad":I
    add-int v18, v15, v14

    if-eqz v18, :cond_8

    int-to-double v0, v14

    move-wide/from16 v18, v0

    add-int v20, v15, v14

    move/from16 v0, v20

    int-to-double v0, v0

    move-wide/from16 v20, v0

    div-double v18, v18, v20

    const-wide/high16 v20, 0x4059000000000000L    # 100.0

    mul-double v16, v18, v20

    :cond_8
    move-object/from16 v0, p0

    iput v7, v0, Lcom/android/server/ePDGTracker;->oldGood:I

    move-object/from16 v0, p0

    iput v4, v0, Lcom/android/server/ePDGTracker;->oldBad:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->isFeatureSwitch:[Z

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aget-boolean v18, v18, v19

    if-eqz v18, :cond_9

    :cond_9
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/ePDGTracker;->thre:I

    move/from16 v18, v0

    move/from16 v0, v18

    int-to-double v0, v0

    move-wide/from16 v18, v0

    cmpg-double v18, v16, v18

    if-gez v18, :cond_a

    const/16 v18, 0x1

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    const/4 v13, 0x1

    goto/16 :goto_1

    :cond_a
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    move/from16 v18, v0

    if-nez v18, :cond_b

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

    const/4 v13, 0x0

    goto/16 :goto_1

    :cond_b
    const/16 v18, 0x0

    move/from16 v0, v18

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/server/ePDGTracker;->isbeforeSigstat:Z

    const/16 v18, 0x14

    move/from16 v0, v18

    if-gt v14, v0, :cond_c

    if-eqz v8, :cond_d

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

    const/4 v13, 0x0

    goto/16 :goto_1

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

    const/4 v13, 0x1

    goto/16 :goto_1

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
    const-string v1, "net.wifisigmon"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "operator":Ljava/lang/String;
    if-nez v0, :cond_0

    const-string v1, "[ePDG] packet loss check is disabled"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "yes"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

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

    :cond_1
    const-string v1, "[ePDG] Stop monitoring!!"

    invoke-direct {p0, v1}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    const/4 v1, 0x3

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGTracker;->removeMessages(I)V

    goto :goto_0
.end method

.method public temptestcode()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    invoke-direct {p0, v5}, Lcom/android/server/ePDGTracker;->findePDGConnection(I)Lcom/android/server/ePDGConnection;

    move-result-object v0

    .local v0, "dc":Lcom/android/server/ePDGConnection;
    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v1

    .local v1, "msg_connect":Landroid/os/Message;
    iput v5, v1, Landroid/os/Message;->what:I

    invoke-virtual {p0}, Lcom/android/server/ePDGTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v2

    .local v2, "msg_lost":Landroid/os/Message;
    const/4 v3, 0x2

    iput v3, v2, Landroid/os/Message;->what:I

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->mcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGTracker;->mnc:Ljava/lang/String;

    invoke-virtual/range {v0 .. v5}, Lcom/android/server/ePDGConnection;->ePDGbringUp(Landroid/os/Message;Landroid/os/Message;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aput v5, v3, v5

    :goto_0
    return-void

    :cond_0
    const-string v3, "connection req Error"

    invoke-direct {p0, v3}, Lcom/android/server/ePDGTracker;->log(Ljava/lang/String;)V

    goto :goto_0
.end method
