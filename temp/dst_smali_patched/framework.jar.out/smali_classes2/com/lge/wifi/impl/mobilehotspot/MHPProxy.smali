.class public Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;
.super Ljava/lang/Object;
.source "MHPProxy.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/mobilehotspot/MHPProxy$Callback;
    }
.end annotation


# static fields
.field public static final SERVICE_NAME:Ljava/lang/String; = "mobilehotspot"

.field public static final STATE_DHCP_ERROR:I = -0x1

.field public static final STATE_DHCP_OFF:I = 0x15

.field public static final STATE_DHCP_ON:I = 0x14

.field public static final STATE_MHP_ERROR:I = -0x1

.field public static final STATE_MHP_OFF:I = 0xa

.field public static final STATE_MHP_ON:I = 0xc

.field public static final STATE_MHP_RESUME:I = 0xf

.field public static final STATE_MHP_SUSPEND:I = 0xe

.field public static final STATE_MHP_TURNING_OFF:I = 0xb

.field public static final STATE_MHP_TURNING_ON:I = 0xd

.field public static final STATE_STATION_ASSOC:I = 0x1e

.field public static final STATE_STATION_DISASSOC:I = 0x1f

.field private static mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;


# instance fields
.field public final TAG:Ljava/lang/String;

.field private mCallback:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/wifi/impl/mobilehotspot/MHPProxy$Callback;",
            ">;"
        }
    .end annotation
.end field

.field private mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "MobileHotspotProxy"

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->TAG:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mCallback:Ljava/util/ArrayList;

    return-void
.end method

.method public constructor <init>(Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;)V
    .locals 2
    .param p1, "service"    # Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "MobileHotspotProxy"

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->TAG:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mCallback:Ljava/util/ArrayList;

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "service is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iput-object p1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    return-void
.end method

.method private createDevice([Ljava/lang/String;[Ljava/lang/String;)Ljava/util/Set;
    .locals 5
    .param p1, "devicelistmac"    # [Ljava/lang/String;
    .param p2, "devicename"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Set",
            "<",
            "Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;",
            ">;"
        }
    .end annotation

    .prologue
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .local v0, "devices":Ljava/util/Set;, "Ljava/util/Set<Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    array-length v2, p2

    if-ge v1, v2, :cond_0

    aget-object v2, p1, v1

    aget-object v3, p2, v1

    invoke-direct {p0, v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->getRemoteDevice(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const-string v2, "MobileHotspotProxy"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[MHP_GOOKY] create device >> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getMobileHotspotServiceProxy()Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;
    .locals 4

    .prologue
    const-string v2, "mobilehotspot"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    if-nez v2, :cond_0

    const-string v2, "MHPProxy"

    const-string v3, "[MHP_GOOKY] Create Proxy Object.."

    invoke-static {v2, v3}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    move-result-object v1

    .local v1, "service":Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;
    new-instance v2, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    invoke-direct {v2, v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;-><init>(Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;)V

    sput-object v2, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    .end local v1    # "service":Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;
    :cond_0
    sget-object v2, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    return-object v2
.end method

.method private getRemoteDevice(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;
    .locals 1
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "devicename"    # Ljava/lang/String;

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;

    invoke-direct {v0, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public addConnectedDevice(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "ipAddr"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->connectFromRemoteDevice(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public addMacFilter(Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 2
    .param p1, "macAddr"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "mode"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->addMacFilter(Ljava/lang/String;Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->changedAllowedDevice()V

    const/4 v1, 0x1

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public declared-synchronized addMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->addMacFilterAllowList(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public declared-synchronized addMacFilterDenyList(Ljava/lang/String;I)Z
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->addMacFilterDenyList(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public changedAllowedDevice()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mCallback:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mCallback:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy$Callback;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy$Callback;->onChangedAllowedDevice()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public clearPortFilterRule()V
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->clearPortFilterRule()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public clearPortForwardingrRule()V
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->clearPortForwardingrRule()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public dchpRestart()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->dhcpRestart()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public deAuthMac(Ljava/lang/String;)Z
    .locals 2
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->deAuthMac(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public diableDhcpServer(Z)V
    .locals 4
    .param p1, "on"    # Z

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Dhcp Power off >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->dhcpDisable(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public declared-synchronized disableMobileHotspot()V
    .locals 2

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->disable(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public doClearNATRule()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    const-string v2, "[MHP_GOOKY] MobileHotspot Clear NAT Rule"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->clearNATRule()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public doDisableNATMasq()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    const-string v2, "[antonio] MobileHotspot Clear NAT Rule"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->disableNatMasquerade()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public doMhsCdmaDataConnect()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    const-string v2, "[MHP_GOOKY] MobileHotspot 3GData MhsCdmaDataConnect"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->mhsCdmaDataConnect()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public doMhsCdmaDataDisconnect()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    const-string v2, "[MHP_GOOKY] MobileHotspot 3GData MhsCdmaDataDisconnect"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->mhsCdmaDataDisconnect()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableDhcpServer(Z)V
    .locals 4
    .param p1, "on"    # Z

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Dhcp Power on >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->dhcpEnable(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableMhsCdmaDataRestart()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    const-string v2, "[MHP_GOOKY] MobileHotspot 3GData Restart"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->mhsCdmaDataRestart()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public declared-synchronized enableMobileHotspot(Z)Z
    .locals 4
    .param p1, "on"    # Z

    .prologue
    monitor-enter p0

    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Enable MobileHotspot >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->enable(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public get80211Mode()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->get802Mode()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getAllConnectedDeviceList()Ljava/util/Set;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;",
            ">;"
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->listConnectedDevices()[Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->listConnectedDevicesname()[Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->createDevice([Ljava/lang/String;[Ljava/lang/String;)Ljava/util/Set;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAllowedDevicesList()Ljava/util/Set;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Lcom/lge/wifi/impl/mobilehotspot/NetworkDevice;",
            ">;"
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->listAllowedDevices()[Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->listConnectedDevicesname()[Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->createDevice([Ljava/lang/String;[Ljava/lang/String;)Ljava/util/Set;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getAssocIPAddress(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAssocIpHostname(Ljava/lang/String;)[Ljava/lang/String;
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getAssocIpHostname(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAssocListCount()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getAssocListCount()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getAuthentication()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getAuthentication()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getBroadcastChannel()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getBroadcastChannel()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public declared-synchronized getBroadcastSSID()I
    .locals 2

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getBroadcastSSID()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, -0x1

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public getConnecteddDevicesList()[Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->listConnectedDevices()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDhcpDns1()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getDhcpDNS1()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDhcpDns2()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getDhcpDNS2()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDhcpEndIp()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getDhcpEndIp()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDhcpGateway()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getDhcpGateway()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDhcpMask()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getDhcpMask()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDhcpStartIp()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getDhcpStartIp()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getEncryption()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getEncryption()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getFrequency()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getFrequency()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getMacFilterByIndex(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getMacFilterByIndex(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getMacFilterCount()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getMacFilterCount()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public declared-synchronized getMacFilterMode()I
    .locals 2

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getMacFilterMode()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, -0x1

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public getMaxClients()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getMaxClients()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getMobileHotspotState()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getMobileHotspotState()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getName()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getName()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getPortFilteringList()[Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getPortFilteringList()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getPortforwardingList()[Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getPortforwardingList()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getSoftapIsolation()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getSoftapIsolation()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getStaticIp()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getStaticIp()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getStaticSubnet()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getStaticSubnet()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getWEPKey1()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getWEPKey1()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getWEPKey2()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getWEPKey2()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getWEPKey3()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getWEPKey3()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getWEPKey4()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getWEPKey4()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getWEPKeyIndex()I
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getWEPKeyIndex()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getWPAKey()Ljava/lang/String;
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->getWPAKey()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public initIpTable()V
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->initIpTable()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public insertDeniedList(Ljava/lang/String;)V
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->insertDeniedList(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isMHPEnabled()Z
    .locals 1

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->isEnabled()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isMhsAvailable()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    const-string v2, "[MHP_GOOKY] MobileHotspot isMhsDataAvailable"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->isMhsDataAvailable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isUsed()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->isUsed()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public registCallback(Lcom/lge/wifi/impl/mobilehotspot/MHPProxy$Callback;)V
    .locals 1
    .param p1, "cb"    # Lcom/lge/wifi/impl/mobilehotspot/MHPProxy$Callback;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mCallback:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public removeAllAllowedDevices()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->removeAllAllowedDevices()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public removeAllConnectedDevices()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->removeAllConnectedDevices()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public removeAllowedDevice(Ljava/lang/String;)Z
    .locals 4
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] removeAllowedDevice >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->removeAllowedDevice(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public removeAlltheList()V
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->removeAlltheList()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public removeDeniedList(Ljava/lang/String;)V
    .locals 2
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->removeDeniedList(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public set80211Mode(I)V
    .locals 2
    .param p1, "mode"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->set802Mode(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setAllowAllPort(Z)Z
    .locals 2
    .param p1, "allow"    # Z

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setAllowAll(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setAuthentication(I)Z
    .locals 2
    .param p1, "value"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setAuthentication(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setBroadcastChannel(I)V
    .locals 1
    .param p1, "channel"    # I

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setBroadcastChannel(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized setBroadcastSSID(I)V
    .locals 1
    .param p1, "command"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setBroadcastSSID(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public setCountryCode(I)I
    .locals 2
    .param p1, "countrycode"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setCountryCode(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpDns1(Ljava/lang/String;)Z
    .locals 2
    .param p1, "dns1"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setDhcpDNS1(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setDhcpServerEndIp(Ljava/lang/String;)V
    .locals 4
    .param p1, "ip"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Set Dhcp End IP >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setDhcpEndIp(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setDhcpServerGateway(Ljava/lang/String;)V
    .locals 4
    .param p1, "ip"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Set Dhcp Gateway >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setDhcpGateway(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setDhcpServerMask(Ljava/lang/String;)V
    .locals 4
    .param p1, "ip"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Set Dhcp Mask >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setDhcpMask(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setDhcpServerStartIp(Ljava/lang/String;)V
    .locals 4
    .param p1, "ip"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "MobileHotspotProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[MHP_GOOKY] Set Dhcp Start IP >> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/MHPLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setDhcpStartIp(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setEmergencyCall(Z)V
    .locals 1
    .param p1, "isECM"    # Z

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setEmergencyCall(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public setEncryption(I)Z
    .locals 2
    .param p1, "value"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setEncryption(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setForward()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setForward()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setFrequency(I)V
    .locals 1
    .param p1, "value"    # I

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setFrequency(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public declared-synchronized setMacFilterByIndex(ILjava/lang/String;)Z
    .locals 2
    .param p1, "index"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMacFilterByIndex(ILjava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public setMacFilterCount(I)Z
    .locals 2
    .param p1, "count"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMacFilterCount(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public declared-synchronized setMacFilterMode(I)Z
    .locals 2
    .param p1, "mode"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMacFilterMode(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public setMacaddracl(I)Z
    .locals 2
    .param p1, "value"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMacaddracl(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setMasquerade()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMasquerade()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public declared-synchronized setMaxAssoc(I)Z
    .locals 2
    .param p1, "value"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMaxAssoc(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public declared-synchronized setMaxClients(I)Z
    .locals 2
    .param p1, "value"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMaxClients(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public setMobileHotspotState(I)V
    .locals 2
    .param p1, "state"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMobileHotspotState(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setMssChange()Z
    .locals 2

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setMssChange()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setName(Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setName(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public setPortFiltering(IIII)Z
    .locals 2
    .param p1, "start"    # I
    .param p2, "end"    # I
    .param p3, "type"    # I
    .param p4, "addORdel"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2, p3, p4}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setPortFiltering(IIII)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setPortforwarding(ILjava/lang/String;I)Z
    .locals 2
    .param p1, "port"    # I
    .param p2, "addr"    # Ljava/lang/String;
    .param p3, "addORdel"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setPortforwarding(ILjava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setSecurity(I)V
    .locals 3
    .param p1, "option"    # I

    .prologue
    sget v0, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_WPA_AUTH_SHARED:I

    .local v0, "mode":I
    packed-switch p1, :pswitch_data_0

    :goto_0
    return-void

    :pswitch_0
    :try_start_0
    sget v0, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_WPA_AUTH_NONE:I

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, v0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setAuthentication(I)Z

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_0

    :pswitch_1
    sget v0, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_WPA_AUTH_SHARED:I

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, v0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setAuthentication(I)Z

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    sget v2, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_ALGO_WEP128:I

    invoke-interface {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setEncryption(I)Z

    goto :goto_0

    :pswitch_2
    sget v0, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_WPA_AUTH_WPA2PSK:I

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, v0}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setAuthentication(I)Z

    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    sget v2, Lcom/lge/wifi/impl/mobilehotspot/MHPCommand;->BCMP2P_ALGO_AES:I

    invoke-interface {v1, v2}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setEncryption(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public setSoftapIsolation(Z)Z
    .locals 2
    .param p1, "enabled"    # Z

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setSoftapIsolation(Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setStaticIp(Ljava/lang/String;)V
    .locals 2
    .param p1, "staticIp"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setStaticIp(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setStaticSubnet(Ljava/lang/String;)V
    .locals 2
    .param p1, "staticSubnet"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setStaticSubnet(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setTxPower(I)I
    .locals 2
    .param p1, "txPower"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setTxPower(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public setUsageTime(I)V
    .locals 2
    .param p1, "time"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setBatteryUsageTime(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setWEPKey1(Ljava/lang/String;)Z
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setWEPKey1(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setWEPKey2(Ljava/lang/String;)Z
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setWEPKey2(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setWEPKey3(Ljava/lang/String;)Z
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setWEPKey3(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setWEPKey4(Ljava/lang/String;)Z
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setWEPKey4(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setWEPKeyIndex(I)Z
    .locals 2
    .param p1, "index"    # I

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setWEPKeyIndex(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setWPAKey(Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v0, p1}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->setWPAKey(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public updateAllowedDevice(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .param p1, "oldMacAddr"    # Ljava/lang/String;
    .param p2, "newMacAddr"    # Ljava/lang/String;
    .param p3, "newName"    # Ljava/lang/String;

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->mService:Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/wifi/impl/mobilehotspot/IMobileHotspot;->updateAllowedDevice(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    invoke-virtual {p0}, Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;->changedAllowedDevice()V

    const/4 v1, 0x1

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method
