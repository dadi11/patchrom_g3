.class public Lcom/android/server/Watchdog;
.super Ljava/lang/Thread;
.source "Watchdog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/Watchdog$Monitor;,
        Lcom/android/server/Watchdog$RebootRequestReceiver;,
        Lcom/android/server/Watchdog$HandlerChecker;
    }
.end annotation


# static fields
.field static final CHECK_INTERVAL:J = 0x7530L

.field static final COMPLETED:I = 0x0

.field static final DB:Z = false

.field static final DEFAULT_TIMEOUT:J = 0xea60L

.field public static final NATIVE_STACKS_OF_INTEREST:[Ljava/lang/String;

.field static final OVERDUE:I = 0x3

.field static final RECORD_KERNEL_THREADS:Z = true

.field static final TAG:Ljava/lang/String; = "Watchdog"

.field static final WAITED_HALF:I = 0x2

.field static final WAITING:I = 0x1

.field static final localLOGV:Z

.field static sWatchdog:Lcom/android/server/Watchdog;


# instance fields
.field mActivity:Lcom/android/server/am/ActivityManagerService;

.field mAllowRestart:Z

.field mController:Landroid/app/IActivityController;

.field final mHandlerCheckers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/Watchdog$HandlerChecker;",
            ">;"
        }
    .end annotation
.end field

.field final mMonitorChecker:Lcom/android/server/Watchdog$HandlerChecker;

.field mPhonePid:I

.field mResolver:Landroid/content/ContentResolver;

.field mTraceDateFormat:Ljava/text/SimpleDateFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 70
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "/system/bin/mediaserver"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "/system/bin/sdcard"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "/system/bin/surfaceflinger"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/server/Watchdog;->NATIVE_STACKS_OF_INTEREST:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 7

    .prologue
    const-wide/32 v4, 0xea60

    .line 211
    const-string v0, "watchdog"

    invoke-direct {p0, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    .line 79
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    .line 86
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/Watchdog;->mAllowRestart:Z

    .line 87
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "dd_MMM_HH_mm_ss.SSS"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/android/server/Watchdog;->mTraceDateFormat:Ljava/text/SimpleDateFormat;

    .line 219
    new-instance v0, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-static {}, Lcom/android/server/FgThread;->getHandler()Landroid/os/Handler;

    move-result-object v2

    const-string v3, "foreground thread"

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/server/Watchdog$HandlerChecker;-><init>(Lcom/android/server/Watchdog;Landroid/os/Handler;Ljava/lang/String;J)V

    iput-object v0, p0, Lcom/android/server/Watchdog;->mMonitorChecker:Lcom/android/server/Watchdog$HandlerChecker;

    .line 221
    iget-object v0, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/android/server/Watchdog;->mMonitorChecker:Lcom/android/server/Watchdog$HandlerChecker;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 224
    iget-object v6, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/server/Watchdog$HandlerChecker;

    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v2, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    const-string v3, "main thread"

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/server/Watchdog$HandlerChecker;-><init>(Lcom/android/server/Watchdog;Landroid/os/Handler;Ljava/lang/String;J)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 227
    iget-object v6, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-static {}, Lcom/android/server/UiThread;->getHandler()Landroid/os/Handler;

    move-result-object v2

    const-string v3, "ui thread"

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/server/Watchdog$HandlerChecker;-><init>(Lcom/android/server/Watchdog;Landroid/os/Handler;Ljava/lang/String;J)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 230
    iget-object v6, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-static {}, Lcom/android/server/IoThread;->getHandler()Landroid/os/Handler;

    move-result-object v2

    const-string v3, "i/o thread"

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/server/Watchdog$HandlerChecker;-><init>(Lcom/android/server/Watchdog;Landroid/os/Handler;Ljava/lang/String;J)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 233
    iget-object v6, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-static {}, Lcom/android/server/DisplayThread;->getHandler()Landroid/os/Handler;

    move-result-object v2

    const-string v3, "display thread"

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/server/Watchdog$HandlerChecker;-><init>(Lcom/android/server/Watchdog;Landroid/os/Handler;Ljava/lang/String;J)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 235
    return-void
.end method

.method private describeCheckersLocked(Ljava/util/ArrayList;)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/Watchdog$HandlerChecker;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 322
    .local p1, "checkers":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/Watchdog$HandlerChecker;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v2, 0x80

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 323
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 324
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 325
    const-string v2, ", "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 327
    :cond_0
    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-virtual {v2}, Lcom/android/server/Watchdog$HandlerChecker;->describeBlockedStateLocked()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 323
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 329
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private dumpKernelStackTraces()Ljava/io/File;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 531
    const-string v2, "dalvik.vm.stack-trace-file"

    invoke-static {v2, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 532
    .local v0, "tracesPath":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    .line 537
    :cond_0
    :goto_0
    return-object v1

    .line 536
    :cond_1
    invoke-direct {p0, v0}, Lcom/android/server/Watchdog;->native_dumpKernelStacks(Ljava/lang/String;)V

    .line 537
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private evaluateCheckerCompletionLocked()I
    .locals 4

    .prologue
    .line 302
    const/4 v2, 0x0

    .line 303
    .local v2, "state":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v3, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v1, v3, :cond_0

    .line 304
    iget-object v3, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/Watchdog$HandlerChecker;

    .line 305
    .local v0, "hc":Lcom/android/server/Watchdog$HandlerChecker;
    invoke-virtual {v0}, Lcom/android/server/Watchdog$HandlerChecker;->getCompletionStateLocked()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 303
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 307
    .end local v0    # "hc":Lcom/android/server/Watchdog$HandlerChecker;
    :cond_0
    return v2
.end method

.method private getBlockedCheckersLocked()Ljava/util/ArrayList;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/Watchdog$HandlerChecker;",
            ">;"
        }
    .end annotation

    .prologue
    .line 311
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 312
    .local v0, "checkers":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/Watchdog$HandlerChecker;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget-object v3, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 313
    iget-object v3, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/Watchdog$HandlerChecker;

    .line 314
    .local v1, "hc":Lcom/android/server/Watchdog$HandlerChecker;
    invoke-virtual {v1}, Lcom/android/server/Watchdog$HandlerChecker;->isOverdueLocked()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 315
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 312
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 318
    .end local v1    # "hc":Lcom/android/server/Watchdog$HandlerChecker;
    :cond_1
    return-object v0
.end method

.method public static getInstance()Lcom/android/server/Watchdog;
    .locals 1

    .prologue
    .line 203
    sget-object v0, Lcom/android/server/Watchdog;->sWatchdog:Lcom/android/server/Watchdog;

    if-nez v0, :cond_0

    .line 204
    new-instance v0, Lcom/android/server/Watchdog;

    invoke-direct {v0}, Lcom/android/server/Watchdog;-><init>()V

    sput-object v0, Lcom/android/server/Watchdog;->sWatchdog:Lcom/android/server/Watchdog;

    .line 207
    :cond_0
    sget-object v0, Lcom/android/server/Watchdog;->sWatchdog:Lcom/android/server/Watchdog;

    return-object v0
.end method

.method private native native_dumpKernelStacks(Ljava/lang/String;)V
.end method


# virtual methods
.method public addMonitor(Lcom/android/server/Watchdog$Monitor;)V
    .locals 2
    .param p1, "monitor"    # Lcom/android/server/Watchdog$Monitor;

    .prologue
    .line 267
    monitor-enter p0

    .line 268
    :try_start_0
    invoke-virtual {p0}, Lcom/android/server/Watchdog;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 269
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Monitors can\'t be added once the Watchdog is running"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 272
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 271
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/android/server/Watchdog;->mMonitorChecker:Lcom/android/server/Watchdog$HandlerChecker;

    invoke-virtual {v0, p1}, Lcom/android/server/Watchdog$HandlerChecker;->addMonitor(Lcom/android/server/Watchdog$Monitor;)V

    .line 272
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 273
    return-void
.end method

.method public addThread(Landroid/os/Handler;)V
    .locals 2
    .param p1, "thread"    # Landroid/os/Handler;

    .prologue
    .line 276
    const-wide/32 v0, 0xea60

    invoke-virtual {p0, p1, v0, v1}, Lcom/android/server/Watchdog;->addThread(Landroid/os/Handler;J)V

    .line 277
    return-void
.end method

.method public addThread(Landroid/os/Handler;J)V
    .locals 8
    .param p1, "thread"    # Landroid/os/Handler;
    .param p2, "timeoutMillis"    # J

    .prologue
    .line 280
    monitor-enter p0

    .line 281
    :try_start_0
    invoke-virtual {p0}, Lcom/android/server/Watchdog;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 282
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Threads can\'t be added once the Watchdog is running"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 286
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 284
    :cond_0
    :try_start_1
    invoke-virtual {p1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v3

    .line 285
    .local v3, "name":Ljava/lang/String;
    iget-object v6, p0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/server/Watchdog$HandlerChecker;

    move-object v1, p0

    move-object v2, p1

    move-wide v4, p2

    invoke-direct/range {v0 .. v5}, Lcom/android/server/Watchdog$HandlerChecker;-><init>(Lcom/android/server/Watchdog;Landroid/os/Handler;Ljava/lang/String;J)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 286
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 287
    return-void
.end method

.method public init(Landroid/content/Context;Lcom/android/server/am/ActivityManagerService;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "activity"    # Lcom/android/server/am/ActivityManagerService;

    .prologue
    .line 238
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/Watchdog;->mResolver:Landroid/content/ContentResolver;

    .line 239
    iput-object p2, p0, Lcom/android/server/Watchdog;->mActivity:Lcom/android/server/am/ActivityManagerService;

    .line 241
    new-instance v0, Lcom/android/server/Watchdog$RebootRequestReceiver;

    invoke-direct {v0, p0}, Lcom/android/server/Watchdog$RebootRequestReceiver;-><init>(Lcom/android/server/Watchdog;)V

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.REBOOT"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    const-string v2, "android.permission.REBOOT"

    const/4 v3, 0x0

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    .line 244
    return-void
.end method

.method public processStarted(Ljava/lang/String;I)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "pid"    # I

    .prologue
    .line 247
    monitor-enter p0

    .line 248
    :try_start_0
    const-string v0, "com.android.phone"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 249
    iput p2, p0, Lcom/android/server/Watchdog;->mPhonePid:I

    .line 251
    :cond_0
    monitor-exit p0

    .line 252
    return-void

    .line 251
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method rebootSystem(Ljava/lang/String;)V
    .locals 4
    .param p1, "reason"    # Ljava/lang/String;

    .prologue
    .line 293
    const-string v1, "Watchdog"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Rebooting system because: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 294
    const-string v1, "power"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    check-cast v0, Landroid/os/IPowerManager;

    .line 296
    .local v0, "pms":Landroid/os/IPowerManager;
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    invoke-interface {v0, v1, p1, v2}, Landroid/os/IPowerManager;->reboot(ZLjava/lang/String;Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 299
    :goto_0
    return-void

    .line 297
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public run()V
    .locals 42

    .prologue
    .line 334
    const/16 v37, 0x0

    .line 339
    .local v37, "waitedHalf":Z
    :goto_0
    const/4 v10, 0x0

    .line 340
    .local v10, "debuggerWasConnected":I
    monitor-enter p0

    .line 341
    const-wide/16 v32, 0x7530

    .line 344
    .local v32, "timeout":J
    const/4 v15, 0x0

    .local v15, "i":I
    :goto_1
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Ljava/util/ArrayList;->size()I

    move-result v38

    move/from16 v0, v38

    if-ge v15, v0, :cond_0

    .line 345
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/Watchdog;->mHandlerCheckers:Ljava/util/ArrayList;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    invoke-virtual {v0, v15}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lcom/android/server/Watchdog$HandlerChecker;

    .line 346
    .local v14, "hc":Lcom/android/server/Watchdog$HandlerChecker;
    invoke-virtual {v14}, Lcom/android/server/Watchdog$HandlerChecker;->scheduleCheckLocked()V

    .line 344
    add-int/lit8 v15, v15, 0x1

    goto :goto_1

    .line 349
    .end local v14    # "hc":Lcom/android/server/Watchdog$HandlerChecker;
    :cond_0
    if-lez v10, :cond_1

    .line 350
    add-int/lit8 v10, v10, -0x1

    .line 357
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v28

    .line 358
    .local v28, "start":J
    :goto_2
    const-wide/16 v38, 0x0

    cmp-long v38, v32, v38

    if-lez v38, :cond_4

    .line 359
    invoke-static {}, Landroid/os/Debug;->isDebuggerConnected()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v38

    if-eqz v38, :cond_2

    .line 360
    const/4 v10, 0x2

    .line 363
    :cond_2
    :try_start_1
    move-object/from16 v0, p0

    move-wide/from16 v1, v32

    invoke-virtual {v0, v1, v2}, Ljava/lang/Object;->wait(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 367
    :goto_3
    :try_start_2
    invoke-static {}, Landroid/os/Debug;->isDebuggerConnected()Z

    move-result v38

    if-eqz v38, :cond_3

    .line 368
    const/4 v10, 0x2

    .line 370
    :cond_3
    const-wide/16 v38, 0x7530

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v40

    sub-long v40, v40, v28

    sub-long v32, v38, v40

    goto :goto_2

    .line 364
    :catch_0
    move-exception v12

    .line 365
    .local v12, "e":Ljava/lang/InterruptedException;
    const-string v38, "Watchdog"

    move-object/from16 v0, v38

    invoke-static {v0, v12}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_3

    .line 398
    .end local v12    # "e":Ljava/lang/InterruptedException;
    .end local v28    # "start":J
    :catchall_0
    move-exception v38

    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v38

    .line 373
    .restart local v28    # "start":J
    :cond_4
    :try_start_3
    invoke-direct/range {p0 .. p0}, Lcom/android/server/Watchdog;->evaluateCheckerCompletionLocked()I

    move-result v36

    .line 374
    .local v36, "waitState":I
    if-nez v36, :cond_5

    .line 376
    const/16 v37, 0x0

    .line 377
    monitor-exit p0

    goto :goto_0

    .line 378
    :cond_5
    const/16 v38, 0x1

    move/from16 v0, v36

    move/from16 v1, v38

    if-ne v0, v1, :cond_6

    .line 380
    monitor-exit p0

    goto :goto_0

    .line 381
    :cond_6
    const/16 v38, 0x2

    move/from16 v0, v36

    move/from16 v1, v38

    if-ne v0, v1, :cond_8

    .line 382
    if-nez v37, :cond_7

    .line 385
    new-instance v23, Ljava/util/ArrayList;

    invoke-direct/range {v23 .. v23}, Ljava/util/ArrayList;-><init>()V

    .line 386
    .local v23, "pids":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v38

    invoke-static/range {v38 .. v38}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v38

    move-object/from16 v0, v23

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 387
    const/16 v38, 0x1

    const/16 v39, 0x0

    const/16 v40, 0x0

    sget-object v41, Lcom/android/server/Watchdog;->NATIVE_STACKS_OF_INTEREST:[Ljava/lang/String;

    move/from16 v0, v38

    move-object/from16 v1, v23

    move-object/from16 v2, v39

    move-object/from16 v3, v40

    move-object/from16 v4, v41

    invoke-static {v0, v1, v2, v3, v4}, Lcom/android/server/am/ActivityManagerService;->dumpStackTraces(ZLjava/util/ArrayList;Lcom/android/internal/os/ProcessCpuTracker;Landroid/util/SparseArray;[Ljava/lang/String;)Ljava/io/File;

    .line 389
    const/16 v37, 0x1

    .line 391
    .end local v23    # "pids":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    :cond_7
    monitor-exit p0

    goto/16 :goto_0

    .line 395
    :cond_8
    invoke-direct/range {p0 .. p0}, Lcom/android/server/Watchdog;->getBlockedCheckersLocked()Ljava/util/ArrayList;

    move-result-object v8

    .line 396
    .local v8, "blockedCheckers":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/Watchdog$HandlerChecker;>;"
    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/android/server/Watchdog;->describeCheckersLocked(Ljava/util/ArrayList;)Ljava/lang/String;

    move-result-object v27

    .line 397
    .local v27, "subject":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-boolean v6, v0, Lcom/android/server/Watchdog;->mAllowRestart:Z

    .line 398
    .local v6, "allowRestart":Z
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 403
    const/16 v38, 0xaf2

    move/from16 v0, v38

    move-object/from16 v1, v27

    invoke-static {v0, v1}, Landroid/util/EventLog;->writeEvent(ILjava/lang/String;)I

    .line 405
    new-instance v23, Ljava/util/ArrayList;

    invoke-direct/range {v23 .. v23}, Ljava/util/ArrayList;-><init>()V

    .line 406
    .restart local v23    # "pids":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v38

    invoke-static/range {v38 .. v38}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v38

    move-object/from16 v0, v23

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 407
    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/Watchdog;->mPhonePid:I

    move/from16 v38, v0

    if-lez v38, :cond_9

    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/server/Watchdog;->mPhonePid:I

    move/from16 v38, v0

    invoke-static/range {v38 .. v38}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v38

    move-object/from16 v0, v23

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 410
    :cond_9
    if-nez v37, :cond_c

    const/16 v38, 0x1

    :goto_4
    const/16 v39, 0x0

    const/16 v40, 0x0

    sget-object v41, Lcom/android/server/Watchdog;->NATIVE_STACKS_OF_INTEREST:[Ljava/lang/String;

    move/from16 v0, v38

    move-object/from16 v1, v23

    move-object/from16 v2, v39

    move-object/from16 v3, v40

    move-object/from16 v4, v41

    invoke-static {v0, v1, v2, v3, v4}, Lcom/android/server/am/ActivityManagerService;->dumpStackTraces(ZLjava/util/ArrayList;Lcom/android/internal/os/ProcessCpuTracker;Landroid/util/SparseArray;[Ljava/lang/String;)Ljava/io/File;

    move-result-object v25

    .line 415
    .local v25, "stack":Ljava/io/File;
    const-wide/16 v38, 0x7d0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemClock;->sleep(J)V

    .line 419
    invoke-direct/range {p0 .. p0}, Lcom/android/server/Watchdog;->dumpKernelStackTraces()Ljava/io/File;

    .line 424
    :try_start_4
    new-instance v30, Ljava/io/FileWriter;

    const-string v38, "/proc/sysrq-trigger"

    move-object/from16 v0, v30

    move-object/from16 v1, v38

    invoke-direct {v0, v1}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    .line 425
    .local v30, "sysrq_trigger":Ljava/io/FileWriter;
    const-string v38, "w"

    move-object/from16 v0, v30

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    .line 427
    const-string v38, "1"

    const-string v39, "ro.debuggable"

    const-string v40, "0"

    invoke-static/range {v39 .. v40}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v17

    .line 428
    .local v17, "isDebuggable":Z
    if-eqz v17, :cond_a

    .line 429
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/Watchdog;->mActivity:Lcom/android/server/am/ActivityManagerService;

    move-object/from16 v38, v0

    move-object/from16 v0, v38

    iget v0, v0, Lcom/android/server/am/ActivityManagerService;->mLastMemoryLevel:I

    move/from16 v20, v0

    .line 430
    .local v20, "memorylevel":I
    const/16 v38, 0x2

    move/from16 v0, v20

    move/from16 v1, v38

    if-le v0, v1, :cond_a

    .line 431
    invoke-virtual/range {v30 .. v30}, Ljava/io/FileWriter;->flush()V

    .line 432
    const-string v38, "m"

    move-object/from16 v0, v30

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    .line 435
    .end local v20    # "memorylevel":I
    :cond_a
    invoke-virtual/range {v30 .. v30}, Ljava/io/FileWriter;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    .line 441
    .end local v17    # "isDebuggable":Z
    .end local v30    # "sysrq_trigger":Ljava/io/FileWriter;
    :goto_5
    const-string v38, "dalvik.vm.stack-trace-file"

    const/16 v39, 0x0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v35

    .line 442
    .local v35, "tracesPath":Ljava/lang/String;
    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "_SystemServer_WDT"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/Watchdog;->mTraceDateFormat:Ljava/text/SimpleDateFormat;

    move-object/from16 v39, v0

    new-instance v40, Ljava/util/Date;

    invoke-direct/range {v40 .. v40}, Ljava/util/Date;-><init>()V

    invoke-virtual/range {v39 .. v40}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    .line 444
    .local v31, "traceFileNameAmendment":Ljava/lang/String;
    if-eqz v35, :cond_b

    invoke-virtual/range {v35 .. v35}, Ljava/lang/String;->length()I

    move-result v38

    if-eqz v38, :cond_b

    .line 445
    new-instance v34, Ljava/io/File;

    invoke-direct/range {v34 .. v35}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 447
    .local v34, "traceRenameFile":Ljava/io/File;
    const-string v38, "."

    move-object/from16 v0, v35

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v19

    .line 448
    .local v19, "lpos":I
    const/16 v38, -0x1

    move/from16 v0, v38

    move/from16 v1, v19

    if-eq v0, v1, :cond_d

    .line 449
    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v39, 0x0

    move-object/from16 v0, v35

    move/from16 v1, v39

    move/from16 v2, v19

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v31

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v35

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    .line 452
    .local v22, "newTracesPath":Ljava/lang/String;
    :goto_6
    new-instance v38, Ljava/io/File;

    move-object/from16 v0, v38

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, v34

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    .line 453
    move-object/from16 v35, v22

    .line 456
    .end local v19    # "lpos":I
    .end local v22    # "newTracesPath":Ljava/lang/String;
    .end local v34    # "traceRenameFile":Ljava/io/File;
    :cond_b
    new-instance v21, Ljava/io/File;

    move-object/from16 v0, v21

    move-object/from16 v1, v35

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 461
    .local v21, "newFd":Ljava/io/File;
    new-instance v11, Lcom/android/server/Watchdog$1;

    const-string v38, "watchdogWriteToDropbox"

    move-object/from16 v0, p0

    move-object/from16 v1, v38

    move-object/from16 v2, v27

    move-object/from16 v3, v21

    invoke-direct {v11, v0, v1, v2, v3}, Lcom/android/server/Watchdog$1;-><init>(Lcom/android/server/Watchdog;Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    .line 468
    .local v11, "dropboxThread":Ljava/lang/Thread;
    invoke-virtual {v11}, Ljava/lang/Thread;->start()V

    .line 470
    const-wide/16 v38, 0x7d0

    :try_start_5
    move-wide/from16 v0, v38

    invoke-virtual {v11, v0, v1}, Ljava/lang/Thread;->join(J)V
    :try_end_5
    .catch Ljava/lang/InterruptedException; {:try_start_5 .. :try_end_5} :catch_3

    .line 474
    :goto_7
    monitor-enter p0

    .line 475
    :try_start_6
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/android/server/Watchdog;->mController:Landroid/app/IActivityController;

    .line 476
    .local v9, "controller":Landroid/app/IActivityController;
    monitor-exit p0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 477
    if-eqz v9, :cond_e

    .line 478
    const-string v38, "Watchdog"

    const-string v39, "Reporting stuck state to activity controller"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 480
    :try_start_7
    const-string v38, "Service dumps disabled due to hung system process."

    invoke-static/range {v38 .. v38}, Landroid/os/Binder;->setDumpDisabled(Ljava/lang/String;)V

    .line 482
    move-object/from16 v0, v27

    invoke-interface {v9, v0}, Landroid/app/IActivityController;->systemNotResponding(Ljava/lang/String;)I

    move-result v24

    .line 483
    .local v24, "res":I
    if-ltz v24, :cond_e

    .line 484
    const-string v38, "Watchdog"

    const-string v39, "Activity controller requested to coninue to wait"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catch Landroid/os/RemoteException; {:try_start_7 .. :try_end_7} :catch_2

    .line 485
    const/16 v37, 0x0

    goto/16 :goto_0

    .line 410
    .end local v9    # "controller":Landroid/app/IActivityController;
    .end local v11    # "dropboxThread":Ljava/lang/Thread;
    .end local v21    # "newFd":Ljava/io/File;
    .end local v24    # "res":I
    .end local v25    # "stack":Ljava/io/File;
    .end local v31    # "traceFileNameAmendment":Ljava/lang/String;
    .end local v35    # "tracesPath":Ljava/lang/String;
    :cond_c
    const/16 v38, 0x0

    goto/16 :goto_4

    .line 436
    .restart local v25    # "stack":Ljava/io/File;
    :catch_1
    move-exception v12

    .line 437
    .local v12, "e":Ljava/io/IOException;
    const-string v38, "Watchdog"

    const-string v39, "Failed to write to /proc/sysrq-trigger"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 438
    const-string v38, "Watchdog"

    invoke-virtual {v12}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    .line 451
    .end local v12    # "e":Ljava/io/IOException;
    .restart local v19    # "lpos":I
    .restart local v31    # "traceFileNameAmendment":Ljava/lang/String;
    .restart local v34    # "traceRenameFile":Ljava/io/File;
    .restart local v35    # "tracesPath":Ljava/lang/String;
    :cond_d
    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v38

    move-object/from16 v1, v35

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v31

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    .restart local v22    # "newTracesPath":Ljava/lang/String;
    goto/16 :goto_6

    .line 476
    .end local v19    # "lpos":I
    .end local v22    # "newTracesPath":Ljava/lang/String;
    .end local v34    # "traceRenameFile":Ljava/io/File;
    .restart local v11    # "dropboxThread":Ljava/lang/Thread;
    .restart local v21    # "newFd":Ljava/io/File;
    :catchall_1
    move-exception v38

    :try_start_8
    monitor-exit p0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    throw v38

    .line 488
    .restart local v9    # "controller":Landroid/app/IActivityController;
    :catch_2
    move-exception v38

    .line 493
    :cond_e
    invoke-static {}, Landroid/os/Debug;->isDebuggerConnected()Z

    move-result v38

    if-eqz v38, :cond_f

    .line 494
    const/4 v10, 0x2

    .line 496
    :cond_f
    const/16 v38, 0x2

    move/from16 v0, v38

    if-lt v10, v0, :cond_10

    .line 497
    const-string v38, "Watchdog"

    const-string v39, "Debugger connected: Watchdog is *not* killing the system process"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 526
    :goto_8
    const/16 v37, 0x0

    .line 527
    goto/16 :goto_0

    .line 498
    :cond_10
    if-lez v10, :cond_11

    .line 499
    const-string v38, "Watchdog"

    const-string v39, "Debugger was connected: Watchdog is *not* killing the system process"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_8

    .line 500
    :cond_11
    if-nez v6, :cond_12

    .line 501
    const-string v38, "Watchdog"

    const-string v39, "Restart not allowed: Watchdog is *not* killing the system process"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_8

    .line 503
    :cond_12
    const-string v38, "Watchdog"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "*** WATCHDOG KILLING SYSTEM PROCESS: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 504
    const/4 v15, 0x0

    :goto_9
    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v38

    move/from16 v0, v38

    if-ge v15, v0, :cond_14

    .line 505
    const-string v39, "Watchdog"

    new-instance v40, Ljava/lang/StringBuilder;

    invoke-direct/range {v40 .. v40}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v15}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v38

    check-cast v38, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-virtual/range {v38 .. v38}, Lcom/android/server/Watchdog$HandlerChecker;->getName()Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v40

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v40, " stack trace:"

    move-object/from16 v0, v38

    move-object/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v39

    move-object/from16 v1, v38

    invoke-static {v0, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 506
    invoke-virtual {v8, v15}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v38

    check-cast v38, Lcom/android/server/Watchdog$HandlerChecker;

    invoke-virtual/range {v38 .. v38}, Lcom/android/server/Watchdog$HandlerChecker;->getThread()Ljava/lang/Thread;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v26

    .line 508
    .local v26, "stackTrace":[Ljava/lang/StackTraceElement;
    move-object/from16 v7, v26

    .local v7, "arr$":[Ljava/lang/StackTraceElement;
    array-length v0, v7

    move/from16 v18, v0

    .local v18, "len$":I
    const/16 v16, 0x0

    .local v16, "i$":I
    :goto_a
    move/from16 v0, v16

    move/from16 v1, v18

    if-ge v0, v1, :cond_13

    aget-object v13, v7, v16

    .line 509
    .local v13, "element":Ljava/lang/StackTraceElement;
    const-string v38, "Watchdog"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "    at "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 508
    add-int/lit8 v16, v16, 0x1

    goto :goto_a

    .line 504
    .end local v13    # "element":Ljava/lang/StackTraceElement;
    :cond_13
    add-int/lit8 v15, v15, 0x1

    goto :goto_9

    .line 513
    .end local v7    # "arr$":[Ljava/lang/StackTraceElement;
    .end local v16    # "i$":I
    .end local v18    # "len$":I
    .end local v26    # "stackTrace":[Ljava/lang/StackTraceElement;
    :cond_14
    const-string v38, "sys.watchdog.disabled"

    const/16 v39, 0x0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v38

    if-nez v38, :cond_15

    .line 514
    const-string v38, "Watchdog"

    const-string v39, "*** GOODBYE!"

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 515
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v38

    invoke-static/range {v38 .. v38}, Landroid/os/Process;->killProcess(I)V

    .line 516
    const/16 v38, 0xa

    invoke-static/range {v38 .. v38}, Ljava/lang/System;->exit(I)V

    goto/16 :goto_8

    .line 518
    :cond_15
    const-string v38, "Watchdog"

    const-string v39, "*** WATCHDOG NOT KILLING SYSTEM PROCESS: "

    invoke-static/range {v38 .. v39}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 520
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v38

    const/16 v39, 0x13

    invoke-static/range {v38 .. v39}, Landroid/os/Process;->sendSignal(II)V

    .line 528
    return-void

    .line 471
    .end local v9    # "controller":Landroid/app/IActivityController;
    :catch_3
    move-exception v38

    goto/16 :goto_7
.end method

.method public setActivityController(Landroid/app/IActivityController;)V
    .locals 1
    .param p1, "controller"    # Landroid/app/IActivityController;

    .prologue
    .line 255
    monitor-enter p0

    .line 256
    :try_start_0
    iput-object p1, p0, Lcom/android/server/Watchdog;->mController:Landroid/app/IActivityController;

    .line 257
    monitor-exit p0

    .line 258
    return-void

    .line 257
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public setAllowRestart(Z)V
    .locals 1
    .param p1, "allowRestart"    # Z

    .prologue
    .line 261
    monitor-enter p0

    .line 262
    :try_start_0
    iput-boolean p1, p0, Lcom/android/server/Watchdog;->mAllowRestart:Z

    .line 263
    monitor-exit p0

    .line 264
    return-void

    .line 263
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method