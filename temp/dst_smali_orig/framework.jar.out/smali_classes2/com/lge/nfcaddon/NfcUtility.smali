.class public Lcom/lge/nfcaddon/NfcUtility;
.super Ljava/lang/Object;
.source "NfcUtility.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;
    }
.end annotation


# static fields
.field private static final CHECK_LOOP_MAX_COUNT:I = 0x2

.field private static final DBG:Z = true

.field private static final TAG:Ljava/lang/String; = "NfcUtility"

.field private static nfcUtilManager:Lcom/lge/nfcaddon/NfcUtilityManager;

.field private static sService:Lcom/lge/nfcaddon/INfcUtility;

.field private static sSingleton:Lcom/lge/nfcaddon/NfcUtility;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static get(Landroid/nfc/NfcAdapter;)Lcom/lge/nfcaddon/NfcUtility;
    .locals 4
    .param p0, "adapter"    # Landroid/nfc/NfcAdapter;

    .prologue
    const-string v1, "NfcUtility"

    const-string v2, "get()"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Landroid/nfc/NfcAdapter;->getContext()Landroid/content/Context;

    move-result-object v0

    .local v0, "context":Landroid/content/Context;
    if-nez v0, :cond_0

    new-instance v1, Ljava/lang/UnsupportedOperationException;

    const-string v2, "You must pass a context to your NfcAdapter to use the NFC Utility APIs"

    invoke-direct {v1, v2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_0
    const-class v2, Lcom/lge/nfcaddon/NfcUtility;

    monitor-enter v2

    :try_start_0
    invoke-static {p0}, Lcom/lge/nfcaddon/NfcUtility;->initServivce(Landroid/nfc/NfcAdapter;)V

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sSingleton:Lcom/lge/nfcaddon/NfcUtility;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v1, :cond_1

    :try_start_1
    new-instance v1, Lcom/lge/nfcaddon/NfcUtility;

    invoke-direct {v1}, Lcom/lge/nfcaddon/NfcUtility;-><init>()V

    sput-object v1, Lcom/lge/nfcaddon/NfcUtility;->sSingleton:Lcom/lge/nfcaddon/NfcUtility;

    new-instance v1, Lcom/lge/nfcaddon/NfcUtilityManager;

    invoke-direct {v1}, Lcom/lge/nfcaddon/NfcUtilityManager;-><init>()V

    sput-object v1, Lcom/lge/nfcaddon/NfcUtility;->nfcUtilManager:Lcom/lge/nfcaddon/NfcUtilityManager;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sSingleton:Lcom/lge/nfcaddon/NfcUtility;

    if-nez v1, :cond_1

    const/4 v1, 0x0

    sput-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    :cond_1
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sSingleton:Lcom/lge/nfcaddon/NfcUtility;

    return-object v1

    :catchall_0
    move-exception v1

    :try_start_3
    sget-object v3, Lcom/lge/nfcaddon/NfcUtility;->sSingleton:Lcom/lge/nfcaddon/NfcUtility;

    if-nez v3, :cond_2

    const/4 v3, 0x0

    sput-object v3, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    :cond_2
    throw v1

    :catchall_1
    move-exception v1

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v1
.end method

.method private static getNfcUtilityInterface()Lcom/lge/nfcaddon/INfcUtility;
    .locals 4

    .prologue
    const/4 v1, 0x0

    const-string v2, "lge.nfc.vendor"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "sony"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .local v0, "binder":Landroid/os/IBinder;
    :goto_0
    return-object v1

    .end local v0    # "binder":Landroid/os/IBinder;
    :cond_0
    const-string v2, "nfcvendor"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .restart local v0    # "binder":Landroid/os/IBinder;
    if-nez v0, :cond_1

    const-string v2, "NfcUtility"

    const-string v3, "nfcsony binder null!!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    invoke-static {v0}, Lcom/lge/nfcaddon/INfcUtility$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/INfcUtility;

    move-result-object v1

    goto :goto_0
.end method

.method private static initServivce(Landroid/nfc/NfcAdapter;)V
    .locals 4
    .param p0, "adapter"    # Landroid/nfc/NfcAdapter;

    .prologue
    const-string v2, "NfcUtility"

    const-string v3, "initServivce()"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .local v0, "loopCount":I
    :goto_0
    const/4 v2, 0x2

    if-ge v0, v2, :cond_0

    invoke-static {}, Lcom/lge/nfcaddon/NfcUtility;->getNfcUtilityInterface()Lcom/lge/nfcaddon/INfcUtility;

    move-result-object v1

    .local v1, "service":Lcom/lge/nfcaddon/INfcUtility;
    if-eqz v1, :cond_1

    const-string v2, "NfcUtility"

    const-string v3, "[initServivce] get INfcUtility service instance."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sput-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    .end local v1    # "service":Lcom/lge/nfcaddon/INfcUtility;
    :cond_0
    return-void

    .restart local v1    # "service":Lcom/lge/nfcaddon/INfcUtility;
    :cond_1
    const-string v2, "NfcUtility"

    const-string v3, "[initServivce] service is null..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method


# virtual methods
.method public disableCashbee()Z
    .locals 3

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcUtility;->disableCashbee()Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "NfcUtility"

    const-string v2, "disableCashbee sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "NfcUtility"

    const-string v2, "disableCashbee sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public enableCashbee()Z
    .locals 3

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcUtility;->enableCashbee()Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "NfcUtility"

    const-string v2, "enableCashbee sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "NfcUtility"

    const-string v2, "enableCashbee sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public getCashbeeState()I
    .locals 3

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcUtility;->getCashbeeState()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "NfcUtility"

    const-string v2, "isNfcRecoveryMode sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "NfcUtility"

    const-string v2, "isNfcRecoveryMode sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public isNfcLock()Z
    .locals 3

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcUtility;->isNfcLock()Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "NfcUtility"

    const-string v2, "isNfcLock sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "NfcUtility"

    const-string v2, "isNfcLock sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public isNfcRecoveryMode()Z
    .locals 3

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcUtility;->isNfcRecoveryMode()Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "NfcUtility"

    const-string v2, "isNfcRecoveryMode sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "NfcUtility"

    const-string v2, "isNfcRecoveryMode sServie is null ..."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public waitSimBoot(Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;Z)Z
    .locals 4
    .param p1, "callback"    # Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;
    .param p2, "isLock"    # Z

    .prologue
    const-string v2, "NfcUtility"

    const-string v3, "waitSimBoot(NfcUtilityCallback)"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    .local v1, "result":Z
    sget-object v2, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    if-nez v2, :cond_0

    const-string v2, "NfcUtility"

    const-string v3, "waitSimBoot sServie is null ..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v1

    :goto_0
    return v2

    :cond_0
    :try_start_0
    const-string v2, "NfcUtility"

    const-string v3, "sService.waitSimBoot() start"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v2, Lcom/lge/nfcaddon/NfcUtility;->nfcUtilManager:Lcom/lge/nfcaddon/NfcUtilityManager;

    invoke-virtual {v2, p1}, Lcom/lge/nfcaddon/NfcUtilityManager;->setNfcUtilityCallback(Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;)V

    sget-object v2, Lcom/lge/nfcaddon/NfcUtility;->sService:Lcom/lge/nfcaddon/INfcUtility;

    sget-object v3, Lcom/lge/nfcaddon/NfcUtility;->nfcUtilManager:Lcom/lge/nfcaddon/NfcUtilityManager;

    invoke-interface {v2, v3, p2}, Lcom/lge/nfcaddon/INfcUtility;->waitSimBootCallback(Lcom/lge/nfcaddon/INfcUtilityCallback;Z)Z

    move-result v1

    const-string v2, "NfcUtility"

    const-string v3, "sService.waitSimBoot() end"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move v2, v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "NfcUtility"

    const-string v3, "waitSimBoot sServie is null ..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x0

    goto :goto_0
.end method
