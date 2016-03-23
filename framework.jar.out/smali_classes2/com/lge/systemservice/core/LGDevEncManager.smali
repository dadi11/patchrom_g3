.class public Lcom/lge/systemservice/core/LGDevEncManager;
.super Ljava/lang/Object;
.source "LGDevEncManager.java"


# static fields
.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.devencryption"

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private mService:Lcom/lge/systemservice/core/ILGDevEncManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 20
    const-class v0, Lcom/lge/systemservice/core/LGDevEncManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/core/LGDevEncManager;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/LGDevEncManager;Lcom/lge/systemservice/core/ILGDevEncManager;)Lcom/lge/systemservice/core/ILGDevEncManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LGDevEncManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ILGDevEncManager;

    .prologue
    .line 16
    iput-object p1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    return-object p1
.end method

.method public static getDevEncSupportStatus(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 149
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Lcom/lge/internal/R$bool;->config_data_encrypt:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 150
    const/4 v0, 0x1

    .line 152
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private final getService()Lcom/lge/systemservice/core/ILGDevEncManager;
    .locals 4

    .prologue
    .line 27
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-nez v1, :cond_0

    .line 28
    const-string v1, "lgdevencryption"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ILGDevEncManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILGDevEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    .line 29
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-eqz v1, :cond_0

    .line 31
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILGDevEncManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/LGDevEncManager$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/LGDevEncManager$1;-><init>(Lcom/lge/systemservice/core/LGDevEncManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 38
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    return-object v1

    .line 35
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    goto :goto_0
.end method


# virtual methods
.method public quicklyencryptStorage(ILjava/lang/String;)I
    .locals 3
    .param p1, "type"    # I
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    .line 77
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-nez v1, :cond_0

    .line 78
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGDevEncManager;->getService()Lcom/lge/systemservice/core/ILGDevEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    .line 80
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-eqz v1, :cond_1

    .line 82
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/ILGDevEncManager;->quicklyencryptStorage(ILjava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 88
    :goto_0
    return v1

    .line 83
    :catch_0
    move-exception v0

    .line 84
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 87
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGDevEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGDevEncManager connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public quicklyunencryptStorage(Ljava/lang/String;)I
    .locals 3
    .param p1, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    .line 102
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-nez v1, :cond_0

    .line 103
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGDevEncManager;->getService()Lcom/lge/systemservice/core/ILGDevEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    .line 105
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-eqz v1, :cond_1

    .line 107
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGDevEncManager;->quicklyunencryptStorage(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 113
    :goto_0
    return v1

    .line 108
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 112
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGDevEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGDevEncManager connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 113
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public unencryptStorage(Ljava/lang/String;)I
    .locals 3
    .param p1, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    .line 52
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-nez v1, :cond_0

    .line 53
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGDevEncManager;->getService()Lcom/lge/systemservice/core/ILGDevEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    .line 55
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-eqz v1, :cond_1

    .line 57
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGDevEncManager;->unencryptStorage(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 63
    :goto_0
    return v1

    .line 58
    :catch_0
    move-exception v0

    .line 59
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 62
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGDevEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGDevEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 63
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public unencryptWipeStorage(Ljava/lang/String;)I
    .locals 3
    .param p1, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    .line 127
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-nez v1, :cond_0

    .line 128
    invoke-direct {p0}, Lcom/lge/systemservice/core/LGDevEncManager;->getService()Lcom/lge/systemservice/core/ILGDevEncManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    .line 130
    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    if-eqz v1, :cond_1

    .line 132
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LGDevEncManager;->mService:Lcom/lge/systemservice/core/ILGDevEncManager;

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/ILGDevEncManager;->unencryptWipeStorage(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 138
    :goto_0
    return v1

    .line 133
    :catch_0
    move-exception v0

    .line 134
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 137
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v1, Lcom/lge/systemservice/core/LGDevEncManager;->TAG:Ljava/lang/String;

    const-string v2, "LGDevEncService connection error"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 138
    const/4 v1, -0x1

    goto :goto_0
.end method