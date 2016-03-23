.class public Lcom/lge/hardware/LGCamera$LGParameters;
.super Ljava/lang/Object;
.source "LGCamera.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/hardware/LGCamera;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "LGParameters"
.end annotation


# static fields
.field private static final KEY_BACKLIGHT_CONDITION:Ljava/lang/String; = "backlight-condition"

.field private static final KEY_BEAUTY:Ljava/lang/String; = "beautyshot"

.field private static final KEY_FLASH_MODE:Ljava/lang/String; = "flash-mode"

.field private static final KEY_FLASH_STATUS:Ljava/lang/String; = "flash-status"

.field private static final KEY_FOCUS_MODE_OBJECT_TRACKING:Ljava/lang/String; = "object-tracking"

.field private static final KEY_HDR_MODE:Ljava/lang/String; = "hdr-mode"

.field private static final KEY_LG_MULTI_WINDOW_FOCUS_AREA:Ljava/lang/String; = "multi-window-focus-area"

.field private static final KEY_LUMINANCE_CONDITION:Ljava/lang/String; = "luminance-condition"

.field private static final KEY_QC_SCENE_DETECT:Ljava/lang/String; = "scene-detect"

.field private static final KEY_SUPERZOOM:Ljava/lang/String; = "superzoom"

.field private static final KEY_ZOOM:Ljava/lang/String; = "zoom"

.field public static final SCENE_MODE_AUTO:Ljava/lang/String; = "auto"

.field public static final SCENE_MODE_NIGHT:Ljava/lang/String; = "night"


# instance fields
.field backlightCondition:Ljava/lang/String;

.field luminanceCondition:Ljava/lang/String;

.field mCurrentFlash:Ljava/lang/String;

.field mFlashStatus:Ljava/lang/String;

.field mHDRstatus:Ljava/lang/String;

.field mIsBeauty:Ljava/lang/String;

.field mIsCurrentFlash:Z

.field mIsFlashAuto:Z

.field mIsFlashOff:Z

.field mIsFlashOn:Z

.field mIsHDRAuto:Z

.field mIsHDROff:Z

.field mIsHDROn:Z

.field mIsHighBackLight:Z

.field mIsLuminanceEis:Z

.field mIsLuminanceHigh:Z

.field mIsSuperZoomEnabled:Z

.field private mParameters:Landroid/hardware/Camera$Parameters;

.field mSuperZoomStatus:I

.field mshotMode:Ljava/lang/String;

.field final synthetic this$0:Lcom/lge/hardware/LGCamera;


# direct methods
.method public constructor <init>(Lcom/lge/hardware/LGCamera;)V
    .locals 2

    .prologue
    .line 379
    iput-object p1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->this$0:Lcom/lge/hardware/LGCamera;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 381
    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {p1}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v0

    if-nez v0, :cond_1

    .line 382
    const-string v0, "LGCamera"

    const-string v1, "Camera hardware is not opened!. open camera first."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 389
    :cond_0
    :goto_0
    return-void

    .line 385
    :cond_1
    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {p1}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v0

    invoke-virtual {v0}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    .line 386
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    if-nez v0, :cond_0

    .line 387
    const-string v0, "LGCamera"

    const-string v1, "didn\'t get native parameters."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private checkBacklightStatus()V
    .locals 3

    .prologue
    .line 479
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHighBackLight:Z

    if-eqz v0, :cond_0

    .line 480
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] HDR_auto BL_high SZ_off"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 481
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->setHDROnParam()V

    .line 489
    :goto_0
    return-void

    .line 485
    :cond_0
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] BL_low HDR_off"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 486
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "hdr-mode"

    const-string v2, "0"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 487
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkSceneStatus()V

    goto :goto_0
.end method

.method private checkFlashStatus()V
    .locals 2

    .prologue
    .line 526
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashOn:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashAuto:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsCurrentFlash:Z

    if-eqz v0, :cond_1

    .line 527
    :cond_0
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] flash_on"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 528
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->setDefaultParam()V

    .line 534
    :goto_0
    return-void

    .line 531
    :cond_1
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] flash_off"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 532
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkLuminanceStatus()V

    goto :goto_0
.end method

.method private checkHDRStatus()V
    .locals 3

    .prologue
    .line 493
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHDRAuto:Z

    if-eqz v0, :cond_0

    .line 494
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkBacklightStatus()V

    .line 508
    :goto_0
    return-void

    .line 498
    :cond_0
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHDROn:Z

    if-eqz v0, :cond_1

    .line 499
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] HDR_on SZ_off"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 500
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->setHDROnParam()V

    goto :goto_0

    .line 504
    :cond_1
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] HDR_off"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 505
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "hdr-mode"

    const-string v2, "0"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 506
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkSceneStatus()V

    goto :goto_0
.end method

.method private checkLuminanceStatus()V
    .locals 3

    .prologue
    .line 512
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceHigh:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceEis:Z

    if-eqz v0, :cond_1

    .line 514
    :cond_0
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkHDRStatus()V

    .line 522
    :goto_0
    return-void

    .line 519
    :cond_1
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "hdr-mode"

    const-string v2, "0"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 520
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkSuperZoomStatus()V

    goto :goto_0
.end method

.method private checkSceneStatus()V
    .locals 2

    .prologue
    .line 467
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceEis:Z

    if-eqz v0, :cond_0

    .line 468
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "night"

    invoke-virtual {v0, v1}, Landroid/hardware/Camera$Parameters;->setSceneMode(Ljava/lang/String;)V

    .line 469
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] EIS Scene_Night"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 475
    :goto_0
    return-void

    .line 472
    :cond_0
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "auto"

    invoke-virtual {v0, v1}, Landroid/hardware/Camera$Parameters;->setSceneMode(Ljava/lang/String;)V

    .line 473
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] Scene_Auto"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private checkSuperZoomStatus()V
    .locals 3

    .prologue
    .line 451
    iget-boolean v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsSuperZoomEnabled:Z

    if-eqz v0, :cond_0

    .line 452
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "superzoom"

    const-string v2, "on"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 454
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "auto"

    invoke-virtual {v0, v1}, Landroid/hardware/Camera$Parameters;->setSceneMode(Ljava/lang/String;)V

    .line 455
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] lumi_low : SZ_on Scene_Auto"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 464
    :goto_0
    return-void

    .line 459
    :cond_0
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "superzoom"

    const-string v2, "off"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 461
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "night"

    invoke-virtual {v0, v1}, Landroid/hardware/Camera$Parameters;->setSceneMode(Ljava/lang/String;)V

    .line 462
    const-string v0, "LGCamera"

    const-string v1, "[LGSF] lumi_low : SZ_off Scene_Night"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private setDefaultParam()V
    .locals 3

    .prologue
    .line 438
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "superzoom"

    const-string v2, "off"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 439
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "hdr-mode"

    const-string v2, "0"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 440
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "auto"

    invoke-virtual {v0, v1}, Landroid/hardware/Camera$Parameters;->setSceneMode(Ljava/lang/String;)V

    .line 441
    return-void
.end method

.method private setHDROnParam()V
    .locals 3

    .prologue
    .line 444
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "hdr-mode"

    const-string v2, "1"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 445
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "superzoom"

    const-string v2, "off"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 446
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "auto"

    invoke-virtual {v0, v1}, Landroid/hardware/Camera$Parameters;->setSceneMode(Ljava/lang/String;)V

    .line 447
    return-void
.end method

.method private setLGParameters()V
    .locals 3

    .prologue
    .line 671
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    const-string v1, "mode_normal"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 672
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    const-string v1, "mode_burst"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 673
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->setDefaultParam()V

    .line 695
    :cond_0
    :goto_0
    return-void

    .line 675
    :cond_1
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsBeauty:Ljava/lang/String;

    const-string v1, "mode_beauty"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 677
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    const-string v1, "mode_beauty=0"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 679
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "beautyshot"

    const-string v2, "off"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 680
    const-string v0, "LGCamera"

    const-string v1, "[LGSF]Beautyshot : level is 0 and normal mode"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 687
    :goto_1
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkLuminanceStatus()V

    goto :goto_0

    .line 684
    :cond_2
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "beautyshot"

    const-string v2, "on"

    invoke-virtual {v0, v1, v2}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 685
    const-string v0, "LGCamera"

    const-string v1, "[LGSF]Beautyshot : level is higher than 0 and  not normal mode"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 691
    :cond_3
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    const-string v1, "mode_normal"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 692
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->checkFlashStatus()V

    goto :goto_0
.end method


# virtual methods
.method public getMultiWindowFocusAreas()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/hardware/Camera$Area;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    .line 781
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v3, "multi-window-focus-area"

    invoke-virtual {v2, v3}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 783
    .local v0, "area":Ljava/lang/String;
    :try_start_0
    # getter for: Lcom/lge/hardware/LGCamera;->sSplitAreaMethod:Ljava/lang/Object;
    invoke-static {}, Lcom/lge/hardware/LGCamera;->access$100()Ljava/lang/Object;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v0, v4, v5

    invoke-static {v2, v3, v4}, Lcom/lge/util/ProxyUtil;->invokeMethod(Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 787
    :goto_0
    return-object v2

    .line 784
    :catch_0
    move-exception v1

    .line 785
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "LGCamera"

    invoke-virtual {v1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 787
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "Param"    # Ljava/lang/String;
    .param p2, "Status"    # Ljava/lang/String;

    .prologue
    .line 429
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 430
    const/4 v0, 0x1

    .line 433
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getParameters()Landroid/hardware/Camera$Parameters;
    .locals 1

    .prologue
    .line 399
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    return-object v0
.end method

.method public setNightandHDRorAuto(Landroid/hardware/Camera$Parameters;Ljava/lang/String;Z)Landroid/hardware/Camera$Parameters;
    .locals 5
    .param p1, "Param"    # Landroid/hardware/Camera$Parameters;
    .param p2, "modeType"    # Ljava/lang/String;
    .param p3, "recording_flag"    # Z

    .prologue
    const/4 v3, 0x0

    .line 547
    iput-object p1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    .line 549
    iput-object p2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    .line 550
    const-string v0, "mode_beauty"

    .line 553
    .local v0, "beautyShot":Ljava/lang/String;
    if-eqz p3, :cond_0

    .line 555
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->setDefaultParam()V

    .line 557
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v2}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    invoke-virtual {v2, v3}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 558
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    .line 661
    :goto_0
    return-object v2

    .line 564
    :cond_0
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string/jumbo v4, "zoom"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 565
    .local v1, "temp":Ljava/lang/String;
    if-nez v1, :cond_1

    .line 566
    iput v3, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mSuperZoomStatus:I

    .line 571
    :goto_1
    iget v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mSuperZoomStatus:I

    const/16 v4, 0xa

    if-lt v2, v4, :cond_2

    const/4 v2, 0x1

    :goto_2
    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsSuperZoomEnabled:Z

    .line 573
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v4, "luminance-condition"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->luminanceCondition:Ljava/lang/String;

    .line 575
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->luminanceCondition:Ljava/lang/String;

    const-string v4, "high"

    invoke-virtual {p0, v2, v4}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceHigh:Z

    .line 576
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->luminanceCondition:Ljava/lang/String;

    const-string v4, "eis"

    invoke-virtual {p0, v2, v4}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceEis:Z

    .line 579
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v4, "backlight-condition"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->backlightCondition:Ljava/lang/String;

    .line 580
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->backlightCondition:Ljava/lang/String;

    const-string v4, "high"

    invoke-virtual {p0, v2, v4}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHighBackLight:Z

    .line 583
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v4, "flash-mode"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mFlashStatus:Ljava/lang/String;

    .line 584
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mFlashStatus:Ljava/lang/String;

    const-string v4, "off"

    invoke-virtual {p0, v2, v4}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashOff:Z

    .line 592
    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHighBackLight:Z

    if-nez v2, :cond_3

    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceHigh:Z

    if-eqz v2, :cond_3

    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsSuperZoomEnabled:Z

    if-nez v2, :cond_3

    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashOff:Z

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    const-string v4, "mode_normal"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 594
    const-string v2, "LGCamera"

    const-string v3, "[LGSF] return1"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 595
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v2}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    invoke-virtual {v2, v3}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 596
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    goto/16 :goto_0

    .line 569
    :cond_1
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string/jumbo v4, "zoom"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->getInt(Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mSuperZoomStatus:I

    goto/16 :goto_1

    :cond_2
    move v2, v3

    .line 571
    goto/16 :goto_2

    .line 617
    :cond_3
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v4, "hdr-mode"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mHDRstatus:Ljava/lang/String;

    .line 619
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v4, "flash-status"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mCurrentFlash:Ljava/lang/String;

    .line 621
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    if-le v2, v4, :cond_4

    .line 622
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsBeauty:Ljava/lang/String;

    .line 634
    :cond_4
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mFlashStatus:Ljava/lang/String;

    const-string v3, "on"

    invoke-virtual {p0, v2, v3}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashOn:Z

    .line 635
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mFlashStatus:Ljava/lang/String;

    const-string v3, "auto"

    invoke-virtual {p0, v2, v3}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashAuto:Z

    .line 636
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mHDRstatus:Ljava/lang/String;

    const-string v3, "0"

    invoke-virtual {p0, v2, v3}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHDROff:Z

    .line 637
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mHDRstatus:Ljava/lang/String;

    const-string v3, "1"

    invoke-virtual {p0, v2, v3}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHDROn:Z

    .line 638
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mHDRstatus:Ljava/lang/String;

    const-string v3, "2"

    invoke-virtual {p0, v2, v3}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHDRAuto:Z

    .line 640
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mCurrentFlash:Ljava/lang/String;

    const-string v3, "on"

    invoke-virtual {p0, v2, v3}, Lcom/lge/hardware/LGCamera$LGParameters;->getParamStatus(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsCurrentFlash:Z

    .line 653
    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsHighBackLight:Z

    if-nez v2, :cond_5

    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsLuminanceHigh:Z

    if-eqz v2, :cond_5

    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsSuperZoomEnabled:Z

    if-nez v2, :cond_5

    iget-boolean v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsFlashOff:Z

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mshotMode:Ljava/lang/String;

    const-string v3, "mode_normal"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    .line 655
    :cond_5
    invoke-direct {p0}, Lcom/lge/hardware/LGCamera$LGParameters;->setLGParameters()V

    .line 660
    :goto_3
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v2}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    invoke-virtual {v2, v3}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 661
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    goto/16 :goto_0

    .line 658
    :cond_6
    const-string v2, "LGCamera"

    const-string v3, "[LGSF] return2"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_3
.end method

.method public setObjectTracking(Ljava/lang/String;)V
    .locals 2
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 797
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "object-tracking"

    invoke-virtual {v0, v1, p1}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 798
    return-void
.end method

.method public setParameters(Landroid/hardware/Camera$Parameters;)V
    .locals 2
    .param p1, "param"    # Landroid/hardware/Camera$Parameters;

    .prologue
    .line 410
    iput-object p1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    .line 411
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v0}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    invoke-virtual {v0, v1}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 412
    return-void
.end method

.method public setSceneDetectMode(Ljava/lang/String;)V
    .locals 2
    .param p1, "value"    # Ljava/lang/String;

    .prologue
    .line 425
    iget-object v0, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v1, "scene-detect"

    invoke-virtual {v0, v1, p1}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 426
    return-void
.end method

.method public setSuperZoom(Landroid/hardware/Camera$Parameters;)Landroid/hardware/Camera$Parameters;
    .locals 4
    .param p1, "Param"    # Landroid/hardware/Camera$Parameters;

    .prologue
    const/4 v1, 0x0

    .line 707
    iput-object p1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    .line 709
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string/jumbo v3, "zoom"

    invoke-virtual {v2, v3}, Landroid/hardware/Camera$Parameters;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 711
    .local v0, "temp":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 712
    iput v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mSuperZoomStatus:I

    .line 718
    :goto_0
    iget v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mSuperZoomStatus:I

    const/16 v3, 0xa

    if-lt v2, v3, :cond_0

    const/4 v1, 0x1

    :cond_0
    iput-boolean v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsSuperZoomEnabled:Z

    .line 719
    iget-boolean v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mIsSuperZoomEnabled:Z

    if-eqz v1, :cond_2

    .line 720
    iget-object v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v2, "superzoom"

    const-string v3, "on"

    invoke-virtual {v1, v2, v3}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 725
    :goto_1
    iget-object v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v1}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    invoke-virtual {v1, v2}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 726
    iget-object v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    return-object v1

    .line 715
    :cond_1
    iget-object v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string/jumbo v3, "zoom"

    invoke-virtual {v2, v3}, Landroid/hardware/Camera$Parameters;->getInt(Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mSuperZoomStatus:I

    goto :goto_0

    .line 723
    :cond_2
    iget-object v1, p0, Lcom/lge/hardware/LGCamera$LGParameters;->mParameters:Landroid/hardware/Camera$Parameters;

    const-string v2, "superzoom"

    const-string v3, "off"

    invoke-virtual {v1, v2, v3}, Landroid/hardware/Camera$Parameters;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method
