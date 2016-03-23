.class public Lcom/lge/os/NetworkManagerEx;
.super Ljava/lang/Object;
.source "NetworkManagerEx.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static sInstance:Lcom/lge/os/NetworkManagerEx;


# instance fields
.field final mService:Landroid/os/INetworkManagementService;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/os/NetworkManagerEx;->sInstance:Lcom/lge/os/NetworkManagerEx;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v1, "network_management"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "service":Landroid/os/IBinder;
    invoke-static {v0}, Landroid/os/INetworkManagementService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/INetworkManagementService;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/os/NetworkManagerEx;->mService:Landroid/os/INetworkManagementService;

    return-void
.end method


# virtual methods
.method public getDefault()Lcom/lge/os/NetworkManagerEx;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/os/NetworkManagerEx;->sInstance:Lcom/lge/os/NetworkManagerEx;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/os/NetworkManagerEx;

    invoke-direct {v0}, Lcom/lge/os/NetworkManagerEx;-><init>()V

    sput-object v0, Lcom/lge/os/NetworkManagerEx;->sInstance:Lcom/lge/os/NetworkManagerEx;

    :cond_0
    sget-object v0, Lcom/lge/os/NetworkManagerEx;->sInstance:Lcom/lge/os/NetworkManagerEx;

    return-object v0
.end method
