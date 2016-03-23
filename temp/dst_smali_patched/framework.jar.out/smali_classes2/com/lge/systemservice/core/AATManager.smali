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
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/AATManager;Lcom/lge/systemservice/core/IAATManager;)Lcom/lge/systemservice/core/IAATManager;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/AATManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/IAATManager;

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    return-object p1
.end method

.method private final getService()Lcom/lge/systemservice/core/IAATManager;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    if-nez v1, :cond_0

    const-string v1, "AAT"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/IAATManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    if-eqz v1, :cond_0

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

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;

    return-object v1

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
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] AATFinalize"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->AATFinalize()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public AATInitialize()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] AATInitialize"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->AATInitialize()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public AATsetLCDOnOff(Z)V
    .locals 3
    .param p1, "Lcd_OnOff"    # Z

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] AATsetLCDOnOff"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->AATsetLCDOnOff(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetDetailTestSupportValue(I)Z
    .locals 3
    .param p1, "nWhatTest"    # I

    .prologue
    const/4 v1, 0x1

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetDetailTestSupportValue(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetDimOnBacklightValue()F
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":F
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetDimOnBacklightValue()F
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetFilePath(I)Ljava/lang/String;
    .locals 3
    .param p1, "nWhatPath"    # I

    .prologue
    const-string v1, ""

    .local v1, "mvalue":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetFilePath(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public FolderTest_GetSupportedMenuList()[Z
    .locals 3

    .prologue
    const/16 v2, 0x8

    new-array v1, v2, [Z

    .local v1, "mvalue":[Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->FolderTest_GetSupportedMenuList()[Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public GetUsbOnOffValue()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->GetUsbOnOffValue()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsFMRadio()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportAutoFocus()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportAutoFocus"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportAutoFocus()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportBarometer()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportBarometer"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportBarometer()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportGLOTestGps()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportGLOTestGps"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportGLOTestGps()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportHookKeyTest()Z
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportHookKeyTest()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportInvalidAATSet()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mInvalidAATSet":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportInvalidAATSet()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportMura()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportMura()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportProximityCalibration()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportProximityCalibration"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportProximityCalibration()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportShowInternalMemoryCapacity()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mIsSupportShowInternalMemoryCapacity":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportShowInternalMemoryCapacity()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public IsSupportSubMic()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] IsSupportSubMic"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->IsSupportSubMic()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public IsSupportUSIM()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->IsSupportUSIM()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public NFC_Disable()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] NFC_Disable"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Disable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public NFC_Enable()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] NFC_Enable"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Enable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public NFC_Off([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_Off"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Off([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_On([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_On"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_On([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_Reader([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_Reader"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Reader([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_SmartMX([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_SmartMX"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_SmartMX([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public NFC_Swp([B)I
    .locals 2
    .param p1, "response"    # [B

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] NFC_Swp"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->NFC_Swp([B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public QwertyLedOff()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] QwertyLedOff"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->QwertyLedOff()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public QwertyLedOn()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] QwertyLedOn"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->QwertyLedOn()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public RebootforModeChange(II)V
    .locals 4
    .param p1, "index"    # I
    .param p2, "data"    # I

    .prologue
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

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IAATManager;->RebootforModeChange(II)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public SetLoopbackParam(I)Ljava/lang/String;
    .locals 3
    .param p1, "mode"    # I

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] SetLoopbackParam"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->SetLoopbackParam(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const-string v1, "AATManagerSetLoopbackParam error"

    goto :goto_0
.end method

.method public Start_AccCalibration([F)I
    .locals 3
    .param p1, "returnval"    # [F

    .prologue
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

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->Start_AccCalibration([F)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public Start_GyroCalibration()I
    .locals 2

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] Start_GyroCalibration"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/systemservice/core/IAATManager;->Start_GyroCalibration()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public Start_ProximityCalibration()I
    .locals 1

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/systemservice/core/IAATManager;->Start_ProximityCalibration()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    return v0

    :catch_0
    move-exception v0

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public Start_SmartFactoryReset()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] Start_SmartFactoryReset"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->Start_SmartFactoryReset()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public ThresholdALC()F
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] ThresholdALC"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->ThresholdALC()F
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/high16 v1, -0x40800000    # -1.0f

    goto :goto_0
.end method

.method public camcorder_submic(Z)V
    .locals 3
    .param p1, "set"    # Z

    .prologue
    if-eqz p1, :cond_0

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

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/lge/systemservice/core/IAATManager;->camcorder_submic(Z)V

    :goto_0
    return-void

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

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lcom/lge/systemservice/core/IAATManager;->camcorder_submic(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public createFmRadioMgrFMRadio()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->createFmRadioMgrFMRadio()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public disableMTS()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->disableMTS()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public disableOisProp()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->disableOisProp()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public disableTouchPoint()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] disableTouchPoint"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->disableTouchPoint()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableMTS()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->enableMTS()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableOisProp()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->enableOisProp()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableTDMBTestActivity()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "enableTDMBTest":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->enableTDMBTestActivity()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public enableTouchPoint()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] enableTouchPoint"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->enableTouchPoint()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public felicacmdEXTIDM([B)Z
    .locals 3
    .param p1, "idm"    # [B

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->felicacmdEXTIDM([B)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public finalizeGps()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] finalizeGps"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->finalizeGps()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public finalizeLoopback()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] finalizeLoopback"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->finalizeLoopback()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getAATSWversion()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v1, ""

    .local v1, "swversion":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getAATSWversion()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getAccelCalSleep()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .local v1, "returnval":Z
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getAccelCalSleep"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getAccelCalSleep()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getAccelerometerCalOption()Ljava/lang/String;
    .locals 4

    .prologue
    const-string v1, ""

    .local v1, "returnval":Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getAccelerometerCalOption"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getAccelerometerCalOption()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getBatteryCapacityFilePath()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v1, ""

    .local v1, "mBatt_capacity":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getBatteryCapacityFilePath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getBatteryIDFilePath()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v1, ""

    .local v1, "mBatt_valid_id":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getBatteryIDFilePath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getBatteryThermistorFilePath()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v1, ""

    .local v1, "mBatteryThermistorFilePath":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getBatteryThermistorFilePath()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getCameraResolution()[I
    .locals 4

    .prologue
    const/4 v2, 0x2

    new-array v1, v2, [I

    .local v1, "resolution":[I
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getCameraResolution"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getCameraResolution()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getCountSuppotedSIM()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getCountSuppotedSIM()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getHallSensorResult()[Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x3

    new-array v1, v2, [Ljava/lang/String;

    .local v1, "mvalue":[Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getHallSensorResult()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getLedVal()[Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v2, 0x2

    new-array v1, v2, [Ljava/lang/String;

    .local v1, "ledval":[Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getLedVal"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getLedVal()[Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getLimitBatteryCapacity()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mLimitBatteryCapacity":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getLimitBatteryCapacity()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getMaxVolume(I)I
    .locals 3
    .param p1, "type"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "mMaxVolume":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->getMaxVolume(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getQuickMemoKeyCodeValue()I
    .locals 4

    .prologue
    const/4 v1, 0x0

    .local v1, "returnval":I
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getQuickMemoKeyCodeValue"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getQuickMemoKeyCodeValue()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getQwertyStatusValue()Ljava/lang/String;
    .locals 4

    .prologue
    const-string v1, ""

    .local v1, "enableval":Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getQwertyStatusValue"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getQwertyStatusValue()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getSaveVolume(I)I
    .locals 3
    .param p1, "type"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "mVolume":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->getSaveVolume(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getSupportVideoEncorder()Ljava/lang/String;
    .locals 4

    .prologue
    const-string v1, ""

    .local v1, "returnval":Ljava/lang/String;
    :try_start_0
    const-string v2, "AAT"

    const-string v3, "[AATManager] getSupportVideoEncorder"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getSupportVideoEncorder()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getTestOrderLength()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getTestOrderLength()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public getTestOrderNumber()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v1, ""

    .local v1, "mvalue":Ljava/lang/String;
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->getTestOrderNumber()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public initializeGps()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] initializeGps"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->initializeGps()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public initializeLoopback()V
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] initializeLoopback"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->initializeLoopback()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isDualSIM()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->isDualSIM()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isFactoryTestMode()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->isFactoryTestMode()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public requestToCapSensor(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "request"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->requestToCapSensor(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] getService() is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "AATManagerrequestToCapSensor error"
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const-string v1, "AATManagerrequestToCapSensor error"

    goto :goto_0
.end method

.method public requestToService(ILjava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "i"    # I
    .param p2, "data"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/lge/systemservice/core/IAATManager;->requestToService(ILjava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const-string v1, "AATManagerrequestToService error"

    goto :goto_0
.end method

.method public resetData()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->resetData()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public sendAATStatus(Ljava/lang/String;)V
    .locals 2
    .param p1, "aat_status"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->sendAATStatus(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

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
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setBackLedVal"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IAATManager;->setBackLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

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
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setLedVal"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/systemservice/core/IAATManager;->setLedVal(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setProximityCrossTalkValue(I)V
    .locals 2
    .param p1, "proxLimit"    # I

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->setProximityCrossTalkValue(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setRGBLedVal(Ljava/lang/String;)V
    .locals 3
    .param p1, "val"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setRGBLedVal"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->setRGBLedVal(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setRotationSensor(Z)V
    .locals 2
    .param p1, "enable"    # Z

    .prologue
    :try_start_0
    const-string v0, "AAT"

    const-string v1, "[AATManager] setRotationSensor"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/IAATManager;->setRotationSensor(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public setSpeakerState(Ljava/lang/String;)V
    .locals 4
    .param p1, "mSpeakerState"    # Ljava/lang/String;

    .prologue
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

    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->setSpeakerState(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setSpeakerphoneOnUse()Z
    .locals 3

    .prologue
    :try_start_0
    const-string v1, "AAT"

    const-string v2, "[AATManager] setSpeakerphoneOnUse"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/systemservice/core/IAATManager;->setSpeakerphoneOnUse()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public startAutoScanFMRadio()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->startAutoScanFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public startBackwardScanFMRadio()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->startBackwardScanFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public startForwardScanFMRadio()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->startForwardScanFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public switchUSBMode(I)V
    .locals 2
    .param p1, "change_value"    # I

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/systemservice/core/IAATManager;->switchUSBMode(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public testDualUSIM1()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->testDualUSIM1()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public testDualUSIM2()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->testDualUSIM2()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public testDualUSIM3()I
    .locals 3

    .prologue
    const/4 v1, -0x1

    .local v1, "mvalue":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->testDualUSIM3()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public tuneFrequencyFMRadio(I)Z
    .locals 3
    .param p1, "nFreq"    # I

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/systemservice/core/IAATManager;->tuneFrequencyFMRadio(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public turnOffFMRadio()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->turnOffFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public turnOnFMRadio()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mvalue":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/systemservice/core/IAATManager;->turnOnFMRadio()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method
