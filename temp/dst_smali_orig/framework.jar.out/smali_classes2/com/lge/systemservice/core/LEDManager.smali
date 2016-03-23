.class public Lcom/lge/systemservice/core/LEDManager;
.super Ljava/lang/Object;
.source "LEDManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/LEDManager$ErrorNums;
    }
.end annotation


# static fields
.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.led"

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private mService:Lcom/lge/systemservice/core/ILEDManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-class v0, Lcom/lge/systemservice/core/LEDManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/LEDManager;Lcom/lge/systemservice/core/ILEDManager;)Lcom/lge/systemservice/core/ILEDManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/LEDManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ILEDManager;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/ILEDManager;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-nez v1, :cond_0

    const-string v1, "emotionled"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ILEDManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    iget-object v1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ILEDManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/LEDManager$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/LEDManager$1;-><init>(Lcom/lge/systemservice/core/LEDManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v1, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getService() could not link to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " binder death"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    goto :goto_0
.end method


# virtual methods
.method public clearAllPatterns()I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .local v1, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2}, Lcom/lge/systemservice/core/ILEDManager;->clearAllLeds()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const/4 v1, -0x1

    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getEmotionalLedType()I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .local v1, "ledType":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2}, Lcom/lge/systemservice/core/ILEDManager;->getEmotionalLedType()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public restartPatterns()I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .local v1, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2}, Lcom/lge/systemservice/core/ILEDManager;->restart()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const/4 v1, -0x1

    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setBrightnessLed(II)I
    .locals 4
    .param p1, "brightness"    # I
    .param p2, "lednum"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/ILEDManager;->setBrightness(I)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const/4 v1, -0x1

    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public startPattern(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)I
    .locals 4
    .param p1, "pkgName"    # Ljava/lang/String;
    .param p2, "id"    # I
    .param p3, "record"    # Lcom/lge/systemservice/core/LGLedRecord;

    .prologue
    const/4 v1, -0x1

    .local v1, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/systemservice/core/ILEDManager;->start(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const/4 v1, -0x1

    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public stopPattern(Ljava/lang/String;I)I
    .locals 4
    .param p1, "pkgName"    # Ljava/lang/String;
    .param p2, "id"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2, p1, p2}, Lcom/lge/systemservice/core/ILEDManager;->stop(Ljava/lang/String;I)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const/4 v1, -0x1

    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public updatePattern(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)I
    .locals 4
    .param p1, "pkgName"    # Ljava/lang/String;
    .param p2, "id"    # I
    .param p3, "record"    # Lcom/lge/systemservice/core/LGLedRecord;

    .prologue
    const/4 v1, -0x1

    .local v1, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/systemservice/core/ILEDManager;->update(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v3, "cannot get service!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const/4 v1, -0x1

    sget-object v2, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public updatePatternList(IIIIIILjava/lang/String;)I
    .locals 10
    .param p1, "action"    # I
    .param p2, "recordId"    # I
    .param p3, "exceptional"    # I
    .param p4, "ledARGB"    # I
    .param p5, "ledOnMS"    # I
    .param p6, "ledOffMS"    # I
    .param p7, "pkg"    # Ljava/lang/String;

    .prologue
    const/4 v9, -0x1

    .local v9, "result":I
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;->getService()Lcom/lge/systemservice/core/ILEDManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    :try_start_0
    iget-object v0, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/systemservice/core/LEDManager;->mService:Lcom/lge/systemservice/core/ILEDManager;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    invoke-interface/range {v0 .. v7}, Lcom/lge/systemservice/core/ILEDManager;->updateLightList(IIIIIILjava/lang/String;)I

    move-result v9

    :goto_0
    return v9

    :cond_0
    sget-object v0, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    const-string v1, "cannot get service!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v8

    .local v8, "ex":Landroid/os/RemoteException;
    const/4 v9, -0x1

    sget-object v0, Lcom/lge/systemservice/core/LEDManager;->TAG:Ljava/lang/String;

    invoke-virtual {v8}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
