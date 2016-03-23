.class public Lcom/lge/systemservice/core/LGPowerManagerHelper;
.super Ljava/lang/Object;
.source "LGPowerManagerHelper.java"

# interfaces
.implements Lcom/lge/loader/power/ILGPowerManagerLoader;


# static fields
.field public static final ID_APP_LAUNCH:I = 0x1

.field public static final ID_APP_SWITCH:I = 0xd

.field public static final ID_BT_MUSIC_PLAY:I = 0x1f

.field public static final ID_CALL_OUTGOING:I = 0xc

.field public static final ID_CAMERA_PREVIEW:I = 0x29

.field public static final ID_COVER_OPEN:I = 0x5

.field public static final ID_HOME_SCROLL:I = 0xe

.field public static final ID_HOTSPOT_TRAFFIC:I = 0x7

.field public static final ID_KNOCKON_WAKEUP:I = 0x3

.field public static final ID_MUSIC_SOUND_CONTROL:I = 0x20

.field public static final ID_SCREENOFF_VOLUPDOWN_LONGPRESS:I = 0x4

.field public static final ID_SCREEN_ROTATION:I = 0x2

.field public static final ID_SOFT_KEY:I = 0xf

.field public static final ID_VIDEO_PLAY:I = 0x28

.field public static final ID_WIFI_TRAFFIC:I = 0x6

.field private static final TAG:Ljava/lang/String; = "LGPowerManagerHelper"


# instance fields
.field private mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/LGPowerManagerHelper;Lcom/lge/systemservice/core/ILGPowerManagerHelper;)Lcom/lge/systemservice/core/ILGPowerManagerHelper;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LGPowerManagerHelper;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/ILGPowerManagerHelper;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    if-nez v1, :cond_0

    const-string v1, "lgpowermanagerhelper"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ILGPowerManagerHelper$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    iget-object v1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGPowerManagerHelper;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/LGPowerManagerHelper$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/LGPowerManagerHelper$1;-><init>(Lcom/lge/systemservice/core/LGPowerManagerHelper;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    goto :goto_0
.end method


# virtual methods
.method public boost(I)I
    .locals 4
    .param p1, "id"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "ret":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGPowerManagerHelper;->getService()Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    iget-object v2, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/ILGPowerManagerHelper;->boost(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "LGPowerManagerHelper"

    const-string v3, "exception:"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v2

    goto :goto_0
.end method

.method public setGoToSleep()V
    .locals 1

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGPowerManagerHelper;->getService()Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    iget-object v0, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    invoke-interface {v0}, Lcom/lge/systemservice/core/ILGPowerManagerHelper;->setGoToSleep()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public setPowerModePolicy(I)I
    .locals 4
    .param p1, "function"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "ret":I
    const/4 v2, 0x1

    :try_start_0
    invoke-virtual {p0, p1, v2}, Lcom/lge/systemservice/core/LGPowerManagerHelper;->setPowerModePolicy(IZ)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "LGPowerManagerHelper"

    const-string v3, "exception:"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public declared-synchronized setPowerModePolicy(IZ)I
    .locals 4
    .param p1, "function"    # I
    .param p2, "enable"    # Z

    .prologue
    monitor-enter p0

    const/4 v1, -0x1

    .local v1, "ret":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGPowerManagerHelper;->getService()Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    iget-object v2, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    invoke-interface {v2, p1, p2}, Lcom/lge/systemservice/core/ILGPowerManagerHelper;->setPowerModePolicy(IZ)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    :cond_0
    :goto_0
    monitor-exit p0

    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    :try_start_1
    const-string v2, "LGPowerManagerHelper"

    const-string v3, "exception:"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v2

    monitor-exit p0

    throw v2

    :catch_1
    move-exception v2

    goto :goto_0
.end method

.method public turnOffThermald()V
    .locals 4

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGPowerManagerHelper;->getService()Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    iget-object v2, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LGPowerManagerHelper;->mService:Lcom/lge/systemservice/core/ILGPowerManagerHelper;

    invoke-interface {v2}, Lcom/lge/systemservice/core/ILGPowerManagerHelper;->turnOffThermald()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "re":Landroid/os/RemoteException;
    const-string v2, "LGPowerManagerHelper"

    const-string v3, "Error while turning off thermal daemon."

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v1    # "re":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "LGPowerManagerHelper"

    const-string v3, "exception:"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method
