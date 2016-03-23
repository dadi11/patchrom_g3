.class public Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;
.super Ljava/lang/Object;
.source "MHPBlockDeviceManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager$JobThread;
    }
.end annotation


# instance fields
.field private final TAG:Ljava/lang/String;

.field private final mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "proxy"    # Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "MHPBlockDeviceManager"

    iput-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;->TAG:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    return-void
.end method

.method static synthetic access$000(Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;)Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;->mProxy:Lcom/lge/wifi/impl/mobilehotspot/MHPProxy;

    return-object v0
.end method

.method private startJobThread(Ljava/lang/String;)V
    .locals 1
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager$JobThread;

    invoke-direct {v0, p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager$JobThread;-><init>(Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;Ljava/lang/String;)V

    .local v0, "newJobThread":Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager$JobThread;
    invoke-virtual {v0}, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager$JobThread;->start()V

    return-void
.end method


# virtual methods
.method public insertBlockDevice(Ljava/lang/String;)V
    .locals 0
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/mobilehotspot/MHPBlockDeviceManager;->startJobThread(Ljava/lang/String;)V

    return-void
.end method
