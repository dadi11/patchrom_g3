.class public Lcom/lge/uicc/framework/IccSwapDialog;
.super Landroid/os/Handler;
.source "IccSwapDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;
    }
.end annotation


# static fields
.field private static final EVENT_CARD_STATE_CHANGED:I = 0x1

.field private static mInstance:Lcom/lge/uicc/framework/IccSwapDialog;

.field public static mSimInserted:Z


# instance fields
.field private mCardState:[Ljava/lang/String;

.field private mContext:Landroid/content/Context;

.field private final mLock:Ljava/lang/Object;

.field private mProgressDialog:Landroid/app/ProgressDialog;

.field private mProgressTimer:Landroid/os/CountDownTimer;

.field private reboot_in_progress:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 52
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/uicc/framework/IccSwapDialog;->mSimInserted:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 60
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 45
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mLock:Ljava/lang/Object;

    .line 47
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "UNKNOWN"

    aput-object v1, v0, v4

    const-string v1, "UNKNOWN"

    aput-object v1, v0, v5

    const/4 v1, 0x2

    const-string v2, "UNKNOWN"

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mCardState:[Ljava/lang/String;

    .line 119
    iput-boolean v4, p0, Lcom/lge/uicc/framework/IccSwapDialog;->reboot_in_progress:Z

    .line 171
    iput-object v3, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    .line 172
    iput-object v3, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressTimer:Landroid/os/CountDownTimer;

    .line 62
    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    .line 63
    const-string v0, "card_state"

    invoke-static {v0, p0, v5, v3}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    .line 64
    const-string v0, "#operator_cardswap_dialog"

    const-string v1, "yes"

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 65
    return-void
.end method

.method static synthetic access$000(Lcom/lge/uicc/framework/IccSwapDialog;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccSwapDialog;

    .prologue
    .line 41
    iget-object v0, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mLock:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/uicc/framework/IccSwapDialog;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccSwapDialog;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/lge/uicc/framework/IccSwapDialog;->reboot(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/uicc/framework/IccSwapDialog;)Landroid/os/CountDownTimer;
    .locals 1
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccSwapDialog;

    .prologue
    .line 41
    iget-object v0, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressTimer:Landroid/os/CountDownTimer;

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/uicc/framework/IccSwapDialog;)Landroid/app/ProgressDialog;
    .locals 1
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccSwapDialog;

    .prologue
    .line 41
    iget-object v0, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    return-object v0
.end method

.method static synthetic access$400(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    .line 41
    invoke-static {p0}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private isPopupDisabled()Z
    .locals 4

    .prologue
    .line 374
    const-string v0, "ro.factorytest"

    .line 375
    .local v0, "FACTORY_PROPERTY":Ljava/lang/String;
    const-string v2, "ro.factorytest"

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 376
    .local v1, "factoryTestStr":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isPopupDisabled check value: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 377
    const-string v2, "2"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 378
    const/4 v2, 0x0

    .line 380
    :goto_0
    return v2

    :cond_0
    const/4 v2, 0x1

    goto :goto_0
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    .line 389
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[IccSwapDialog] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    .line 390
    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    .line 386
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[IccSwapDialog] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    .line 387
    return-void
.end method

.method private onIccAbsentEx()V
    .locals 15

    .prologue
    const/4 v13, 0x1

    const/4 v12, 0x0

    const/4 v14, 0x2

    .line 294
    const-string v10, "onIccAbsentEx"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 296
    const/4 v10, 0x3

    new-array v10, v10, [Ljava/lang/String;

    const-string v11, "VZW"

    aput-object v11, v10, v12

    const-string v11, "ATT"

    aput-object v11, v10, v13

    const-string v11, "TRF_ATT"

    aput-object v11, v10, v14

    invoke-static {v10}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    .line 368
    :goto_0
    return-void

    .line 299
    :cond_0
    iget-object v11, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mLock:Ljava/lang/Object;

    monitor-enter v11

    .line 300
    :try_start_0
    iget-object v10, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    invoke-virtual {v10}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v6

    .line 301
    .local v6, "pm":Landroid/content/pm/PackageManager;
    const-string v8, "com.android.LGSetupWizard"
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 304
    .local v8, "setupWizard":Ljava/lang/String;
    :try_start_1
    invoke-virtual {v6, v8}, Landroid/content/pm/PackageManager;->getApplicationEnabledSetting(Ljava/lang/String;)I

    move-result v10

    if-eq v10, v14, :cond_1

    const/4 v10, 0x2

    new-array v10, v10, [Ljava/lang/String;

    const/4 v12, 0x0

    const-string v13, "ATT"

    aput-object v13, v10, v12

    const/4 v12, 0x1

    const-string v13, "TRF_ATT"

    aput-object v13, v10, v12

    invoke-static {v10}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_1

    .line 306
    const-string v10, "No sim pop up is not displayed because of SetupWizard is enabled"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 307
    :try_start_2
    monitor-exit v11

    goto :goto_0

    .line 367
    .end local v6    # "pm":Landroid/content/pm/PackageManager;
    .end local v8    # "setupWizard":Ljava/lang/String;
    :catchall_0
    move-exception v10

    monitor-exit v11
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v10

    .line 310
    .restart local v6    # "pm":Landroid/content/pm/PackageManager;
    .restart local v8    # "setupWizard":Ljava/lang/String;
    :cond_1
    :try_start_3
    invoke-direct {p0}, Lcom/lge/uicc/framework/IccSwapDialog;->isPopupDisabled()Z

    move-result v10

    if-nez v10, :cond_2

    .line 311
    const-string v10, "fartory mode, do not display no sim pop-up"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 312
    :try_start_4
    monitor-exit v11
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 315
    :cond_2
    :try_start_5
    sget-boolean v10, Lcom/lge/uicc/framework/IccSwapDialog;->mSimInserted:Z

    if-eqz v10, :cond_3

    .line 316
    const-string v10, "SIM Removed, do not display no sim pop-up"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 317
    :try_start_6
    monitor-exit v11
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_0

    .line 319
    :cond_3
    :try_start_7
    const-string v10, "quiet_mode"

    const/4 v12, 0x0

    invoke-static {v10, v12}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v10

    const-string v12, "true"

    invoke-virtual {v10, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 321
    const-string v10, "quiet_mode is true"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 322
    :try_start_8
    monitor-exit v11
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto :goto_0

    .line 327
    :cond_4
    :try_start_9
    const-string v10, "com.lge.foldertest"

    invoke-virtual {v6, v10}, Landroid/content/pm/PackageManager;->getApplicationEnabledSetting(Ljava/lang/String;)I

    move-result v10

    if-eq v10, v14, :cond_5

    .line 328
    const-string v10, "No sim pop up is not displayed because of foldertest is enabled"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V
    :try_end_9
    .catch Ljava/lang/IllegalArgumentException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 329
    :try_start_a
    monitor-exit v11
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto :goto_0

    .line 332
    :catch_0
    move-exception v2

    .line 333
    .local v2, "e":Ljava/lang/IllegalArgumentException;
    :try_start_b
    const-string v10, "IllegalArgumentException (Unknown package) cause of missing com.lge.foldertest"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->loge(Ljava/lang/String;)V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_1
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    .line 341
    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    :cond_5
    :try_start_c
    new-instance v5, Lcom/lge/uicc/framework/IccSwapDialog$4;

    invoke-direct {v5, p0}, Lcom/lge/uicc/framework/IccSwapDialog$4;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;)V

    .line 353
    .local v5, "listener":Landroid/content/DialogInterface$OnClickListener;
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v7

    .line 354
    .local v7, "r":Landroid/content/res/Resources;
    sget v10, Lcom/lge/internal/R$string;->sp_no_simcard_popup_title:I

    invoke-virtual {v7, v10}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 355
    .local v9, "title":Ljava/lang/String;
    const v10, 0x104000a

    invoke-virtual {v7, v10}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 357
    .local v0, "buttonOkTxt":Ljava/lang/String;
    iget-object v10, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    invoke-static {v10}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    .line 358
    .local v3, "inflater":Landroid/view/LayoutInflater;
    sget v10, Lcom/lge/internal/R$layout;->no_sim_dialog:I

    const/4 v12, 0x0

    invoke-virtual {v3, v10, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    .line 360
    .local v4, "layout":Landroid/view/View;
    new-instance v10, Landroid/app/AlertDialog$Builder;

    iget-object v12, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    sget v13, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v10, v12, v13}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v10, v9}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v10

    invoke-virtual {v10, v4}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v10

    invoke-virtual {v10, v0, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v10

    invoke-virtual {v10}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 365
    .local v1, "dialog":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v10

    const/16 v12, 0x7d3

    invoke-virtual {v10, v12}, Landroid/view/Window;->setType(I)V

    .line 366
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 367
    monitor-exit v11

    goto/16 :goto_0

    .line 336
    .end local v0    # "buttonOkTxt":Ljava/lang/String;
    .end local v1    # "dialog":Landroid/app/AlertDialog;
    .end local v3    # "inflater":Landroid/view/LayoutInflater;
    .end local v4    # "layout":Landroid/view/View;
    .end local v5    # "listener":Landroid/content/DialogInterface$OnClickListener;
    .end local v7    # "r":Landroid/content/res/Resources;
    .end local v9    # "title":Ljava/lang/String;
    :catch_1
    move-exception v2

    .line 337
    .local v2, "e":Ljava/lang/Exception;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "popup is not displayed : "

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/lge/uicc/framework/IccSwapDialog;->loge(Ljava/lang/String;)V

    .line 338
    monitor-exit v11
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    goto/16 :goto_0
.end method

.method private reboot(Ljava/lang/String;)V
    .locals 4
    .param p1, "reason"    # Ljava/lang/String;

    .prologue
    .line 122
    iget-boolean v2, p0, Lcom/lge/uicc/framework/IccSwapDialog;->reboot_in_progress:Z

    if-eqz v2, :cond_0

    .line 123
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Reboot in progress: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 134
    :goto_0
    return-void

    .line 126
    :cond_0
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/lge/uicc/framework/IccSwapDialog;->reboot_in_progress:Z

    .line 127
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Reboot: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 129
    :try_start_0
    const-string v2, "power"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/os/IPowerManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/IPowerManager;

    move-result-object v1

    .line 130
    .local v1, "pm":Landroid/os/IPowerManager;
    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-interface {v1, v2, p1, v3}, Landroid/os/IPowerManager;->reboot(ZLjava/lang/String;Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 131
    .end local v1    # "pm":Landroid/os/IPowerManager;
    :catch_0
    move-exception v0

    .line 132
    .local v0, "e":Landroid/os/RemoteException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PowerManager service died! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/IccSwapDialog;->loge(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected static setup()V
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lcom/lge/uicc/framework/IccSwapDialog;->mInstance:Lcom/lge/uicc/framework/IccSwapDialog;

    if-nez v0, :cond_0

    .line 57
    new-instance v0, Lcom/lge/uicc/framework/IccSwapDialog;

    invoke-direct {v0}, Lcom/lge/uicc/framework/IccSwapDialog;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IccSwapDialog;->mInstance:Lcom/lge/uicc/framework/IccSwapDialog;

    .line 58
    :cond_0
    return-void
.end method

.method private showIccAddedDialog(I)V
    .locals 14
    .param p1, "slotId"    # I

    .prologue
    .line 137
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "showIccAddedDialog "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 138
    iget-object v13, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mLock:Ljava/lang/Object;

    monitor-enter v13

    .line 139
    :try_start_0
    new-instance v8, Lcom/lge/uicc/framework/IccSwapDialog$1;

    invoke-direct {v8, p0}, Lcom/lge/uicc/framework/IccSwapDialog$1;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;)V

    .line 152
    .local v8, "listener":Landroid/content/DialogInterface$OnClickListener;
    sget v11, Lcom/lge/internal/R$style;->Theme_LGE_Default_Dialog_Alert:I

    .line 153
    .local v11, "theme":I
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v10

    .line 154
    .local v10, "r":Landroid/content/res/Resources;
    const v0, 0x10404dd

    invoke-virtual {v10, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 155
    .local v12, "title":Ljava/lang/String;
    const v0, 0x10404de

    invoke-virtual {v10, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 156
    .local v9, "message":Ljava/lang/String;
    const v0, 0x10404df

    invoke-virtual {v10, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 158
    .local v6, "buttonTxt":Ljava/lang/String;
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, v11}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v0, v12}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v9}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v6, v8}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v7

    .line 163
    .local v7, "dialog":Landroid/app/AlertDialog;
    invoke-virtual {v7}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7da

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    .line 164
    invoke-virtual {v7}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/high16 v1, 0x200000

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 165
    invoke-virtual {v7}, Landroid/app/AlertDialog;->show()V

    .line 167
    new-instance v0, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;

    const-wide/16 v2, 0x7d0

    const-wide/16 v4, 0x3e8

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;JJ)V

    invoke-virtual {v0}, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;->start()Landroid/os/CountDownTimer;

    .line 168
    monitor-exit v13

    .line 169
    return-void

    .line 168
    .end local v6    # "buttonTxt":Ljava/lang/String;
    .end local v7    # "dialog":Landroid/app/AlertDialog;
    .end local v8    # "listener":Landroid/content/DialogInterface$OnClickListener;
    .end local v9    # "message":Ljava/lang/String;
    .end local v10    # "r":Landroid/content/res/Resources;
    .end local v11    # "theme":I
    .end local v12    # "title":Ljava/lang/String;
    :catchall_0
    move-exception v0

    monitor-exit v13
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private showIccRemovedDialog(I)V
    .locals 18
    .param p1, "slotId"    # I

    .prologue
    .line 186
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "showIccRemovedDialog "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p1

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 187
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mLock:Ljava/lang/Object;

    move-object/from16 v17, v0

    monitor-enter v17

    .line 188
    :try_start_0
    new-instance v11, Lcom/lge/uicc/framework/IccSwapDialog$2;

    move-object/from16 v0, p0

    invoke-direct {v11, v0}, Lcom/lge/uicc/framework/IccSwapDialog$2;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;)V

    .line 203
    .local v11, "listener":Landroid/content/DialogInterface$OnClickListener;
    sget v15, Lcom/lge/internal/R$style;->Theme_LGE_Default_Dialog_Alert:I

    .line 204
    .local v15, "theme":I
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v14

    .line 205
    .local v14, "r":Landroid/content/res/Resources;
    const v2, 0x10404da

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v16

    .line 208
    .local v16, "title":Ljava/lang/String;
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "LGU"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 209
    sget v2, Lcom/lge/internal/R$string;->sim_removed_title_lgu:I

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v13

    .line 226
    .local v13, "message":Ljava/lang/String;
    :goto_0
    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->isMultiSimEnabled()Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v2, 0x7

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "SKT"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "KT"

    aput-object v4, v2, v3

    const/4 v3, 0x2

    const-string v4, "DCM"

    aput-object v4, v2, v3

    const/4 v3, 0x3

    const-string v4, "SPR"

    aput-object v4, v2, v3

    const/4 v3, 0x4

    const-string v4, "VZW"

    aput-object v4, v2, v3

    const/4 v3, 0x5

    const-string v4, "ATT"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "TRF_ATT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 228
    :cond_0
    new-instance v2, Landroid/app/AlertDialog$Builder;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    invoke-direct {v2, v3, v15}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    move-object/from16 v0, v16

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2, v13}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v10

    .line 250
    .local v10, "dialog":Landroid/app/AlertDialog;
    :goto_1
    const v2, 0x104000a

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 251
    .local v9, "buttonOkTxt":Ljava/lang/String;
    const/high16 v2, 0x1040000

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 253
    .local v8, "buttonCancelTxt":Ljava/lang/String;
    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->isMultiSimEnabled()Z

    move-result v2

    if-eqz v2, :cond_9

    .line 254
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 255
    const/4 v2, -0x1

    invoke-virtual {v10, v2, v9, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 256
    const-string v2, "proxy.sim_state"

    move/from16 v0, p1

    invoke-static {v2, v0}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "PIN_REQUIRED"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 257
    const/4 v2, -0x2

    invoke-virtual {v10, v2, v8, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 286
    :cond_1
    :goto_2
    invoke-virtual {v10}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x7da

    invoke-virtual {v2, v3}, Landroid/view/Window;->setType(I)V

    .line 287
    invoke-virtual {v10}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/high16 v3, 0x200000

    invoke-virtual {v2, v3}, Landroid/view/Window;->addFlags(I)V

    .line 288
    invoke-virtual {v10}, Landroid/app/AlertDialog;->show()V

    .line 289
    monitor-exit v17

    .line 290
    return-void

    .line 210
    .end local v8    # "buttonCancelTxt":Ljava/lang/String;
    .end local v9    # "buttonOkTxt":Ljava/lang/String;
    .end local v10    # "dialog":Landroid/app/AlertDialog;
    .end local v13    # "message":Ljava/lang/String;
    :cond_2
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "SKT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 211
    sget v2, Lcom/lge/internal/R$string;->SKT_STR_USIM_ERR_RECHECK:I

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v13

    .restart local v13    # "message":Ljava/lang/String;
    goto/16 :goto_0

    .line 212
    .end local v13    # "message":Ljava/lang/String;
    :cond_3
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "KT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 213
    sget v2, Lcom/lge/internal/R$string;->KT_STR_USIM_ERR_RECHECK:I

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v13

    .restart local v13    # "message":Ljava/lang/String;
    goto/16 :goto_0

    .line 214
    .end local v13    # "message":Ljava/lang/String;
    :cond_4
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "DCM"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 215
    sget v2, Lcom/lge/internal/R$string;->sp_sim_removed_message_dcm_MLINE:I

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v13

    .restart local v13    # "message":Ljava/lang/String;
    goto/16 :goto_0

    .line 216
    .end local v13    # "message":Ljava/lang/String;
    :cond_5
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "SPR"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-static {}, Lcom/android/internal/telephony/PhoneFactory;->getDefaultPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v2

    invoke-interface {v2}, Lcom/android/internal/telephony/Phone;->getPhoneType()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_6

    .line 218
    const-string v13, "The mobile 4G network will be unavailable until you restart with a valid SIM card inserted."

    .restart local v13    # "message":Ljava/lang/String;
    goto/16 :goto_0

    .line 219
    .end local v13    # "message":Ljava/lang/String;
    :cond_6
    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "VZW"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "ATT"

    aput-object v4, v2, v3

    const/4 v3, 0x2

    const-string v4, "TRF_ATT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 220
    sget v2, Lcom/lge/internal/R$string;->sim_removed_message_confirm:I

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v13

    .restart local v13    # "message":Ljava/lang/String;
    goto/16 :goto_0

    .line 222
    .end local v13    # "message":Ljava/lang/String;
    :cond_7
    const v2, 0x10404db

    invoke-virtual {v14, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v13

    .restart local v13    # "message":Ljava/lang/String;
    goto/16 :goto_0

    .line 234
    :cond_8
    const/16 v12, 0xa

    .line 235
    .local v12, "max":I
    new-instance v2, Landroid/app/ProgressDialog;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mContext:Landroid/content/Context;

    invoke-direct {v2, v3, v15}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;I)V

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    .line 236
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    move-object/from16 v0, v16

    invoke-virtual {v2, v0}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    .line 237
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v2, v13}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 238
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    invoke-virtual {v2, v12}, Landroid/app/ProgressDialog;->setMax(I)V

    .line 239
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/app/ProgressDialog;->setProgress(I)V

    .line 240
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/app/ProgressDialog;->setProgressStyle(I)V

    .line 241
    new-instance v2, Lcom/lge/uicc/framework/IccSwapDialog$3;

    const/16 v3, 0x2af8

    int-to-long v4, v3

    const-wide/16 v6, 0x3e8

    move-object/from16 v3, p0

    invoke-direct/range {v2 .. v7}, Lcom/lge/uicc/framework/IccSwapDialog$3;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;JJ)V

    invoke-virtual {v2}, Lcom/lge/uicc/framework/IccSwapDialog$3;->start()Landroid/os/CountDownTimer;

    move-result-object v2

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressTimer:Landroid/os/CountDownTimer;

    .line 246
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/lge/uicc/framework/IccSwapDialog;->mProgressDialog:Landroid/app/ProgressDialog;

    .restart local v10    # "dialog":Landroid/app/AlertDialog;
    goto/16 :goto_1

    .line 259
    .end local v12    # "max":I
    .restart local v8    # "buttonCancelTxt":Ljava/lang/String;
    .restart local v9    # "buttonOkTxt":Ljava/lang/String;
    :cond_9
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "LGU"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 260
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 261
    const/4 v2, -0x1

    invoke-virtual {v10, v2, v9, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 262
    const/4 v2, -0x2

    invoke-virtual {v10, v2, v8, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    goto/16 :goto_2

    .line 289
    .end local v8    # "buttonCancelTxt":Ljava/lang/String;
    .end local v9    # "buttonOkTxt":Ljava/lang/String;
    .end local v10    # "dialog":Landroid/app/AlertDialog;
    .end local v11    # "listener":Landroid/content/DialogInterface$OnClickListener;
    .end local v13    # "message":Ljava/lang/String;
    .end local v14    # "r":Landroid/content/res/Resources;
    .end local v15    # "theme":I
    .end local v16    # "title":Ljava/lang/String;
    :catchall_0
    move-exception v2

    monitor-exit v17
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 263
    .restart local v8    # "buttonCancelTxt":Ljava/lang/String;
    .restart local v9    # "buttonOkTxt":Ljava/lang/String;
    .restart local v10    # "dialog":Landroid/app/AlertDialog;
    .restart local v11    # "listener":Landroid/content/DialogInterface$OnClickListener;
    .restart local v13    # "message":Ljava/lang/String;
    .restart local v14    # "r":Landroid/content/res/Resources;
    .restart local v15    # "theme":I
    .restart local v16    # "title":Ljava/lang/String;
    :cond_a
    const/4 v2, 0x1

    :try_start_1
    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "SKT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 264
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 265
    const/4 v2, -0x3

    invoke-virtual {v10, v2, v9, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 266
    new-instance v2, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;

    const-wide/16 v4, 0x1388

    const-wide/16 v6, 0x3e8

    move-object/from16 v3, p0

    invoke-direct/range {v2 .. v7}, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;JJ)V

    invoke-virtual {v2}, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;->start()Landroid/os/CountDownTimer;

    goto/16 :goto_2

    .line 267
    :cond_b
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "KT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 268
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 269
    const/4 v3, -0x3

    const/4 v2, 0x0

    check-cast v2, Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v10, v3, v9, v2}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    goto/16 :goto_2

    .line 270
    :cond_c
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "DCM"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_d

    .line 271
    new-instance v2, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;

    const-wide/16 v4, 0xbb8

    const-wide/16 v6, 0x3e8

    move-object/from16 v3, p0

    invoke-direct/range {v2 .. v7}, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;-><init>(Lcom/lge/uicc/framework/IccSwapDialog;JJ)V

    invoke-virtual {v2}, Lcom/lge/uicc/framework/IccSwapDialog$RebootTimer;->start()Landroid/os/CountDownTimer;

    goto/16 :goto_2

    .line 272
    :cond_d
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "SPR"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 273
    invoke-static {}, Lcom/android/internal/telephony/PhoneFactory;->getDefaultPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v2

    invoke-interface {v2}, Lcom/android/internal/telephony/Phone;->getPhoneType()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_e

    .line 274
    const/4 v3, -0x3

    const/4 v2, 0x0

    check-cast v2, Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v10, v3, v9, v2}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    goto/16 :goto_2

    .line 276
    :cond_e
    const/4 v2, -0x3

    invoke-virtual {v10, v2, v9, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    goto/16 :goto_2

    .line 278
    :cond_f
    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "VZW"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "ATT"

    aput-object v4, v2, v3

    const/4 v3, 0x2

    const-string v4, "TRF_ATT"

    aput-object v4, v2, v3

    invoke-static {v2}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 279
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 280
    const/4 v2, -0x1

    sget v3, Lcom/lge/internal/R$string;->alert_dialog_yes:I

    invoke-virtual {v14, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v10, v2, v3, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 281
    const/4 v2, -0x2

    sget v3, Lcom/lge/internal/R$string;->alert_dialog_no:I

    invoke-virtual {v14, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v10, v2, v3, v11}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_2
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 73
    iget v4, p1, Landroid/os/Message;->what:I

    packed-switch v4, :pswitch_data_0

    .line 114
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unknown Event "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->what:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/uicc/framework/IccSwapDialog;->loge(Ljava/lang/String;)V

    .line 117
    :cond_0
    :goto_0
    return-void

    .line 75
    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 76
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v4, :cond_0

    .line 78
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 80
    .local v3, "slotId":I
    iget-object v4, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mCardState:[Ljava/lang/String;

    aget-object v2, v4, v3

    .line 81
    .local v2, "oldState":Ljava/lang/String;
    const-string v4, "card_state"

    invoke-static {v4, v3}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 82
    .local v1, "newState":Ljava/lang/String;
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 85
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_CARD_STATE_CHANGED: [slot"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " -> "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    .line 86
    const-string v4, "radio_state"

    invoke-static {v4, v3}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v4

    const-string v5, "ON"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 87
    const-string v4, "radio off or unavailable"

    invoke-static {v4}, Lcom/lge/uicc/framework/IccSwapDialog;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 92
    :cond_1
    const-string v4, "SIM_DETECT_INSERTED"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    const-string v4, "SIM_DETECT_INSERTED"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 93
    invoke-direct {p0, v3}, Lcom/lge/uicc/framework/IccSwapDialog;->showIccAddedDialog(I)V

    .line 98
    :cond_2
    :goto_1
    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->isMultiSimEnabled()Z

    move-result v4

    if-nez v4, :cond_3

    .line 99
    const-string v4, "ABSENT"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    const-string v4, "ABSENT"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 101
    invoke-direct {p0}, Lcom/lge/uicc/framework/IccSwapDialog;->onIccAbsentEx()V

    .line 110
    :cond_3
    :goto_2
    iget-object v4, p0, Lcom/lge/uicc/framework/IccSwapDialog;->mCardState:[Ljava/lang/String;

    aput-object v1, v4, v3

    goto/16 :goto_0

    .line 94
    :cond_4
    const-string v4, "REMOVED"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "REMOVED"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 95
    invoke-direct {p0, v3}, Lcom/lge/uicc/framework/IccSwapDialog;->showIccRemovedDialog(I)V

    goto :goto_1

    .line 104
    :cond_5
    const-string v4, "PRESENT"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    const-string v4, "PRESENT"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 105
    const/4 v4, 0x1

    sput-boolean v4, Lcom/lge/uicc/framework/IccSwapDialog;->mSimInserted:Z

    goto :goto_2

    .line 73
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method
