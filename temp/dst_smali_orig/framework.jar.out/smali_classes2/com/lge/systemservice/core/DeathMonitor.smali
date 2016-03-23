.class public Lcom/lge/systemservice/core/DeathMonitor;
.super Ljava/lang/Object;
.source "DeathMonitor.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "DeathMonitor"


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mService:Lcom/lge/systemservice/core/IDeathMonitor;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mContext:Landroid/content/Context;

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/DeathMonitor;Lcom/lge/systemservice/core/IDeathMonitor;)Lcom/lge/systemservice/core/IDeathMonitor;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/DeathMonitor;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IDeathMonitor;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/IDeathMonitor;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    if-nez v1, :cond_0

    const-string v1, "deathmonitor"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/IDeathMonitor$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IDeathMonitor;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    iget-object v1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    invoke-interface {v1}, Lcom/lge/systemservice/core/IDeathMonitor;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/DeathMonitor$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/DeathMonitor$1;-><init>(Lcom/lge/systemservice/core/DeathMonitor;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/DeathMonitor;->mService:Lcom/lge/systemservice/core/IDeathMonitor;

    goto :goto_0
.end method


# virtual methods
.method public register(Landroid/os/IBinder;Lcom/lge/systemservice/core/DeathMonitorResponse;)V
    .locals 4
    .param p1, "binder"    # Landroid/os/IBinder;
    .param p2, "res"    # Lcom/lge/systemservice/core/DeathMonitorResponse;

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/DeathMonitor;->getService()Lcom/lge/systemservice/core/IDeathMonitor;

    move-result-object v1

    .local v1, "service":Lcom/lge/systemservice/core/IDeathMonitor;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IDeathMonitor;->register(Landroid/os/IBinder;Lcom/lge/systemservice/core/DeathMonitorResponse;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "service":Lcom/lge/systemservice/core/IDeathMonitor;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "DeathMonitor"

    const-string v3, "register() : exception!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public unregister(Landroid/os/IBinder;)Z
    .locals 5
    .param p1, "binder"    # Landroid/os/IBinder;

    .prologue
    const/4 v1, 0x0

    .local v1, "ret":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/DeathMonitor;->getService()Lcom/lge/systemservice/core/IDeathMonitor;

    move-result-object v2

    .local v2, "service":Lcom/lge/systemservice/core/IDeathMonitor;
    if-eqz v2, :cond_0

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IDeathMonitor;->unregister(Landroid/os/IBinder;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .end local v2    # "service":Lcom/lge/systemservice/core/IDeathMonitor;
    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "DeathMonitor"

    const-string v4, "unregister() : exception!"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
