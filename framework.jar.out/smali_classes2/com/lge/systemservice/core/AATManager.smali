.class public Lcom/lge/systemservice/core/AATManager;
.super Ljava/lang/Object;
.source "AATManager.java"


# static fields
.field static final SERVICE_NAME:Ljava/lang/String; = "AAT"

.field private static final TAG:Ljava/lang/String; = "AAT"

.field private static final TITLE:Ljava/lang/String; = "AATManager"


# instance fields
.field private mService:Lcom/lge/systemservice/core/IAATManager;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/AATManager;Lcom/lge/systemservice/core/IAATManager;)Lcom/lge/systemservice/core/IAATManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/AATManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IAATManager;

    .prologue
    .line 17
    iput-object p1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/IAATManager;
    .locals 4

    .prologue
    .line 31
    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    if-nez v1, :cond_0

    .line 32
    const-string v1, "AAT"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/IAATManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    .line 33
    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    if-eqz v1, :cond_0

    .line 35
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/AATManager$1;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/AATManager$1;-><init>(Lcom/lge/systemservice/core/AATManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 42
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    return-object v1

    .line 39
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    goto :goto_0
.end method


# virtual methods
.method public AATFinalize()V
    .locals 3

    .prologue
    .line 82
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] AATFinalize"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->AATFinalize()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 91
    :goto_0
    return-void

    .line 85
    :catch_0
    move-exception v0

    .line 89
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public AATInitialize()V
    .locals 3

    .prologue
    .line 60
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] AATInitialize"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 61
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->AATInitialize()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 69
    :goto_0
    return-void

    .line 63
    :catch_0
    move-exception v0

    .line 67
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public AATsetLCDOnOff(Z)V
    .locals 3
    .param p1, "Lcd_OnOff"    # Z

    .prologue
    .line 1243
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] AATsetLCDOnOff"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1244
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->AATsetLCDOnOff(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1250
    :goto_0
    return-void

    .line 1246
    :catch_0
    move-exception v0

    .line 1248
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetDetailTestSupportValue(I)Z
    .locals 3
    .param p1, "nWhatTest"    # I

    .prologue
    .line 1390
    const/4 v1, 0x1

    .line 1393
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetDetailTestSupportValue(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1399
    :goto_0
    return v1

    .line 1395
    :catch_0
    move-exception v0

    .line 1397
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetDimOnBacklightValue()F
    .locals 3

    .prologue
    .line 1430
    const/4 v1, 0x0

    .line 1433
    .local v1, "mvalue":F
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetDimOnBacklightValue()F
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1439
    :goto_0
    return v1

    .line 1435
    :catch_0
    move-exception v0

    .line 1437
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetFilePath(I)Ljava/lang/String;
    .locals 3
    .param p1, "nWhatPath"    # I

    .prologue
    .line 1410
    const-string v1, ""

    .line 1413
    .local v1, "mvalue":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetFilePath(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1419
    :goto_0
    return-object v1

    .line 1415
    :catch_0
    move-exception v0

    .line 1417
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetSupportedMenuList()[Z
    .locals 3

    .prologue
    .line 1370
    const/16 v2, 0x8

    new-array v1, v2, [Z

    .line 1373
    .local v1, "mvalue":[Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetSupportedMenuList()[Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1379
    :goto_0
    return-object v1

    .line 1375
    :catch_0
    move-exception v0

    .line 1377
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public GetUsbOnOffValue()I
    .locals 3

    .prologue
    .line 1450
    const/4 v1, -0x1

    .line 1453
    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->GetUsbOnOffValue()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1459
    :goto_0
    return v1

    .line 1455
    :catch_0
    move-exception v0

    .line 1457
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsFMRadio()Z
    .locals 3

    .prologue
    .line 970
    const/4 v1, 0x0

    .line 974
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 980
    :goto_0
    return v1

    .line 976
    :catch_0
    move-exception v0

    .line 978
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportAutoFocus()Z
    .locals 3

    .prologue
    .line 1288
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportAutoFocus"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1289
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportAutoFocus()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1297
    :goto_0
    return v1

    .line 1291
    :catch_0
    move-exception v0

    .line 1295
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 1297
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportBarometer()Z
    .locals 3

    .prologue
    .line 587
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportBarometer"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 588
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportBarometer()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 596
    :goto_0
    return v1

    .line 590
    :catch_0
    move-exception v0

    .line 594
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 596
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportGLOTestGps()Z
    .locals 3

    .prologue
    .line 206
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportGLOTestGps"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportGLOTestGps()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 215
    :goto_0
    return v1

    .line 209
    :catch_0
    move-exception v0

    .line 213
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 215
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportHookKeyTest()Z
    .locals 2

    .prologue
    .line 610
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportHookKeyTest()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 619
    :goto_0
    return v1

    .line 612
    :catch_0
    move-exception v0

    .line 616
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 619
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportInvalidAATSet()Z
    .locals 3

    .prologue
    .line 1867
    const/4 v1, 0x0

    .line 1871
    .local v1, "mInvalidAATSet":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportInvalidAATSet()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1878
    :goto_0
    return v1

    .line 1873
    :catch_0
    move-exception v0

    .line 1875
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportMura()Z
    .locals 3

    .prologue
    .line 948
    const/4 v1, 0x0

    .line 952
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportMura()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 958
    :goto_0
    return v1

    .line 954
    :catch_0
    move-exception v0

    .line 956
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportProximityCalibration()Z
    .locals 3

    .prologue
    .line 563
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportProximityCalibration"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 564
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportProximityCalibration()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 572
    :goto_0
    return v1

    .line 566
    :catch_0
    move-exception v0

    .line 570
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 572
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportShowInternalMemoryCapacity()Z
    .locals 3

    .prologue
    .line 1821
    const/4 v1, 0x0

    .line 1825
    .local v1, "mIsSupportShowInternalMemoryCapacity":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportShowInternalMemoryCapacity()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1832
    :goto_0
    return v1

    .line 1827
    :catch_0
    move-exception v0

    .line 1829
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportSubMic()Z
    .locals 3

    .prologue
    .line 1310
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportSubMic"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1311
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportSubMic()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1319
    :goto_0
    return v1

    .line 1313
    :catch_0
    move-exception v0

    .line 1317
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 1319
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportUSIM()Z
    .locals 3

    .prologue
    .line 924
    const/4 v1, 0x0

    .line 928
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportUSIM()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 936
    :goto_0
    return v1

    .line 930
    :catch_0
    move-exception v0

    .line 934
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public NFC_Disable()Z
    .locals 3

    .prologue
    .line 296
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] NFC_Disable"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 297
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Disable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 305
    :goto_0
    return v1

    .line 299
    :catch_0
    move-exception v0

    .line 303
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 305
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public NFC_Enable()Z
    .locals 3

    .prologue
    .line 273
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] NFC_Enable"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 274
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Enable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 282
    :goto_0
    return v1

    .line 276
    :catch_0
    move-exception v0

    .line 280
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 282
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public NFC_Off([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    .line 341
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_Off"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 342
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Off([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 349
    :goto_0
    return v0

    .line 344
    :catch_0
    move-exception v0

    .line 349
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_On([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    .line 319
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_On"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 320
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_On([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 327
    :goto_0
    return v0

    .line 322
    :catch_0
    move-exception v0

    .line 327
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_Reader([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    .line 409
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_Reader"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 410
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Reader([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 417
    :goto_0
    return v0

    .line 412
    :catch_0
    move-exception v0

    .line 417
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_SmartMX([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    .line 386
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_SmartMX"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 387
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_SmartMX([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 394
    :goto_0
    return v0

    .line 389
    :catch_0
    move-exception v0

    .line 394
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_Swp([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    .line 363
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_Swp"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 364
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Swp([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 371
    :goto_0
    return v0

    .line 366
    :catch_0
    move-exception v0

    .line 371
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public QwertyLedOff()V
    .locals 3

    .prologue
    .line 680
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] QwertyLedOff"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 681
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->QwertyLedOff()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 689
    :goto_0
    return-void

    .line 683
    :catch_0
    move-exception v0

    .line 687
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public QwertyLedOn()V
    .locals 3

    .prologue
    .line 658
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] QwertyLedOn"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 659
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->QwertyLedOn()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 667
    :goto_0
    return-void

    .line 661
    :catch_0
    move-exception v0

    .line 665
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public RebootforModeChange(II)V
    .locals 4
    .param p1, "index"    # I
    .param p2, "data"    # I

    .prologue
    .line 789
    :try_start_0
    const-string v1, "AAT"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[AATManager] RebootforModeChange, index : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " data : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 790
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IAATManager;->RebootforModeChange(II)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 798
    :goto_0
    return-void

    .line 792
    :catch_0
    move-exception v0

    .line 796
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public SetLoopbackParam(I)Ljava/lang/String;
    .locals 3
    .param p1, "mode"    # I

    .prologue
    .line 172
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] SetLoopbackParam"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->SetLoopbackParam(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 180
    :goto_0
    return-object v1

    .line 175
    :catch_0
    move-exception v0

    .line 179
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 180
    const-string v1, "AATManagerSetLoopbackParam error"

    goto :goto_0
.end method

.method public Start_AccCalibration([F)I
    .locals 3
    .param p1, "returnval"    # [F

    .prologue
    .line 503
    :try_start_0
    const-string v0, "AAT"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[AATManager] Start_AccCalibration return val : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 504
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->Start_AccCalibration([F)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 511
    :goto_0
    return v0

    .line 506
    :catch_0
    move-exception v0

    .line 511
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public Start_GyroCalibration()I
    .locals 2

    .prologue
    .line 517
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] Start_GyroCalibration"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 518
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/systemservice/core/IAATManager;->Start_GyroCalibration()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 525
    :goto_0
    return v0

    .line 520
    :catch_0
    move-exception v0

    .line 525
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public Start_ProximityCalibration()I
    .locals 1

    .prologue
    .line 540
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/systemservice/core/IAATManager;->Start_ProximityCalibration()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 547
    :goto_0
    return v0

    .line 542
    :catch_0
    move-exception v0

    .line 547
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public Start_SmartFactoryReset()V
    .locals 3

    .prologue
    .line 767
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] Start_SmartFactoryReset"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 768
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->Start_SmartFactoryReset()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 776
    :goto_0
    return-void

    .line 770
    :catch_0
    move-exception v0

    .line 774
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public ThresholdALC()F
    .locals 3

    .prologue
    .line 459
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] ThresholdALC"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 460
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->ThresholdALC()F
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 467
    :goto_0
    return v1

    .line 462
    :catch_0
    move-exception v0

    .line 466
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 467
    const/high16 v1, -0x40800000    # -1.0f

    goto :goto_0
.end method

.method public camcorder_submic(Z)V
    .locals 3
    .param p1, "set"    # Z

    .prologue
    .line 430
    if-eqz p1, :cond_0

    .line 432
    :try_start_0
    const-string v0, "AAT"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[AATManager] camcorder_submic : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 433
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/lge/systemservice/core/IAATManager;->camcorder_submic(Z)V

    .line 446
    :goto_0
    return-void

    .line 437
    :cond_0
    const-string v0, "AAT"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[AATManager] camcorder_submic : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 438
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lcom/lge/systemservice/core/IAATManager;->camcorder_submic(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 441
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public createFmRadioMgrFMRadio()V
    .locals 2

    .prologue
    .line 1038
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->createFmRadioMgrFMRadio()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1044
    :goto_0
    return-void

    .line 1040
    :catch_0
    move-exception v0

    .line 1042
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public disableMTS()V
    .locals 2

    .prologue
    .line 1537
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->disableMTS()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1544
    :goto_0
    return-void

    .line 1539
    :catch_0
    move-exception v0

    .line 1541
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public disableOisProp()V
    .locals 2

    .prologue
    .line 1743
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->disableOisProp()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1749
    :goto_0
    return-void

    .line 1745
    :catch_0
    move-exception v0

    .line 1747
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public disableTouchPoint()V
    .locals 3

    .prologue
    .line 1920
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] disableTouchPoint"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1921
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->disableTouchPoint()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1927
    :goto_0
    return-void

    .line 1923
    :catch_0
    move-exception v0

    .line 1925
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableMTS()V
    .locals 2

    .prologue
    .line 1524
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->enableMTS()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1531
    :goto_0
    return-void

    .line 1526
    :catch_0
    move-exception v0

    .line 1528
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableOisProp()V
    .locals 2

    .prologue
    .line 1725
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->enableOisProp()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1731
    :goto_0
    return-void

    .line 1727
    :catch_0
    move-exception v0

    .line 1729
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableTDMBTestActivity()Z
    .locals 3

    .prologue
    .line 1778
    const/4 v1, 0x0

    .line 1782
    .local v1, "enableTDMBTest":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->enableTDMBTestActivity()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1789
    :goto_0
    return v1

    .line 1784
    :catch_0
    move-exception v0

    .line 1786
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableTouchPoint()V
    .locals 3

    .prologue
    .line 1907
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] enableTouchPoint"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1908
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->enableTouchPoint()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1914
    :goto_0
    return-void

    .line 1910
    :catch_0
    move-exception v0

    .line 1912
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public felicacmdEXTIDM([B)Z
    .locals 3
    .param p1, "idm"    # [B

    .prologue
    .line 1143
    const/4 v1, 0x0

    .line 1147
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->felicacmdEXTIDM([B)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1154
    :goto_0
    return v1

    .line 1149
    :catch_0
    move-exception v0

    .line 1151
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public finalizeGps()V
    .locals 3

    .prologue
    .line 251
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] finalizeGps"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 252
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->finalizeGps()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 260
    :goto_0
    return-void

    .line 254
    :catch_0
    move-exception v0

    .line 258
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public finalizeLoopback()V
    .locals 3

    .prologue
    .line 150
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] finalizeLoopback"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 151
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->finalizeLoopback()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 159
    :goto_0
    return-void

    .line 153
    :catch_0
    move-exception v0

    .line 157
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getAATSWversion()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1656
    const-string v1, ""

    .line 1660
    .local v1, "swversion":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getAATSWversion()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1666
    :goto_0
    return-object v1

    .line 1662
    :catch_0
    move-exception v0

    .line 1664
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getAccelCalSleep()Z
    .locals 4

    .prologue
    .line 1216
    const/4 v1, 0x0

    .line 1220
    .local v1, "returnval":Z
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getAccelCalSleep"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1221
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getAccelCalSleep()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1229
    :goto_0
    return v1

    .line 1223
    :catch_0
    move-exception v0

    .line 1227
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getAccelerometerCalOption()Ljava/lang/String;
    .locals 4

    .prologue
    .line 1191
    const-string v1, ""

    .line 1195
    .local v1, "returnval":Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getAccelerometerCalOption"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1196
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getAccelerometerCalOption()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1204
    :goto_0
    return-object v1

    .line 1198
    :catch_0
    move-exception v0

    .line 1202
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getBatteryCapacityFilePath()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1596
    const-string v1, ""

    .line 1600
    .local v1, "mBatt_capacity":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getBatteryCapacityFilePath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1607
    :goto_0
    return-object v1

    .line 1602
    :catch_0
    move-exception v0

    .line 1604
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getBatteryIDFilePath()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1619
    const-string v1, ""

    .line 1623
    .local v1, "mBatt_valid_id":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getBatteryIDFilePath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1630
    :goto_0
    return-object v1

    .line 1625
    :catch_0
    move-exception v0

    .line 1627
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getBatteryThermistorFilePath()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1635
    const-string v1, ""

    .line 1639
    .local v1, "mBatteryThermistorFilePath":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getBatteryThermistorFilePath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1646
    :goto_0
    return-object v1

    .line 1641
    :catch_0
    move-exception v0

    .line 1643
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getCameraResolution()[I
    .locals 4

    .prologue
    .line 631
    const/4 v2, 0x2

    new-array v1, v2, [I

    .line 635
    .local v1, "resolution":[I
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getCameraResolution"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 636
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getCameraResolution()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 644
    :goto_0
    return-object v1

    .line 638
    :catch_0
    move-exception v0

    .line 642
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getCountSuppotedSIM()I
    .locals 3

    .prologue
    .line 832
    const/4 v1, -0x1

    .line 835
    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getCountSuppotedSIM()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 843
    :goto_0
    return v1

    .line 837
    :catch_0
    move-exception v0

    .line 841
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getHallSensorResult()[Ljava/lang/String;
    .locals 3

    .prologue
    .line 1554
    const/4 v2, 0x3

    new-array v1, v2, [Ljava/lang/String;

    .line 1558
    .local v1, "mvalue":[Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getHallSensorResult()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1564
    :goto_0
    return-object v1

    .line 1560
    :catch_0
    move-exception v0

    .line 1562
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getLedVal()[Ljava/lang/String;
    .locals 4

    .prologue
    .line 748
    const/4 v2, 0x2

    new-array v1, v2, [Ljava/lang/String;

    .line 752
    .local v1, "ledval":[Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getLedVal"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 753
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getLedVal()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 761
    :goto_0
    return-object v1

    .line 755
    :catch_0
    move-exception v0

    .line 759
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getLimitBatteryCapacity()I
    .locals 3

    .prologue
    .line 1794
    const/4 v1, 0x0

    .line 1798
    .local v1, "mLimitBatteryCapacity":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getLimitBatteryCapacity()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1805
    :goto_0
    return v1

    .line 1800
    :catch_0
    move-exception v0

    .line 1802
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getMaxVolume(I)I
    .locals 3
    .param p1, "type"    # I

    .prologue
    .line 1701
    const/4 v1, -0x1

    .line 1705
    .local v1, "mMaxVolume":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->getMaxVolume(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1712
    :goto_0
    return v1

    .line 1707
    :catch_0
    move-exception v0

    .line 1709
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getQuickMemoKeyCodeValue()I
    .locals 4

    .prologue
    .line 1261
    const/4 v1, 0x0

    .line 1265
    .local v1, "returnval":I
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getQuickMemoKeyCodeValue"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1266
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getQuickMemoKeyCodeValue()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1274
    :goto_0
    return v1

    .line 1268
    :catch_0
    move-exception v0

    .line 1272
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getQwertyStatusValue()Ljava/lang/String;
    .locals 4

    .prologue
    .line 699
    const-string v1, ""

    .line 703
    .local v1, "enableval":Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getQwertyStatusValue"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 704
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getQwertyStatusValue()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 712
    :goto_0
    return-object v1

    .line 706
    :catch_0
    move-exception v0

    .line 710
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getSaveVolume(I)I
    .locals 3
    .param p1, "type"    # I

    .prologue
    .line 1678
    const/4 v1, -0x1

    .line 1682
    .local v1, "mVolume":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->getSaveVolume(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1689
    :goto_0
    return v1

    .line 1684
    :catch_0
    move-exception v0

    .line 1686
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getSupportVideoEncorder()Ljava/lang/String;
    .locals 4

    .prologue
    .line 1166
    const-string v1, ""

    .line 1170
    .local v1, "returnval":Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getSupportVideoEncorder"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1171
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getSupportVideoEncorder()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1179
    :goto_0
    return-object v1

    .line 1173
    :catch_0
    move-exception v0

    .line 1177
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getTestOrderLength()I
    .locals 3

    .prologue
    .line 1490
    const/4 v1, -0x1

    .line 1493
    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getTestOrderLength()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1499
    :goto_0
    return v1

    .line 1495
    :catch_0
    move-exception v0

    .line 1497
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getTestOrderNumber()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1470
    const-string v1, ""

    .line 1473
    .local v1, "mvalue":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getTestOrderNumber()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1479
    :goto_0
    return-object v1

    .line 1475
    :catch_0
    move-exception v0

    .line 1477
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public initializeGps()V
    .locals 3

    .prologue
    .line 229
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] initializeGps"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 230
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->initializeGps()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 238
    :goto_0
    return-void

    .line 232
    :catch_0
    move-exception v0

    .line 236
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public initializeLoopback()V
    .locals 3

    .prologue
    .line 128
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] initializeLoopback"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 129
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->initializeLoopback()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 137
    :goto_0
    return-void

    .line 131
    :catch_0
    move-exception v0

    .line 135
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isDualSIM()Z
    .locals 3

    .prologue
    .line 809
    const/4 v1, 0x0

    .line 813
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->isDualSIM()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 821
    :goto_0
    return v1

    .line 815
    :catch_0
    move-exception v0

    .line 819
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isFactoryTestMode()Z
    .locals 3

    .prologue
    .line 1330
    const/4 v1, 0x0

    .line 1333
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->isFactoryTestMode()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1339
    :goto_0
    return v1

    .line 1335
    :catch_0
    move-exception v0

    .line 1337
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public requestToCapSensor(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "request"    # Ljava/lang/String;

    .prologue
    .line 1884
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 1886
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->requestToCapSensor(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1899
    :goto_0
    return-object v1

    .line 1890
    :cond_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] getService() is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1891
    const-string v1, "AATManagerrequestToCapSensor error"
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1894
    :catch_0
    move-exception v0

    .line 1898
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 1899
    const-string v1, "AATManagerrequestToCapSensor error"

    goto :goto_0
.end method

.method public requestToService(ILjava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "i"    # I
    .param p2, "data"    # Ljava/lang/String;

    .prologue
    .line 106
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IAATManager;->requestToService(ILjava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 113
    :goto_0
    return-object v1

    .line 108
    :catch_0
    move-exception v0

    .line 112
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 113
    const-string v1, "AATManagerrequestToService error"

    goto :goto_0
.end method

.method public resetData()V
    .locals 2

    .prologue
    .line 1512
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->resetData()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1518
    :goto_0
    return-void

    .line 1514
    :catch_0
    move-exception v0

    .line 1516
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public sendAATStatus(Ljava/lang/String;)V
    .locals 2
    .param p1, "aat_status"    # Ljava/lang/String;

    .prologue
    .line 1811
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->sendAATStatus(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1817
    :goto_0
    return-void

    .line 1813
    :catch_0
    move-exception v0

    .line 1815
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setBackLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "red"    # Ljava/lang/String;
    .param p2, "green"    # Ljava/lang/String;
    .param p3, "blue"    # Ljava/lang/String;

    .prologue
    .line 1839
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setBackLedVal"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1840
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IAATManager;->setBackLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1848
    :goto_0
    return-void

    .line 1842
    :catch_0
    move-exception v0

    .line 1846
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "red"    # Ljava/lang/String;
    .param p2, "green"    # Ljava/lang/String;
    .param p3, "blue"    # Ljava/lang/String;

    .prologue
    .line 728
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setLedVal"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 729
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IAATManager;->setLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 737
    :goto_0
    return-void

    .line 731
    :catch_0
    move-exception v0

    .line 735
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setProximityCrossTalkValue(I)V
    .locals 2
    .param p1, "proxLimit"    # I

    .prologue
    .line 1761
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->setProximityCrossTalkValue(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1767
    :goto_0
    return-void

    .line 1763
    :catch_0
    move-exception v0

    .line 1765
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setRGBLedVal(Ljava/lang/String;)V
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    .line 1853
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setRGBLedVal"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1854
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->setRGBLedVal(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1862
    :goto_0
    return-void

    .line 1856
    :catch_0
    move-exception v0

    .line 1860
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setRotationSensor(Z)V
    .locals 2
    .param p1, "enable"    # Z

    .prologue
    .line 482
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] setRotationSensor"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 483
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->setRotationSensor(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 490
    :goto_0
    return-void

    .line 485
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public setSpeakerState(Ljava/lang/String;)V
    .locals 4
    .param p1, "mSpeakerState"    # Ljava/lang/String;

    .prologue
    .line 1576
    const-string v1, "AAT"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[AATManager] setSpeakerState"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1579
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->setSpeakerState(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1585
    :goto_0
    return-void

    .line 1581
    :catch_0
    move-exception v0

    .line 1583
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setSpeakerphoneOnUse()Z
    .locals 3

    .prologue
    .line 185
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setSpeakerphoneOnUse"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 186
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->setSpeakerphoneOnUse()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 192
    :goto_0
    return v1

    .line 187
    :catch_0
    move-exception v0

    .line 190
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 192
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public startAutoScanFMRadio()Z
    .locals 3

    .prologue
    .line 1055
    const/4 v1, 0x0

    .line 1059
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->startAutoScanFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1065
    :goto_0
    return v1

    .line 1061
    :catch_0
    move-exception v0

    .line 1063
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public startBackwardScanFMRadio()Z
    .locals 3

    .prologue
    .line 1077
    const/4 v1, 0x0

    .line 1081
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->startBackwardScanFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1087
    :goto_0
    return v1

    .line 1083
    :catch_0
    move-exception v0

    .line 1085
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public startForwardScanFMRadio()Z
    .locals 3

    .prologue
    .line 1099
    const/4 v1, 0x0

    .line 1103
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->startForwardScanFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1109
    :goto_0
    return v1

    .line 1105
    :catch_0
    move-exception v0

    .line 1107
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public switchUSBMode(I)V
    .locals 2
    .param p1, "change_value"    # I

    .prologue
    .line 1353
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->switchUSBMode(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1360
    :goto_0
    return-void

    .line 1355
    :catch_0
    move-exception v0

    .line 1357
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public testDualUSIM1()I
    .locals 3

    .prologue
    .line 855
    const/4 v1, -0x1

    .line 859
    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->testDualUSIM1()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 867
    :goto_0
    return v1

    .line 861
    :catch_0
    move-exception v0

    .line 865
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public testDualUSIM2()I
    .locals 3

    .prologue
    .line 878
    const/4 v1, -0x1

    .line 882
    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->testDualUSIM2()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 890
    :goto_0
    return v1

    .line 884
    :catch_0
    move-exception v0

    .line 888
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public testDualUSIM3()I
    .locals 3

    .prologue
    .line 901
    const/4 v1, -0x1

    .line 904
    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->testDualUSIM3()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 912
    :goto_0
    return v1

    .line 906
    :catch_0
    move-exception v0

    .line 910
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public tuneFrequencyFMRadio(I)Z
    .locals 3
    .param p1, "nFreq"    # I

    .prologue
    .line 1121
    const/4 v1, 0x0

    .line 1125
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->tuneFrequencyFMRadio(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1131
    :goto_0
    return v1

    .line 1127
    :catch_0
    move-exception v0

    .line 1129
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public turnOffFMRadio()Z
    .locals 3

    .prologue
    .line 1014
    const/4 v1, 0x0

    .line 1018
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->turnOffFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1024
    :goto_0
    return v1

    .line 1020
    :catch_0
    move-exception v0

    .line 1022
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public turnOnFMRadio()Z
    .locals 3

    .prologue
    .line 992
    const/4 v1, 0x0

    .line 996
    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->turnOnFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1002
    :goto_0
    return v1

    .line 998
    :catch_0
    move-exception v0

    .line 1000
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method
