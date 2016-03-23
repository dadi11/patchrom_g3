.class public Lcom/lge/wifi/impl/mobilehotspot/MHPService;
.super Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot$Stub;
.source "MHPService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpDisableThread;,
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpEnableThread;,
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpRestartThread;,
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotDisableThread;,
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotEnableThread;,
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;,
        Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotNetworkInterfaceThread;
    }
.end annotation


# static fields
.field public static final ALLOWED_ALL_DEVCIE:Ljava/lang/String; = "mhp_allowed_all_device"

.field public static final SETTINGS_MHP_COUNTRY:Ljava/lang/String; = "mhp_country"

.field public static final VZW_MOBILEHOTSPOT_ON:Ljava/lang/String; = "wifi_vzw_mobile_hotspot_on"


# instance fields
.field private final MHP_LOG:Ljava/lang/String;

.field private final TAG:Ljava/lang/String;

.field private allowedlist:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected dnsServers:[Ljava/lang/String;

.field private isAirplaneModeOn:Z

.field private isChangedConfigure:Z

.field private isECM:Z

.field private isRecoverAfterECM:Z

.field private mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

.field private mBatteryUsageEnabler:Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;

.field private mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

.field private mContext:Landroid/content/Context;

.field private mDeniedList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mDeviceProperies:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private mDhcpDisableThread:Ljava/lang/Thread;

.field private mDhcpEnableThread:Ljava/lang/Thread;

.field private mDhcpRestartThread:Ljava/lang/Thread;

.field private mEventLoop:Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

.field private mIFace:Ljava/lang/String;

.field private mIsLoging:Z

.field private mIsMobileHotspotOn:Z

.field private mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

.field private mMhpDisableThread:Ljava/lang/Thread;

.field private mMhpEnableThread:Ljava/lang/Thread;

.field private mMobileHotspotState:I

.field private mOffByAirplaneMode:Z

.field private mOnOffWlP2pService:Z

.field private mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

.field mReceiver:Landroid/content/BroadcastReceiver;

.field private phone:Lcom/android/internal/telephony/ITelephony;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot$Stub;-><init>()V

    const-string v1, "MobileHotspotService"

    iput-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->TAG:Ljava/lang/String;

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mEventLoop:Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    const-string v1, "persist.service.mhp.log"

    iput-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->MHP_LOG:Ljava/lang/String;

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    const/16 v1, 0xa

    iput v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I

    iput-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z

    new-instance v1, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;

    invoke-direct {v1, p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$1;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V

    iput-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mReceiver:Landroid/content/BroadcastReceiver;

    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.mobilehotspot.action.STATE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_NATIVE_EVENT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_LOG"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.ANY_DATA_STATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.wifi.sap.WIFI_SAP_DHCP_INFO_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.mobilehotspot.action.AP_POWER_ONOFF_CONFIG"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_EMC_EVENT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.net.wifi.WIFI_AP_STATE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    const-string v1, "persist.service.mhp.log"

    const-string v2, "1"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/wifi/impl/mobilehotspot/MHPService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I

    return p1
.end method

.method static synthetic access$100(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z

    return v0
.end method

.method static synthetic access$1000(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Lcom/lge/wifi/impl/mobilehotspot/MHPManager;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    return-object v0
.end method

.method static synthetic access$102(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z

    return p1
.end method

.method static synthetic access$1102(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isECM:Z

    return p1
.end method

.method static synthetic access$1200(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z

    return v0
.end method

.method static synthetic access$1202(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z

    return p1
.end method

.method static synthetic access$1300(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->syncAllConectedDevices()V

    return-void
.end method

.method static synthetic access$1400(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mEventLoop:Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

    return-object v0
.end method

.method static synthetic access$200(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/util/ArrayList;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z

    return v0
.end method

.method static synthetic access$302(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isChangedConfigure:Z

    return p1
.end method

.method static synthetic access$400(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsLoging:Z

    return v0
.end method

.method static synthetic access$502(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsLoging:Z

    return p1
.end method

.method static synthetic access$600(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isAirPlaneModeOn()Z

    move-result v0

    return v0
.end method

.method static synthetic access$702(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isAirplaneModeOn:Z

    return p1
.end method

.method static synthetic access$800(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOffByAirplaneMode:Z

    return v0
.end method

.method static synthetic access$802(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOffByAirplaneMode:Z

    return p1
.end method

.method static synthetic access$900(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$902(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPService;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;

    return-object p1
.end method

.method private addConnectedNotification()V
    .locals 3

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_CONNECTED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.lge.mobilehotspot.extra.MOBILEHOTSPOT_CONNECTION_COUNT_NOTIFICATION"

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAssocListCount()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method private addNetworkDeviceProperties(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 0
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "properties"    # [Ljava/lang/String;

    .prologue
    return-void
.end method

.method private addOnOffNotification()V
    .locals 3

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.mobilehotspot.action.MOBILEHOTSPOT_ONOFF"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.lge.mobilehotspot.extra.MOBILEHOTSPOT"

    iget-boolean v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method private getConnectedDeviceKeyList()Ljava/util/ArrayList;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .local v0, "connectedDeviceKeylist":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;>;"
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getAllowedAllDevcie()I

    move-result v5

    const/4 v6, 0x1

    if-ne v5, v6, :cond_2

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    sget v6, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_MAC_FILTER_DENY:I

    invoke-virtual {v5, v7, v7, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->addMacFilter(Ljava/lang/String;Ljava/lang/String;I)Z

    :goto_0
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->syncAllConectedDevices()V

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getList()Ljava/util/HashMap;
    invoke-static {v5}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1800(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;)Ljava/util/HashMap;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .local v4, "item":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/HashMap<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;>;"
    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_1
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .local v1, "device":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const/4 v6, 0x3

    if-ne v5, v6, :cond_1

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .end local v1    # "device":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;"
    .end local v3    # "i$":Ljava/util/Iterator;
    .end local v4    # "item":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/HashMap<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;>;"
    :cond_2
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    sget v6, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_MAC_FILTER_ALLOW:I

    invoke-virtual {v5, v7, v7, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->addMacFilter(Ljava/lang/String;Ljava/lang/String;I)Z

    goto :goto_0

    :cond_3
    return-object v0
.end method

.method private getNetworkDeviceProperties(Ljava/lang/String;)[Ljava/lang/String;
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method private getNetworkDeviceProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "property"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeviceProperies:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashMap;

    .local v0, "properties":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v0, :cond_0

    invoke-virtual {v0, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    :goto_0
    return-object v1

    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->updateNetworkDeviceProperty(Ljava/lang/String;)V

    invoke-direct {p0, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkDeviceProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    const/4 v1, 0x0

    goto :goto_0
.end method

.method private getNetworkIface()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[MHS_NEZZIMOM] Available network interface : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIFace:Ljava/lang/String;

    return-object v0
.end method

.method private final isAirPlaneModeOn()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "airplane_mode_on"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    if-ne v2, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method private isNetworkDeviceCached(Ljava/lang/String;)Z
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeviceProperies:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private setNetworkIFace()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotNetworkInterfaceThread;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotNetworkInterfaceThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotNetworkInterfaceThread;->start()V

    return-void
.end method

.method private syncAllConectedDevices()V
    .locals 7

    .prologue
    const-string v3, "MobileHotspotService"

    const-string v4, "syncAllConectedDevices "

    invoke-static {v3, v4}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->clear()V
    invoke-static {v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1500(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;)V

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAllAssocMac()[Ljava/lang/String;

    move-result-object v2

    .local v2, "items_mac":[Ljava/lang/String;
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAllAssocDevicename()[Ljava/lang/String;

    move-result-object v1

    .local v1, "items_dname":[Ljava/lang/String;
    if-nez v2, :cond_1

    :cond_0
    return-void

    :cond_1
    if-eqz v1, :cond_0

    const-string v3, "MobileHotspotService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[MHS_NEZZIMOM] Assoc list[mac] : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "MobileHotspotService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[MHS_NEZZIMOM] Assoc list[dname] : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAssocListCount()I

    move-result v3

    if-ge v0, v3, :cond_0

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    aget-object v4, v2, v0

    aget-object v5, v1, v0

    const/4 v6, 0x3

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->putList(Ljava/lang/String;Ljava/lang/String;I)V
    invoke-static {v3, v4, v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1600(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;Ljava/lang/String;I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private syncMacFilter([Ljava/lang/String;I)Z
    .locals 10
    .param p1, "macList"    # [Ljava/lang/String;
    .param p2, "mode"    # I

    .prologue
    array-length v1, p1

    .local v1, "filterCnt":I
    const/4 v5, 0x0

    .local v5, "ret":Z
    :try_start_0
    invoke-virtual {p0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->setMacFilterCount(I)Z

    move-result v5

    const-string v7, "MobileHotspotService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[MHS_NEZZIMOM] setMacFilterCount Result : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const-string v7, "MobileHotspotService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[MHS_NEZZIMOM] Mac Filtered Device Count : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz v5, :cond_0

    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v1, :cond_0

    :try_start_1
    aget-object v7, p1, v2

    invoke-virtual {p0, v2, v7}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->setMacFilterByIndex(ILjava/lang/String;)Z

    move-result v5

    const-string v7, "MobileHotspotService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[MHS_NEZZIMOM] setMacFilterByIndex Result : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " : Index ==> "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " Mac addr ==> "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    aget-object v9, p1, v2

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .end local v2    # "i":I
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    .restart local v2    # "i":I
    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_2

    .end local v0    # "e":Landroid/os/RemoteException;
    .end local v2    # "i":I
    :cond_0
    if-eqz v5, :cond_1

    :try_start_2
    invoke-virtual {p0, p2}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->setMacFilterMode(I)Z

    move-result v5

    const-string v7, "MobileHotspotService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[MHS_NEZZIMOM] setMacFilterMode Result : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_2

    :cond_1
    :goto_3
    const/4 v6, 0x0

    .local v6, "temp":I
    :try_start_3
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getMacFilterCount()I

    move-result v6

    const-string v7, "MobileHotspotService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[MHS_NEZZIMOM] MAC count : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_3

    :goto_4
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_5
    if-ge v3, v6, :cond_2

    :try_start_4
    invoke-virtual {p0, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getMacFilterByIndex(I)Ljava/lang/String;

    move-result-object v4

    .local v4, "macAddr":Ljava/lang/String;
    const-string v7, "MobileHotspotService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[MHS_NEZZIMOM] MAC List : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_4
    .catch Landroid/os/RemoteException; {:try_start_4 .. :try_end_4} :catch_4

    .end local v4    # "macAddr":Ljava/lang/String;
    :goto_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .end local v3    # "j":I
    .end local v6    # "temp":I
    :catch_2
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_3

    .end local v0    # "e":Landroid/os/RemoteException;
    .restart local v6    # "temp":I
    :catch_3
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_4

    .end local v0    # "e":Landroid/os/RemoteException;
    .restart local v3    # "j":I
    :catch_4
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_6

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    return v5
.end method

.method private updateNetworkDeviceProperty(Ljava/lang/String;)V
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkDeviceProperties(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "properties":[Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-direct {p0, p1, v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->addNetworkDeviceProperties(Ljava/lang/String;[Ljava/lang/String;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public addMacFilter(Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 4
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "mode"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Add Mac Filter Info >> Mac Addr : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " - mode : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " - exist : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getListItem(Ljava/lang/String;)Ljava/util/HashMap;
    invoke-static {v3, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1900(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    sget v0, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_MAC_FILTER_OFF:I

    if-ne p3, v0, :cond_0

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Add New MAC filter : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->putList(Ljava/lang/String;Ljava/lang/String;I)V
    invoke-static {v0, p1, p2, p3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1600(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;Ljava/lang/String;I)V

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Filter Mode : Off, Add New Mac : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->listAllowedDevices()[Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move v0, v1

    :goto_0
    return v0

    :cond_0
    sget v0, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_MAC_FILTER_DENY:I

    if-ne p3, v0, :cond_1

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    invoke-direct {p0, v0, p3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->syncMacFilter([Ljava/lang/String;I)Z

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Filter Mode : Deny, Filter List : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_1
    if-nez p1, :cond_2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->listAllowedDevices()[Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->syncMacFilter([Ljava/lang/String;I)Z

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Filter Mode : Allow, Filter List is existed list : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->listAllowedDevices()[Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    move v0, v1

    goto :goto_0

    :cond_2
    if-eqz p1, :cond_3

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getListItem(Ljava/lang/String;)Ljava/util/HashMap;
    invoke-static {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1900(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v0

    if-nez v0, :cond_3

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Add New MAC filter : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->putList(Ljava/lang/String;Ljava/lang/String;I)V
    invoke-static {v0, p1, p2, p3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1600(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;Ljava/lang/String;I)V

    const-string v0, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Filter Mode : Allow, Add New Mac : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->listAllowedDevices()[Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->listAllowedDevices()[Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->syncMacFilter([Ljava/lang/String;I)Z

    move v0, v1

    goto/16 :goto_0

    :cond_3
    const/4 v0, 0x0

    goto/16 :goto_0
.end method

.method public addMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pAddMacFilterAllowList(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public addMacFilterDenyList(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pAddMacFilterDenyList(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public clearNATRule()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pNatRuleClear()V

    return-void
.end method

.method public clearPortFilterRule()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->clearPortFilterRule()V

    return-void
.end method

.method public clearPortForwardingrRule()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->clearPortForwardRule()V

    return-void
.end method

.method public connectFromRemoteDevice(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "ipAddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[MHS_NEZZIMOM] Add connected device >> item : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    const/4 v1, 0x0

    const/4 v2, 0x3

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->putList(Ljava/lang/String;Ljava/lang/String;I)V
    invoke-static {v0, p1, v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1600(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;Ljava/lang/String;I)V

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->addConnectedNotification()V

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public createSoftAPService()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->createSoftAP()I

    move-result v0

    return v0
.end method

.method public deAuthMac(Ljava/lang/String;)Z
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDeAuthMac(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public destroySoftAPService()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->destroySoftAP()I

    move-result v0

    return v0
.end method

.method public dhcpDisable(Z)Z
    .locals 1
    .param p1, "persistSetting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpDisableThread;

    invoke-direct {v0, p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpDisableThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDhcpEnableThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDhcpEnableThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const/4 v0, 0x0

    return v0
.end method

.method public dhcpEnable(Z)Z
    .locals 1
    .param p1, "persistSetting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpEnableThread;

    invoke-direct {v0, p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpEnableThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDhcpDisableThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDhcpDisableThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const/4 v0, 0x0

    return v0
.end method

.method public dhcpRestart()Z
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpRestartThread;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DhcpRestartThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDhcpRestartThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDhcpRestartThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const/4 v0, 0x1

    return v0
.end method

.method public disable(Z)Z
    .locals 3
    .param p1, "persistSetting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotDisableThread;

    invoke-direct {v0, p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotDisableThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMhpDisableThread:Ljava/lang/Thread;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMhpDisableThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "wifi_vzw_mobile_hotspot_on"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    return v2
.end method

.method public disableNatMasquerade()Z
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "MobileHotspotService"

    const-string v1, "[MHS_NEZZIMOM] Can\'t get network iface!!"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDisableNatMasquerade(Ljava/lang/String;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public disconnectDevice(Ljava/lang/String;)Z
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->removeAtList(Ljava/lang/String;)V
    invoke-static {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$2100(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pMacFilterremoveAllowedList(Ljava/lang/String;)I

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public enable(Z)Z
    .locals 3
    .param p1, "persistSetting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    iget-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isAirplaneModeOn:Z

    if-eqz v1, :cond_0

    const-string v0, "MobileHotspotService"

    const-string v1, "[MHS_NEZZIMOM] Airplane mode is on, so return enabling"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const-string v1, "MobileHotspotService"

    const-string v2, "[MHS_NEZZIMOM] Mobile Hotspot enable"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->openSoftAP()I

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mEventLoop:Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

    const/16 v2, 0xd

    invoke-virtual {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;->onMobileHotspotStateChanged(I)V

    iget-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOnOffWlP2pService:Z

    if-nez v1, :cond_1

    iput-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOnOffWlP2pService:Z

    :cond_1
    new-instance v1, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotEnableThread;

    invoke-direct {v1, p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$MobileHotspotEnableThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;Z)V

    iput-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMhpEnableThread:Ljava/lang/Thread;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMhpEnableThread:Ljava/lang/Thread;

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "wifi_vzw_mobile_hotspot_on"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0
.end method

.method protected finalize()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    invoke-super {p0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot$Stub;->finalize()V

    return-void
.end method

.method public get802Mode()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAllow11B()I

    move-result v0

    return v0
.end method

.method public getAllAssocDevicename()[Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAllAssocDevicename()[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAllAssocMac()[Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAllAssocMac()[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAllowedAllDevcie()I
    .locals 3

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhp_allowed_all_device"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public getAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAssocIpHostname(Ljava/lang/String;)[Ljava/lang/String;
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAssocIpHostname(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAssocListCount()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAssocListCount()I

    move-result v0

    return v0
.end method

.method public getAuthentication()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetAuthentication()I

    move-result v0

    return v0
.end method

.method public getBroadcastChannel()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetSocialChannel()I

    move-result v0

    return v0
.end method

.method public getBroadcastSSID()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetHideSSID()I

    move-result v0

    return v0
.end method

.method public getDNS1Sample()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdGetDNS1()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDNS2Sample()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdGetDNS2()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDataUsageTime()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getDefaultCountryCode()I
    .locals 3

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhp_country"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public getDhcpDNS1()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetDHCPDNS1()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDhcpDNS2()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetDHCPDNS2()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDhcpEndIp()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetDHCPEndAddress()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDhcpGateway()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetDHCPGateway()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDhcpMask()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetDHCPMask()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDhcpStartIp()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetDHCPStartAddress()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEncryption()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetEncryption()I

    move-result v0

    return v0
.end method

.method public getEndIPSample()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdGetEndIP()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getFrequency()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetFrequency()I

    move-result v0

    return v0
.end method

.method public getGatewaySample()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdGetGateway()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIPAddress()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getMacAddress()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getMacFilterByIndex(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetMacFilterByIndex(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMacFilterCount()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetMacFilterCount()I

    move-result v0

    return v0
.end method

.method public getMacFilterMode()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetMacFilterMode()I

    move-result v0

    return v0
.end method

.method public getMaxClients()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetMaxClients()I

    move-result v0

    return v0
.end method

.method public getMobileHotspotState()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetSSID()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNetInterface()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetNetInterface()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPortFilteringList()[Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getPortforwardingList()[Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getSSIDService()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetSSID()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSoftapIsolation()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetSoftapIsolation()Z

    move-result v0

    return v0
.end method

.method public getStartIPSample()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdGetStartIP()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStaticIp()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetStaticIP()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStaticSubnet()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetStaticSubnet()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSubnetMaskSample()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdGetSubnetMask()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWEPKey1()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetWEPKey1()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWEPKey2()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetWEPKey2()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWEPKey3()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetWEPKey3()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWEPKey4()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetWEPKey4()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWEPKeyIndex()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetWEPIndex()I

    move-result v0

    return v0
.end method

.method public getWPAKey()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pGetWPAKey()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public init()Z
    .locals 3

    .prologue
    const-string v0, "MobileHotspotService"

    const-string v1, "[MHS_NEZZIMOM] Mobile Hotspot Service Init!!"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-direct {v0, v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;-><init>(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mEventLoop:Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    invoke-direct {v0, p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPService;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeviceProperies:Ljava/util/HashMap;

    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getMobileHotspotServiceProxy()Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mEventLoop:Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->getInstance(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/MHPEventLoop;)Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-direct {v0, v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;-><init>(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mBatteryUsageEnabler:Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOnOffWlP2pService:Z

    const/4 v0, 0x1

    return v0
.end method

.method public initHSLService()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->openSoftAP()I

    move-result v0

    return v0
.end method

.method public initIpTable()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    invoke-static {}, Lcom/lge/wifi/impl/mobilehotspot/iptables;->initIptables()V

    return-void
.end method

.method public insertDeniedList(Ljava/lang/String;)Z
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[MHS_NEZZIMOM] Current denied list(inserted) : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0
.end method

.method public isDhcpEnabled()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public isEnabled()Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[NEZZIMOM] isEnabled : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z

    return v0
.end method

.method public isMhsDataAvailable()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    const-string v5, "phone"

    invoke-static {v5}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v5

    iput-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v5, :cond_0

    :goto_0
    return v4

    :cond_0
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    .local v2, "tm":Landroid/telephony/TelephonyManager;
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->getDataState()I

    move-result v1

    .local v1, "state":I
    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->isNetworkRoaming()Z

    move-result v0

    .local v0, "isRoaming":Z
    const-string v5, "MobileHotspotService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[antonoi]phone.getDataState"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const-string v5, "MobileHotspotService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[antonoi]phone.isNetworkRoaming"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v5

    if-eq v5, v3, :cond_1

    if-eq v0, v3, :cond_1

    :goto_1
    move v4, v3

    goto :goto_0

    :cond_1
    move v3, v4

    goto :goto_1
.end method

.method public isUsed()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mOnOffWlP2pService:Z

    return v0
.end method

.method public listAllowedDevices()[Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    iput-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->allowedlist:Ljava/util/ArrayList;

    const-string v4, "MobileHotspotService"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MHS_NEZZIMOM] listAllowedDevices.getSize(): "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getSize()I
    invoke-static {v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1700(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getList()Ljava/util/HashMap;
    invoke-static {v4}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1800(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;)Ljava/util/HashMap;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .local v3, "item":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/HashMap<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;>;"
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .local v0, "device":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    const/4 v5, 0x2

    if-ne v4, v5, :cond_1

    const-string v5, "MobileHotspotService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MHS_NEZZIMOM] listAllowedDevices: "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    invoke-virtual {v4}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->getMacAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->allowedlist:Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    invoke-virtual {v4}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->getMacAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v0    # "device":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;"
    .end local v2    # "i$":Ljava/util/Iterator;
    .end local v3    # "item":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/HashMap<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;Ljava/lang/Integer;>;>;"
    :cond_2
    const-string v4, "MobileHotspotService"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MHS_NEZZIMOM] Allowed list : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->allowedlist:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v4, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->allowedlist:Ljava/util/ArrayList;

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->allowedlist:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    new-array v5, v5, [Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Ljava/lang/String;

    return-object v4
.end method

.method public listConnectedDevices()[Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .local v0, "connectedDeviceMaclist":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getConnectedDeviceKeyList()Ljava/util/ArrayList;

    move-result-object v1

    .local v1, "connectedDevicelist":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;>;"
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    .local v2, "device":Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
    invoke-virtual {v2}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->getMacAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v2    # "device":Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v4

    new-array v4, v4, [Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Ljava/lang/String;

    return-object v4
.end method

.method public listConnectedDevicesname()[Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .local v0, "connectedDeviceNamelist":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getConnectedDeviceKeyList()Ljava/util/ArrayList;

    move-result-object v1

    .local v1, "connectedDevicelist":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;>;"
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    .local v2, "device":Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
    invoke-virtual {v2}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;->getDeviceName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v2    # "device":Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v4

    new-array v4, v4, [Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Ljava/lang/String;

    return-object v4
.end method

.method public loadDriverService()I
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getDefaultCountryCode()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->loadP2PDriver(I)I

    move-result v0

    return v0
.end method

.method public mhsCdmaDataConnect()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x1

    const-string v5, "phone"

    invoke-static {v5}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v5

    iput-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v5, :cond_1

    const/4 v4, 0x0

    :cond_0
    :goto_0
    return v4

    :cond_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->getDataState()I

    move-result v3

    .local v3, "state":I
    const-string v5, "MobileHotspotService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[antonoi]phone.getDataState"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x1

    .local v1, "result":Z
    const/4 v2, 0x3

    .local v2, "retry_count":I
    :goto_1
    if-lez v2, :cond_0

    :try_start_0
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->enableDataConnectivity()Z

    move-result v1

    if-ne v1, v4, :cond_2

    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Enabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v5, "MobileHotspotService"

    const-string v6, "Exception - Data Call Not Enabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    :try_start_1
    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Not Enabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v2, v2, -0x1

    goto :goto_1
.end method

.method public mhsCdmaDataDisconnect()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x1

    const-string v5, "phone"

    invoke-static {v5}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v5

    iput-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v5, :cond_1

    const/4 v4, 0x0

    :cond_0
    :goto_0
    return v4

    :cond_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->getDataState()I

    move-result v3

    .local v3, "state":I
    const-string v5, "MobileHotspotService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[antonoi]phone.getDataState"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x1

    .local v1, "result":Z
    const/4 v2, 0x3

    .local v2, "retry_count":I
    :goto_1
    if-lez v2, :cond_0

    :try_start_0
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->disableDataConnectivity()Z

    move-result v1

    if-ne v1, v4, :cond_2

    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Disabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v5, "MobileHotspotService"

    const-string v6, "Exception - Data Call Not Disabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    :try_start_1
    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Not Disabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v2, v2, -0x1

    goto :goto_1
.end method

.method public mhsCdmaDataRestart()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x1

    const-string v5, "phone"

    invoke-static {v5}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v5

    iput-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v5, :cond_1

    const/4 v4, 0x0

    :cond_0
    :goto_0
    return v4

    :cond_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->getDataState()I

    move-result v3

    .local v3, "state":I
    const-string v5, "MobileHotspotService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[antonoi]phone.getDataState"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x1

    .local v1, "result":Z
    const/4 v2, 0x3

    .local v2, "retry_count":I
    :goto_1
    if-lez v2, :cond_2

    :try_start_0
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->disableDataConnectivity()Z

    move-result v1

    if-ne v1, v4, :cond_3

    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Disabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    :cond_2
    :goto_2
    const/4 v1, 0x1

    const/4 v2, 0x3

    :goto_3
    if-lez v2, :cond_0

    :try_start_1
    iget-object v5, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v5}, Lcom/android/internal/telephony/ITelephony;->enableDataConnectivity()Z

    move-result v1

    if-ne v1, v4, :cond_4

    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Enabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v5, "MobileHotspotService"

    const-string v6, "Exception - Data Call Not Enabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_3
    :try_start_2
    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Not Disabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_1

    add-int/lit8 v2, v2, -0x1

    goto :goto_1

    :catch_1
    move-exception v0

    .restart local v0    # "e":Landroid/os/RemoteException;
    const-string v5, "MobileHotspotService"

    const-string v6, "Exception - Data Call Not Disabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_4
    :try_start_3
    const-string v5, "MobileHotspotService"

    const-string v6, "[antonoi]Data Call Not Enabled"

    invoke-static {v5, v6}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_0

    add-int/lit8 v2, v2, -0x1

    goto :goto_3
.end method

.method public removeAllAllowedDevices()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->clear()V
    invoke-static {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1500(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;)V

    const/4 v0, 0x1

    return v0
.end method

.method public removeAllConnectedDevices()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mConnectedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->clear()V
    invoke-static {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1500(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;)V

    const/4 v0, 0x1

    return v0
.end method

.method public removeAllowedDevice(Ljava/lang/String;)Z
    .locals 3
    .param p1, "macAddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    if-eqz p1, :cond_0

    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[MHS_NEZZIMOM] Remove allowed device >> item : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->removeAtList(Ljava/lang/String;)V
    invoke-static {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$2100(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pMacFilterremoveAllowedList(Ljava/lang/String;)I

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public removeAlltheList()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2premoveAlltheList()I

    const/4 v0, 0x1

    return v0
.end method

.method public removeDeniedList(Ljava/lang/String;)Z
    .locals 3
    .param p1, "mac"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[MHS_NEZZIMOM] Current denied list(removed) : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mDeniedList:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pMacFilterremoveDeniedList(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public set802Mode(I)Z
    .locals 3
    .param p1, "mode"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const-string v0, "MobileHotspotService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[DPKIM] set802Mode : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetAllow11B(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setAllowAll(Z)Z
    .locals 1
    .param p1, "persistSetting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public setAuthentication(I)Z
    .locals 1
    .param p1, "option"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetAuthentication(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setBatteryUsageTime(I)Z
    .locals 1
    .param p1, "time"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mBatteryUsageEnabler:Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPBatteryUsageEnabler;->setUsageTime(I)V

    const/4 v0, 0x1

    return v0
.end method

.method public setBroadcastChannel(I)Z
    .locals 1
    .param p1, "channel"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetSocialChannel(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setBroadcastSSID(I)I
    .locals 1
    .param p1, "command"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetHideSSID(I)I

    move-result v0

    return v0
.end method

.method public setCountryCode(I)I
    .locals 1
    .param p1, "countrycode"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->setCountryCode(I)I

    move-result v0

    return v0
.end method

.method public setDNS1Sample(Ljava/lang/String;)I
    .locals 1
    .param p1, "dns1"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdSetDNS1(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setDNS2Sample(Ljava/lang/String;)I
    .locals 1
    .param p1, "dns2"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdSetDNS2(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setDefaultCountryCode(I)V
    .locals 2
    .param p1, "wlan_country"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhp_country"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    return-void
.end method

.method public setDhcpDNS1(Ljava/lang/String;)Z
    .locals 3
    .param p1, "dns1"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetDHCPDNS1(Ljava/lang/String;)I

    move-result v0

    .local v0, "ret":I
    if-ne v0, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpDNS2(Ljava/lang/String;)Z
    .locals 3
    .param p1, "dns2"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetDHCPDNS2(Ljava/lang/String;)I

    move-result v0

    .local v0, "ret":I
    if-ne v0, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpEndIp(Ljava/lang/String;)Z
    .locals 3
    .param p1, "ipaddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetDHCPEndAddress(Ljava/lang/String;)I

    move-result v0

    .local v0, "ret":I
    if-ne v0, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpGateway(Ljava/lang/String;)Z
    .locals 3
    .param p1, "gateway"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetDHCPGateway(Ljava/lang/String;)I

    move-result v0

    .local v0, "ret":I
    if-ne v0, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpMask(Ljava/lang/String;)Z
    .locals 3
    .param p1, "mask"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetDHCPMask(Ljava/lang/String;)I

    move-result v0

    .local v0, "ret":I
    if-ne v0, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpStartIp(Ljava/lang/String;)Z
    .locals 3
    .param p1, "ipaddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetDHCPStartAddress(Ljava/lang/String;)I

    move-result v0

    .local v0, "ret":I
    if-ne v0, v1, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setEmergencyCall(Z)V
    .locals 4
    .param p1, "_isECM"    # Z

    .prologue
    const/4 v3, 0x1

    iput-boolean p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isECM:Z

    iget-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isECM:Z

    if-eqz v1, :cond_0

    const-string v1, "MobileHotspotService"

    const-string v2, "[MHS_NEZZIMOM] Exit Emergency call mode)"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mIsMobileHotspotOn:Z

    if-eqz v1, :cond_1

    iput-boolean v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z

    const/4 v1, 0x1

    :try_start_0
    invoke-virtual {p0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->disable(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->isRecoverAfterECM:Z

    goto :goto_0
.end method

.method public setEncryption(I)Z
    .locals 1
    .param p1, "command"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetEncryption(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setEndIPSample(Ljava/lang/String;)I
    .locals 1
    .param p1, "endip"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdSetEndIP(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setForward()Z
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "MobileHotspotService"

    const-string v1, "[MHS_NEZZIMOM] Can\'t get network iface!!"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->setNatForward(Ljava/lang/String;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public setFrequency(I)V
    .locals 1
    .param p1, "value"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetFrequency(I)V

    return-void
.end method

.method public setGatewaySample(Ljava/lang/String;)I
    .locals 1
    .param p1, "gateway"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdSetGateway(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setIsolationEnabled(Z)Z
    .locals 1
    .param p1, "enable"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->setIsolationEnabled(Z)Z

    move-result v0

    return v0
.end method

.method public setMacFilterByIndex(ILjava/lang/String;)Z
    .locals 1
    .param p1, "index"    # I
    .param p2, "bssid"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetMacFilterByIndex(ILjava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public setMacFilterCount(I)Z
    .locals 1
    .param p1, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetMacFilterCount(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setMacFilterMode(I)Z
    .locals 1
    .param p1, "mode"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetMacFilterMode(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setMacaddracl(I)Z
    .locals 1
    .param p1, "value"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pMacaddracl(I)Z

    const/4 v0, 0x1

    return v0
.end method

.method public setMasquerade()Z
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "MobileHotspotService"

    const-string v1, "[MHS_NEZZIMOM] Can\'t get network iface!!"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pNatMasqurade(Ljava/lang/String;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public setMaxAssoc(I)Z
    .locals 1
    .param p1, "value"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetMaxAssoc(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setMaxClients(I)Z
    .locals 1
    .param p1, "value"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetMaxClients(I)Z

    const/4 v0, 0x1

    return v0
.end method

.method public setMobileHotspotState(I)V
    .locals 0
    .param p1, "state"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iput p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMobileHotspotState:I

    return-void
.end method

.method public setMssChange()Z
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, "MobileHotspotService"

    const-string v1, "[MHS_NEZZIMOM] Can\'t get network iface!!"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->setMssSize(Ljava/lang/String;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public setName(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetSSID(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public setNetInterface(Ljava/lang/String;)V
    .locals 1
    .param p1, "ifs"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetNetInterface(Ljava/lang/String;)V

    return-void
.end method

.method public setPortFiltering(IIII)Z
    .locals 6
    .param p1, "start"    # I
    .param p2, "end"    # I
    .param p3, "portType"    # I
    .param p4, "addORdel"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    const/4 v0, 0x0

    .local v0, "protocol":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "rule":Ljava/lang/String;
    if-ne v5, p3, :cond_0

    const-string v0, "udp"

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v2, v1, p4}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->setPortFilterRule(Ljava/lang/String;I)V

    const-string v2, "MobileHotspotService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[antonio] Port Filter Rule : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    return v5

    :cond_0
    const-string v0, "tcp"

    goto :goto_0
.end method

.method public setPortforwarding(ILjava/lang/String;I)Z
    .locals 5
    .param p1, "port"    # I
    .param p2, "addr"    # Ljava/lang/String;
    .param p3, "addORdel"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    new-instance v0, Ljava/lang/Integer;

    invoke-direct {v0, p1}, Ljava/lang/Integer;-><init>(I)V

    .local v0, "intport":Ljava/lang/Integer;
    invoke-virtual {v0}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    .local v1, "strport":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-direct {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->getNetworkIface()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v1, p2, p3}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->setPortForwardRule(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    const-string v2, "MobileHotspotService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[antonio] Port Filter Rule >>  %d %s "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v2, 0x1

    return v2
.end method

.method public setSSIDService(Ljava/lang/String;)I
    .locals 1
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetSSID(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setSoftapIsolation(Z)Z
    .locals 1
    .param p1, "enabled"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetSoftapIsolation(Z)Z

    move-result v0

    return v0
.end method

.method public setStartIPSample(Ljava/lang/String;)I
    .locals 1
    .param p1, "startip"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdSetStartIP(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setStaticIp(Ljava/lang/String;)V
    .locals 1
    .param p1, "ip"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetStaticIP(Ljava/lang/String;)V

    return-void
.end method

.method public setStaticSubnet(Ljava/lang/String;)V
    .locals 1
    .param p1, "netmask"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetStaticSubnet(Ljava/lang/String;)V

    return-void
.end method

.method public setSubnetMaskSample(Ljava/lang/String;)I
    .locals 1
    .param p1, "mask"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pDhcpdSetSubnetMask(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setTxPower(I)I
    .locals 1
    .param p1, "txPower"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetTxPower(I)I

    move-result v0

    return v0
.end method

.method public setWEPKey1(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetWEPKey1(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public setWEPKey2(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetWEPKey2(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public setWEPKey3(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetWEPKey3(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public setWEPKey4(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetWEPKey4(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public setWEPKeyIndex(I)Z
    .locals 1
    .param p1, "index"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetWEPIndex(I)I

    const/4 v0, 0x1

    return v0
.end method

.method public setWPAKey(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pSetWPAKey(Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public unloadDriverService()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->unloadP2PDriver()I

    move-result v0

    return v0
.end method

.method public updateAllowedDevice(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "oldMacAddr"    # Ljava/lang/String;
    .param p2, "newMacAddr"    # Ljava/lang/String;
    .param p3, "newName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const-string v1, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Check exist device : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getListItem(Ljava/lang/String;)Ljava/util/HashMap;
    invoke-static {v3, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1900(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p1, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->getListItem(Ljava/lang/String;)Ljava/util/HashMap;
    invoke-static {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$1900(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v1, "MobileHotspotService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHS_NEZZIMOM] Update >> from "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mAllowedDeviceListManager:Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;

    const/4 v2, 0x2

    # invokes: Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->updateList(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    invoke-static {v1, p1, p2, p3, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;->access$2000(Lcom/lge/wifi/impl/mobilehotspot/MHPService$DeviceListManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->mMHPManager:Lcom/lge/wifi/impl/mobilehotspot/MHPManager;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPManager;->p2pMacFilterremoveAllowedList(Ljava/lang/String;)I

    invoke-virtual {p0, p2, v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPService;->addMacFilterAllowList(Ljava/lang/String;I)Z

    const/4 v0, 0x1

    :cond_0
    return v0
.end method
