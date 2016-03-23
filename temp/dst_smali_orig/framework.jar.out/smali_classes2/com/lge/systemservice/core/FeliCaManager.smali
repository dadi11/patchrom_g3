.class public Lcom/lge/systemservice/core/FeliCaManager;
.super Ljava/lang/Object;
.source "FeliCaManager.java"


# static fields
.field static final SERVICE_NAME:Ljava/lang/String; = "FeliCaService"

.field private static final TAG:Ljava/lang/String; = "FeliCaManager"


# instance fields
.field private mService:Lcom/lge/systemservice/core/IFeliCaManager;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/FeliCaManager;Lcom/lge/systemservice/core/IFeliCaManager;)Lcom/lge/systemservice/core/IFeliCaManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/FeliCaManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IFeliCaManager;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/IFeliCaManager;
    .locals 5

    .prologue
    iget-object v2, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    if-nez v2, :cond_0

    const-string v2, "FeliCaService"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Lcom/lge/systemservice/core/IFeliCaManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    iget-object v2, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    invoke-interface {v2}, Lcom/lge/systemservice/core/IFeliCaManager;->asBinder()Landroid/os/IBinder;

    move-result-object v2

    new-instance v3, Lcom/lge/systemservice/core/FeliCaManager$1;

    invoke-direct {v3, p0}, Lcom/lge/systemservice/core/FeliCaManager$1;-><init>(Lcom/lge/systemservice/core/FeliCaManager;)V

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "b":Landroid/os/IBinder;
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    return-object v2

    .restart local v0    # "b":Landroid/os/IBinder;
    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/systemservice/core/FeliCaManager;->mService:Lcom/lge/systemservice/core/IFeliCaManager;

    goto :goto_0
.end method


# virtual methods
.method public cmdEXTIDM([B)Z
    .locals 3
    .param p1, "idm"    # [B

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdEXTIDM is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdEXTIDM([B)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdEXTIDM is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdFreqCalRange([Ljava/lang/String;)Z
    .locals 3
    .param p1, "response"    # [Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdFreqCalRange is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdFreqCalRange([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdFreqCalRange is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdFreqCalRead([Ljava/lang/String;)Z
    .locals 3
    .param p1, "response"    # [Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdFreqCalRead is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdFreqCalRead([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdFreqCalRead is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdFreqCalWrite(F)Z
    .locals 3
    .param p1, "freq"    # F

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdFreqCalWrite is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdFreqCalWrite(F)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdFreqCalWrite is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdIDM([Ljava/lang/String;)Z
    .locals 3
    .param p1, "response"    # [Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdIDM is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdIDM([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdIDM is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdRFIDCK()I
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdRFIDCK is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdRFIDCK()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdRFIDCK is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdRFRegCalCheck()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdRFRegCalCheck is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdRFRegCalCheck()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdRFRegCalCheck is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdRFRegCalLoad()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdRFRegCalLoad is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdRFRegCalLoad()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdRFRegCalLoad is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdSwitchRange([Ljava/lang/String;)Z
    .locals 3
    .param p1, "response"    # [Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdSwitchRange is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdSwitchRange([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdSwitchRange is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdSwitchRead([Ljava/lang/String;)Z
    .locals 3
    .param p1, "response"    # [Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdSwitchRead is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdSwitchRead([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdSwitchRead is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public cmdSwitchWrite(I)Z
    .locals 3
    .param p1, "idx"    # I

    .prologue
    :try_start_0
    const-string v1, "FeliCaManager"

    const-string v2, "cmdSwitchWrite is called."

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/FeliCaManager;->getService()Lcom/lge/systemservice/core/IFeliCaManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IFeliCaManager;->cmdSwitchWrite(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "FeliCaManager"

    const-string v2, "cmdSwitchWrite is failed."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method
