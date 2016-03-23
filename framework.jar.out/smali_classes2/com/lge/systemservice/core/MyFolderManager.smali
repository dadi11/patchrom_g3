.class public Lcom/lge/systemservice/core/MyFolderManager;
.super Ljava/lang/Object;
.source "MyFolderManager.java"


# static fields
.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.myfolder"

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private mService:Lcom/lge/systemservice/core/IMyFolderManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 13
    const-class v0, Lcom/lge/systemservice/core/MyFolderManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/MyFolderManager;Lcom/lge/systemservice/core/IMyFolderManager;)Lcom/lge/systemservice/core/IMyFolderManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/MyFolderManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IMyFolderManager;

    .prologue
    .line 11
    iput-object p1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/IMyFolderManager;
    .locals 4

    .prologue
    .line 22
    iget-object v1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    if-nez v1, :cond_0

    .line 23
    const-string v1, "myfolder"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/IMyFolderManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    .line 24
    iget-object v1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    if-eqz v1, :cond_0

    .line 26
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/IMyFolderManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/MyFolderManager$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/MyFolderManager$1;-><init>(Lcom/lge/systemservice/core/MyFolderManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 33
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    return-object v1

    .line 30
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;

    goto :goto_0
.end method


# virtual methods
.method public addPackageListToMyFolder([Ljava/lang/String;)Z
    .locals 5
    .param p1, "packageList"    # [Ljava/lang/String;

    .prologue
    .line 119
    const/4 v0, 0x0

    .line 120
    .local v0, "bResult":Z
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v2

    .line 121
    .local v2, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v2, :cond_0

    .line 123
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IMyFolderManager;->addPackageListToMyFolder([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 130
    :goto_0
    return v0

    .line 124
    :catch_0
    move-exception v1

    .line 125
    .local v1, "e":Landroid/os/RemoteException;
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 128
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v4, "Can\'t get service!!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public addPackageToMyFolder(Ljava/lang/String;)Z
    .locals 5
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 98
    const/4 v0, 0x0

    .line 99
    .local v0, "bResult":Z
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v2

    .line 100
    .local v2, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v2, :cond_0

    .line 102
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IMyFolderManager;->addPackageToMyFolder(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 109
    :goto_0
    return v0

    .line 103
    :catch_0
    move-exception v1

    .line 104
    .local v1, "e":Landroid/os/RemoteException;
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 107
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v4, "Can\'t get service!!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public enterMyFolder(I)V
    .locals 4
    .param p1, "type"    # I

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v1

    .line 44
    .local v1, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v1, :cond_0

    .line 46
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IMyFolderManager;->enterMyFolder(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 53
    :goto_0
    return-void

    .line 47
    :catch_0
    move-exception v0

    .line 48
    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 51
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v3, "Can\'t get service!!"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public exitMyFolder(I)V
    .locals 4
    .param p1, "type"    # I

    .prologue
    .line 62
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v1

    .line 63
    .local v1, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v1, :cond_0

    .line 65
    :try_start_0
    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IMyFolderManager;->exitMyFolder(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 72
    :goto_0
    return-void

    .line 66
    :catch_0
    move-exception v0

    .line 67
    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 70
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v3, "Can\'t get service!!"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getAddedPackageList()[Ljava/lang/String;
    .locals 4

    .prologue
    .line 180
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v1

    .line 181
    .local v1, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v1, :cond_0

    .line 183
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IMyFolderManager;->getAddedPackageList()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 189
    :goto_0
    return-object v2

    .line 184
    :catch_0
    move-exception v0

    .line 185
    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 188
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v3, "Can\'t get service!!"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public getState()I
    .locals 4

    .prologue
    .line 80
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v1

    .line 81
    .local v1, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v1, :cond_0

    .line 83
    :try_start_0
    invoke-interface {v1}, Lcom/lge/systemservice/core/IMyFolderManager;->getState()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 89
    :goto_0
    return v2

    .line 84
    :catch_0
    move-exception v0

    .line 85
    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v3, "Can\'t get service!!"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 89
    const/4 v2, -0x1

    goto :goto_0
.end method

.method public removePackageFromMyFolder(Ljava/lang/String;)Z
    .locals 5
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 139
    const/4 v0, 0x0

    .line 140
    .local v0, "bResult":Z
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v2

    .line 141
    .local v2, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v2, :cond_0

    .line 143
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IMyFolderManager;->removePackageFromMyFolder(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 150
    :goto_0
    return v0

    .line 144
    :catch_0
    move-exception v1

    .line 145
    .local v1, "e":Landroid/os/RemoteException;
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 148
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v4, "Can\'t get service!!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public removePackageListFromMyFolder([Ljava/lang/String;)Z
    .locals 5
    .param p1, "packageList"    # [Ljava/lang/String;

    .prologue
    .line 160
    const/4 v0, 0x0

    .line 161
    .local v0, "bResult":Z
    invoke-direct {p0}, Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;

    move-result-object v2

    .line 162
    .local v2, "service":Lcom/lge/systemservice/core/IMyFolderManager;
    if-eqz v2, :cond_0

    .line 164
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IMyFolderManager;->removePackageListFromMyFolder([Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 171
    :goto_0
    return v0

    .line 165
    :catch_0
    move-exception v1

    .line 166
    .local v1, "e":Landroid/os/RemoteException;
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    invoke-virtual {v1}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 169
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Lcom/lge/systemservice/core/MyFolderManager;->TAG:Ljava/lang/String;

    const-string v4, "Can\'t get service!!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
