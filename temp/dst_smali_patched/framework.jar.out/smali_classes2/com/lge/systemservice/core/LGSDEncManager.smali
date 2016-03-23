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
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/LGSDEncManager;Lcom/lge/systemservice/core/ILGSDEncManager;)Lcom/lge/systemservice/core/ILGSDEncManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LGSDEncManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ILGSDEncManager;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    return-object p1
.end method

.method public static getSDEncSupportStatus(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
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

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private final getService()Lcom/lge/systemservice/core/ILGSDEncManager;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    const-string v1, "lgsdencryption"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ILGSDEncManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_0

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

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    return-object v1

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
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->MDMStorageEncryptionStatus()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public StorageEncryptionStatus()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->StorageEncryptionStatus()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public changepw(Ljava/lang/String;)I
    .locals 3
    .param p1, "passwd"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->changepw(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardCheckMemory()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardCheckMemory()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardDeleteMetaDir()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardDeleteMetaDir()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardDisableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardDisableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardEnableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardEnableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardEnableEncryptionUserPassword(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "passwd"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardEnableEncryptionUserPassword(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardFullDisableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardFullDisableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardFullEnableEncryption(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardFullEnableEncryption(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardFullTotalMemory(J)I
    .locals 3
    .param p1, "totalMemory"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardFullTotalMemory(J)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardMediaDisableEncryption()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardMediaDisableEncryption()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardMediaDisableEncryption(Ljava/lang/String;)I
    .locals 1
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->externalSDCardMediaDisableEncryption()I

    move-result v0

    return v0
.end method

.method public externalSDCardMediaEnableEncryption()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardMediaEnableEncryption()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public externalSDCardMediaEnableEncryption(Ljava/lang/String;)I
    .locals 1
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->externalSDCardMediaEnableEncryption()I

    move-result v0

    return v0
.end method

.method public externalSDCardMountComplete(Ljava/lang/String;)I
    .locals 3
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->externalSDCardMountComplete(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getExternalSDCardMountPath()Ljava/lang/String;
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->getExternalSDCardMountPath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getInternalSDCardMountPath()Ljava/lang/String;
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->getInternalSDCardMountPath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isExistSDEncMetaFile()Z
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->isExistSDEncMetaFile()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isProgressing()Z
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->isProgressing()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public lockDevice()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGSDEncManager;->lockDevice()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public setProgressing(Z)I
    .locals 3
    .param p1, "isProgressing"    # Z

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->setProgressing(Z)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public unlockDevice(Ljava/lang/String;)I
    .locals 3
    .param p1, "passwd"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-nez v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/LGSDEncManager;->getService()Lcom/lge/systemservice/core/ILGSDEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    if-eqz v1, :cond_1

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGSDEncManager;->mService:Lcom/lge/systemservice/core/ILGSDEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGSDEncManager;->unlockDevice(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGSDEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGSDEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method
