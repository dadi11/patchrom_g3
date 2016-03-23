.class public Lcom/lge/app/floating/FloatingWindowService;
.super Landroid/app/Service;
.source "FloatingWindowService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;
    }
.end annotation


# static fields
.field private static final ACTION_ACCESSORY_EVENT:Ljava/lang/String; = "com.lge.android.intent.action.ACCESSORY_COVER_EVENT"

.field private static final ACTION_CAMERA_STARTED:Ljava/lang/String; = "com.lge.camera.action.LGE_CAMERA_STARTED"

.field private static final ACTION_FLOATING_CALL_INCOMMING:Ljava/lang/String; = "com.lge.action.CALLALERTING_SHOW"

.field private static final ACTION_FULLSCREEN_CALL_INCOMING:Ljava/lang/String; = "com.lge.action.INCOMING_FULLSCREEN"

.field private static final ACTION_REMOVEINCALLFLOATING:Ljava/lang/String; = "com.lge.incallfloating.ACTION_REMOVEINCALLFLOATING"

.field private static final ACTION_SOFT_INPUT_HIDDEN:Ljava/lang/String; = "com.lge.intent.action.SOFT_INPUT_HIDDEN"

.field private static final ACTION_SOFT_INPUT_SHOWN:Ljava/lang/String; = "com.lge.intent.action.SOFT_INPUT_SHOWN"

.field private static final ACTION_SOFT_KEYPAD_HIDE:Ljava/lang/String; = "com.lge.softkeypad.intent.HIDE"

.field private static final ACTION_SOFT_KEYPAD_SHOW:Ljava/lang/String; = "com.lge.softkeypad.intent.SHOW"

.field private static final EXTRA_ACCESSORY_COVER_STATE:Ljava/lang/String; = "com.lge.intent.extra.ACCESSORY_COVER_STATE"

.field public static final EXTRA_ACCESSORY_STATE_FRONT_CLOSED:I = 0x1

.field public static final EXTRA_ACCESSORY_STATE_FRONT_HALFOPEN:I = 0x2

.field public static final EXTRA_ACCESSORY_STATE_FRONT_OPENED:I = 0x0

.field static final EXTRA_ACTIVITY_NAME:Ljava/lang/String; = "ActivityName"

.field private static final EXTRA_CAMERA_ISSTARTED:Ljava/lang/String; = "isStart"

.field private static final TAG:Ljava/lang/String;

.field private static isServiceExist:Z

.field private static isServiceExistenceConfirmed:Z

.field private static sIsKeyguardSecure:Ljava/lang/reflect/Method;


# instance fields
.field mHandler:Landroid/os/Handler;

.field private mReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v2, 0x0

    const-class v1, Lcom/lge/app/floating/FloatingWindowService;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    sput-boolean v2, Lcom/lge/app/floating/FloatingWindowService;->isServiceExist:Z

    sput-boolean v2, Lcom/lge/app/floating/FloatingWindowService;->isServiceExistenceConfirmed:Z

    :try_start_0
    const-class v1, Landroid/app/KeyguardManager;

    const-string v2, "isKeyguardSecure"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    sput-object v1, Lcom/lge/app/floating/FloatingWindowService;->sIsKeyguardSecure:Ljava/lang/reflect/Method;

    sget-object v1, Lcom/lge/app/floating/FloatingWindowService;->sIsKeyguardSecure:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/app/floating/FloatingWindowService;->sIsKeyguardSecure:Ljava/lang/reflect/Method;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v2, "success to access isKeyguardSecure using reflection API"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    return-void

    .end local v0    # "e":Ljava/lang/Exception;
    :catch_0
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v2, "fail to access isKeyguardSecure using reflection API"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindowService;->mHandler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/app/floating/FloatingWindowService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindowService;

    .prologue
    invoke-direct {p0}, Lcom/lge/app/floating/FloatingWindowService;->isInTPhoneMode()Z

    move-result v0

    return v0
.end method

.method static synthetic access$200()Ljava/lang/reflect/Method;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatingWindowService;->sIsKeyguardSecure:Ljava/lang/reflect/Method;

    return-object v0
.end method

.method static checkExistence(Landroid/content/Context;)Z
    .locals 6
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v5, 0x0

    const/4 v2, 0x1

    sget-boolean v3, Lcom/lge/app/floating/FloatingWindowService;->isServiceExistenceConfirmed:Z

    if-eqz v3, :cond_0

    sget-boolean v2, Lcom/lge/app/floating/FloatingWindowService;->isServiceExist:Z

    :goto_0
    return v2

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .local v1, "pm":Landroid/content/pm/PackageManager;
    :try_start_0
    new-instance v3, Landroid/content/ComponentName;

    const-class v4, Lcom/lge/app/floating/FloatingWindowService;

    invoke-direct {v3, p0, v4}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;

    move-result-object v3

    if-eqz v3, :cond_1

    const/4 v3, 0x1

    sput-boolean v3, Lcom/lge/app/floating/FloatingWindowService;->isServiceExist:Z

    const/4 v3, 0x1

    sput-boolean v3, Lcom/lge/app/floating/FloatingWindowService;->isServiceExistenceConfirmed:Z
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    sget-object v3, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v4, "FloatingWindowService is not added in the AndroidManifest.xml file."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v3, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v4, "Add <service android:name=\"com.lge.app.floating.FloatingWindowService\"></service> under <application/> tag"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_1
    sput-boolean v5, Lcom/lge/app/floating/FloatingWindowService;->isServiceExist:Z

    sput-boolean v2, Lcom/lge/app/floating/FloatingWindowService;->isServiceExistenceConfirmed:Z

    sget-boolean v2, Lcom/lge/app/floating/FloatingWindowService;->isServiceExist:Z

    goto :goto_0
.end method

.method private disableOverlayIfNecessary(Z)V
    .locals 9
    .param p1, "starting"    # Z

    .prologue
    const/4 v8, 0x1

    invoke-static {p0}, Lcom/lge/app/floating/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f090003

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v1

    .local v1, "disableOverlayIsNecessary":Z
    if-eqz v1, :cond_0

    sget-object v5, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v6, "disable hardware overlay while running one or more QSlide app"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "activity"

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .local v0, "am":Landroid/app/ActivityManager;
    const v5, 0x7fffffff

    invoke-virtual {v0, v5}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object v4

    .local v4, "services":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningServiceInfo;>;"
    const/4 v3, 0x0

    .local v3, "nFloatingService":I
    if-nez v4, :cond_1

    .end local v0    # "am":Landroid/app/ActivityManager;
    .end local v3    # "nFloatingService":I
    .end local v4    # "services":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningServiceInfo;>;"
    :cond_0
    :goto_0
    return-void

    .restart local v0    # "am":Landroid/app/ActivityManager;
    .restart local v3    # "nFloatingService":I
    .restart local v4    # "services":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningServiceInfo;>;"
    :cond_1
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v5

    if-ge v2, v5, :cond_3

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/app/ActivityManager$RunningServiceInfo;

    iget-object v5, v5, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v5}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v5

    const-class v6, Lcom/lge/app/floating/FloatingWindowService;

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    add-int/lit8 v3, v3, 0x1

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    if-ne v3, v8, :cond_4

    if-nez p1, :cond_5

    :cond_4
    if-nez v3, :cond_0

    if-nez p1, :cond_0

    :cond_5
    new-instance v2, Landroid/content/Intent;

    .end local v2    # "i":I
    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    .local v2, "i":Landroid/content/Intent;
    new-instance v5, Landroid/content/ComponentName;

    const-string v6, "com.lge.systemservice"

    const-string v7, "com.lge.systemservice.service.SystemServicesProxy"

    invoke-direct {v5, v6, v7}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v2, v5}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    const-string v5, "command"

    const-string v6, "DisableOverlays"

    invoke-virtual {v2, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v6, "args"

    new-array v7, v8, [Ljava/lang/String;

    const/4 v8, 0x0

    if-eqz p1, :cond_6

    const-string v5, "true"

    :goto_2
    aput-object v5, v7, v8

    invoke-virtual {v2, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;

    sget-object v5, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Disable Hardware Overlays = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, v2}, Lcom/lge/app/floating/FloatingWindowService;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    :cond_6
    const-string v5, "false"

    goto :goto_2
.end method

.method private isInTPhoneMode()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindowService;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "phone_mode_set"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    if-ne v2, v0, :cond_0

    const-string v1, "TAG"

    const-string v2, "T-Phone Mode detected"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "arg0"    # Landroid/content/Intent;

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v1, "on ConfigurationChanged"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0, p1}, Landroid/app/Service;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    invoke-static {p0}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/lge/app/floating/FloatingWindowManager;->configutationChangeforWindows(Landroid/content/res/Configuration;)V

    return-void
.end method

.method public onCreate()V
    .locals 3

    .prologue
    sget-object v1, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v2, "on create"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    new-instance v1, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;

    invoke-direct {v1, p0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;-><init>(Lcom/lge/app/floating/FloatingWindowService;)V

    iput-object v1, p0, Lcom/lge/app/floating/FloatingWindowService;->mReceiver:Landroid/content/BroadcastReceiver;

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.intent.action.STOP_FLOATING_WINDOW_SERVICE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.FLOATING_WINDOW_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.PHONE_STATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.camera.action.LGE_CAMERA_STARTED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.SOFT_INPUT_SHOWN"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.SOFT_INPUT_HIDDEN"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.softkeypad.intent.SHOW"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.softkeypad.intent.HIDE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.action.CALLALERTING_SHOW"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.action.INCOMING_FULLSCREEN"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.incallfloating.ACTION_REMOVEINCALLFLOATING"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.android.intent.action.ACCESSORY_COVER_EVENT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.FLOATING_WINDOW_ENTER_LOWPROFILE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.android.intent.action.FLOATING_WINDOW_ENTER_LOWPROFILE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.FLOATING_WINDOW_EXIT_LOWPROFILE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.android.intent.action.FLOATING_WINDOW_EXIT_LOWPROFILE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.FLOATING_WINDOW_ALREADY_RUNNING"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.FLOATING_WINDOW_CLOSE_REQUESTED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.android.intent.action.FLOATING_WINDOW_CLOSE_REQUESTED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.lockscreen.intent.action.START_KIDSHOME"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.lockscreen.intent.action.END_KIDSHOME"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.lockscreen.intent.action.LOCKSCREEN_CREATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.lockscreen.intent.action.START_STANDARD_HOME"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.FORCE_UNDOCK"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.APP_SWITCH_ACTION_DOWN"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.USER_SWITCHED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/lge/app/floating/FloatingWindowService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method public onDestroy()V
    .locals 6

    .prologue
    sget-object v3, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v4, "on destroy"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    invoke-direct {p0, v3}, Lcom/lge/app/floating/FloatingWindowService;->disableOverlayIfNecessary(Z)V

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    invoke-static {p0}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    .local v0, "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    sget-object v3, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v4, "FloatingWindowService destroyed."

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/app/floating/FloatingWindow;

    .local v2, "w":Lcom/lge/app/floating/FloatingWindow;
    sget-object v3, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Close "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->getWindowName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "window"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->closeInner()V

    goto :goto_0

    .end local v2    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_1
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindowService;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindowService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    invoke-static {p0}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/lge/app/floating/FloatingWindowManager;->setServiceContext(Landroid/content/Context;)V

    const/4 v3, 0x1

    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindowService;->stopForeground(Z)V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 10
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    const/4 v9, 0x1

    const/4 v5, 0x2

    new-instance v6, Landroid/app/Notification;

    invoke-direct {v6}, Landroid/app/Notification;-><init>()V

    invoke-virtual {p0, v9, v6}, Lcom/lge/app/floating/FloatingWindowService;->startForeground(ILandroid/app/Notification;)V

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    .local v2, "extras":Landroid/os/Bundle;
    if-nez v2, :cond_0

    sget-object v5, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v6, "Cannot do onStartCommand - Fail to intent.getExtras == null"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, -0x1

    :goto_0
    return v5

    :cond_0
    const-string v6, "ActivityName"

    invoke-virtual {v2, v6}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "activityName":Ljava/lang/String;
    sget-object v6, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "start requested for activity="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v0, :cond_1

    sget-object v6, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v7, "service is started with null activity name. do nothing!"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindowService;->stopSelf()V

    goto :goto_0

    :cond_1
    invoke-static {p0}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v3

    .local v3, "manager":Lcom/lge/app/floating/FloatingWindowManager;
    invoke-virtual {v3, p0}, Lcom/lge/app/floating/FloatingWindowManager;->setServiceContext(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    .local v4, "window":Lcom/lge/app/floating/FloatingWindow;
    if-eqz v4, :cond_2

    :try_start_0
    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->attach()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-direct {p0, v9}, Lcom/lge/app/floating/FloatingWindowService;->disableOverlayIfNecessary(Z)V

    goto :goto_0

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/IllegalStateException;
    sget-object v6, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    const-string v7, "cannot attach floating window to the window manager"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindowService;->stopSelf()V

    goto :goto_0

    .end local v1    # "e":Ljava/lang/IllegalStateException;
    :cond_2
    sget-object v6, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "floating window for activity "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " cannot be found"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindowService;->stopSelf()V

    goto :goto_0
.end method

.method public onTaskRemoved(Landroid/content/Intent;)V
    .locals 8
    .param p1, "rootIntent"    # Landroid/content/Intent;

    .prologue
    invoke-virtual {p1}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v5

    if-eqz v5, :cond_0

    invoke-virtual {p1}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .local v2, "packageNameInIntent":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindowService;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .local v3, "thisPackageName":Ljava/lang/String;
    sget-object v5, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "on task removed. packageNameInIntent="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " thisPackageName="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-static {p0}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    .local v0, "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/app/floating/FloatingWindow;

    .local v4, "w":Lcom/lge/app/floating/FloatingWindow;
    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->closeInner()V

    goto :goto_1

    .end local v0    # "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "packageNameInIntent":Ljava/lang/String;
    .end local v3    # "thisPackageName":Ljava/lang/String;
    .end local v4    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_0
    const-string v2, ""

    goto :goto_0

    .restart local v0    # "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    .restart local v1    # "i$":Ljava/util/Iterator;
    .restart local v2    # "packageNameInIntent":Ljava/lang/String;
    .restart local v3    # "thisPackageName":Ljava/lang/String;
    :cond_1
    new-instance v5, Landroid/content/Intent;

    const-class v6, Lcom/lge/app/floating/FloatingWindowService;

    invoke-direct {v5, p0, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingWindowService;->stopService(Landroid/content/Intent;)Z

    .end local v0    # "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_2
    return-void
.end method

.method public stopService(Landroid/content/Intent;)Z
    .locals 3
    .param p1, "name"    # Landroid/content/Intent;

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stop FloatingWindowService : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindowService;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/lge/app/floating/FloatingWindowService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-super {p0, v0}, Landroid/app/Service;->stopService(Landroid/content/Intent;)Z

    move-result v0

    return v0
.end method
