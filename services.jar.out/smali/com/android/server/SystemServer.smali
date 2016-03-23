.class public final Lcom/android/server/SystemServer;
.super Ljava/lang/Object;
.source "SystemServer.java"


# static fields
.field private static final APPWIDGET_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.appwidget.AppWidgetService"

.field private static final BACKUP_MANAGER_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.backup.BackupManagerService$Lifecycle"

.field private static final EARLIEST_SUPPORTED_TIME:J = 0x5265c00L

.field private static final ENCRYPTED_STATE:Ljava/lang/String; = "1"

.field private static final ENCRYPTING_STATE:Ljava/lang/String; = "trigger_restart_min_framework"

.field private static final ETHERNET_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.ethernet.EthernetService"

.field private static final JOB_SCHEDULER_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.job.JobSchedulerService"

.field private static final PERSISTENT_DATA_BLOCK_PROP:Ljava/lang/String; = "ro.frp.pst"

.field private static final PRINT_MANAGER_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.print.PrintManagerService"

.field private static final SNAPSHOT_INTERVAL:J = 0x36ee80L

.field private static final TAG:Ljava/lang/String; = "SystemServer"

.field private static final USB_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.usb.UsbService$Lifecycle"

.field private static final VOICE_RECOGNITION_MANAGER_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.voiceinteraction.VoiceInteractionManagerService"

.field private static final WIFI_P2P_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.wifi.p2p.WifiP2pService"

.field private static final WIFI_SERVICE_CLASS:Ljava/lang/String; = "com.android.server.wifi.WifiService"


# instance fields
.field private mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

.field private mAlarmManagerService:Lcom/android/server/AlarmManagerService;

.field private mContentResolver:Landroid/content/ContentResolver;

.field private mDisplayManagerService:Lcom/android/server/display/DisplayManagerService;

.field private final mFactoryTestMode:I

.field private mFirstBoot:Z

.field private mInstaller:Lcom/android/server/pm/Installer;

.field private mOnlyCore:Z

.field private mPackageManager:Landroid/content/pm/PackageManager;

.field private mPackageManagerService:Lcom/android/server/pm/PackageManagerService;

.field private mPowerManagerService:Lcom/android/server/power/PowerManagerService;

.field private mProfilerSnapshotTimer:Ljava/util/Timer;

.field private mSystemContext:Landroid/content/Context;

.field private mSystemServiceManager:Lcom/android/server/SystemServiceManager;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 192
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 194
    invoke-static {}, Landroid/os/FactoryTest;->getMode()I

    move-result v0

    iput v0, p0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    .line 195
    return-void
.end method

.method static synthetic access$000(Lcom/android/server/SystemServer;)Lcom/android/server/SystemServiceManager;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/SystemServer;

    .prologue
    .line 125
    iget-object v0, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    return-object v0
.end method

.method static synthetic access$100(Lcom/android/server/SystemServer;)Lcom/android/server/am/ActivityManagerService;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/SystemServer;

    .prologue
    .line 125
    iget-object v0, p0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    return-object v0
.end method

.method static synthetic access$200(Lcom/android/server/SystemServer;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/SystemServer;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Ljava/lang/Throwable;

    .prologue
    .line 125
    invoke-direct {p0, p1, p2}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method private createSystemContext()V
    .locals 3

    .prologue
    .line 315
    invoke-static {}, Landroid/app/ActivityThread;->systemMain()Landroid/app/ActivityThread;

    move-result-object v0

    .line 316
    .local v0, "activityThread":Landroid/app/ActivityThread;
    invoke-virtual {v0}, Landroid/app/ActivityThread;->getSystemContext()Landroid/app/ContextImpl;

    move-result-object v1

    iput-object v1, p0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    .line 317
    iget-object v1, p0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    const v2, 0x103013f

    invoke-virtual {v1, v2}, Landroid/content/Context;->setTheme(I)V

    .line 318
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 1
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 189
    new-instance v0, Lcom/android/server/SystemServer;

    invoke-direct {v0}, Lcom/android/server/SystemServer;-><init>()V

    invoke-direct {v0}, Lcom/android/server/SystemServer;->run()V

    .line 190
    return-void
.end method

.method private static native nativeInit()V
.end method

.method private performPendingShutdown()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    const/4 v3, 0x1

    .line 298
    const-string v4, "sys.shutdown.requested"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 300
    .local v2, "shutdownAction":Ljava/lang/String;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_1

    .line 301
    invoke-virtual {v2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x31

    if-ne v4, v5, :cond_0

    move v1, v3

    .line 304
    .local v1, "reboot":Z
    :cond_0
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-le v4, v3, :cond_2

    .line 305
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 310
    .local v0, "reason":Ljava/lang/String;
    :goto_0
    invoke-static {v1, v0}, Lcom/android/server/power/ShutdownThread;->rebootOrShutdown(ZLjava/lang/String;)V

    .line 312
    .end local v0    # "reason":Ljava/lang/String;
    .end local v1    # "reboot":Z
    :cond_1
    return-void

    .line 307
    .restart local v1    # "reboot":Z
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "reason":Ljava/lang/String;
    goto :goto_0
.end method

.method private reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "e"    # Ljava/lang/Throwable;

    .prologue
    .line 293
    const-string v0, "SystemServer"

    const-string v1, "***********************************************"

    invoke-static {v0, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 294
    const-string v0, "SystemServer"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BOOT FAILURE "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p2}, Landroid/util/Slog;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 295
    return-void
.end method

.method private run()V
    .locals 8

    .prologue
    const-wide/32 v4, 0x5265c00

    const-wide/32 v2, 0x36ee80

    const/4 v7, 0x1

    .line 202
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    cmp-long v0, v0, v4

    if-gez v0, :cond_0

    .line 203
    const-string v0, "SystemServer"

    const-string v1, "System clock is before 1970; setting to 1970."

    invoke-static {v0, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    invoke-static {v4, v5}, Landroid/os/SystemClock;->setCurrentTimeMillis(J)Z

    .line 208
    :cond_0
    const-string v0, "SystemServer"

    const-string v1, "Entered the Android system server!"

    invoke-static {v0, v1}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 209
    const/16 v0, 0xbc2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    invoke-static {v0, v4, v5}, Landroid/util/EventLog;->writeEvent(IJ)I

    .line 218
    const-string v0, "persist.sys.dalvik.vm.lib.2"

    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v1

    invoke-virtual {v1}, Ldalvik/system/VMRuntime;->vmLibrary()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 221
    invoke-static {}, Lcom/android/internal/os/SamplingProfilerIntegration;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 222
    invoke-static {}, Lcom/android/internal/os/SamplingProfilerIntegration;->start()V

    .line 223
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lcom/android/server/SystemServer;->mProfilerSnapshotTimer:Ljava/util/Timer;

    .line 224
    iget-object v0, p0, Lcom/android/server/SystemServer;->mProfilerSnapshotTimer:Ljava/util/Timer;

    new-instance v1, Lcom/android/server/SystemServer$1;

    invoke-direct {v1, p0}, Lcom/android/server/SystemServer$1;-><init>(Lcom/android/server/SystemServer;)V

    move-wide v4, v2

    invoke-virtual/range {v0 .. v5}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;JJ)V

    .line 233
    :cond_1
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v0

    invoke-virtual {v0}, Ldalvik/system/VMRuntime;->clearGrowthLimit()V

    .line 237
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v0

    const-string v1, "dalvik.vm.heaputil.systemserver"

    const-string v2, "0.8f"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    invoke-virtual {v0, v1}, Ldalvik/system/VMRuntime;->setTargetHeapUtilization(F)F

    .line 241
    invoke-static {}, Landroid/os/Build;->ensureFingerprintProperty()V

    .line 245
    invoke-static {v7}, Landroid/os/Environment;->setUserRequired(Z)V

    .line 248
    invoke-static {v7}, Lcom/android/internal/os/BinderInternal;->disableBackgroundScheduling(Z)V

    .line 251
    const/4 v0, -0x2

    invoke-static {v0}, Landroid/os/Process;->setThreadPriority(I)V

    .line 253
    const/4 v0, 0x0

    invoke-static {v0}, Landroid/os/Process;->setCanSelfBackground(Z)V

    .line 254
    invoke-static {}, Landroid/os/Looper;->prepareMainLooper()V

    .line 257
    const-string v0, "android_servers"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 258
    invoke-static {}, Lcom/android/server/SystemServer;->nativeInit()V

    .line 262
    invoke-direct {p0}, Lcom/android/server/SystemServer;->performPendingShutdown()V

    .line 265
    invoke-direct {p0}, Lcom/android/server/SystemServer;->createSystemContext()V

    .line 268
    new-instance v0, Lcom/android/server/SystemServiceManager;

    iget-object v1, p0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/android/server/SystemServiceManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    .line 269
    const-class v0, Lcom/android/server/SystemServiceManager;

    iget-object v1, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    invoke-static {v0, v1}, Lcom/android/server/LocalServices;->addService(Ljava/lang/Class;Ljava/lang/Object;)V

    .line 273
    :try_start_0
    invoke-direct {p0}, Lcom/android/server/SystemServer;->startBootstrapServices()V

    .line 274
    invoke-direct {p0}, Lcom/android/server/SystemServer;->startCoreServices()V

    .line 275
    invoke-direct {p0}, Lcom/android/server/SystemServer;->startOtherServices()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 283
    invoke-static {}, Landroid/os/StrictMode;->conditionallyEnableDebugLogging()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 284
    const-string v0, "SystemServer"

    const-string v1, "Enabled StrictMode for system server main thread."

    invoke-static {v0, v1}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 288
    :cond_2
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 289
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Main thread loop unexpectedly exited"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 276
    :catch_0
    move-exception v6

    .line 277
    .local v6, "ex":Ljava/lang/Throwable;
    const-string v0, "System"

    const-string v1, "******************************************"

    invoke-static {v0, v1}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 278
    const-string v0, "System"

    const-string v1, "************ Failure starting system services"

    invoke-static {v0, v1, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 279
    throw v6
.end method

.method private startBootstrapServices()V
    .locals 7

    .prologue
    const/4 v4, 0x1

    .line 331
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/pm/Installer;

    invoke-virtual {v3, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v3

    check-cast v3, Lcom/android/server/pm/Installer;

    iput-object v3, p0, Lcom/android/server/SystemServer;->mInstaller:Lcom/android/server/pm/Installer;

    .line 334
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/am/ActivityManagerService$Lifecycle;

    invoke-virtual {v3, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v3

    check-cast v3, Lcom/android/server/am/ActivityManagerService$Lifecycle;

    invoke-virtual {v3}, Lcom/android/server/am/ActivityManagerService$Lifecycle;->getService()Lcom/android/server/am/ActivityManagerService;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    .line 336
    iget-object v3, p0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    iget-object v5, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    invoke-virtual {v3, v5}, Lcom/android/server/am/ActivityManagerService;->setSystemServiceManager(Lcom/android/server/SystemServiceManager;)V

    .line 343
    :try_start_0
    const-string v3, "com.android.server.power.PowerManagerServiceEx"

    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 344
    .local v0, "c":Ljava/lang/Class;
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    invoke-virtual {v3, v0}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v3

    check-cast v3, Lcom/android/server/power/PowerManagerService;

    iput-object v3, p0, Lcom/android/server/SystemServer;->mPowerManagerService:Lcom/android/server/power/PowerManagerService;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 352
    .end local v0    # "c":Ljava/lang/Class;
    :goto_0
    iget-object v3, p0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v3}, Lcom/android/server/am/ActivityManagerService;->initPowerManagement()V

    .line 357
    :try_start_1
    const-string v3, "com.android.server.display.DisplayManagerServiceEx"

    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 358
    .restart local v0    # "c":Ljava/lang/Class;
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    invoke-virtual {v3, v0}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v3

    check-cast v3, Lcom/android/server/display/DisplayManagerService;

    iput-object v3, p0, Lcom/android/server/SystemServer;->mDisplayManagerService:Lcom/android/server/display/DisplayManagerService;
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    .line 365
    .end local v0    # "c":Ljava/lang/Class;
    :goto_1
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const/16 v5, 0x64

    invoke-virtual {v3, v5}, Lcom/android/server/SystemServiceManager;->startBootPhase(I)V

    .line 368
    const-string v3, "vold.decrypt"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 369
    .local v1, "cryptState":Ljava/lang/String;
    const-string v3, "trigger_restart_min_framework"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 370
    const-string v3, "SystemServer"

    const-string v5, "Detected encryption in progress - only parsing core apps"

    invoke-static {v3, v5}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 371
    iput-boolean v4, p0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    .line 378
    :cond_0
    :goto_2
    const-string v3, "SystemServer"

    const-string v5, "Package Manager"

    invoke-static {v3, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 379
    iget-object v5, p0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    iget-object v6, p0, Lcom/android/server/SystemServer;->mInstaller:Lcom/android/server/pm/Installer;

    iget v3, p0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    if-eqz v3, :cond_2

    move v3, v4

    :goto_3
    iget-boolean v4, p0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    invoke-static {v5, v6, v3, v4}, Lcom/android/server/pm/PackageManagerService;->main(Landroid/content/Context;Lcom/android/server/pm/Installer;ZZ)Lcom/android/server/pm/PackageManagerService;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/SystemServer;->mPackageManagerService:Lcom/android/server/pm/PackageManagerService;

    .line 381
    iget-object v3, p0, Lcom/android/server/SystemServer;->mPackageManagerService:Lcom/android/server/pm/PackageManagerService;

    invoke-virtual {v3}, Lcom/android/server/pm/PackageManagerService;->isFirstBoot()Z

    move-result v3

    iput-boolean v3, p0, Lcom/android/server/SystemServer;->mFirstBoot:Z

    .line 382
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    .line 384
    const-string v3, "SystemServer"

    const-string v4, "User Service"

    invoke-static {v3, v4}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 385
    const-string v3, "user"

    invoke-static {}, Lcom/android/server/pm/UserManagerService;->getInstance()Lcom/android/server/pm/UserManagerService;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 388
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    invoke-static {v3}, Lcom/android/server/AttributeCache;->init(Landroid/content/Context;)V

    .line 391
    iget-object v3, p0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v3}, Lcom/android/server/am/ActivityManagerService;->setSystemProcess()V

    .line 392
    return-void

    .line 345
    .end local v1    # "cryptState":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 346
    .local v2, "e":Ljava/lang/ClassNotFoundException;
    const-string v3, "SystemServer"

    const-string v5, "PowerManagerServiceEx not found "

    invoke-static {v3, v5, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 347
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/power/PowerManagerService;

    invoke-virtual {v3, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v3

    check-cast v3, Lcom/android/server/power/PowerManagerService;

    iput-object v3, p0, Lcom/android/server/SystemServer;->mPowerManagerService:Lcom/android/server/power/PowerManagerService;

    goto/16 :goto_0

    .line 359
    .end local v2    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1
    move-exception v2

    .line 360
    .restart local v2    # "e":Ljava/lang/ClassNotFoundException;
    const-string v3, "SystemServer"

    const-string v5, "DisplayManagerServiceEx not found "

    invoke-static {v3, v5, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 361
    iget-object v3, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/display/DisplayManagerService;

    invoke-virtual {v3, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v3

    check-cast v3, Lcom/android/server/display/DisplayManagerService;

    iput-object v3, p0, Lcom/android/server/SystemServer;->mDisplayManagerService:Lcom/android/server/display/DisplayManagerService;

    goto/16 :goto_1

    .line 372
    .end local v2    # "e":Ljava/lang/ClassNotFoundException;
    .restart local v1    # "cryptState":Ljava/lang/String;
    :cond_1
    const-string v3, "1"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 373
    const-string v3, "SystemServer"

    const-string v5, "Device encrypted - only parsing core apps"

    invoke-static {v3, v5}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 374
    iput-boolean v4, p0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    goto :goto_2

    .line 379
    :cond_2
    const/4 v3, 0x0

    goto :goto_3
.end method

.method private startCoreServices()V
    .locals 4

    .prologue
    .line 399
    iget-object v2, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v3, Lcom/android/server/lights/LightsService;

    invoke-virtual {v2, v3}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 403
    :try_start_0
    const-string v2, "com.android.server.BatteryServiceEx"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 404
    .local v0, "c":Ljava/lang/Class;
    iget-object v2, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    invoke-virtual {v2, v0}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 411
    .end local v0    # "c":Ljava/lang/Class;
    :goto_0
    iget-object v2, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v3, Lcom/android/server/usage/UsageStatsService;

    invoke-virtual {v2, v3}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 412
    iget-object v3, p0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    const-class v2, Landroid/app/usage/UsageStatsManagerInternal;

    invoke-static {v2}, Lcom/android/server/LocalServices;->getService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/usage/UsageStatsManagerInternal;

    invoke-virtual {v3, v2}, Lcom/android/server/am/ActivityManagerService;->setUsageStatsManager(Landroid/app/usage/UsageStatsManagerInternal;)V

    .line 416
    iget-object v2, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v3, Lcom/android/server/webkit/WebViewUpdateService;

    invoke-virtual {v2, v3}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 417
    return-void

    .line 405
    :catch_0
    move-exception v1

    .line 406
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    const-string v2, "SystemServer"

    const-string v3, "BatteryServiceEx not found "

    invoke-static {v2, v3, v1}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 407
    iget-object v2, p0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v3, Lcom/android/server/BatteryService;

    invoke-virtual {v2, v3}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    goto :goto_0
.end method

.method private static final startDpmService(Landroid/content/Context;)V
    .locals 9
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 1428
    const/4 v4, 0x0

    .line 1429
    .local v4, "dpmObj":Ljava/lang/Object;
    :try_start_0
    const-string v6, "persist.dpm.feature"

    const/4 v7, 0x0

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v3

    .line 1430
    .local v3, "dpmFeature":I
    const-string v6, "SystemServer"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "DPM configuration set to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1432
    if-lez v3, :cond_0

    const/16 v6, 0x8

    if-ge v3, v6, :cond_0

    .line 1433
    new-instance v1, Ldalvik/system/PathClassLoader;

    const-string v6, "/system/framework/com.qti.dpmframework.jar"

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v7

    invoke-direct {v1, v6, v7}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 1436
    .local v1, "dpmClassLoader":Ldalvik/system/PathClassLoader;
    const-string v6, "com.qti.dpm.DpmService"

    invoke-virtual {v1, v6}, Ldalvik/system/PathClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 1437
    .local v0, "dpmClass":Ljava/lang/Class;
    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v6, v7

    invoke-virtual {v0, v6}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v2

    .line 1439
    .local v2, "dpmConstructor":Ljava/lang/reflect/Constructor;
    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p0, v6, v7

    invoke-virtual {v2, v6}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v4

    .line 1441
    if-eqz v4, :cond_0

    :try_start_1
    instance-of v6, v4, Landroid/os/IBinder;

    if-eqz v6, :cond_0

    .line 1442
    const-string v6, "dpmservice"

    check-cast v4, Landroid/os/IBinder;

    .end local v4    # "dpmObj":Ljava/lang/Object;
    invoke-static {v6, v4}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 1443
    const-string v6, "SystemServer"

    const-string v7, "Created DPM Service"

    invoke-static {v6, v7}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 1452
    .end local v0    # "dpmClass":Ljava/lang/Class;
    .end local v1    # "dpmClassLoader":Ldalvik/system/PathClassLoader;
    .end local v2    # "dpmConstructor":Ljava/lang/reflect/Constructor;
    .end local v3    # "dpmFeature":I
    :cond_0
    :goto_0
    return-void

    .line 1445
    .restart local v0    # "dpmClass":Ljava/lang/Class;
    .restart local v1    # "dpmClassLoader":Ldalvik/system/PathClassLoader;
    .restart local v2    # "dpmConstructor":Ljava/lang/reflect/Constructor;
    .restart local v3    # "dpmFeature":I
    :catch_0
    move-exception v5

    .line 1446
    .local v5, "e":Ljava/lang/Exception;
    :try_start_2
    const-string v6, "SystemServer"

    const-string v7, "starting DPM Service"

    invoke-static {v6, v7, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 1449
    .end local v0    # "dpmClass":Ljava/lang/Class;
    .end local v1    # "dpmClassLoader":Ldalvik/system/PathClassLoader;
    .end local v2    # "dpmConstructor":Ljava/lang/reflect/Constructor;
    .end local v3    # "dpmFeature":I
    .end local v5    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v5

    .line 1450
    .local v5, "e":Ljava/lang/Throwable;
    const-string v6, "SystemServer"

    const-string v7, "starting DPM Service"

    invoke-static {v6, v7, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method private startOtherServices()V
    .locals 118

    .prologue
    .line 424
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    .line 425
    .local v3, "context":Landroid/content/Context;
    const/16 v32, 0x0

    .line 426
    .local v32, "accountManager":Lcom/android/server/accounts/AccountManagerService;
    const/16 v52, 0x0

    .line 427
    .local v52, "contentService":Lcom/android/server/content/ContentService;
    const/16 v108, 0x0

    .line 428
    .local v108, "vibrator":Lcom/android/server/VibratorService;
    const/16 v34, 0x0

    .line 429
    .local v34, "alarm":Landroid/app/IAlarmManager;
    const/16 v88, 0x0

    .line 430
    .local v88, "mountService":Lcom/android/server/MountService;
    const/16 v78, 0x0

    .line 431
    .local v78, "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    const/4 v7, 0x0

    .line 432
    .local v7, "networkManagement":Lcom/android/server/NetworkManagementService;
    const/4 v6, 0x0

    .line 433
    .local v6, "networkStats":Lcom/android/server/net/NetworkStatsService;
    const/16 v90, 0x0

    .line 434
    .local v90, "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    const/16 v47, 0x0

    .line 435
    .local v47, "connectivity":Lcom/android/server/ConnectivityService;
    const/16 v91, 0x0

    .line 436
    .local v91, "networkScore":Lcom/android/server/NetworkScoreService;
    const/16 v100, 0x0

    .line 437
    .local v100, "serviceDiscovery":Lcom/android/server/NsdService;
    const/16 v117, 0x0

    .line 438
    .local v117, "wm":Lcom/android/server/wm/WindowManagerService;
    const/16 v39, 0x0

    .line 439
    .local v39, "bluetooth":Lcom/android/server/BluetoothManagerService;
    const/16 v107, 0x0

    .line 440
    .local v107, "usb":Lcom/android/server/usb/UsbService;
    const/16 v98, 0x0

    .line 441
    .local v98, "serial":Lcom/android/server/SerialService;
    const/16 v94, 0x0

    .line 442
    .local v94, "networkTimeUpdater":Lcom/android/server/NetworkTimeUpdateService;
    const/16 v44, 0x0

    .line 443
    .local v44, "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    const/16 v74, 0x0

    .line 444
    .local v74, "inputManager":Lcom/android/server/input/InputManagerService;
    const/16 v103, 0x0

    .line 445
    .local v103, "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    const/16 v50, 0x0

    .line 446
    .local v50, "consumerIr":Lcom/android/server/ConsumerIrService;
    const/16 v37, 0x0

    .line 447
    .local v37, "audioService":Landroid/media/AudioService;
    const/16 v42, 0x0

    .line 448
    .local v42, "ccMode":Lcom/android/server/CCModeService;
    const/16 v87, 0x0

    .line 450
    .local v87, "mmsService":Lcom/android/server/MmsServiceBroker;
    const-string v4, "config.disable_storage"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v68

    .line 451
    .local v68, "disableStorage":Z
    const-string v4, "config.disable_media"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v65

    .line 452
    .local v65, "disableMedia":Z
    const-string v4, "config.disable_bluetooth"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v63

    .line 453
    .local v63, "disableBluetooth":Z
    const-string v4, "config.disable_telephony"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v70

    .line 454
    .local v70, "disableTelephony":Z
    const-string v4, "config.disable_location"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v64

    .line 455
    .local v64, "disableLocation":Z
    const-string v4, "config.disable_systemui"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v69

    .line 456
    .local v69, "disableSystemUI":Z
    const-string v4, "config.disable_noncore"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v67

    .line 457
    .local v67, "disableNonCoreServices":Z
    const-string v4, "config.disable_network"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v66

    .line 458
    .local v66, "disableNetwork":Z
    const-string v4, "ro.kernel.qemu"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "1"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v76

    .line 459
    .local v76, "isEmulator":Z
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x1120085

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v58

    .line 461
    .local v58, "digitalPenCapable":Z
    const-string v4, "config.disable_atlas"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v62

    .line 464
    .local v62, "disableAtlas":Z
    :try_start_0
    const-string v4, "SystemServer"

    const-string v5, "Reading configuration..."

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 465
    invoke-static {}, Lcom/android/server/SystemConfig;->getInstance()Lcom/android/server/SystemConfig;

    .line 467
    const-string v4, "SystemServer"

    const-string v5, "Scheduling Policy"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 468
    const-string v4, "scheduling_policy"

    new-instance v5, Lcom/android/server/os/SchedulingPolicyService;

    invoke-direct {v5}, Lcom/android/server/os/SchedulingPolicyService;-><init>()V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 470
    const-string v4, "SystemServer"

    const-string v5, "Telephony Registry"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 471
    new-instance v104, Lcom/android/server/TelephonyRegistry;

    move-object/from16 v0, v104

    invoke-direct {v0, v3}, Lcom/android/server/TelephonyRegistry;-><init>(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_48

    .line 472
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .local v104, "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    :try_start_1
    const-string v4, "telephony.registry"

    move-object/from16 v0, v104

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 474
    const-string v4, "SystemServer"

    const-string v5, "Entropy Mixer"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 475
    const-string v4, "entropy"

    new-instance v5, Lcom/android/server/EntropyMixer;

    invoke-direct {v5, v3}, Lcom/android/server/EntropyMixer;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 477
    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/android/server/SystemServer;->mContentResolver:Landroid/content/ContentResolver;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 482
    :try_start_2
    const-string v4, "SystemServer"

    const-string v5, "Account Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 483
    new-instance v33, Lcom/android/server/accounts/AccountManagerService;

    move-object/from16 v0, v33

    invoke-direct {v0, v3}, Lcom/android/server/accounts/AccountManagerService;-><init>(Landroid/content/Context;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    .line 484
    .end local v32    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .local v33, "accountManager":Lcom/android/server/accounts/AccountManagerService;
    :try_start_3
    const-string v4, "account"

    move-object/from16 v0, v33

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_4e
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_49

    move-object/from16 v32, v33

    .line 489
    .end local v33    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .restart local v32    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    :goto_0
    :try_start_4
    const-string v4, "SystemServer"

    const-string v5, "Content Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 490
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_2e

    const/4 v4, 0x1

    :goto_1
    invoke-static {v3, v4}, Lcom/android/server/content/ContentService;->main(Landroid/content/Context;Z)Lcom/android/server/content/ContentService;

    move-result-object v52

    .line 493
    const-string v4, "SystemServer"

    const-string v5, "System Content Providers"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 494
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v4}, Lcom/android/server/am/ActivityManagerService;->installSystemProviders()V

    .line 496
    const-string v4, "SystemServer"

    const-string v5, "Vibrator Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 497
    new-instance v109, Lcom/android/server/VibratorService;

    move-object/from16 v0, v109

    invoke-direct {v0, v3}, Lcom/android/server/VibratorService;-><init>(Landroid/content/Context;)V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_1

    .line 498
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .local v109, "vibrator":Lcom/android/server/VibratorService;
    :try_start_5
    const-string v4, "vibrator"

    move-object/from16 v0, v109

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 500
    const-string v4, "SystemServer"

    const-string v5, "Consumer IR Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 501
    new-instance v51, Lcom/android/server/ConsumerIrService;

    move-object/from16 v0, v51

    invoke-direct {v0, v3}, Lcom/android/server/ConsumerIrService;-><init>(Landroid/content/Context;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_4a

    .line 502
    .end local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .local v51, "consumerIr":Lcom/android/server/ConsumerIrService;
    :try_start_6
    const-string v4, "consumer_ir"

    move-object/from16 v0, v51

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 504
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/AlarmManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v4

    check-cast v4, Lcom/android/server/AlarmManagerService;

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/android/server/SystemServer;->mAlarmManagerService:Lcom/android/server/AlarmManagerService;

    .line 505
    const-string v4, "alarm"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Landroid/app/IAlarmManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/app/IAlarmManager;

    move-result-object v34

    .line 508
    const-string v4, "SystemServer"

    const-string v5, "CCModeService"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 509
    new-instance v43, Lcom/android/server/CCModeService;

    move-object/from16 v0, v43

    invoke-direct {v0, v3}, Lcom/android/server/CCModeService;-><init>(Landroid/content/Context;)V
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_4b

    .line 510
    .end local v42    # "ccMode":Lcom/android/server/CCModeService;
    .local v43, "ccMode":Lcom/android/server/CCModeService;
    :try_start_7
    const-string v4, "CCModeService"

    move-object/from16 v0, v43

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 512
    const-string v4, "SystemServer"

    const-string v5, "Init Watchdog"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 513
    invoke-static {}, Lcom/android/server/Watchdog;->getInstance()Lcom/android/server/Watchdog;

    move-result-object v113

    .line 514
    .local v113, "watchdog":Lcom/android/server/Watchdog;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    move-object/from16 v0, v113

    invoke-virtual {v0, v3, v4}, Lcom/android/server/Watchdog;->init(Landroid/content/Context;Lcom/android/server/am/ActivityManagerService;)V

    .line 516
    const-string v4, "SystemServer"

    const-string v5, "Input Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 517
    new-instance v75, Lcom/android/server/input/InputManagerService;

    move-object/from16 v0, v75

    invoke-direct {v0, v3}, Lcom/android/server/input/InputManagerService;-><init>(Landroid/content/Context;)V
    :try_end_7
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_4c

    .line 519
    .end local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    .local v75, "inputManager":Lcom/android/server/input/InputManagerService;
    :try_start_8
    const-string v4, "SystemServer"

    const-string v5, "Window Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 520
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    const/4 v5, 0x1

    if-eq v4, v5, :cond_2f

    const/4 v4, 0x1

    move v5, v4

    :goto_2
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    if-nez v4, :cond_30

    const/4 v4, 0x1

    :goto_3
    move-object/from16 v0, p0

    iget-boolean v8, v0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    move-object/from16 v0, v75

    invoke-static {v3, v0, v5, v4, v8}, Lcom/android/server/wm/WindowManagerService;->main(Landroid/content/Context;Lcom/android/server/input/InputManagerService;ZZZ)Lcom/android/server/wm/WindowManagerService;

    move-result-object v117

    .line 525
    const-string v4, "window"

    move-object/from16 v0, v117

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 526
    const-string v4, "input"

    move-object/from16 v0, v75

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 528
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    move-object/from16 v0, v117

    invoke-virtual {v4, v0}, Lcom/android/server/am/ActivityManagerService;->setWindowManager(Lcom/android/server/wm/WindowManagerService;)V

    .line 530
    invoke-virtual/range {v117 .. v117}, Lcom/android/server/wm/WindowManagerService;->getInputMonitor()Lcom/android/server/wm/InputMonitor;

    move-result-object v4

    move-object/from16 v0, v75

    invoke-virtual {v0, v4}, Lcom/android/server/input/InputManagerService;->setWindowManagerCallbacks(Lcom/android/server/input/InputManagerService$WindowManagerCallbacks;)V

    .line 531
    invoke-virtual/range {v75 .. v75}, Lcom/android/server/input/InputManagerService;->start()V

    .line 534
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mDisplayManagerService:Lcom/android/server/display/DisplayManagerService;

    invoke-virtual {v4}, Lcom/android/server/display/DisplayManagerService;->windowManagerAndInputReady()V

    .line 539
    if-eqz v76, :cond_31

    .line 540
    const-string v4, "SystemServer"

    const-string v5, "No Bluetooh Service (emulator)"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_8
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_2

    :goto_4
    move-object/from16 v42, v43

    .end local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v42    # "ccMode":Lcom/android/server/CCModeService;
    move-object/from16 v50, v51

    .end local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v74, v75

    .end local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    move-object/from16 v108, v109

    .line 558
    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .end local v113    # "watchdog":Lcom/android/server/Watchdog;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    :goto_5
    const/16 v101, 0x0

    .line 559
    .local v101, "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    const/16 v96, 0x0

    .line 560
    .local v96, "notification":Landroid/app/INotificationManager;
    const/16 v72, 0x0

    .line 561
    .local v72, "imm":Lcom/android/server/InputMethodManagerService;
    const/16 v111, 0x0

    .line 562
    .local v111, "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    const/16 v80, 0x0

    .line 563
    .local v80, "location":Lcom/android/server/LocationManagerService;
    const/16 v53, 0x0

    .line 564
    .local v53, "countryDetector":Lcom/android/server/CountryDetectorService;
    const/16 v105, 0x0

    .line 565
    .local v105, "tsms":Lcom/android/server/TextServicesManagerService;
    const/16 v82, 0x0

    .line 566
    .local v82, "lockSettings":Lcom/android/server/LockSettingsService;
    const/16 v35, 0x0

    .line 567
    .local v35, "atlas":Lcom/android/server/AssetAtlasService;
    const/16 v84, 0x0

    .line 570
    .local v84, "mediaRouter":Lcom/android/server/media/MediaRouterService;
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    const/4 v5, 0x1

    if-eq v4, v5, :cond_0

    .line 574
    :try_start_9
    const-string v4, "SystemServer"

    const-string v5, "Input Method Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 575
    new-instance v73, Lcom/android/server/InputMethodManagerService;

    move-object/from16 v0, v73

    move-object/from16 v1, v117

    invoke-direct {v0, v3, v1}, Lcom/android/server/InputMethodManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_3

    .line 576
    .end local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    .local v73, "imm":Lcom/android/server/InputMethodManagerService;
    :try_start_a
    const-string v4, "input_method"

    move-object/from16 v0, v73

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_47

    move-object/from16 v72, v73

    .line 582
    .end local v73    # "imm":Lcom/android/server/InputMethodManagerService;
    .restart local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    :goto_6
    :try_start_b
    const-string v4, "SystemServer"

    const-string v5, "Accessibility Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 583
    const-string v4, "accessibility"

    new-instance v5, Lcom/android/server/accessibility/AccessibilityManagerService;

    invoke-direct {v5, v3}, Lcom/android/server/accessibility/AccessibilityManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_4

    .line 592
    :cond_0
    :goto_7
    :try_start_c
    invoke-virtual/range {v117 .. v117}, Lcom/android/server/wm/WindowManagerService;->displayReady()V
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_5

    .line 598
    :goto_8
    :try_start_d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManagerService:Lcom/android/server/pm/PackageManagerService;

    invoke-virtual {v4}, Lcom/android/server/pm/PackageManagerService;->performBootDexOpt()V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_6

    .line 604
    :goto_9
    :try_start_e
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v4

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v8, 0x1040497

    invoke-virtual {v5, v8}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    const/4 v8, 0x0

    invoke-interface {v4, v5, v8}, Landroid/app/IActivityManager;->showBootMessage(Ljava/lang/CharSequence;Z)V
    :try_end_e
    .catch Landroid/os/RemoteException; {:try_start_e .. :try_end_e} :catch_46

    .line 612
    :goto_a
    :try_start_f
    const-string v4, "smartcover"

    new-instance v5, Lcom/lge/systemservice/service/SmartCoverService;

    invoke-direct {v5, v3}, Lcom/lge/systemservice/service/SmartCoverService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_f
    .catch Ljava/lang/Throwable; {:try_start_f .. :try_end_f} :catch_7

    .line 617
    :goto_b
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    const/4 v5, 0x1

    if-eq v4, v5, :cond_3a

    .line 618
    if-nez v68, :cond_2

    const-string v4, "0"

    const-string v5, "system_init.startmountservice"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 625
    :try_start_10
    const-string v4, "SystemServer"

    const-string v5, "Mount Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_10
    .catch Ljava/lang/Throwable; {:try_start_10 .. :try_end_10} :catch_9

    .line 627
    :try_start_11
    const-string v4, "com.android.server.MountServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 628
    .local v41, "c":Ljava/lang/Class;
    const/16 v49, 0x0

    .line 629
    .local v49, "constructor":Ljava/lang/reflect/Constructor;
    if-eqz v41, :cond_1

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    move-object/from16 v0, v41

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v49

    if-eqz v49, :cond_1

    .line 630
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    move-object/from16 v0, v49

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Lcom/android/server/MountService;

    move-object/from16 v88, v0
    :try_end_11
    .catch Ljava/lang/ClassNotFoundException; {:try_start_11 .. :try_end_11} :catch_8
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_9

    .line 637
    .end local v41    # "c":Ljava/lang/Class;
    .end local v49    # "constructor":Ljava/lang/reflect/Constructor;
    :cond_1
    :goto_c
    :try_start_12
    const-string v4, "mount"

    move-object/from16 v0, v88

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_9

    .line 643
    :cond_2
    :goto_d
    if-nez v67, :cond_5

    .line 645
    :try_start_13
    const-string v4, "SystemServer"

    const-string v5, "LockSettingsService"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_b

    .line 649
    :try_start_14
    const-string v4, "com.android.server.LockSettingsServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 650
    .restart local v41    # "c":Ljava/lang/Class;
    if-eqz v41, :cond_3

    .line 651
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    move-object/from16 v0, v41

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v49

    .line 652
    .restart local v49    # "constructor":Ljava/lang/reflect/Constructor;
    if-eqz v49, :cond_3

    .line 653
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    move-object/from16 v0, v49

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Lcom/android/server/LockSettingsService;

    move-object/from16 v82, v0
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_a
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_b

    .end local v49    # "constructor":Ljava/lang/reflect/Constructor;
    :cond_3
    move-object/from16 v83, v82

    .line 659
    .end local v41    # "c":Ljava/lang/Class;
    .end local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .local v83, "lockSettings":Lcom/android/server/LockSettingsService;
    :goto_e
    if-nez v83, :cond_39

    .line 660
    :try_start_15
    new-instance v82, Lcom/android/server/LockSettingsService;

    move-object/from16 v0, v82

    invoke-direct {v0, v3}, Lcom/android/server/LockSettingsService;-><init>(Landroid/content/Context;)V
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_15 .. :try_end_15} :catch_45

    .line 663
    .end local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    :goto_f
    :try_start_16
    const-string v4, "lock_settings"

    move-object/from16 v0, v82

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_b

    .line 668
    :goto_10
    const-string v4, "ro.frp.pst"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    .line 669
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/PersistentDataBlockService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 674
    :cond_4
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/devicepolicy/DevicePolicyManagerService$Lifecycle;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 677
    :cond_5
    if-nez v69, :cond_7

    .line 679
    :try_start_17
    const-string v4, "SystemServer"

    const-string v5, "Status Bar"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_d

    .line 682
    :try_start_18
    const-string v4, "com.android.server.statusbar.StatusBarManagerServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 683
    .restart local v41    # "c":Ljava/lang/Class;
    if-eqz v41, :cond_6

    .line 684
    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    const/4 v5, 0x1

    const-class v8, Lcom/android/server/wm/WindowManagerService;

    aput-object v8, v4, v5

    move-object/from16 v0, v41

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v55

    .line 685
    .local v55, "ctor":Ljava/lang/reflect/Constructor;
    if-eqz v55, :cond_6

    .line 686
    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    const/4 v5, 0x1

    aput-object v117, v4, v5

    move-object/from16 v0, v55

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Lcom/android/server/statusbar/StatusBarManagerService;

    move-object/from16 v101, v0
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_c
    .catch Ljava/lang/Throwable; {:try_start_18 .. :try_end_18} :catch_d

    .line 694
    .end local v41    # "c":Ljava/lang/Class;
    .end local v55    # "ctor":Ljava/lang/reflect/Constructor;
    :cond_6
    :goto_11
    :try_start_19
    const-string v4, "statusbar"

    move-object/from16 v0, v101

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_d

    .line 700
    :cond_7
    :goto_12
    if-nez v67, :cond_8

    .line 702
    :try_start_1a
    const-string v4, "SystemServer"

    const-string v5, "Clipboard Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 703
    const-string v4, "clipboard"

    new-instance v5, Lcom/android/server/clipboard/ClipboardService;

    invoke-direct {v5, v3}, Lcom/android/server/clipboard/ClipboardService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_e

    .line 710
    :cond_8
    :goto_13
    if-nez v66, :cond_9

    .line 712
    :try_start_1b
    const-string v4, "SystemServer"

    const-string v5, "NetworkManagement Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 713
    invoke-static {v3}, Lcom/android/server/NetworkManagementService;->create(Landroid/content/Context;)Lcom/android/server/NetworkManagementService;

    move-result-object v7

    .line 714
    const-string v4, "network_management"

    invoke-static {v4, v7}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_f

    .line 720
    :cond_9
    :goto_14
    if-nez v67, :cond_a

    .line 722
    :try_start_1c
    const-string v4, "SystemServer"

    const-string v5, "Text Service Manager Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 723
    new-instance v106, Lcom/android/server/TextServicesManagerService;

    move-object/from16 v0, v106

    invoke-direct {v0, v3}, Lcom/android/server/TextServicesManagerService;-><init>(Landroid/content/Context;)V
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_10

    .line 724
    .end local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    .local v106, "tsms":Lcom/android/server/TextServicesManagerService;
    :try_start_1d
    const-string v4, "textservices"

    move-object/from16 v0, v106

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_44

    move-object/from16 v105, v106

    .line 730
    .end local v106    # "tsms":Lcom/android/server/TextServicesManagerService;
    .restart local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    :cond_a
    :goto_15
    if-nez v66, :cond_38

    .line 732
    :try_start_1e
    const-string v4, "SystemServer"

    const-string v5, "Network Score Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 733
    new-instance v92, Lcom/android/server/NetworkScoreService;

    move-object/from16 v0, v92

    invoke-direct {v0, v3}, Lcom/android/server/NetworkScoreService;-><init>(Landroid/content/Context;)V
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_11

    .line 734
    .end local v91    # "networkScore":Lcom/android/server/NetworkScoreService;
    .local v92, "networkScore":Lcom/android/server/NetworkScoreService;
    :try_start_1f
    const-string v4, "network_score"

    move-object/from16 v0, v92

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_43

    move-object/from16 v91, v92

    .line 741
    .end local v92    # "networkScore":Lcom/android/server/NetworkScoreService;
    .restart local v91    # "networkScore":Lcom/android/server/NetworkScoreService;
    :goto_16
    :try_start_20
    const-string v4, "com.android.server.net.NetworkStatsServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 742
    .restart local v41    # "c":Ljava/lang/Class;
    if-eqz v41, :cond_b

    .line 743
    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    const/4 v5, 0x1

    const-class v8, Landroid/os/INetworkManagementService;

    aput-object v8, v4, v5

    const/4 v5, 0x2

    const-class v8, Landroid/app/IAlarmManager;

    aput-object v8, v4, v5

    move-object/from16 v0, v41

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v49

    .line 745
    .restart local v49    # "constructor":Ljava/lang/reflect/Constructor;
    if-eqz v49, :cond_b

    .line 746
    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    const/4 v5, 0x1

    aput-object v7, v4, v5

    const/4 v5, 0x2

    aput-object v34, v4, v5

    move-object/from16 v0, v49

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Lcom/android/server/net/NetworkStatsService;

    move-object v6, v0
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_20} :catch_12

    .end local v49    # "constructor":Ljava/lang/reflect/Constructor;
    :cond_b
    move-object/from16 v93, v6

    .line 757
    .end local v6    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .end local v41    # "c":Ljava/lang/Class;
    .local v93, "networkStats":Lcom/android/server/net/NetworkStatsService;
    :goto_17
    if-nez v93, :cond_37

    .line 759
    :try_start_21
    const-string v4, "SystemServer"

    const-string v5, "NetworkStats Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 760
    new-instance v6, Lcom/android/server/net/NetworkStatsService;

    move-object/from16 v0, v34

    invoke-direct {v6, v3, v7, v0}, Lcom/android/server/net/NetworkStatsService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/app/IAlarmManager;)V
    :try_end_21
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_13

    .line 764
    .end local v93    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .restart local v6    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    :goto_18
    :try_start_22
    const-string v4, "netstats"

    invoke-static {v4, v6}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_22
    .catch Ljava/lang/Throwable; {:try_start_22 .. :try_end_22} :catch_42

    .line 770
    :goto_19
    :try_start_23
    const-string v4, "SystemServer"

    const-string v5, "NetworkPolicy Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 771
    new-instance v2, Lcom/android/server/net/NetworkPolicyManagerService;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    const-string v5, "power"

    invoke-static {v5}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v5

    check-cast v5, Landroid/os/IPowerManager;

    invoke-direct/range {v2 .. v7}, Lcom/android/server/net/NetworkPolicyManagerService;-><init>(Landroid/content/Context;Landroid/app/IActivityManager;Landroid/os/IPowerManager;Landroid/net/INetworkStatsService;Landroid/os/INetworkManagementService;)V
    :try_end_23
    .catch Ljava/lang/Throwable; {:try_start_23 .. :try_end_23} :catch_14

    .line 775
    .end local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .local v2, "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    :try_start_24
    const-string v4, "netpolicy"

    invoke-static {v4, v2}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_24
    .catch Ljava/lang/Throwable; {:try_start_24 .. :try_end_24} :catch_41

    .line 780
    :goto_1a
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.wifi.p2p.WifiP2pService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 781
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.wifi.WifiService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 782
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.wifi.WifiScanningService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 785
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.wifi.RttService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 787
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.hardware.ethernet"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_c

    .line 788
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.ethernet.EthernetService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 792
    :cond_c
    :try_start_25
    const-string v4, "SystemServer"

    const-string v5, "Connectivity Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 805
    new-instance v48, Lcom/android/server/ConnectivityService;

    move-object/from16 v0, v48

    invoke-direct {v0, v3, v7, v6, v2}, Lcom/android/server/ConnectivityService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/net/INetworkStatsService;Landroid/net/INetworkPolicyManager;)V
    :try_end_25
    .catch Ljava/lang/Throwable; {:try_start_25 .. :try_end_25} :catch_15

    .line 807
    .end local v47    # "connectivity":Lcom/android/server/ConnectivityService;
    .local v48, "connectivity":Lcom/android/server/ConnectivityService;
    :try_start_26
    const-string v4, "connectivity"

    move-object/from16 v0, v48

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 808
    move-object/from16 v0, v48

    invoke-virtual {v6, v0}, Lcom/android/server/net/NetworkStatsService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 809
    move-object/from16 v0, v48

    invoke-virtual {v2, v0}, Lcom/android/server/net/NetworkPolicyManagerService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V
    :try_end_26
    .catch Ljava/lang/Throwable; {:try_start_26 .. :try_end_26} :catch_40

    move-object/from16 v47, v48

    .line 815
    .end local v48    # "connectivity":Lcom/android/server/ConnectivityService;
    .restart local v47    # "connectivity":Lcom/android/server/ConnectivityService;
    :goto_1b
    :try_start_27
    const-string v4, "SystemServer"

    const-string v5, "Network Service Discovery Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 816
    invoke-static {v3}, Lcom/android/server/NsdService;->create(Landroid/content/Context;)Lcom/android/server/NsdService;

    move-result-object v100

    .line 817
    const-string v4, "servicediscovery"

    move-object/from16 v0, v100

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_27
    .catch Ljava/lang/Throwable; {:try_start_27 .. :try_end_27} :catch_16

    .line 823
    :goto_1c
    :try_start_28
    const-string v4, "SystemServer"

    const-string v5, "DPM Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 824
    invoke-static {v3}, Lcom/android/server/SystemServer;->startDpmService(Landroid/content/Context;)V
    :try_end_28
    .catch Ljava/lang/Throwable; {:try_start_28 .. :try_end_28} :catch_17

    .line 830
    :goto_1d
    if-nez v67, :cond_d

    .line 832
    :try_start_29
    const-string v4, "SystemServer"

    const-string v5, "UpdateLock Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 833
    const-string v4, "updatelock"

    new-instance v5, Lcom/android/server/UpdateLockService;

    invoke-direct {v5, v3}, Lcom/android/server/UpdateLockService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_29
    .catch Ljava/lang/Throwable; {:try_start_29 .. :try_end_29} :catch_18

    .line 840
    :cond_d
    :goto_1e
    if-nez v67, :cond_e

    .line 842
    :try_start_2a
    const-string v4, "SystemServer"

    const-string v5, "LG Encryption Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 843
    new-instance v79, Lcom/android/server/LGEncryptionService;

    move-object/from16 v0, v79

    invoke-direct {v0, v3}, Lcom/android/server/LGEncryptionService;-><init>(Landroid/content/Context;)V
    :try_end_2a
    .catch Ljava/lang/Throwable; {:try_start_2a .. :try_end_2a} :catch_19

    .line 844
    .end local v78    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    .local v79, "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    :try_start_2b
    const-string v4, "encryption"

    move-object/from16 v0, v79

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2b
    .catch Ljava/lang/Throwable; {:try_start_2b .. :try_end_2b} :catch_3f

    move-object/from16 v78, v79

    .line 855
    .end local v79    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    .restart local v78    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    :cond_e
    :goto_1f
    if-eqz v88, :cond_f

    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    if-nez v4, :cond_f

    .line 856
    invoke-virtual/range {v88 .. v88}, Lcom/android/server/MountService;->waitForAsecScan()V

    .line 860
    :cond_f
    if-eqz v32, :cond_10

    .line 861
    :try_start_2c
    invoke-virtual/range {v32 .. v32}, Lcom/android/server/accounts/AccountManagerService;->systemReady()V
    :try_end_2c
    .catch Ljava/lang/Throwable; {:try_start_2c .. :try_end_2c} :catch_1a

    .line 867
    :cond_10
    :goto_20
    if-eqz v52, :cond_11

    .line 868
    :try_start_2d
    invoke-virtual/range {v52 .. v52}, Lcom/android/server/content/ContentService;->systemReady()V
    :try_end_2d
    .catch Ljava/lang/Throwable; {:try_start_2d .. :try_end_2d} :catch_1b

    .line 874
    :cond_11
    :goto_21
    :try_start_2e
    const-string v4, "com.android.server.notification.NotificationManagerServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 875
    .restart local v41    # "c":Ljava/lang/Class;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    move-object/from16 v0, v41

    invoke-virtual {v4, v0}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;
    :try_end_2e
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2e .. :try_end_2e} :catch_1c

    .line 880
    .end local v41    # "c":Ljava/lang/Class;
    :goto_22
    const-string v4, "notification"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Landroid/app/INotificationManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/app/INotificationManager;

    move-result-object v96

    .line 882
    move-object/from16 v0, v96

    invoke-virtual {v2, v0}, Lcom/android/server/net/NetworkPolicyManagerService;->bindNotificationManager(Landroid/app/INotificationManager;)V

    .line 885
    :try_start_2f
    const-string v4, "com.android.server.storage.DeviceStorageMonitorServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 886
    .restart local v41    # "c":Ljava/lang/Class;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    move-object/from16 v0, v41

    invoke-virtual {v4, v0}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;
    :try_end_2f
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2f .. :try_end_2f} :catch_1d

    .line 892
    .end local v41    # "c":Ljava/lang/Class;
    :goto_23
    if-nez v64, :cond_12

    .line 894
    :try_start_30
    const-string v4, "SystemServer"

    const-string v5, "Location Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 895
    new-instance v81, Lcom/android/server/LocationManagerService;

    move-object/from16 v0, v81

    invoke-direct {v0, v3}, Lcom/android/server/LocationManagerService;-><init>(Landroid/content/Context;)V
    :try_end_30
    .catch Ljava/lang/Throwable; {:try_start_30 .. :try_end_30} :catch_1e

    .line 896
    .end local v80    # "location":Lcom/android/server/LocationManagerService;
    .local v81, "location":Lcom/android/server/LocationManagerService;
    :try_start_31
    const-string v4, "location"

    move-object/from16 v0, v81

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_31
    .catch Ljava/lang/Throwable; {:try_start_31 .. :try_end_31} :catch_3e

    move-object/from16 v80, v81

    .line 902
    .end local v81    # "location":Lcom/android/server/LocationManagerService;
    .restart local v80    # "location":Lcom/android/server/LocationManagerService;
    :goto_24
    :try_start_32
    const-string v4, "SystemServer"

    const-string v5, "Country Detector"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 903
    new-instance v54, Lcom/android/server/CountryDetectorService;

    move-object/from16 v0, v54

    invoke-direct {v0, v3}, Lcom/android/server/CountryDetectorService;-><init>(Landroid/content/Context;)V
    :try_end_32
    .catch Ljava/lang/Throwable; {:try_start_32 .. :try_end_32} :catch_1f

    .line 904
    .end local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .local v54, "countryDetector":Lcom/android/server/CountryDetectorService;
    :try_start_33
    const-string v4, "country_detector"

    move-object/from16 v0, v54

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_33
    .catch Ljava/lang/Throwable; {:try_start_33 .. :try_end_33} :catch_3d

    move-object/from16 v53, v54

    .line 910
    .end local v54    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .restart local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    :cond_12
    :goto_25
    if-nez v67, :cond_13

    .line 912
    :try_start_34
    const-string v4, "SystemServer"

    const-string v5, "Search Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 913
    const-string v4, "search"

    new-instance v5, Lcom/android/server/search/SearchManagerService;

    invoke-direct {v5, v3}, Lcom/android/server/search/SearchManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_34
    .catch Ljava/lang/Throwable; {:try_start_34 .. :try_end_34} :catch_20

    .line 921
    :cond_13
    :goto_26
    :try_start_35
    const-string v4, "SystemServer"

    const-string v5, "DropBox Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 922
    const-string v4, "dropbox"

    new-instance v5, Lcom/android/server/DropBoxManagerService;

    new-instance v8, Ljava/io/File;

    const-string v9, "/data/system/dropbox"

    invoke-direct {v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v3, v8}, Lcom/android/server/DropBoxManagerService;-><init>(Landroid/content/Context;Ljava/io/File;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_35
    .catch Ljava/lang/Throwable; {:try_start_35 .. :try_end_35} :catch_21

    .line 928
    :goto_27
    if-nez v67, :cond_15

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x112003b

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v4

    if-eqz v4, :cond_15

    .line 931
    :try_start_36
    const-string v4, "SystemServer"

    const-string v5, "Wallpaper Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_36
    .catch Ljava/lang/Throwable; {:try_start_36 .. :try_end_36} :catch_23

    .line 933
    :try_start_37
    const-string v4, "com.android.server.wallpaper.WallpaperManagerServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v41

    .line 934
    .restart local v41    # "c":Ljava/lang/Class;
    const/16 v49, 0x0

    .line 935
    .restart local v49    # "constructor":Ljava/lang/reflect/Constructor;
    if-eqz v41, :cond_14

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    move-object/from16 v0, v41

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v49

    if-eqz v49, :cond_14

    .line 936
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    move-object/from16 v0, v49

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Lcom/android/server/wallpaper/WallpaperManagerService;

    move-object/from16 v111, v0
    :try_end_37
    .catch Ljava/lang/ClassNotFoundException; {:try_start_37 .. :try_end_37} :catch_22
    .catch Ljava/lang/Throwable; {:try_start_37 .. :try_end_37} :catch_23

    .line 942
    .end local v41    # "c":Ljava/lang/Class;
    .end local v49    # "constructor":Ljava/lang/reflect/Constructor;
    :cond_14
    :goto_28
    :try_start_38
    const-string v4, "wallpaper"

    move-object/from16 v0, v111

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_38
    .catch Ljava/lang/Throwable; {:try_start_38 .. :try_end_38} :catch_23

    .line 948
    :cond_15
    :goto_29
    if-nez v65, :cond_16

    const-string v4, "0"

    const-string v5, "system_init.startaudioservice"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_16

    .line 950
    :try_start_39
    const-string v4, "SystemServer"

    const-string v5, "Audio Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 951
    const-string v4, "android.media.AudioServiceEx"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v38

    .line 952
    .local v38, "audioServiceClass":Ljava/lang/Class;
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    move-object/from16 v0, v38

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v56

    .line 953
    .local v56, "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<+Landroid/media/AudioService;>;"
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    move-object/from16 v0, v56

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Landroid/media/AudioService;

    move-object/from16 v37, v0

    .line 955
    const-string v4, "audio"

    move-object/from16 v0, v37

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_39
    .catch Ljava/lang/Throwable; {:try_start_39 .. :try_end_39} :catch_24

    .line 961
    .end local v38    # "audioServiceClass":Ljava/lang/Class;
    .end local v56    # "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<+Landroid/media/AudioService;>;"
    :cond_16
    :goto_2a
    if-nez v67, :cond_17

    .line 962
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/DockObserver;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 965
    :cond_17
    if-nez v65, :cond_18

    .line 967
    :try_start_3a
    const-string v4, "SystemServer"

    const-string v5, "Wired Accessory Manager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 969
    new-instance v4, Lcom/android/server/WiredAccessoryManager;

    move-object/from16 v0, v74

    invoke-direct {v4, v3, v0}, Lcom/android/server/WiredAccessoryManager;-><init>(Landroid/content/Context;Lcom/android/server/input/InputManagerService;)V

    move-object/from16 v0, v74

    invoke-virtual {v0, v4}, Lcom/android/server/input/InputManagerService;->setWiredAccessoryCallbacks(Lcom/android/server/input/InputManagerService$WiredAccessoryCallbacks;)V
    :try_end_3a
    .catch Ljava/lang/Throwable; {:try_start_3a .. :try_end_3a} :catch_25

    .line 976
    :cond_18
    :goto_2b
    if-nez v67, :cond_1b

    .line 977
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.hardware.usb.host"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_19

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.hardware.usb.accessory"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1a

    .line 981
    :cond_19
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.usb.UsbService$Lifecycle"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 985
    :cond_1a
    :try_start_3b
    const-string v4, "SystemServer"

    const-string v5, "Serial Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 987
    new-instance v99, Lcom/android/server/SerialService;

    move-object/from16 v0, v99

    invoke-direct {v0, v3}, Lcom/android/server/SerialService;-><init>(Landroid/content/Context;)V
    :try_end_3b
    .catch Ljava/lang/Throwable; {:try_start_3b .. :try_end_3b} :catch_26

    .line 988
    .end local v98    # "serial":Lcom/android/server/SerialService;
    .local v99, "serial":Lcom/android/server/SerialService;
    :try_start_3c
    const-string v4, "serial"

    move-object/from16 v0, v99

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3c
    .catch Ljava/lang/Throwable; {:try_start_3c .. :try_end_3c} :catch_3c

    move-object/from16 v98, v99

    .line 994
    .end local v99    # "serial":Lcom/android/server/SerialService;
    .restart local v98    # "serial":Lcom/android/server/SerialService;
    :cond_1b
    :goto_2c
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/twilight/TwilightService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 996
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/UiModeManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 998
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/job/JobSchedulerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1000
    if-nez v67, :cond_1e

    .line 1001
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.software.backup"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1c

    .line 1002
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.backup.BackupManagerService$Lifecycle"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 1005
    :cond_1c
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.software.app_widgets"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1d

    .line 1006
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.appwidget.AppWidgetService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 1009
    :cond_1d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.software.voice_recognizers"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1e

    .line 1010
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.voiceinteraction.VoiceInteractionManagerService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 1015
    :cond_1e
    :try_start_3d
    const-string v4, "SystemServer"

    const-string v5, "DiskStats Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1016
    const-string v4, "diskstats"

    new-instance v5, Lcom/android/server/DiskStatsService;

    invoke-direct {v5, v3}, Lcom/android/server/DiskStatsService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3d
    .catch Ljava/lang/Throwable; {:try_start_3d .. :try_end_3d} :catch_27

    .line 1026
    :goto_2d
    :try_start_3e
    const-string v4, "SystemServer"

    const-string v5, "SamplingProfiler Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1027
    const-string v4, "samplingprofiler"

    new-instance v5, Lcom/android/server/SamplingProfilerService;

    invoke-direct {v5, v3}, Lcom/android/server/SamplingProfilerService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3e
    .catch Ljava/lang/Throwable; {:try_start_3e .. :try_end_3e} :catch_28

    .line 1033
    :goto_2e
    if-nez v66, :cond_1f

    .line 1035
    :try_start_3f
    const-string v4, "SystemServer"

    const-string v5, "NetworkTimeUpdateService"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1036
    new-instance v95, Lcom/android/server/NetworkTimeUpdateService;

    move-object/from16 v0, v95

    invoke-direct {v0, v3}, Lcom/android/server/NetworkTimeUpdateService;-><init>(Landroid/content/Context;)V
    :try_end_3f
    .catch Ljava/lang/Throwable; {:try_start_3f .. :try_end_3f} :catch_29

    .end local v94    # "networkTimeUpdater":Lcom/android/server/NetworkTimeUpdateService;
    .local v95, "networkTimeUpdater":Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v94, v95

    .line 1042
    .end local v95    # "networkTimeUpdater":Lcom/android/server/NetworkTimeUpdateService;
    .restart local v94    # "networkTimeUpdater":Lcom/android/server/NetworkTimeUpdateService;
    :cond_1f
    :goto_2f
    if-nez v65, :cond_20

    .line 1044
    :try_start_40
    const-string v4, "SystemServer"

    const-string v5, "CommonTimeManagementService"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1045
    new-instance v45, Lcom/android/server/CommonTimeManagementService;

    move-object/from16 v0, v45

    invoke-direct {v0, v3}, Lcom/android/server/CommonTimeManagementService;-><init>(Landroid/content/Context;)V
    :try_end_40
    .catch Ljava/lang/Throwable; {:try_start_40 .. :try_end_40} :catch_2a

    .line 1046
    .end local v44    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    .local v45, "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    :try_start_41
    const-string v4, "commontime_management"

    move-object/from16 v0, v45

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_41
    .catch Ljava/lang/Throwable; {:try_start_41 .. :try_end_41} :catch_3b

    move-object/from16 v44, v45

    .line 1052
    .end local v45    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    .restart local v44    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    :cond_20
    :goto_30
    if-nez v66, :cond_21

    .line 1054
    :try_start_42
    const-string v4, "SystemServer"

    const-string v5, "CertBlacklister"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1055
    new-instance v4, Lcom/android/server/CertBlacklister;

    invoke-direct {v4, v3}, Lcom/android/server/CertBlacklister;-><init>(Landroid/content/Context;)V
    :try_end_42
    .catch Ljava/lang/Throwable; {:try_start_42 .. :try_end_42} :catch_2b

    .line 1061
    :cond_21
    :goto_31
    if-nez v67, :cond_22

    .line 1063
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/dreams/DreamManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1066
    :cond_22
    if-nez v67, :cond_23

    if-nez v62, :cond_23

    .line 1068
    :try_start_43
    const-string v4, "SystemServer"

    const-string v5, "Assets Atlas Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1069
    new-instance v36, Lcom/android/server/AssetAtlasService;

    move-object/from16 v0, v36

    invoke-direct {v0, v3}, Lcom/android/server/AssetAtlasService;-><init>(Landroid/content/Context;)V
    :try_end_43
    .catch Ljava/lang/Throwable; {:try_start_43 .. :try_end_43} :catch_2c

    .line 1070
    .end local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    .local v36, "atlas":Lcom/android/server/AssetAtlasService;
    :try_start_44
    const-string v4, "assetatlas"

    move-object/from16 v0, v36

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_44
    .catch Ljava/lang/Throwable; {:try_start_44 .. :try_end_44} :catch_3a

    move-object/from16 v35, v36

    .line 1077
    .end local v36    # "atlas":Lcom/android/server/AssetAtlasService;
    .restart local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    :cond_23
    :goto_32
    sget-boolean v4, Lcom/lge/config/ConfigBuildFlags;->CAPP_THEMEICON:Z

    if-eqz v4, :cond_24

    .line 1082
    :try_start_45
    const-string v4, "SystemServer"

    const-string v5, "ThemeIconManager"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1083
    const-string v4, "themeicon"

    new-instance v5, Lcom/android/server/thm/ThemeIconManagerService;

    invoke-direct {v5, v3}, Lcom/android/server/thm/ThemeIconManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_45
    .catch Ljava/lang/Throwable; {:try_start_45 .. :try_end_45} :catch_2d

    .line 1091
    :cond_24
    :goto_33
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.software.print"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_25

    .line 1092
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-string v5, "com.android.server.print.PrintManagerService"

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/String;)Lcom/android/server/SystemService;

    .line 1095
    :cond_25
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/restrictions/RestrictionsManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1097
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/media/MediaSessionService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1099
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.hardware.hdmi.cec"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_26

    .line 1100
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/hdmi/HdmiControlService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1103
    :cond_26
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManager:Landroid/content/pm/PackageManager;

    const-string v5, "android.software.live_tv"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_27

    .line 1104
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/tv/TvInputManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1107
    :cond_27
    const-string v4, "ro.build.target_operator"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "KT"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_28

    .line 1109
    :try_start_46
    const-string v4, "KT UCA"

    const-string v5, "KT UCA Service"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1110
    const-string v4, "ktuca"

    new-instance v5, Landroid/ktuca/KtUcaService;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/android/server/SystemServer;->mSystemContext:Landroid/content/Context;

    invoke-direct {v5, v8}, Landroid/ktuca/KtUcaService;-><init>(Landroid/content/Context;)V

    invoke-static {v4, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_46
    .catch Ljava/lang/Throwable; {:try_start_46 .. :try_end_46} :catch_2e

    .line 1116
    :cond_28
    :goto_34
    if-nez v67, :cond_29

    .line 1118
    :try_start_47
    const-string v4, "SystemServer"

    const-string v5, "Media Router Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1119
    new-instance v85, Lcom/android/server/media/MediaRouterService;

    move-object/from16 v0, v85

    invoke-direct {v0, v3}, Lcom/android/server/media/MediaRouterService;-><init>(Landroid/content/Context;)V
    :try_end_47
    .catch Ljava/lang/Throwable; {:try_start_47 .. :try_end_47} :catch_2f

    .line 1120
    .end local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .local v85, "mediaRouter":Lcom/android/server/media/MediaRouterService;
    :try_start_48
    const-string v4, "media_router"

    move-object/from16 v0, v85

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_48
    .catch Ljava/lang/Throwable; {:try_start_48 .. :try_end_48} :catch_39

    move-object/from16 v84, v85

    .line 1125
    .end local v85    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .restart local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    :goto_35
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/trust/TrustManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1127
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/fingerprint/FingerprintService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1130
    :try_start_49
    const-string v4, "SystemServer"

    const-string v5, "BackgroundDexOptService"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1131
    invoke-static {v3}, Lcom/android/server/pm/BackgroundDexOptService;->schedule(Landroid/content/Context;)V
    :try_end_49
    .catch Ljava/lang/Throwable; {:try_start_49 .. :try_end_49} :catch_30

    .line 1138
    :cond_29
    :goto_36
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/pm/LauncherAppsService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1140
    const-string v4, "ro.bluetooth.wipower"

    const/4 v5, 0x0

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v77

    .line 1142
    .local v77, "isWipowerEnabled":Z
    if-eqz v77, :cond_35

    .line 1144
    :try_start_4a
    const-string v31, "wbc_service"

    .line 1145
    .local v31, "WBC_SERVICE_NAME":Ljava/lang/String;
    const-string v4, "SystemServer"

    const-string v5, "WipowerBatteryControl Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1147
    new-instance v115, Ldalvik/system/PathClassLoader;

    const-string v4, "/system/framework/com.quicinc.wbc.jar:/system/framework/com.quicinc.wbcservice.jar"

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    move-object/from16 v0, v115

    invoke-direct {v0, v4, v5}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 1150
    .local v115, "wbcClassLoader":Ldalvik/system/PathClassLoader;
    const-string v4, "com.quicinc.wbcservice.WbcService"

    move-object/from16 v0, v115

    invoke-virtual {v0, v4}, Ldalvik/system/PathClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v114

    .line 1151
    .local v114, "wbcClass":Ljava/lang/Class;
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    move-object/from16 v0, v114

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v57

    .line 1152
    .local v57, "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Ljava/lang/Class;>;"
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    move-object/from16 v0, v57

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v116

    .line 1153
    .local v116, "wbcObject":Ljava/lang/Object;
    const-string v4, "SystemServer"

    const-string v5, "Successfully loaded WbcService class"

    invoke-static {v4, v5}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1154
    const-string v4, "wbc_service"

    check-cast v116, Landroid/os/IBinder;

    .end local v116    # "wbcObject":Ljava/lang/Object;
    move-object/from16 v0, v116

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4a
    .catch Ljava/lang/Throwable; {:try_start_4a .. :try_end_4a} :catch_31

    .line 1162
    .end local v31    # "WBC_SERVICE_NAME":Ljava/lang/String;
    .end local v57    # "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Ljava/lang/Class;>;"
    .end local v114    # "wbcClass":Ljava/lang/Class;
    .end local v115    # "wbcClassLoader":Ldalvik/system/PathClassLoader;
    :goto_37
    if-eqz v58, :cond_2a

    .line 1164
    :try_start_4b
    const-string v4, "SystemServer"

    const-string v5, "Digital Pen Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1165
    new-instance v60, Ldalvik/system/PathClassLoader;

    const-string v4, "/system/framework/DigitalPenService.jar"

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    move-object/from16 v0, v60

    invoke-direct {v0, v4, v5}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 1168
    .local v60, "digitalPenClassLoader":Ldalvik/system/PathClassLoader;
    const-string v4, "com.qti.snapdragon.digitalpen.DigitalPenService"

    move-object/from16 v0, v60

    invoke-virtual {v0, v4}, Ldalvik/system/PathClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v59

    .line 1170
    .local v59, "digitalPenClass":Ljava/lang/Class;
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v4, v5

    move-object/from16 v0, v59

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v57

    .line 1171
    .restart local v57    # "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Ljava/lang/Class;>;"
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v3, v4, v5

    move-object/from16 v0, v57

    invoke-virtual {v0, v4}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v61

    .line 1172
    .local v61, "digitalPenRemoteObject":Ljava/lang/Object;
    const-string v4, "SystemServer"

    const-string v5, "Successfully loaded DigitalPenService class"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1173
    const-string v4, "DigitalPen"

    check-cast v61, Landroid/os/IBinder;

    .end local v61    # "digitalPenRemoteObject":Ljava/lang/Object;
    move-object/from16 v0, v61

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4b
    .catch Ljava/lang/Throwable; {:try_start_4b .. :try_end_4b} :catch_32

    .line 1180
    .end local v57    # "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<Ljava/lang/Class;>;"
    .end local v59    # "digitalPenClass":Ljava/lang/Class;
    .end local v60    # "digitalPenClassLoader":Ldalvik/system/PathClassLoader;
    .end local v77    # "isWipowerEnabled":Z
    :cond_2a
    :goto_38
    if-nez v67, :cond_2b

    .line 1181
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/media/projection/MediaProjectionManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    .line 1186
    :cond_2b
    invoke-virtual/range {v117 .. v117}, Lcom/android/server/wm/WindowManagerService;->detectSafeMode()Z

    move-result v97

    .line 1187
    .local v97, "safeMode":Z
    if-eqz v97, :cond_36

    .line 1188
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v4}, Lcom/android/server/am/ActivityManagerService;->enterSafeMode()V

    .line 1190
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v4

    invoke-virtual {v4}, Ldalvik/system/VMRuntime;->disableJitCompilation()V

    .line 1197
    :goto_39
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/MmsServiceBroker;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    move-result-object v87

    .end local v87    # "mmsService":Lcom/android/server/MmsServiceBroker;
    check-cast v87, Lcom/android/server/MmsServiceBroker;

    .line 1202
    .restart local v87    # "mmsService":Lcom/android/server/MmsServiceBroker;
    :try_start_4c
    invoke-virtual/range {v108 .. v108}, Lcom/android/server/VibratorService;->systemReady()V
    :try_end_4c
    .catch Ljava/lang/Throwable; {:try_start_4c .. :try_end_4c} :catch_33

    .line 1207
    :goto_3a
    if-eqz v82, :cond_2c

    .line 1209
    :try_start_4d
    invoke-virtual/range {v82 .. v82}, Lcom/android/server/LockSettingsService;->systemReady()V
    :try_end_4d
    .catch Ljava/lang/Throwable; {:try_start_4d .. :try_end_4d} :catch_34

    .line 1216
    :cond_2c
    :goto_3b
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const/16 v5, 0x1e0

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startBootPhase(I)V

    .line 1218
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const/16 v5, 0x1f4

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startBootPhase(I)V

    .line 1221
    :try_start_4e
    invoke-virtual/range {v117 .. v117}, Lcom/android/server/wm/WindowManagerService;->systemReady()V
    :try_end_4e
    .catch Ljava/lang/Throwable; {:try_start_4e .. :try_end_4e} :catch_35

    .line 1226
    :goto_3c
    if-eqz v97, :cond_2d

    .line 1227
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v4}, Lcom/android/server/am/ActivityManagerService;->showSafeModeOverlay()V

    .line 1233
    :cond_2d
    invoke-virtual/range {v117 .. v117}, Lcom/android/server/wm/WindowManagerService;->computeNewConfiguration()Landroid/content/res/Configuration;

    move-result-object v46

    .line 1234
    .local v46, "config":Landroid/content/res/Configuration;
    new-instance v86, Landroid/util/DisplayMetrics;

    invoke-direct/range {v86 .. v86}, Landroid/util/DisplayMetrics;-><init>()V

    .line 1235
    .local v86, "metrics":Landroid/util/DisplayMetrics;
    const-string v4, "window"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v110

    check-cast v110, Landroid/view/WindowManager;

    .line 1236
    .local v110, "w":Landroid/view/WindowManager;
    invoke-interface/range {v110 .. v110}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v4

    move-object/from16 v0, v86

    invoke-virtual {v4, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 1237
    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    move-object/from16 v0, v46

    move-object/from16 v1, v86

    invoke-virtual {v4, v0, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 1241
    :try_start_4f
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPowerManagerService:Lcom/android/server/power/PowerManagerService;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v5}, Lcom/android/server/am/ActivityManagerService;->getAppOpsService()Lcom/android/internal/app/IAppOpsService;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/android/server/power/PowerManagerService;->systemReady(Lcom/android/internal/app/IAppOpsService;)V
    :try_end_4f
    .catch Ljava/lang/Throwable; {:try_start_4f .. :try_end_4f} :catch_36

    .line 1247
    :goto_3d
    :try_start_50
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mPackageManagerService:Lcom/android/server/pm/PackageManagerService;

    invoke-virtual {v4}, Lcom/android/server/pm/PackageManagerService;->systemReady()V
    :try_end_50
    .catch Ljava/lang/Throwable; {:try_start_50 .. :try_end_50} :catch_37

    .line 1254
    :goto_3e
    :try_start_51
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mDisplayManagerService:Lcom/android/server/display/DisplayManagerService;

    move-object/from16 v0, p0

    iget-boolean v5, v0, Lcom/android/server/SystemServer;->mOnlyCore:Z

    move/from16 v0, v97

    invoke-virtual {v4, v0, v5}, Lcom/android/server/display/DisplayManagerService;->systemReady(ZZ)V
    :try_end_51
    .catch Ljava/lang/Throwable; {:try_start_51 .. :try_end_51} :catch_38

    .line 1260
    :goto_3f
    move-object/from16 v11, v88

    .line 1261
    .local v11, "mountServiceF":Lcom/android/server/MountService;
    move-object v13, v7

    .line 1262
    .local v13, "networkManagementF":Lcom/android/server/NetworkManagementService;
    move-object v14, v6

    .line 1263
    .local v14, "networkStatsF":Lcom/android/server/net/NetworkStatsService;
    move-object v15, v2

    .line 1264
    .local v15, "networkPolicyF":Lcom/android/server/net/NetworkPolicyManagerService;
    move-object/from16 v16, v47

    .line 1265
    .local v16, "connectivityF":Lcom/android/server/ConnectivityService;
    move-object/from16 v12, v91

    .line 1266
    .local v12, "networkScoreF":Lcom/android/server/NetworkScoreService;
    move-object/from16 v18, v111

    .line 1267
    .local v18, "wallpaperF":Lcom/android/server/wallpaper/WallpaperManagerService;
    move-object/from16 v19, v72

    .line 1268
    .local v19, "immF":Lcom/android/server/InputMethodManagerService;
    move-object/from16 v21, v80

    .line 1269
    .local v21, "locationF":Lcom/android/server/LocationManagerService;
    move-object/from16 v22, v53

    .line 1270
    .local v22, "countryDetectorF":Lcom/android/server/CountryDetectorService;
    move-object/from16 v23, v94

    .line 1271
    .local v23, "networkTimeUpdaterF":Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v24, v44

    .line 1272
    .local v24, "commonTimeMgmtServiceF":Lcom/android/server/CommonTimeManagementService;
    move-object/from16 v25, v105

    .line 1273
    .local v25, "textServiceManagerServiceF":Lcom/android/server/TextServicesManagerService;
    move-object/from16 v20, v101

    .line 1274
    .local v20, "statusBarF":Lcom/android/server/statusbar/StatusBarManagerService;
    move-object/from16 v26, v35

    .line 1275
    .local v26, "atlasF":Lcom/android/server/AssetAtlasService;
    move-object/from16 v27, v74

    .line 1276
    .local v27, "inputManagerF":Lcom/android/server/input/InputManagerService;
    move-object/from16 v28, v103

    .line 1277
    .local v28, "telephonyRegistryF":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v29, v84

    .line 1278
    .local v29, "mediaRouterF":Lcom/android/server/media/MediaRouterService;
    move-object/from16 v17, v37

    .line 1279
    .local v17, "audioServiceF":Landroid/media/AudioService;
    move-object/from16 v30, v87

    .line 1286
    .local v30, "mmsServiceF":Lcom/android/server/MmsServiceBroker;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mActivityManagerService:Lcom/android/server/am/ActivityManagerService;

    new-instance v8, Lcom/android/server/SystemServer$2;

    move-object/from16 v9, p0

    move-object v10, v3

    invoke-direct/range {v8 .. v30}, Lcom/android/server/SystemServer$2;-><init>(Lcom/android/server/SystemServer;Landroid/content/Context;Lcom/android/server/MountService;Lcom/android/server/NetworkScoreService;Lcom/android/server/NetworkManagementService;Lcom/android/server/net/NetworkStatsService;Lcom/android/server/net/NetworkPolicyManagerService;Lcom/android/server/ConnectivityService;Landroid/media/AudioService;Lcom/android/server/wallpaper/WallpaperManagerService;Lcom/android/server/InputMethodManagerService;Lcom/android/server/statusbar/StatusBarManagerService;Lcom/android/server/LocationManagerService;Lcom/android/server/CountryDetectorService;Lcom/android/server/NetworkTimeUpdateService;Lcom/android/server/CommonTimeManagementService;Lcom/android/server/TextServicesManagerService;Lcom/android/server/AssetAtlasService;Lcom/android/server/input/InputManagerService;Lcom/android/server/TelephonyRegistry;Lcom/android/server/media/MediaRouterService;Lcom/android/server/MmsServiceBroker;)V

    invoke-virtual {v4, v8}, Lcom/android/server/am/ActivityManagerService;->systemReady(Ljava/lang/Runnable;)V

    .line 1416
    return-void

    .line 485
    .end local v2    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v11    # "mountServiceF":Lcom/android/server/MountService;
    .end local v12    # "networkScoreF":Lcom/android/server/NetworkScoreService;
    .end local v13    # "networkManagementF":Lcom/android/server/NetworkManagementService;
    .end local v14    # "networkStatsF":Lcom/android/server/net/NetworkStatsService;
    .end local v15    # "networkPolicyF":Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v16    # "connectivityF":Lcom/android/server/ConnectivityService;
    .end local v17    # "audioServiceF":Landroid/media/AudioService;
    .end local v18    # "wallpaperF":Lcom/android/server/wallpaper/WallpaperManagerService;
    .end local v19    # "immF":Lcom/android/server/InputMethodManagerService;
    .end local v20    # "statusBarF":Lcom/android/server/statusbar/StatusBarManagerService;
    .end local v21    # "locationF":Lcom/android/server/LocationManagerService;
    .end local v22    # "countryDetectorF":Lcom/android/server/CountryDetectorService;
    .end local v23    # "networkTimeUpdaterF":Lcom/android/server/NetworkTimeUpdateService;
    .end local v24    # "commonTimeMgmtServiceF":Lcom/android/server/CommonTimeManagementService;
    .end local v25    # "textServiceManagerServiceF":Lcom/android/server/TextServicesManagerService;
    .end local v26    # "atlasF":Lcom/android/server/AssetAtlasService;
    .end local v27    # "inputManagerF":Lcom/android/server/input/InputManagerService;
    .end local v28    # "telephonyRegistryF":Lcom/android/server/TelephonyRegistry;
    .end local v29    # "mediaRouterF":Lcom/android/server/media/MediaRouterService;
    .end local v30    # "mmsServiceF":Lcom/android/server/MmsServiceBroker;
    .end local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    .end local v46    # "config":Landroid/content/res/Configuration;
    .end local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .end local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    .end local v80    # "location":Lcom/android/server/LocationManagerService;
    .end local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .end local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .end local v86    # "metrics":Landroid/util/DisplayMetrics;
    .end local v96    # "notification":Landroid/app/INotificationManager;
    .end local v97    # "safeMode":Z
    .end local v101    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    .end local v110    # "w":Landroid/view/WindowManager;
    .end local v111    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    .restart local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    :catch_0
    move-exception v71

    .line 486
    .local v71, "e":Ljava/lang/Throwable;
    :goto_40
    :try_start_52
    const-string v4, "SystemServer"

    const-string v5, "Failure starting Account Manager"

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_52
    .catch Ljava/lang/RuntimeException; {:try_start_52 .. :try_end_52} :catch_1

    goto/16 :goto_0

    .line 553
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_1
    move-exception v71

    move-object/from16 v103, v104

    .line 554
    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .local v71, "e":Ljava/lang/RuntimeException;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    :goto_41
    const-string v4, "System"

    const-string v5, "******************************************"

    invoke-static {v4, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 555
    const-string v4, "System"

    const-string v5, "************ Failure starting core service"

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_5

    .line 490
    .end local v71    # "e":Ljava/lang/RuntimeException;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    :cond_2e
    const/4 v4, 0x0

    goto/16 :goto_1

    .line 520
    .end local v42    # "ccMode":Lcom/android/server/CCModeService;
    .end local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .end local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v113    # "watchdog":Lcom/android/server/Watchdog;
    :cond_2f
    const/4 v4, 0x0

    move v5, v4

    goto/16 :goto_2

    :cond_30
    const/4 v4, 0x0

    goto/16 :goto_3

    .line 541
    :cond_31
    :try_start_53
    move-object/from16 v0, p0

    iget v4, v0, Lcom/android/server/SystemServer;->mFactoryTestMode:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_32

    .line 542
    const-string v4, "SystemServer"

    const-string v5, "No Bluetooth Service (factory test)"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .line 553
    :catch_2
    move-exception v71

    move-object/from16 v42, v43

    .end local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v42    # "ccMode":Lcom/android/server/CCModeService;
    move-object/from16 v50, v51

    .end local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v74, v75

    .end local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    move-object/from16 v108, v109

    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    goto :goto_41

    .line 543
    .end local v42    # "ccMode":Lcom/android/server/CCModeService;
    .end local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .end local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v109    # "vibrator":Lcom/android/server/VibratorService;
    :cond_32
    invoke-virtual {v3}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    const-string v5, "android.hardware.bluetooth"

    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_33

    .line 545
    const-string v4, "SystemServer"

    const-string v5, "No Bluetooth Service (Bluetooth Hardware Not Present)"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .line 546
    :cond_33
    if-eqz v63, :cond_34

    .line 547
    const-string v4, "SystemServer"

    const-string v5, "Bluetooth Service disabled by config"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .line 549
    :cond_34
    const-string v4, "SystemServer"

    const-string v5, "Bluetooth Manager Service"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 550
    new-instance v40, Lcom/android/server/BluetoothManagerService;

    move-object/from16 v0, v40

    invoke-direct {v0, v3}, Lcom/android/server/BluetoothManagerService;-><init>(Landroid/content/Context;)V
    :try_end_53
    .catch Ljava/lang/RuntimeException; {:try_start_53 .. :try_end_53} :catch_2

    .line 551
    .end local v39    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    .local v40, "bluetooth":Lcom/android/server/BluetoothManagerService;
    :try_start_54
    const-string v4, "bluetooth_manager"

    move-object/from16 v0, v40

    invoke-static {v4, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_54
    .catch Ljava/lang/RuntimeException; {:try_start_54 .. :try_end_54} :catch_4d

    move-object/from16 v39, v40

    .end local v40    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    .restart local v39    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    goto/16 :goto_4

    .line 577
    .end local v43    # "ccMode":Lcom/android/server/CCModeService;
    .end local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .end local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .end local v113    # "watchdog":Lcom/android/server/Watchdog;
    .restart local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    .restart local v42    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .restart local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    .restart local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v80    # "location":Lcom/android/server/LocationManagerService;
    .restart local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .restart local v96    # "notification":Landroid/app/INotificationManager;
    .restart local v101    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v111    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    :catch_3
    move-exception v71

    .line 578
    .local v71, "e":Ljava/lang/Throwable;
    :goto_42
    const-string v4, "starting Input Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_6

    .line 585
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_4
    move-exception v71

    .line 586
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting Accessibility Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_7

    .line 593
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_5
    move-exception v71

    .line 594
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making display ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_8

    .line 599
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_6
    move-exception v71

    .line 600
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "performing boot dexopt"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_9

    .line 613
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_7
    move-exception v71

    .line 614
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting SmartCover"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_b

    .line 632
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_8
    move-exception v71

    .line 633
    .local v71, "e":Ljava/lang/ClassNotFoundException;
    :try_start_55
    const-string v4, "SystemServer"

    const-string v5, "Error while creating MountServiceEx."

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 634
    new-instance v89, Lcom/android/server/MountService;

    move-object/from16 v0, v89

    invoke-direct {v0, v3}, Lcom/android/server/MountService;-><init>(Landroid/content/Context;)V
    :try_end_55
    .catch Ljava/lang/Throwable; {:try_start_55 .. :try_end_55} :catch_9

    .end local v88    # "mountService":Lcom/android/server/MountService;
    .local v89, "mountService":Lcom/android/server/MountService;
    move-object/from16 v88, v89

    .end local v89    # "mountService":Lcom/android/server/MountService;
    .restart local v88    # "mountService":Lcom/android/server/MountService;
    goto/16 :goto_c

    .line 638
    .end local v71    # "e":Ljava/lang/ClassNotFoundException;
    :catch_9
    move-exception v71

    .line 639
    .local v71, "e":Ljava/lang/Throwable;
    const-string v4, "starting Mount Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_d

    .line 656
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_a
    move-exception v71

    .line 657
    .local v71, "e":Ljava/lang/Exception;
    :try_start_56
    const-string v4, "SystemServer"

    const-string v5, "Error while creating LockSettingsServiceEx."

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_56
    .catch Ljava/lang/Throwable; {:try_start_56 .. :try_end_56} :catch_b

    move-object/from16 v83, v82

    .end local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    goto/16 :goto_e

    .line 664
    .end local v71    # "e":Ljava/lang/Exception;
    .end local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    :catch_b
    move-exception v71

    .line 665
    .local v71, "e":Ljava/lang/Throwable;
    :goto_43
    const-string v4, "starting LockSettingsService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_10

    .line 689
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_c
    move-exception v71

    .line 690
    .local v71, "e":Ljava/lang/Exception;
    :try_start_57
    const-string v4, "SystemServer"

    const-string v5, "Could not load com.android.server.statusbar.StatusBarManagerServiceEx."

    invoke-static {v4, v5}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 691
    new-instance v102, Lcom/android/server/statusbar/StatusBarManagerService;

    move-object/from16 v0, v102

    move-object/from16 v1, v117

    invoke-direct {v0, v3, v1}, Lcom/android/server/statusbar/StatusBarManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_57
    .catch Ljava/lang/Throwable; {:try_start_57 .. :try_end_57} :catch_d

    .end local v101    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    .local v102, "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    move-object/from16 v101, v102

    .end local v102    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    .restart local v101    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    goto/16 :goto_11

    .line 695
    .end local v71    # "e":Ljava/lang/Exception;
    :catch_d
    move-exception v71

    .line 696
    .local v71, "e":Ljava/lang/Throwable;
    const-string v4, "starting StatusBarManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_12

    .line 705
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_e
    move-exception v71

    .line 706
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting Clipboard Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_13

    .line 715
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_f
    move-exception v71

    .line 716
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting NetworkManagement Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_14

    .line 725
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_10
    move-exception v71

    .line 726
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_44
    const-string v4, "starting Text Service Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_15

    .line 735
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_11
    move-exception v71

    .line 736
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_45
    const-string v4, "starting Network Score Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_16

    .line 750
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_12
    move-exception v71

    .line 751
    .local v71, "e":Ljava/lang/Exception;
    const-string v4, "SystemServer"

    const-string v5, "Error while creating NetworkStatsServiceEx."

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object/from16 v93, v6

    .end local v6    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .restart local v93    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    goto/16 :goto_17

    .line 765
    .end local v71    # "e":Ljava/lang/Exception;
    :catch_13
    move-exception v71

    move-object/from16 v6, v93

    .line 766
    .end local v93    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .restart local v6    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .local v71, "e":Ljava/lang/Throwable;
    :goto_46
    const-string v4, "starting NetworkStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_19

    .line 776
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_14
    move-exception v71

    move-object/from16 v2, v90

    .line 777
    .end local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v2    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_47
    const-string v4, "starting NetworkPolicy Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1a

    .line 810
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_15
    move-exception v71

    .line 811
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_48
    const-string v4, "starting Connectivity Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1b

    .line 819
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_16
    move-exception v71

    .line 820
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting Service Discovery Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1c

    .line 825
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_17
    move-exception v71

    .line 826
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting DpmService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1d

    .line 835
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_18
    move-exception v71

    .line 836
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting UpdateLockService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1e

    .line 845
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_19
    move-exception v71

    .line 846
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_49
    const-string v4, "starting LGEncryptionService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1f

    .line 862
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_1a
    move-exception v71

    .line 863
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Account Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_20

    .line 869
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_1b
    move-exception v71

    .line 870
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Content Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_21

    .line 876
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_1c
    move-exception v71

    .line 877
    .local v71, "e":Ljava/lang/ClassNotFoundException;
    const-string v4, "SystemServer"

    const-string v5, "NotificationManagerserviceEx not found "

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 878
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/notification/NotificationManagerService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    goto/16 :goto_22

    .line 887
    .end local v71    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1d
    move-exception v71

    .line 888
    .restart local v71    # "e":Ljava/lang/ClassNotFoundException;
    const-string v4, "SystemServer"

    const-string v5, "DeviceStorageMonitorServiceEx not found "

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 889
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/server/SystemServer;->mSystemServiceManager:Lcom/android/server/SystemServiceManager;

    const-class v5, Lcom/android/server/storage/DeviceStorageMonitorService;

    invoke-virtual {v4, v5}, Lcom/android/server/SystemServiceManager;->startService(Ljava/lang/Class;)Lcom/android/server/SystemService;

    goto/16 :goto_23

    .line 897
    .end local v71    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1e
    move-exception v71

    .line 898
    .local v71, "e":Ljava/lang/Throwable;
    :goto_4a
    const-string v4, "starting Location Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_24

    .line 905
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_1f
    move-exception v71

    .line 906
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_4b
    const-string v4, "starting Country Detector"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_25

    .line 915
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_20
    move-exception v71

    .line 916
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting Search Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_26

    .line 924
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_21
    move-exception v71

    .line 925
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting DropBoxManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_27

    .line 938
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_22
    move-exception v71

    .line 939
    .local v71, "e":Ljava/lang/ClassNotFoundException;
    :try_start_58
    const-string v4, "SystemServer"

    const-string v5, "Error while creating WallpaperManagerServiceEx."

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 940
    new-instance v112, Lcom/android/server/wallpaper/WallpaperManagerService;

    move-object/from16 v0, v112

    invoke-direct {v0, v3}, Lcom/android/server/wallpaper/WallpaperManagerService;-><init>(Landroid/content/Context;)V
    :try_end_58
    .catch Ljava/lang/Throwable; {:try_start_58 .. :try_end_58} :catch_23

    .end local v111    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    .local v112, "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    move-object/from16 v111, v112

    .end local v112    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    .restart local v111    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    goto/16 :goto_28

    .line 943
    .end local v71    # "e":Ljava/lang/ClassNotFoundException;
    :catch_23
    move-exception v71

    .line 944
    .local v71, "e":Ljava/lang/Throwable;
    const-string v4, "starting Wallpaper Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_29

    .line 956
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_24
    move-exception v71

    .line 957
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting Audio Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2a

    .line 971
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_25
    move-exception v71

    .line 972
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting WiredAccessoryManager"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2b

    .line 989
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_26
    move-exception v71

    .line 990
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_4c
    const-string v4, "SystemServer"

    const-string v5, "Failure starting SerialService"

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_2c

    .line 1017
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_27
    move-exception v71

    .line 1018
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting DiskStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2d

    .line 1029
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_28
    move-exception v71

    .line 1030
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting SamplingProfiler Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2e

    .line 1037
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_29
    move-exception v71

    .line 1038
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting NetworkTimeUpdate service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2f

    .line 1047
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_2a
    move-exception v71

    .line 1048
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_4d
    const-string v4, "starting CommonTimeManagementService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_30

    .line 1056
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_2b
    move-exception v71

    .line 1057
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting CertBlacklister"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_31

    .line 1071
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_2c
    move-exception v71

    .line 1072
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_4e
    const-string v4, "starting AssetAtlasService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_32

    .line 1085
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_2d
    move-exception v71

    .line 1086
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "SystemServer"

    const-string v5, "Failure starting ThemeIconManager"

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_33

    .line 1111
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_2e
    move-exception v71

    .line 1112
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "KT UCA"

    const-string v5, "Failure starting KT UCA Service"

    move-object/from16 v0, v71

    invoke-static {v4, v5, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_34

    .line 1121
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_2f
    move-exception v71

    .line 1122
    .restart local v71    # "e":Ljava/lang/Throwable;
    :goto_4f
    const-string v4, "starting MediaRouterService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_35

    .line 1132
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_30
    move-exception v71

    .line 1133
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting BackgroundDexOptService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_36

    .line 1155
    .end local v71    # "e":Ljava/lang/Throwable;
    .restart local v77    # "isWipowerEnabled":Z
    :catch_31
    move-exception v71

    .line 1156
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting WipowerBatteryControl Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_37

    .line 1159
    .end local v71    # "e":Ljava/lang/Throwable;
    :cond_35
    const-string v4, "SystemServer"

    const-string v5, "Wipower not supported"

    invoke-static {v4, v5}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_37

    .line 1174
    :catch_32
    move-exception v71

    .line 1175
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "starting DigitalPenService"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_38

    .line 1193
    .end local v71    # "e":Ljava/lang/Throwable;
    .end local v77    # "isWipowerEnabled":Z
    .restart local v97    # "safeMode":Z
    :cond_36
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v4

    invoke-virtual {v4}, Ldalvik/system/VMRuntime;->startJitCompilation()V

    goto/16 :goto_39

    .line 1203
    :catch_33
    move-exception v71

    .line 1204
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Vibrator Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3a

    .line 1210
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_34
    move-exception v71

    .line 1211
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Lock Settings Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3b

    .line 1222
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_35
    move-exception v71

    .line 1223
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Window Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3c

    .line 1242
    .end local v71    # "e":Ljava/lang/Throwable;
    .restart local v46    # "config":Landroid/content/res/Configuration;
    .restart local v86    # "metrics":Landroid/util/DisplayMetrics;
    .restart local v110    # "w":Landroid/view/WindowManager;
    :catch_36
    move-exception v71

    .line 1243
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Power Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3d

    .line 1248
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_37
    move-exception v71

    .line 1249
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Package Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3e

    .line 1255
    .end local v71    # "e":Ljava/lang/Throwable;
    :catch_38
    move-exception v71

    .line 1256
    .restart local v71    # "e":Ljava/lang/Throwable;
    const-string v4, "making Display Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v71

    invoke-direct {v0, v4, v1}, Lcom/android/server/SystemServer;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3f

    .line 1121
    .end local v46    # "config":Landroid/content/res/Configuration;
    .end local v71    # "e":Ljava/lang/Throwable;
    .end local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .end local v86    # "metrics":Landroid/util/DisplayMetrics;
    .end local v97    # "safeMode":Z
    .end local v110    # "w":Landroid/view/WindowManager;
    .restart local v85    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    :catch_39
    move-exception v71

    move-object/from16 v84, v85

    .end local v85    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .restart local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    goto/16 :goto_4f

    .line 1071
    .end local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    .restart local v36    # "atlas":Lcom/android/server/AssetAtlasService;
    :catch_3a
    move-exception v71

    move-object/from16 v35, v36

    .end local v36    # "atlas":Lcom/android/server/AssetAtlasService;
    .restart local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    goto/16 :goto_4e

    .line 1047
    .end local v44    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    .restart local v45    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    :catch_3b
    move-exception v71

    move-object/from16 v44, v45

    .end local v45    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    .restart local v44    # "commonTimeMgmtService":Lcom/android/server/CommonTimeManagementService;
    goto/16 :goto_4d

    .line 989
    .end local v98    # "serial":Lcom/android/server/SerialService;
    .restart local v99    # "serial":Lcom/android/server/SerialService;
    :catch_3c
    move-exception v71

    move-object/from16 v98, v99

    .end local v99    # "serial":Lcom/android/server/SerialService;
    .restart local v98    # "serial":Lcom/android/server/SerialService;
    goto/16 :goto_4c

    .line 905
    .end local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .restart local v54    # "countryDetector":Lcom/android/server/CountryDetectorService;
    :catch_3d
    move-exception v71

    move-object/from16 v53, v54

    .end local v54    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .restart local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    goto/16 :goto_4b

    .line 897
    .end local v80    # "location":Lcom/android/server/LocationManagerService;
    .restart local v81    # "location":Lcom/android/server/LocationManagerService;
    :catch_3e
    move-exception v71

    move-object/from16 v80, v81

    .end local v81    # "location":Lcom/android/server/LocationManagerService;
    .restart local v80    # "location":Lcom/android/server/LocationManagerService;
    goto/16 :goto_4a

    .line 845
    .end local v78    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    .restart local v79    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    :catch_3f
    move-exception v71

    move-object/from16 v78, v79

    .end local v79    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    .restart local v78    # "lgEncryptionService":Lcom/android/server/LGEncryptionService;
    goto/16 :goto_49

    .line 810
    .end local v47    # "connectivity":Lcom/android/server/ConnectivityService;
    .restart local v48    # "connectivity":Lcom/android/server/ConnectivityService;
    :catch_40
    move-exception v71

    move-object/from16 v47, v48

    .end local v48    # "connectivity":Lcom/android/server/ConnectivityService;
    .restart local v47    # "connectivity":Lcom/android/server/ConnectivityService;
    goto/16 :goto_48

    .line 776
    :catch_41
    move-exception v71

    goto/16 :goto_47

    .line 765
    .end local v2    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    :catch_42
    move-exception v71

    goto/16 :goto_46

    .line 735
    .end local v91    # "networkScore":Lcom/android/server/NetworkScoreService;
    .restart local v92    # "networkScore":Lcom/android/server/NetworkScoreService;
    :catch_43
    move-exception v71

    move-object/from16 v91, v92

    .end local v92    # "networkScore":Lcom/android/server/NetworkScoreService;
    .restart local v91    # "networkScore":Lcom/android/server/NetworkScoreService;
    goto/16 :goto_45

    .line 725
    .end local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    .restart local v106    # "tsms":Lcom/android/server/TextServicesManagerService;
    :catch_44
    move-exception v71

    move-object/from16 v105, v106

    .end local v106    # "tsms":Lcom/android/server/TextServicesManagerService;
    .restart local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    goto/16 :goto_44

    .line 664
    .end local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    :catch_45
    move-exception v71

    move-object/from16 v82, v83

    .end local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    goto/16 :goto_43

    .line 608
    :catch_46
    move-exception v4

    goto/16 :goto_a

    .line 577
    .end local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    .restart local v73    # "imm":Lcom/android/server/InputMethodManagerService;
    :catch_47
    move-exception v71

    move-object/from16 v72, v73

    .end local v73    # "imm":Lcom/android/server/InputMethodManagerService;
    .restart local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    goto/16 :goto_42

    .line 553
    .end local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    .end local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .end local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    .end local v80    # "location":Lcom/android/server/LocationManagerService;
    .end local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .end local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .end local v96    # "notification":Landroid/app/INotificationManager;
    .end local v101    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    .end local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    .end local v111    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    :catch_48
    move-exception v71

    goto/16 :goto_41

    .end local v32    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v33    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    :catch_49
    move-exception v71

    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v32, v33

    .end local v33    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .restart local v32    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    goto/16 :goto_41

    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v109    # "vibrator":Lcom/android/server/VibratorService;
    :catch_4a
    move-exception v71

    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v108, v109

    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    goto/16 :goto_41

    .end local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v109    # "vibrator":Lcom/android/server/VibratorService;
    :catch_4b
    move-exception v71

    move-object/from16 v50, v51

    .end local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v108, v109

    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    goto/16 :goto_41

    .end local v42    # "ccMode":Lcom/android/server/CCModeService;
    .end local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v109    # "vibrator":Lcom/android/server/VibratorService;
    :catch_4c
    move-exception v71

    move-object/from16 v42, v43

    .end local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v42    # "ccMode":Lcom/android/server/CCModeService;
    move-object/from16 v50, v51

    .end local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v108, v109

    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    goto/16 :goto_41

    .end local v39    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    .end local v42    # "ccMode":Lcom/android/server/CCModeService;
    .end local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .end local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v108    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v40    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    .restart local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v113    # "watchdog":Lcom/android/server/Watchdog;
    :catch_4d
    move-exception v71

    move-object/from16 v42, v43

    .end local v43    # "ccMode":Lcom/android/server/CCModeService;
    .restart local v42    # "ccMode":Lcom/android/server/CCModeService;
    move-object/from16 v50, v51

    .end local v51    # "consumerIr":Lcom/android/server/ConsumerIrService;
    .restart local v50    # "consumerIr":Lcom/android/server/ConsumerIrService;
    move-object/from16 v103, v104

    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    move-object/from16 v74, v75

    .end local v75    # "inputManager":Lcom/android/server/input/InputManagerService;
    .restart local v74    # "inputManager":Lcom/android/server/input/InputManagerService;
    move-object/from16 v39, v40

    .end local v40    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    .restart local v39    # "bluetooth":Lcom/android/server/BluetoothManagerService;
    move-object/from16 v108, v109

    .end local v109    # "vibrator":Lcom/android/server/VibratorService;
    .restart local v108    # "vibrator":Lcom/android/server/VibratorService;
    goto/16 :goto_41

    .line 485
    .end local v32    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .end local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .end local v113    # "watchdog":Lcom/android/server/Watchdog;
    .restart local v33    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .restart local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    :catch_4e
    move-exception v71

    move-object/from16 v32, v33

    .end local v33    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    .restart local v32    # "accountManager":Lcom/android/server/accounts/AccountManagerService;
    goto/16 :goto_40

    .end local v6    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .end local v104    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v35    # "atlas":Lcom/android/server/AssetAtlasService;
    .restart local v53    # "countryDetector":Lcom/android/server/CountryDetectorService;
    .restart local v72    # "imm":Lcom/android/server/InputMethodManagerService;
    .restart local v80    # "location":Lcom/android/server/LocationManagerService;
    .restart local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v84    # "mediaRouter":Lcom/android/server/media/MediaRouterService;
    .restart local v93    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .restart local v96    # "notification":Landroid/app/INotificationManager;
    .restart local v101    # "statusBar":Lcom/android/server/statusbar/StatusBarManagerService;
    .restart local v103    # "telephonyRegistry":Lcom/android/server/TelephonyRegistry;
    .restart local v105    # "tsms":Lcom/android/server/TextServicesManagerService;
    .restart local v111    # "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService;
    :cond_37
    move-object/from16 v6, v93

    .end local v93    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    .restart local v6    # "networkStats":Lcom/android/server/net/NetworkStatsService;
    goto/16 :goto_18

    :cond_38
    move-object/from16 v2, v90

    .end local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v2    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    goto/16 :goto_1d

    .end local v2    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    :cond_39
    move-object/from16 v82, v83

    .end local v83    # "lockSettings":Lcom/android/server/LockSettingsService;
    .restart local v82    # "lockSettings":Lcom/android/server/LockSettingsService;
    goto/16 :goto_f

    :cond_3a
    move-object/from16 v2, v90

    .end local v90    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v2    # "networkPolicy":Lcom/android/server/net/NetworkPolicyManagerService;
    goto/16 :goto_38
.end method

.method static final startSystemUi(Landroid/content/Context;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 1419
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 1420
    .local v0, "intent":Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.android.systemui"

    const-string v3, "com.android.systemui.SystemUIService"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1423
    sget-object v1, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->startServiceAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)Landroid/content/ComponentName;

    .line 1424
    return-void
.end method
