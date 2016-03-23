.class public Lcom/lge/uicc/SimPhonebookBaseManager;
.super Ljava/lang/Object;
.source "SimPhonebookBaseManager.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "SimPhonebookBaseManager"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static deleteEntry(II)I
    .locals 6
    .param p0, "slot"    # I
    .param p1, "simIndex"    # I

    .prologue
    const/4 v2, -0x1

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "deleteEntry: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1}, Lcom/lge/uicc/ISimPhonebookService;->deleteEntry(II)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "deleteEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "deleteEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static deleteGroup(II)I
    .locals 6
    .param p0, "slot"    # I
    .param p1, "groupIndex"    # I

    .prologue
    const/4 v2, -0x1

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "deleteGroup: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1}, Lcom/lge/uicc/ISimPhonebookService;->deleteGroup(II)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "deleteGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "deleteGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private static getPbmService()Lcom/lge/uicc/ISimPhonebookService;
    .locals 1

    .prologue
    const-string v0, "lguiccpbm"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/ISimPhonebookService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v0

    return-object v0
.end method

.method public static getSimPhonebookInfo(I)Lcom/lge/uicc/SimPhonebookBaseInfo;
    .locals 6
    .param p0, "slot"    # I

    .prologue
    const/4 v2, 0x0

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "getSimPhonebookInfo: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return-object v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0}, Lcom/lge/uicc/ISimPhonebookService;->getSimPhonebookInfo(I)Lcom/lge/uicc/SimPhonebookBaseInfo;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getSimPhonebookInfo: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getSimPhonebookInfo: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static insertEntry(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 6
    .param p0, "slot"    # I
    .param p1, "simIndex"    # I
    .param p2, "entry"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v2, -0x1

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "insertEntry: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1, p2}, Lcom/lge/uicc/ISimPhonebookService;->insertEntry(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static insertGroup(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 6
    .param p0, "slot"    # I
    .param p1, "groupIndex"    # I
    .param p2, "group"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v2, -0x1

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "insertGroup: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1, p2}, Lcom/lge/uicc/ISimPhonebookService;->insertGroup(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static readEntry(II)Lcom/lge/uicc/SimPhonebookBaseEntry;
    .locals 6
    .param p0, "slot"    # I
    .param p1, "simIndex"    # I

    .prologue
    const/4 v2, 0x0

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "readEntry: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return-object v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1}, Lcom/lge/uicc/ISimPhonebookService;->readEntry(II)Lcom/lge/uicc/SimPhonebookBaseEntry;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "readEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "readEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static readGroup(II)Lcom/lge/uicc/SimPhonebookBaseEntry;
    .locals 6
    .param p0, "slot"    # I
    .param p1, "groupIndex"    # I

    .prologue
    const/4 v2, 0x0

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "readGroup: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return-object v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1}, Lcom/lge/uicc/ISimPhonebookService;->readGroup(II)Lcom/lge/uicc/SimPhonebookBaseEntry;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "readGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "readGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static updateEntry(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 6
    .param p0, "slot"    # I
    .param p1, "simIndex"    # I
    .param p2, "entry"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v2, -0x1

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "updateEntry: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1, p2}, Lcom/lge/uicc/ISimPhonebookService;->updateEntry(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "updateEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "updateEntry: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static updateGroup(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 6
    .param p0, "slot"    # I
    .param p1, "groupIndex"    # I
    .param p2, "group"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v2, -0x1

    :try_start_0
    invoke-static {}, Lcom/lge/uicc/SimPhonebookBaseManager;->getPbmService()Lcom/lge/uicc/ISimPhonebookService;

    move-result-object v1

    .local v1, "service":Lcom/lge/uicc/ISimPhonebookService;
    if-nez v1, :cond_0

    const-string v3, "SimPhonebookBaseManager"

    const-string v4, "updateGroup: fail to get service"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :goto_0
    return v2

    .restart local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :cond_0
    invoke-interface {v1, p0, p1, p2}, Lcom/lge/uicc/ISimPhonebookService;->updateGroup(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "service":Lcom/lge/uicc/ISimPhonebookService;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "updateGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v3, "SimPhonebookBaseManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "updateGroup: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
