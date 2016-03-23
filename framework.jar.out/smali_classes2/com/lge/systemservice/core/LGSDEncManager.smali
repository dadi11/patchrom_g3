.class public Lcom/lge/systemservice/core/LGSDEncManager;
.super Ljava/lang/Object;
.source "LGSDEncManager.java"


# static fields
.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.sdencryption"

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private mService:Lcom/lge/systemservice/core/ILGSDEncManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 19
    const-class v0, Lcom/lge/systemservice/core/LGSDEncManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/LGSDEncManager;Lcom/lge/systemservice/core/ILGSDEncManager;)Lcom/lge/systemservice/core/ILGSDEncManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LGSDEncManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ILGSDEncManager;

    .prologue
    .line 16
    iput-object p1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    return-object p1
.end method

.method public static getSDEncSupportStatus(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 410
    const-string v0, "ro.build.characteristics"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "nosdcard"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Lcom/lge/internal/R$bool;->config_sd_encrypt:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    if-nez v0, :cond_1

    .line 412
    :cond_0
    const/4 v0, 0x0

    .line 414
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private final getService()Lcom/lge/systemservice/core/ILGSDEncManager;
    .locals 4

    .prologue
    .line 28
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 29
    const-string v1, "lgsdencryption"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ILGSDEncManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 30
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_0

    .line 32
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/LGSDEncManager$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/LGSDEncManager$1;-><init>(Lcom/lge/systemservice/core/LGSDEncManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 39
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    return-object v1

    .line 36
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    goto :goto_0
.end method


# virtual methods
.method public MDMStorageEncryptionStatus()Z
    .locals 3

    .prologue
    .line 384
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 385
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 388
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 389
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->MDMStorageEncryptionStatus()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 395
    :goto_0
    return v1

    .line 391
    :catch_0
    move-exception v0

    .line 392
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 394
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 395
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public StorageEncryptionStatus()I
    .locals 3

    .prologue
    .line 316
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 317
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 320
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 321
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->StorageEncryptionStatus()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 327
    :goto_0
    return v1

    .line 323
    :catch_0
    move-exception v0

    .line 324
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 326
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 327
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public changepw(Ljava/lang/String;)I
    .locals 3
    .param p1, "passwd"    # Ljava/lang/String;

    .prologue
    .line 484
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 485
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 488
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 489
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->changepw(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 495
    :goto_0
    return v1

    .line 491
    :catch_0
    move-exception v0

    .line 492
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 494
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 495
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardCheckMemory()I
    .locals 3

    .prologue
    .line 426
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 427
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 430
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 431
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardCheckMemory()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 437
    :goto_0
    return v1

    .line 433
    :catch_0
    move-exception v0

    .line 434
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 436
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 437
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardDeleteMetaDir()I
    .locals 3

    .prologue
    .line 114
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 115
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 118
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 119
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardDeleteMetaDir()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 126
    :goto_0
    return v1

    .line 121
    :catch_0
    move-exception v0

    .line 122
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 125
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 126
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardDisableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 98
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 99
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 102
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 103
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardDisableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 110
    :goto_0
    return v1

    .line 105
    :catch_0
    move-exception v0

    .line 106
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 109
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 110
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardEnableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 55
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 56
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 59
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 60
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardEnableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 67
    :goto_0
    return v1

    .line 62
    :catch_0
    move-exception v0

    .line 63
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 66
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardEnableEncryptionUserPassword(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "passwd"    # Ljava/lang/String;

    .prologue
    .line 71
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 72
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 75
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 76
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardEnableEncryptionUserPassword(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 83
    :goto_0
    return v1

    .line 78
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 82
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardFullDisableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 169
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 170
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 173
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 174
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardFullDisableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 181
    :goto_0
    return v1

    .line 176
    :catch_0
    move-exception v0

    .line 177
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 180
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardFullEnableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 142
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 143
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 146
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 147
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardFullEnableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 154
    :goto_0
    return v1

    .line 149
    :catch_0
    move-exception v0

    .line 150
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 153
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardFullTotalMemory(J)I
    .locals 3
    .param p1, "totalMemory"    # J

    .prologue
    .line 193
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 194
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 197
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 198
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardFullTotalMemory(J)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 204
    :goto_0
    return v1

    .line 200
    :catch_0
    move-exception v0

    .line 201
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 203
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardMediaDisableEncryption()I
    .locals 3

    .prologue
    .line 237
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 238
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 241
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 242
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardMediaDisableEncryption()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 248
    :goto_0
    return v1

    .line 244
    :catch_0
    move-exception v0

    .line 245
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 247
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 248
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardMediaDisableEncryption(Ljava/lang/String;)I
    .locals 1
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 276
    invoke-virtual {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->externalSDCardMediaDisableEncryption()I

    move-result v0

    return v0
.end method

.method public externalSDCardMediaEnableEncryption()I
    .locals 3

    .prologue
    .line 215
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 216
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 219
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 220
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardMediaEnableEncryption()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 226
    :goto_0
    return v1

    .line 222
    :catch_0
    move-exception v0

    .line 223
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 225
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 226
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardMediaEnableEncryption(Ljava/lang/String;)I
    .locals 1
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 262
    invoke-virtual {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->externalSDCardMediaEnableEncryption()I

    move-result v0

    return v0
.end method

.method public externalSDCardMountComplete(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 291
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 292
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 295
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 296
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardMountComplete(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 302
    :goto_0
    return v1

    .line 298
    :catch_0
    move-exception v0

    .line 299
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 301
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 302
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getExternalSDCardMountPath()Ljava/lang/String;
    .locals 3

    .prologue
    .line 360
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 361
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 364
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 365
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->getExternalSDCardMountPath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 371
    :goto_0
    return-object v1

    .line 367
    :catch_0
    move-exception v0

    .line 368
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 370
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 371
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getInternalSDCardMountPath()Ljava/lang/String;
    .locals 3

    .prologue
    .line 338
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 339
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 342
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 343
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->getInternalSDCardMountPath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 349
    :goto_0
    return-object v1

    .line 345
    :catch_0
    move-exception v0

    .line 346
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 348
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 349
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isExistSDEncMetaFile()Z
    .locals 3

    .prologue
    .line 529
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 530
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 532
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 534
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->isExistSDEncMetaFile()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 540
    :goto_0
    return v1

    .line 535
    :catch_0
    move-exception v0

    .line 536
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 539
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 540
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isProgressing()Z
    .locals 3

    .prologue
    .line 469
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 470
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 473
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 474
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->isProgressing()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 480
    :goto_0
    return v1

    .line 476
    :catch_0
    move-exception v0

    .line 477
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 479
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 480
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public lockDevice()I
    .locals 3

    .prologue
    .line 499
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 500
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 502
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 504
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->lockDevice()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 510
    :goto_0
    return v1

    .line 505
    :catch_0
    move-exception v0

    .line 506
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 509
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 510
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public setProgressing(Z)I
    .locals 3
    .param p1, "isProgressing"    # Z

    .prologue
    .line 447
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 448
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 451
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 452
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->setProgressing(Z)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 458
    :goto_0
    return v1

    .line 454
    :catch_0
    move-exception v0

    .line 455
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 457
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 458
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public unlockDevice(Ljava/lang/String;)I
    .locals 3
    .param p1, "passwd"    # Ljava/lang/String;

    .prologue
    .line 514
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    .line 515
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    .line 517
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    .line 519
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->unlockDevice(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 525
    :goto_0
    return v1

    .line 520
    :catch_0
    move-exception v0

    .line 521
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 524
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 525
    const/4 v1, -0x1

    goto :goto_0
.end method
