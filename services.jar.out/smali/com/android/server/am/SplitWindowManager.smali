.class public Lcom/android/server/am/SplitWindowManager;
.super Ljava/lang/Object;
.source "SplitWindowManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/am/SplitWindowManager$1;,
        Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;,
        Lcom/android/server/am/SplitWindowManager$SplitActivity;,
        Lcom/android/server/am/SplitWindowManager$State;
    }
.end annotation


# static fields
.field static final DEBUG:Z = false

.field static final DEBUG_LIGHT:Z = true

.field static final EXTRA_SPLIT_WINDOW_OPTION_LAUNCH_SCREEN:Ljava/lang/String; = "com.lge.intent.extra.SPLIT_WINDOW_LAUNCH_SCREEN"

.field static final MAX_MULTIPLE_INSTANCE_COUNT:I = 0x2

.field static final PUT_STATE_TO_LOG_MSG:I = 0x1f6

.field static final STACK_ID_HOME:I = 0x0

.field static final STACK_ID_INVALID:I = -0x1

.field static final TAG:Ljava/lang/String; = "SplitWindowManager"

.field static final UPDATE_ACTIVITY_STATE_MSG:I = 0x1f5


# instance fields
.field final mHandler:Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

.field mHistorySplit:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/am/SplitWindowManager$SplitActivity;",
            ">;"
        }
    .end annotation
.end field

.field mPreparedActivity:Lcom/android/server/am/ActivityRecord;

.field final mService:Lcom/android/server/am/ActivityManagerService;

.field mSplitActivityList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/am/SplitWindowManager$SplitActivity;",
            ">;"
        }
    .end annotation
.end field

.field private mSplitPolicy:Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

.field final mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

.field mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

.field private mState:Lcom/android/server/am/SplitWindowManager$State;

.field mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

.field final mWindowManager:Lcom/android/server/wm/WindowManagerService;


# direct methods
.method public constructor <init>(Lcom/android/server/am/ActivityManagerService;Lcom/android/server/am/ActivityStackSupervisor;Lcom/android/server/wm/WindowManagerService;)V
    .locals 3
    .param p1, "service"    # Lcom/android/server/am/ActivityManagerService;
    .param p2, "stackSupervisor"    # Lcom/android/server/am/ActivityStackSupervisor;
    .param p3, "windowManager"    # Lcom/android/server/wm/WindowManagerService;

    .prologue
    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 64
    const-class v1, Lcom/android/server/am/SplitWindowManager;

    monitor-enter v1

    .line 65
    :try_start_0
    const-string v0, "SplitWindowManager"

    const-string v2, "SplitWindowManager has been created..."

    invoke-static {v0, v2}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 66
    iput-object p1, p0, Lcom/android/server/am/SplitWindowManager;->mService:Lcom/android/server/am/ActivityManagerService;

    .line 67
    iput-object p2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    .line 68
    iput-object p3, p0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    .line 69
    new-instance v0, Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mService:Lcom/android/server/am/ActivityManagerService;

    iget-object v2, v2, Lcom/android/server/am/ActivityManagerService;->mHandler:Lcom/android/server/am/ActivityManagerService$MainHandler;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityManagerService$MainHandler;->getLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v0, p0, v2}, Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;-><init>(Lcom/android/server/am/SplitWindowManager;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mHandler:Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

    .line 71
    sget-object v0, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    .line 72
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 73
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    .line 75
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    .line 76
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mHistorySplit:Ljava/util/ArrayList;

    .line 77
    monitor-exit v1

    .line 78
    return-void

    .line 77
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method static synthetic access$000(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/am/SplitWindowManager;
    .param p1, "x1"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "x2"    # Z

    .prologue
    .line 27
    invoke-direct {p0, p1, p2}, Lcom/android/server/am/SplitWindowManager;->updateActivityToSplitPolicyService(Lcom/android/server/am/ActivityRecord;Z)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/server/am/SplitWindowManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/am/SplitWindowManager;

    .prologue
    .line 27
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->realPutLogState()V

    return-void
.end method

.method private activitiesToUnSplited()V
    .locals 6

    .prologue
    .line 1730
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v3

    .line 1731
    :try_start_0
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1732
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    const-string v2, "SplitWindowManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " - check SplitActivity "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1733
    if-eqz v1, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v2, :cond_0

    .line 1734
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setUnSplit(Z)V

    goto :goto_0

    .line 1737
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_1
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1739
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mHistorySplit has "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mHistorySplit:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1740
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mHistorySplit:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1741
    .restart local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v2

    sget-object v3, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->UN_SPLITING:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v2, v3, :cond_2

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v2

    sget-object v3, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v2, v3, :cond_2

    .line 1745
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setUnSplit(Z)V

    .line 1746
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setNative()V

    goto :goto_1

    .line 1750
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    const-string v2, "SplitWindowManager"

    const-string v3, " ... all done"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1751
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mHistorySplit:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 1753
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->FINISHING:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1754
    return-void
.end method

.method private attachSplitInfo(Lcom/android/server/am/ActivityRecord;Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;)V
    .locals 2
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "screen"    # Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;

    .prologue
    .line 433
    new-instance v0, Lcom/android/server/am/ActivitySplitInfo;

    invoke-direct {v0, p2}, Lcom/android/server/am/ActivitySplitInfo;-><init>(Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;)V

    iput-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    .line 435
    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    if-eqz v0, :cond_0

    const-string v0, "android"

    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    .line 436
    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/android/server/am/ActivitySplitInfo;->setSupportAsSource(Z)V

    .line 438
    :cond_0
    return-void
.end method

.method private checkAndSetCurrentStateIfNeeded(Z)V
    .locals 5
    .param p1, "forceNormal"    # Z

    .prologue
    const/4 v4, 0x2

    .line 1416
    if-eqz p1, :cond_2

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v2

    sget-object v3, Lcom/android/server/am/SplitWindowManager$State;->REQUESTED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v2, v3}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v2

    sget-object v3, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v2, v3}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1418
    :cond_0
    const-string v2, "SplitWindowManager"

    const-string v3, "SOMETHING WRONG, RESET FOR HOME COMMING!"

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1419
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v3

    .line 1420
    :try_start_0
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1421
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setUnSplit(Z)V

    goto :goto_0

    .line 1423
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_1
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1424
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->FINISHING:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1427
    .end local v0    # "i$":Ljava/util/Iterator;
    :cond_2
    sget-object v2, Lcom/android/server/am/SplitWindowManager$1;->$SwitchMap$com$android$server$am$SplitWindowManager$State:[I

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v3

    invoke-virtual {v3}, Lcom/android/server/am/SplitWindowManager$State;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 1459
    :cond_3
    :goto_1
    :pswitch_0
    return-void

    .line 1431
    :pswitch_1
    if-eqz p1, :cond_3

    .line 1432
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    goto :goto_1

    .line 1436
    :pswitch_2
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitedActivityCount()I

    move-result v2

    if-ne v2, v4, :cond_3

    .line 1437
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->SPLITED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1438
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->letPolicyPrepareSplitMode()V

    .line 1439
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->makeBothActivityOnTopOfHome()V

    goto :goto_1

    .line 1443
    :pswitch_3
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitedActivityCount()I

    move-result v2

    if-ge v2, v4, :cond_3

    .line 1444
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    goto :goto_1

    .line 1448
    :pswitch_4
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v3

    .line 1449
    :try_start_2
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_4
    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1450
    .restart local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v2

    sget-object v4, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->UN_SPLITING:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v2, v4, :cond_4

    .line 1451
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setNative()V

    goto :goto_2

    .line 1454
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_1
    move-exception v2

    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v2

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_5
    :try_start_3
    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1455
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1456
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->letPolicyCancelSplitMode()V

    goto :goto_1

    .line 1427
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method

.method private checkMultipleInstanceTaskInStack(Lcom/android/server/am/ActivityStack;Ljava/lang/String;)I
    .locals 6
    .param p1, "stack"    # Lcom/android/server/am/ActivityStack;
    .param p2, "packageName"    # Ljava/lang/String;

    .prologue
    .line 1936
    const/4 v1, 0x0

    .line 1937
    .local v1, "count":I
    invoke-virtual {p1}, Lcom/android/server/am/ActivityStack;->getAllTasks()Ljava/util/ArrayList;

    move-result-object v0

    .line 1938
    .local v0, "allTasks":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/am/TaskRecord;>;"
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v5

    add-int/lit8 v3, v5, -0x1

    .local v3, "taskNdx":I
    :goto_0
    if-ltz v3, :cond_1

    .line 1939
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/am/TaskRecord;

    .line 1940
    .local v2, "task":Lcom/android/server/am/TaskRecord;
    iget-object v5, v2, Lcom/android/server/am/TaskRecord;->realActivity:Landroid/content/ComponentName;

    invoke-virtual {v5}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 1941
    .local v4, "taskRealActivity":Ljava/lang/String;
    invoke-virtual {v4, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1942
    add-int/lit8 v1, v1, 0x1

    .line 1938
    :cond_0
    add-int/lit8 v3, v3, -0x1

    goto :goto_0

    .line 1945
    .end local v2    # "task":Lcom/android/server/am/TaskRecord;
    .end local v4    # "taskRealActivity":Ljava/lang/String;
    :cond_1
    return v1
.end method

.method private checkScreen(Landroid/content/Intent;Landroid/content/Intent;)Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;
    .locals 3
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "sourceIntent"    # Landroid/content/Intent;

    .prologue
    .line 441
    const/4 v2, 0x0

    .line 442
    .local v2, "screen":Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    .line 443
    .local v1, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-eqz v1, :cond_0

    .line 445
    :try_start_0
    invoke-interface {v1, p1, p2}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->checkScreen(Landroid/content/Intent;Landroid/content/Intent;)Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 451
    :cond_0
    :goto_0
    return-object v2

    .line 446
    :catch_0
    move-exception v0

    .line 448
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method private checkSplitActivityList(Lcom/android/server/am/ActivityRecord;)V
    .locals 13
    .param p1, "top"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 1565
    if-eqz p1, :cond_0

    iget-object v10, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-nez v10, :cond_2

    .line 1566
    :cond_0
    const-string v10, "SplitWindowManager"

    const-string v11, "checkSplitActivityList do nothing due to lack of top ActivityRecord"

    invoke-static {v10, v11}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1620
    :cond_1
    :goto_0
    return-void

    .line 1570
    :cond_2
    move-object v1, p1

    .line 1571
    .local v1, "currentTop":Lcom/android/server/am/ActivityRecord;
    iget-object v10, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v0, v10, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    .line 1572
    .local v0, "currentStack":Lcom/android/server/am/ActivityStack;
    const/4 v3, 0x0

    .line 1573
    .local v3, "isSplitActivityExist":Z
    const/4 v9, -0x1

    .line 1575
    .local v9, "stackIdToRemove":I
    const/4 v7, 0x0

    .line 1577
    .local v7, "splitActivityToAdd":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1579
    .local v6, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget v10, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    iget v11, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    if-ne v10, v11, :cond_6

    .line 1580
    const/4 v3, 0x1

    .line 1581
    iget-object v10, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v10, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_7

    .line 1583
    const-string v10, "SplitWindowManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Need to update "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " to "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1584
    iget v9, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    .line 1585
    new-instance v7, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .end local v7    # "splitActivityToAdd":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-direct {v7, p0, p1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;-><init>(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;)V

    .line 1611
    .end local v6    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .restart local v7    # "splitActivityToAdd":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_4
    :goto_1
    if-lez v9, :cond_5

    .line 1612
    invoke-direct {p0, v9}, Lcom/android/server/am/SplitWindowManager;->removeSplitActivityForStackIdLocked(I)Z

    .line 1615
    :cond_5
    if-eqz v7, :cond_9

    .line 1616
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v10, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 1590
    .restart local v6    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_6
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    iget v11, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {v10, v11}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v8

    .line 1591
    .local v8, "stack":Lcom/android/server/am/ActivityStack;
    if-nez v8, :cond_7

    .line 1592
    iget v9, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    .line 1597
    .end local v8    # "stack":Lcom/android/server/am/ActivityStack;
    :cond_7
    iget-object v10, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v10, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    iget v10, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    iget v11, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    if-eq v10, v11, :cond_3

    .line 1598
    const-string v10, "SplitWindowManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Need to update new top to "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1599
    iget v9, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    .line 1600
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    iget v11, v6, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {v10, v11}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v4

    .line 1601
    .local v4, "oppositeStack":Lcom/android/server/am/ActivityStack;
    if-eqz v4, :cond_8

    invoke-virtual {v4}, Lcom/android/server/am/ActivityStack;->topActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v5

    .line 1603
    .local v5, "oppositeTop":Lcom/android/server/am/ActivityRecord;
    :goto_2
    if-eqz v5, :cond_4

    .line 1604
    new-instance v7, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .end local v7    # "splitActivityToAdd":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-direct {v7, p0, v5}, Lcom/android/server/am/SplitWindowManager$SplitActivity;-><init>(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;)V

    .line 1605
    .restart local v7    # "splitActivityToAdd":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    const/4 v3, 0x1

    goto :goto_1

    .line 1601
    .end local v5    # "oppositeTop":Lcom/android/server/am/ActivityRecord;
    :cond_8
    const/4 v5, 0x0

    goto :goto_2

    .line 1617
    .end local v4    # "oppositeStack":Lcom/android/server/am/ActivityStack;
    .end local v6    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_9
    if-nez v3, :cond_1

    .line 1618
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    new-instance v11, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-direct {v11, p0, p1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;-><init>(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;)V

    invoke-virtual {v10, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0
.end method

.method private checkSplitInfoToRecover(Lcom/android/server/am/ActivityRecord;)V
    .locals 3
    .param p1, "starting"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 731
    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v0

    sget-object v1, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v0, v1}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 738
    :cond_0
    :goto_0
    return-void

    .line 734
    :cond_1
    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->isNative()Z

    move-result v0

    if-nez v0, :cond_0

    .line 735
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Need recover for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/ "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 736
    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    goto :goto_0
.end method

.method private createStack()Lcom/android/server/am/ActivityStack;
    .locals 5

    .prologue
    .line 564
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityStackSupervisor;->getNextStackId()I

    move-result v1

    .line 565
    .local v1, "stackId":I
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Lcom/android/server/am/ActivityStackSupervisor;->createStackOnDisplayForSplitWindow(II)V

    .line 566
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v2, v1}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v0

    .line 567
    .local v0, "stack":Lcom/android/server/am/ActivityStack;
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " -> create stack to be splited: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 568
    return-object v0
.end method

.method private ensureFocusedStackVisible(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;)V
    .locals 9
    .param p1, "top"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "starting"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 585
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v6

    .line 586
    :try_start_0
    invoke-direct {p0, p2}, Lcom/android/server/am/SplitWindowManager;->getSplitActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v4

    .line 587
    .local v4, "startingActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v4, :cond_0

    iget-object v5, v4, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v5, :cond_0

    iget-object v5, v4, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v5, v5, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-nez v5, :cond_1

    .line 588
    :cond_0
    const-string v5, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "startingActivity is null or s.t: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 589
    monitor-exit v6

    .line 645
    :goto_0
    return-void

    .line 592
    :cond_1
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v5

    if-eqz v5, :cond_7

    .line 594
    const/4 v2, 0x0

    .line 595
    .local v2, "prev":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 596
    .local v3, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget v5, v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    iget v7, v4, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    if-ne v5, v7, :cond_2

    .line 597
    move-object v2, v3

    goto :goto_1

    .line 600
    .end local v3    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    if-nez v2, :cond_4

    .line 601
    const-string v5, "SplitWindowManager"

    const-string v7, "ensureActivitiesVisibleLocked couldn\'t find previous splited activity"

    invoke-static {v5, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 602
    monitor-exit v6

    goto :goto_0

    .line 644
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "prev":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v4    # "startingActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v5

    monitor-exit v6
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v5

    .line 605
    .restart local v0    # "i$":Ljava/util/Iterator;
    .restart local v2    # "prev":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .restart local v4    # "startingActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_4
    :try_start_1
    iget-object v5, v4, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v5, v5, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getCurrentScreenZone()I

    move-result v7

    invoke-virtual {v5, v7}, Lcom/android/server/am/ActivitySplitInfo;->setScreenZone(I)V

    .line 607
    iget-object v5, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v4, v5}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 608
    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setSplit()V

    .line 610
    iget-object v5, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v5, v5, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v5}, Lcom/android/server/am/ActivitySplitInfo;->isFullScreen()Z

    move-result v5

    if-eqz v5, :cond_5

    .line 611
    invoke-direct {p0, p2}, Lcom/android/server/am/SplitWindowManager;->findOppositeActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 612
    .local v1, "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_5

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v5

    sget-object v7, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v5, v7}, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 613
    const-string v5, "SplitWindowManager"

    const-string v7, "WAIT TO BE SPLIT AGAIN. do this for his turn."

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 637
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v2    # "prev":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_5
    :goto_2
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    if-nez v5, :cond_9

    .line 638
    iput-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 644
    :goto_3
    monitor-exit v6

    goto :goto_0

    .line 617
    .restart local v0    # "i$":Ljava/util/Iterator;
    .restart local v2    # "prev":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_6
    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setFull()V

    .line 618
    const-string v5, "SplitWindowManager"

    const-string v7, "WAIT TO BE INVISIBLE. do this for his turn."

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 620
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "prev":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_7
    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isRequested()Z

    move-result v5

    if-eqz v5, :cond_5

    .line 621
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v5

    sget-object v7, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v5, v7}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_8

    .line 623
    const-string v5, "SplitWindowManager"

    const-string v7, "startingActivity is REQUESTED but something wrong. cancel it"

    invoke-static {v5, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 624
    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setNative()V

    .line 625
    invoke-direct {p0, p2}, Lcom/android/server/am/SplitWindowManager;->findOppositeActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 626
    .restart local v1    # "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_5

    .line 627
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setNative()V

    goto :goto_2

    .line 631
    .end local v1    # "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_8
    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setSplit()V

    goto :goto_2

    .line 640
    :cond_9
    iget-object v7, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    monitor-enter v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 641
    :try_start_2
    iput-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 642
    monitor-exit v7

    goto :goto_3

    :catchall_1
    move-exception v5

    monitor-exit v7
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :try_start_3
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
.end method

.method private ensureOppositeStackVisible(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;)V
    .locals 9
    .param p1, "top"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "starting"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v4, 0x0

    .line 648
    const/4 v3, 0x0

    .line 649
    .local v3, "unSplitAndFocusTo":Lcom/android/server/am/ActivityStack;
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v5

    .line 650
    :try_start_0
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v6

    if-eqz v6, :cond_8

    .line 652
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->getSplitActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v0

    .line 654
    .local v0, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    if-eqz v6, :cond_0

    if-nez v0, :cond_4

    .line 655
    :cond_0
    const-string v6, "SplitWindowManager"

    const-string v7, "mStartingActivity or sa for top is null: "

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 656
    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v6, :cond_1

    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v6}, Lcom/android/server/am/ActivitySplitInfo;->isSplitNormal()Z

    move-result v6

    if-eqz v6, :cond_1

    iget-object v6, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v6, :cond_1

    iget-object v6, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 659
    const-string v6, "SplitWindowManager"

    const-string v7, "Focused top is normal but starting on opposit is noSupport then.."

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 660
    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v6, :cond_3

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v3, v4, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    .line 696
    .end local v0    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_1
    :goto_0
    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 697
    if-eqz v3, :cond_2

    .line 698
    invoke-direct {p0, v3}, Lcom/android/server/am/SplitWindowManager;->moveStackToFront(Lcom/android/server/am/ActivityStack;)Z

    .line 699
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    .line 701
    :cond_2
    return-void

    .restart local v0    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    move-object v3, v4

    .line 660
    goto :goto_0

    .line 663
    :cond_4
    :try_start_1
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "mStartingActivity: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 664
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-virtual {v6}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v1

    .line 665
    .local v1, "startingState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    invoke-virtual {v0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v2

    .line 667
    .local v2, "topState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    sget-object v6, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v1, v6, :cond_5

    sget-object v6, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v2, v6, :cond_5

    .line 669
    const-string v4, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "startingAct goes FULL to NORMAL. so also change "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 670
    invoke-virtual {v0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setSplit()V

    .line 672
    iget-object v4, v0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v4, v4, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v4, v4, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    const/4 v6, 0x0

    iput-object v6, v4, Lcom/android/server/am/ActivityStack;->mResumedActivity:Lcom/android/server/am/ActivityRecord;

    goto :goto_0

    .line 696
    .end local v0    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v1    # "startingState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    .end local v2    # "topState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v4

    .line 673
    .restart local v0    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .restart local v1    # "startingState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    .restart local v2    # "topState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    :cond_5
    :try_start_2
    sget-object v6, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_FULL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v1, v6, :cond_6

    sget-object v6, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v2, v6, :cond_6

    .line 675
    const-string v4, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "startingAct goes NORMAL to FULL. so also change "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 676
    invoke-virtual {v0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setInvisible()V

    goto/16 :goto_0

    .line 677
    :cond_6
    sget-object v6, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v1, v6, :cond_1

    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v6, :cond_1

    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 679
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "current top is not support split: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "/ "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 681
    iget-object v6, p2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v6, :cond_7

    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v3, v4, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    :goto_1
    goto/16 :goto_0

    :cond_7
    move-object v3, v4

    goto :goto_1

    .line 684
    .end local v0    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v1    # "startingState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    .end local v2    # "topState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    :cond_8
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v6

    sget-object v7, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v6, v7}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b

    .line 686
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->setSplitForResumedActivity(Lcom/android/server/am/ActivityRecord;)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 687
    const-string v4, "SplitWindowManager"

    const-string v6, "opposite top splited."

    invoke-static {v4, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 689
    :cond_9
    const-string v6, "SplitWindowManager"

    const-string v7, "Opposite top could not be splited."

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 690
    iget-object v6, p2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v6, :cond_a

    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v3, v4, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    :goto_2
    goto/16 :goto_0

    :cond_a
    move-object v3, v4

    goto :goto_2

    .line 692
    :cond_b
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v4

    sget-object v6, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v4, v6}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 694
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->checkSplitActivityList(Lcom/android/server/am/ActivityRecord;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_0
.end method

.method private findActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .locals 3
    .param p1, "resumed"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 1292
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1293
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v2, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1297
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :goto_0
    return-object v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private findActivityOnStackLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .locals 4
    .param p1, "resumed"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 1301
    if-eqz p1, :cond_1

    iget-object v2, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v2, :cond_1

    iget-object v2, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v2, v2, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    if-eqz v2, :cond_1

    .line 1302
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1303
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v2, v2, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v2, v2, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v2, v2, Lcom/android/server/am/ActivityStack;->mStackId:I

    iget-object v3, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v3, v3, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v3, v3, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-ne v2, v3, :cond_0

    .line 1309
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :goto_0
    return-object v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private findOppositeActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .locals 5
    .param p1, "component"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v2, 0x0

    .line 1278
    if-eqz p1, :cond_0

    iget-object v3, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-nez v3, :cond_1

    :cond_0
    move-object v1, v2

    .line 1288
    :goto_0
    return-object v1

    .line 1281
    :cond_1
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x2

    if-ne v3, v4, :cond_3

    .line 1282
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1283
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_2

    iget v3, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v4, v4, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v4, v4, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-eq v3, v4, :cond_2

    goto :goto_0

    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    move-object v1, v2

    .line 1288
    goto :goto_0
.end method

.method private findTopSplitActivity()Z
    .locals 11

    .prologue
    const/4 v5, 0x0

    .line 314
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    if-nez v6, :cond_1

    .line 315
    const-string v6, "SplitWindowManager"

    const-string v7, "mStackSupervisor is null"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 346
    :cond_0
    :goto_0
    return v5

    .line 319
    :cond_1
    const/4 v0, 0x0

    .line 320
    .local v0, "numSplitable":I
    iget-object v7, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v7

    .line 321
    :try_start_0
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    if-eqz v6, :cond_2

    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-lez v6, :cond_2

    .line 322
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->clear()V

    .line 324
    :cond_2
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v6}, Lcom/android/server/am/ActivityStackSupervisor;->getStacks()Ljava/util/ArrayList;

    move-result-object v6

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v4, v6, -0x1

    .local v4, "stackNdx":I
    :goto_1
    if-ltz v4, :cond_5

    .line 325
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v6, v4}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v3

    .line 326
    .local v3, "stack":Lcom/android/server/am/ActivityStack;
    if-eqz v3, :cond_3

    iget v6, v3, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-eqz v6, :cond_3

    .line 327
    invoke-virtual {v3}, Lcom/android/server/am/ActivityStack;->topActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v1

    .line 328
    .local v1, "r":Lcom/android/server/am/ActivityRecord;
    if-eqz v1, :cond_3

    iget-object v6, v1, Lcom/android/server/am/ActivityRecord;->state:Lcom/android/server/am/ActivityStack$ActivityState;

    sget-object v8, Lcom/android/server/am/ActivityStack$ActivityState;->RESUMED:Lcom/android/server/am/ActivityStack$ActivityState;

    invoke-virtual {v6, v8}, Lcom/android/server/am/ActivityStack$ActivityState;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 330
    new-instance v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-direct {v2, p0, v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;-><init>(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;)V

    .line 332
    .local v2, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v6, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 334
    const-string v8, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " + "

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Lcom/android/server/am/ActivityRecord;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, "/ state="

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v9, v1, Lcom/android/server/am/ActivityRecord;->state:Lcom/android/server/am/ActivityStack$ActivityState;

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v9, "/ splitable="

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v6, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-nez v6, :cond_4

    move v6, v5

    :goto_2
    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v8, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 338
    iget-object v6, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v6, :cond_3

    iget-object v6, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v8, 0x0

    invoke-virtual {v6, v8}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 339
    add-int/lit8 v0, v0, 0x1

    .line 324
    .end local v1    # "r":Lcom/android/server/am/ActivityRecord;
    .end local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    add-int/lit8 v4, v4, -0x1

    goto :goto_1

    .line 334
    .restart local v1    # "r":Lcom/android/server/am/ActivityRecord;
    .restart local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_4
    iget-object v6, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v10, 0x0

    invoke-virtual {v6, v10}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v6

    goto :goto_2

    .line 344
    .end local v1    # "r":Lcom/android/server/am/ActivityRecord;
    .end local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v3    # "stack":Lcom/android/server/am/ActivityStack;
    :cond_5
    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 345
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "findTopSplitActivity found "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " apps can be splitable"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 346
    const/4 v6, 0x2

    if-ne v0, v6, :cond_0

    const/4 v5, 0x1

    goto/16 :goto_0

    .line 344
    .end local v4    # "stackNdx":I
    :catchall_0
    move-exception v5

    :try_start_1
    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v5
.end method

.method private getDumpstate()Ljava/lang/String;
    .locals 6

    .prologue
    .line 1757
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 1758
    .local v3, "string":Ljava/lang/StringBuilder;
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    .line 1760
    .local v1, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    const-string v4, "SplitWindowManager dumpstate."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1761
    const-string v4, "(_mState : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1762
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager$State;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1763
    const-string v4, ")\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1764
    const-string v4, "_mSplitActivityList("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1765
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 1766
    const-string v4, ")_______\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1767
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v5

    .line 1768
    :try_start_0
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1769
    .local v2, "split":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    const-string v4, " * "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1770
    invoke-virtual {v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toDetailString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1771
    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 1773
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "split":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_0
    :try_start_1
    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1774
    const-string v4, "_mPreparedActivity : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1775
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    if-eqz v4, :cond_1

    .line 1776
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v4}, Lcom/android/server/am/ActivityRecord;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1777
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v4, v4, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v4, :cond_2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ":"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v5, v5, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v5}, Lcom/android/server/am/ActivitySplitInfo;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    :goto_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1779
    :cond_1
    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1781
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 1777
    :cond_2
    const/4 v4, 0x0

    goto :goto_1
.end method

.method private getFocusedTopActivity()Lcom/android/server/am/ActivityRecord;
    .locals 1

    .prologue
    .line 429
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v0}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/am/ActivityStack;->topActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v0

    return-object v0
.end method

.method private getFocusedTopActivitySplitInfo()Lcom/android/server/am/ActivitySplitInfo;
    .locals 2

    .prologue
    .line 424
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getFocusedTopActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v0

    .line 425
    .local v0, "top":Lcom/android/server/am/ActivityRecord;
    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private getMultipleTaskCountInTaskHistory(Ljava/lang/String;)I
    .locals 5
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    .line 1955
    const/4 v1, 0x0

    .line 1957
    .local v1, "multipleCount":I
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v4}, Lcom/android/server/am/ActivityStackSupervisor;->getStacks()Ljava/util/ArrayList;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    add-int/lit8 v3, v4, -0x1

    .local v3, "stackNdx":I
    :goto_0
    if-ltz v3, :cond_0

    .line 1958
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v4}, Lcom/android/server/am/ActivityStackSupervisor;->getStacks()Ljava/util/ArrayList;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/am/ActivityStack;

    .line 1959
    .local v2, "stack":Lcom/android/server/am/ActivityStack;
    if-eqz v2, :cond_2

    iget v4, v2, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-eqz v4, :cond_2

    .line 1960
    invoke-direct {p0, v2, p1}, Lcom/android/server/am/SplitWindowManager;->checkMultipleInstanceTaskInStack(Lcom/android/server/am/ActivityStack;Ljava/lang/String;)I

    move-result v0

    .line 1961
    .local v0, "getHistoryCount":I
    const/4 v4, 0x2

    if-le v0, v4, :cond_1

    .line 1962
    const/4 v1, -0x1

    .line 1968
    .end local v0    # "getHistoryCount":I
    .end local v1    # "multipleCount":I
    .end local v2    # "stack":Lcom/android/server/am/ActivityStack;
    :cond_0
    return v1

    .line 1964
    .restart local v0    # "getHistoryCount":I
    .restart local v1    # "multipleCount":I
    .restart local v2    # "stack":Lcom/android/server/am/ActivityStack;
    :cond_1
    add-int/2addr v1, v0

    .line 1957
    .end local v0    # "getHistoryCount":I
    :cond_2
    add-int/lit8 v3, v3, -0x1

    goto :goto_0
.end method

.method private getOtherStack(I)Lcom/android/server/am/ActivityStack;
    .locals 4
    .param p1, "currentStackId"    # I

    .prologue
    .line 2026
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v3}, Lcom/android/server/am/ActivityStackSupervisor;->getStacks()Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    add-int/lit8 v2, v3, -0x1

    .local v2, "stackNdx":I
    :goto_0
    if-ltz v2, :cond_1

    .line 2027
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v3}, Lcom/android/server/am/ActivityStackSupervisor;->getStacks()Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/am/ActivityStack;

    .line 2028
    .local v0, "stack":Lcom/android/server/am/ActivityStack;
    iget v1, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 2029
    .local v1, "stackId":I
    if-eqz v1, :cond_0

    if-eq v1, p1, :cond_0

    .line 2033
    .end local v0    # "stack":Lcom/android/server/am/ActivityStack;
    .end local v1    # "stackId":I
    :goto_1
    return-object v0

    .line 2026
    .restart local v0    # "stack":Lcom/android/server/am/ActivityStack;
    .restart local v1    # "stackId":I
    :cond_0
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    .line 2033
    .end local v0    # "stack":Lcom/android/server/am/ActivityStack;
    .end local v1    # "stackId":I
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private getScreenForZone(I)Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    .locals 3
    .param p1, "zone"    # I

    .prologue
    .line 1867
    const/4 v1, 0x0

    .line 1868
    .local v1, "info":Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v2

    .line 1870
    .local v2, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->getScreenInfoForZone(I)Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1875
    :goto_0
    return-object v1

    .line 1871
    :catch_0
    move-exception v0

    .line 1873
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method private getSplitActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .locals 5
    .param p1, "activity"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 763
    const/4 v2, 0x0

    .line 764
    .local v2, "splitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 765
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_0

    iget-object v3, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-ne v3, p1, :cond_0

    iget-object v3, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v3, :cond_0

    iget v3, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v4, v4, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v4, v4, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-ne v3, v4, :cond_0

    .line 767
    move-object v2, v1

    .line 772
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_1
    if-nez v2, :cond_2

    .line 773
    new-instance v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .end local v2    # "splitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-direct {v2, p0, p1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;-><init>(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;)V

    .line 776
    .restart local v2    # "splitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_2
    return-object v2
.end method

.method private getSplitState()Lcom/android/server/am/SplitWindowManager$State;
    .locals 1

    .prologue
    .line 288
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    return-object v0
.end method

.method private getSplitedActivityCount()I
    .locals 5

    .prologue
    .line 1462
    const/4 v2, 0x0

    .line 1463
    .local v2, "splitedActivity":I
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v4

    .line 1464
    :try_start_0
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1465
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isSplited()Z

    move-result v3

    if-eqz v3, :cond_0

    add-int/lit8 v2, v2, 0x1

    .line 1466
    :cond_0
    goto :goto_0

    .line 1467
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_1
    monitor-exit v4

    .line 1468
    return v2

    .line 1467
    .end local v0    # "i$":Ljava/util/Iterator;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3
.end method

.method private isNativeMode()Z
    .locals 2

    .prologue
    .line 274
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v0

    sget-object v1, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v0, v1}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method private letPolicyCancelSplitMode()V
    .locals 5

    .prologue
    .line 1507
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    .line 1508
    .local v1, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-eqz v1, :cond_0

    .line 1510
    :try_start_0
    invoke-interface {v1}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->cancelSplitMode()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1515
    :cond_0
    :goto_0
    return-void

    .line 1511
    :catch_0
    move-exception v0

    .line 1512
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "cancelSplitMode occured exception: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private letPolicyPrepareSplitMode()V
    .locals 5

    .prologue
    .line 1496
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    .line 1497
    .local v1, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-eqz v1, :cond_0

    .line 1499
    :try_start_0
    invoke-interface {v1}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->prepareSplitMode()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1504
    :cond_0
    :goto_0
    return-void

    .line 1500
    :catch_0
    move-exception v0

    .line 1501
    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "preprareSplitMode occured exception: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private logStackStatus(Lcom/android/server/am/ActivityStack;Ljava/lang/String;)V
    .locals 6
    .param p1, "stacks"    # Lcom/android/server/am/ActivityStack;
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    .line 986
    const-string v3, "SplitWindowManager"

    invoke-static {v3, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 987
    const-string v3, "SplitWindowManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mFocusedStack: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v5}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 988
    const/4 v0, 0x0

    .line 989
    .local v0, "i":I
    if-nez p1, :cond_1

    .line 994
    :cond_0
    return-void

    .line 990
    :cond_1
    iget-object v3, p1, Lcom/android/server/am/ActivityStack;->mStacks:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/am/ActivityStack;

    .line 991
    .local v2, "stack":Lcom/android/server/am/ActivityStack;
    const-string v3, "SplitWindowManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "- "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lcom/android/server/am/ActivityStack;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 992
    add-int/lit8 v0, v0, 0x1

    .line 993
    goto :goto_0
.end method

.method private makeBothActivityOnTopOfHome()V
    .locals 5

    .prologue
    .line 1481
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1482
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v3

    .line 1483
    :try_start_0
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1484
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v2, :cond_0

    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v2, :cond_0

    .line 1485
    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Lcom/android/server/am/TaskRecord;->setTaskToReturnTo(I)V

    .line 1486
    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v2, :cond_0

    .line 1487
    iget-object v2, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v4, 0x0

    invoke-virtual {v2, v4}, Lcom/android/server/am/ActivitySplitInfo;->setScreenZone(I)V

    goto :goto_0

    .line 1491
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_1
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1493
    .end local v0    # "i$":Ljava/util/Iterator;
    :cond_2
    return-void
.end method

.method private moveStackToFront(Lcom/android/server/am/ActivityStack;)Z
    .locals 9
    .param p1, "toFront"    # Lcom/android/server/am/ActivityStack;

    .prologue
    const/4 v5, 0x1

    .line 954
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "moveStackToFront : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 956
    iget-object v1, p1, Lcom/android/server/am/ActivityStack;->mStacks:Ljava/util/ArrayList;

    .line 957
    .local v1, "stacks":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/am/ActivityStack;>;"
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v3, v6, -0x1

    .line 958
    .local v3, "topNdx":I
    if-gtz v3, :cond_0

    .line 959
    const/4 v5, 0x0

    .line 982
    :goto_0
    return v5

    .line 965
    :cond_0
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/am/ActivityStack;

    .line 966
    .local v4, "topStack":Lcom/android/server/am/ActivityStack;
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v6, v4}, Lcom/android/server/am/ActivityStackSupervisor;->setLastFocusedStackForSplitWindow(Lcom/android/server/am/ActivityStack;)V

    .line 967
    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 968
    invoke-virtual {v1, v3, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 969
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/am/ActivityStack;

    .line 970
    .local v0, "stackToFocus":Lcom/android/server/am/ActivityStack;
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v6, v0}, Lcom/android/server/am/ActivityStackSupervisor;->setFocusedStackForSplitWindow(Lcom/android/server/am/ActivityStack;)V

    .line 973
    invoke-virtual {p1}, Lcom/android/server/am/ActivityStack;->topActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v2

    .line 974
    .local v2, "topActivityToFront":Lcom/android/server/am/ActivityRecord;
    if-eqz v2, :cond_1

    .line 975
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "moveStackToFront setFocus to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 976
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget-object v7, v2, Lcom/android/server/am/ActivityRecord;->appToken:Landroid/view/IApplicationToken$Stub;

    invoke-virtual {v6, v7, v5}, Lcom/android/server/wm/WindowManagerService;->setFocusedApp(Landroid/os/IBinder;Z)V

    .line 979
    :cond_1
    const/4 v6, 0x0

    iput-object v6, v0, Lcom/android/server/am/ActivityStack;->mResumedActivity:Lcom/android/server/am/ActivityRecord;

    goto :goto_0
.end method

.method private moveTaskToStack(IIZ)Z
    .locals 3
    .param p1, "taskId"    # I
    .param p2, "stackId"    # I
    .param p3, "toTop"    # Z

    .prologue
    .line 1253
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v2, p1}, Lcom/android/server/am/ActivityStackSupervisor;->anyTaskForIdLocked(I)Lcom/android/server/am/TaskRecord;

    move-result-object v1

    .line 1254
    .local v1, "task":Lcom/android/server/am/TaskRecord;
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v2, p2}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v0

    .line 1255
    .local v0, "stack":Lcom/android/server/am/ActivityStack;
    invoke-direct {p0, v1, v0, p3}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    move-result v2

    return v2
.end method

.method private moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z
    .locals 5
    .param p1, "task"    # Lcom/android/server/am/TaskRecord;
    .param p2, "stack"    # Lcom/android/server/am/ActivityStack;
    .param p3, "toTop"    # Z

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1259
    if-eqz p1, :cond_2

    if-eqz p2, :cond_2

    .line 1260
    invoke-virtual {p2}, Lcom/android/server/am/ActivityStack;->isHomeStack()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {p1}, Lcom/android/server/am/TaskRecord;->isApplicationTask()Z

    move-result v3

    if-nez v3, :cond_1

    .line 1261
    :cond_0
    const-string v1, "SplitWindowManager"

    const-string v3, "SplitWindowManager does not move any task to HomeStack or move non-application tasks to any"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    .line 1274
    :goto_0
    return v1

    .line 1264
    :cond_1
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "move "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1266
    iget-object v2, p1, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v0, v2, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 1267
    .local v0, "oldStackId":I
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget v3, p1, Lcom/android/server/am/TaskRecord;->taskId:I

    invoke-virtual {v2, v3}, Lcom/android/server/wm/WindowManagerService;->tempararyStoreTaskToAddAgain(I)Z

    .line 1268
    iget-object v2, p1, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    invoke-virtual {v2, p1}, Lcom/android/server/am/ActivityStack;->removeTask(Lcom/android/server/am/TaskRecord;)V

    .line 1269
    invoke-virtual {p2, p1, p3, v1}, Lcom/android/server/am/ActivityStack;->addTask(Lcom/android/server/am/TaskRecord;ZZ)V

    .line 1270
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget v3, p1, Lcom/android/server/am/TaskRecord;->taskId:I

    iget v4, p2, Lcom/android/server/am/ActivityStack;->mStackId:I

    invoke-virtual {v2, v3, v4, p3}, Lcom/android/server/wm/WindowManagerService;->addTask(IIZ)V

    .line 1271
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget v3, p1, Lcom/android/server/am/TaskRecord;->taskId:I

    iget v4, p2, Lcom/android/server/am/ActivityStack;->mStackId:I

    invoke-virtual {v2, v3, v0, v4}, Lcom/android/server/wm/WindowManagerService;->removeTaskFromStackIfNeeded(III)V

    goto :goto_0

    .end local v0    # "oldStackId":I
    :cond_2
    move v1, v2

    .line 1274
    goto :goto_0
.end method

.method private putLogState()V
    .locals 4

    .prologue
    const/16 v1, 0x1f6

    .line 743
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 744
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mHandler:Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

    invoke-virtual {v0, v1}, Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;->removeMessages(I)V

    .line 745
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mHandler:Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;->sendEmptyMessageDelayed(IJ)Z

    .line 747
    :cond_0
    return-void
.end method

.method private realPutLogState()V
    .locals 2

    .prologue
    .line 750
    const-string v0, "SplitWindowManager"

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getDumpstate()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 751
    return-void
.end method

.method private recoverSplitService()V
    .locals 2

    .prologue
    .line 1347
    invoke-static {}, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->recoverService()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitPolicy:Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    .line 1348
    const-string v0, "SplitWindowManager"

    const-string v1, "recover SplitWindowPolicyService."

    invoke-static {v0, v1}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1349
    return-void
.end method

.method private removeSplitActivityForStackIdLocked(I)Z
    .locals 5
    .param p1, "id"    # I

    .prologue
    .line 1623
    const/4 v1, 0x0

    .line 1624
    .local v1, "removed":Z
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/android/server/am/SplitWindowManager$SplitActivity;>;"
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1625
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1626
    .local v2, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v2, :cond_0

    iget v3, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    if-ne v3, p1, :cond_0

    .line 1628
    invoke-virtual {v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v3

    sget-object v4, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NORMAL_REQUESTED:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v3, v4, :cond_1

    invoke-virtual {v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v3

    sget-object v4, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->UN_SPLITING:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v3, v4, :cond_2

    .line 1630
    :cond_1
    const-string v3, "SplitWindowManager"

    const-string v4, "recover before remove"

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1631
    iget-object v3, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v3, v3, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v3}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    .line 1634
    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 1635
    const/4 v1, 0x1

    goto :goto_0

    .line 1638
    .end local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    return v1
.end method

.method private setSplitForResumedActivity(Lcom/android/server/am/ActivityRecord;)Z
    .locals 9
    .param p1, "top"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 791
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    if-nez v6, :cond_0

    .line 792
    const-string v5, "SplitWindowManager"

    const-string v6, "setSplitForResumedActivity: mStartingActivity in not ready."

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 831
    :goto_0
    return v4

    .line 796
    :cond_0
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-virtual {v6}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getRequstedScreenZone()I

    move-result v3

    .line 797
    .local v3, "zone":I
    if-eq v3, v5, :cond_1

    const/4 v6, 0x2

    if-ne v3, v6, :cond_4

    .line 798
    :cond_1
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->findActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 799
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-nez v1, :cond_3

    .line 801
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->findActivityOnStackLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v0

    .line 802
    .local v0, "oldSplitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v0, :cond_3

    iget-object v6, v0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v6, :cond_3

    iget-object v6, v0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-boolean v6, v6, Lcom/android/server/am/ActivityRecord;->finishing:Z

    if-eqz v6, :cond_3

    .line 804
    invoke-virtual {v0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isRequested()Z

    move-result v6

    if-nez v6, :cond_2

    .line 807
    const-string v6, "SplitWindowManager"

    const-string v7, "old activity has not been requested. it would be REQUESTED forcefully"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 808
    const-string v6, "SplitWindowManager"

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getDumpstate()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 809
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "_mStartingActivity : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 813
    :cond_2
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->updateStartActivityToListLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 815
    iget-object v6, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v6, v6, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v6}, Lcom/android/server/am/ActivitySplitInfo;->setRequested()Z

    .line 816
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "update mSplitActivityList for current topActivity: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 820
    .end local v0    # "oldSplitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isRequested()Z

    move-result v6

    if-eqz v6, :cond_4

    .line 821
    rsub-int/lit8 v2, v3, 0x3

    .line 822
    .local v2, "targetZone":I
    invoke-virtual {v1, v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setScreenZone(I)V

    .line 823
    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->setSplit()V

    move v4, v5

    .line 825
    goto/16 :goto_0

    .line 828
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v2    # "targetZone":I
    :cond_4
    const-string v5, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "setSplitForResumedActivity not worked... for "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 829
    const-string v5, "SplitWindowManager"

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getDumpstate()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 830
    const-string v5, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "_mStartingActivity : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method private setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V
    .locals 4
    .param p1, "state"    # Lcom/android/server/am/SplitWindowManager$State;

    .prologue
    .line 278
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    .line 279
    .local v0, "_old":Lcom/android/server/am/SplitWindowManager$State;
    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    if-eq v1, p1, :cond_0

    .line 280
    iput-object p1, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    .line 281
    const-string v1, "SplitWindowManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setSplitMode changed : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " -> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 285
    :cond_0
    return-void
.end method

.method private updateActivityToSplitPolicyService(Lcom/android/server/am/ActivityRecord;Z)V
    .locals 10
    .param p1, "component"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "resumed"    # Z

    .prologue
    .line 1642
    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->realActivity:Landroid/content/ComponentName;

    invoke-virtual {v1}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v9

    .line 1644
    .local v9, "pkgName":Ljava/lang/String;
    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v1, v1, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v2, v1, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 1645
    .local v2, "stackId":I
    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v5, v1, Lcom/android/server/am/TaskRecord;->taskId:I

    .line 1646
    .local v5, "taskId":I
    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v1, :cond_0

    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v1}, Lcom/android/server/am/ActivitySplitInfo;->isFullScreen()Z

    move-result v3

    .line 1648
    .local v3, "bIsScreenFull":Z
    :goto_0
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v0

    .line 1649
    .local v0, "splitWindowPolicy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-nez v0, :cond_1

    .line 1650
    const-string v1, "SplitWindowManager"

    const-string v4, "cant get splitWindowPolicy binder..."

    invoke-static {v1, v4}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1664
    :goto_1
    return-void

    .line 1646
    .end local v0    # "splitWindowPolicy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    .end local v3    # "bIsScreenFull":Z
    :cond_0
    const/4 v3, 0x0

    goto :goto_0

    .line 1655
    .restart local v0    # "splitWindowPolicy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    .restart local v3    # "bIsScreenFull":Z
    :cond_1
    :try_start_0
    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->info:Landroid/content/pm/ActivityInfo;

    iget v6, p1, Lcom/android/server/am/ActivityRecord;->mActivityType:I

    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v7

    move v1, p2

    invoke-interface/range {v0 .. v7}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->updateActivityStateChanged(ZIZLandroid/content/pm/ActivityInfo;IIZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 1660
    :catch_0
    move-exception v8

    .line 1661
    .local v8, "e":Landroid/os/RemoteException;
    const-string v1, "SplitWindowManager"

    const-string v4, "updateActivityStateChanged Failed..., need to recoverSplitService"

    invoke-static {v1, v4}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1662
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->recoverSplitService()V

    goto :goto_1
.end method

.method private updateStartActivityToListLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .locals 4
    .param p1, "component"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v1, 0x0

    .line 1526
    const-string v2, "SplitWindowManager"

    const-string v3, "updateStartActivityToList"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1527
    iget-object v2, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v2, :cond_0

    iget-object v2, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v2, v2, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityStack;->isHomeStack()Z

    move-result v2

    if-eqz v2, :cond_0

    move-object v0, v1

    .line 1536
    :goto_0
    return-object v0

    .line 1531
    :cond_0
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->getSplitActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v0

    .line 1532
    .local v0, "splitComp":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 1533
    invoke-direct {p0, v0}, Lcom/android/server/am/SplitWindowManager;->updateStartActivityToListLocked(Lcom/android/server/am/SplitWindowManager$SplitActivity;)V

    goto :goto_0

    :cond_1
    move-object v0, v1

    .line 1536
    goto :goto_0
.end method

.method private updateStartActivityToListLocked(Lcom/android/server/am/SplitWindowManager$SplitActivity;)V
    .locals 1
    .param p1, "splitActivity"    # Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .prologue
    .line 1547
    if-eqz p1, :cond_0

    .line 1548
    iget v0, p1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-direct {p0, v0}, Lcom/android/server/am/SplitWindowManager;->removeSplitActivityForStackIdLocked(I)Z

    .line 1549
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1551
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mHistorySplit:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1554
    :cond_0
    return-void
.end method


# virtual methods
.method public adjustFocusedActivityLocked(Lcom/android/server/am/ActivityRecord;)Z
    .locals 7
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .line 1888
    if-eqz p1, :cond_0

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-nez v4, :cond_2

    .line 1889
    :cond_0
    const-string v3, "SplitWindowManager"

    const-string v4, "adjustFocusedActivityLocked returns by null variable"

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1926
    :cond_1
    :goto_0
    return v0

    .line 1892
    :cond_2
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1901
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "adjustFocusedActivityLocked:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p1, Lcom/android/server/am/ActivityRecord;->finishing:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    invoke-virtual {v6}, Lcom/android/server/am/TaskRecord;->isOverHomeStack()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1902
    iget-boolean v4, p1, Lcom/android/server/am/ActivityRecord;->finishing:Z

    if-eqz v4, :cond_4

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    invoke-virtual {v4}, Lcom/android/server/am/TaskRecord;->isOverHomeStack()Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    if-eqz v4, :cond_4

    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v4, v4, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v4, v4, Lcom/android/server/am/TaskRecord;->taskId:I

    iget-object v5, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v5, v5, Lcom/android/server/am/TaskRecord;->taskId:I

    if-ne v4, v5, :cond_4

    .line 1904
    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    if-eqz v4, :cond_3

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    invoke-virtual {v4}, Landroid/content/Intent;->getFlags()I

    move-result v0

    .line 1905
    .local v0, "launchFlags":I
    :cond_3
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "launchFlags : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1914
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " is finishing, but keep split mode for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v3

    .line 1915
    goto/16 :goto_0

    .line 1918
    .end local v0    # "launchFlags":I
    :cond_4
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->findOppositeActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 1919
    .local v1, "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_1

    .line 1920
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    iget v5, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {v4, v5}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v2

    .line 1921
    .local v2, "stack":Lcom/android/server/am/ActivityStack;
    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->moveStackToFront(Lcom/android/server/am/ActivityStack;)Z

    .line 1922
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    move v0, v3

    .line 1923
    goto/16 :goto_0
.end method

.method public adjustStackFocus(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/ActivityStack;
    .locals 17
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 465
    if-eqz p1, :cond_f

    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v14, :cond_f

    invoke-virtual/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v14

    if-nez v14, :cond_0

    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v14}, Lcom/android/server/am/ActivitySplitInfo;->isRequested()Z

    move-result v14

    if-eqz v14, :cond_f

    .line 467
    :cond_0
    const-string v14, "SplitWindowManager"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "adjustStackFocus for "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p1

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v16, v0

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 469
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v14}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v2

    .line 470
    .local v2, "focusedStack":Lcom/android/server/am/ActivityStack;
    invoke-virtual/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v14

    if-eqz v14, :cond_4

    .line 471
    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v14}, Lcom/android/server/am/ActivitySplitInfo;->getScreenZone()I

    move-result v13

    .line 472
    .local v13, "zone":I
    move-object/from16 v0, p0

    invoke-direct {v0, v13}, Lcom/android/server/am/SplitWindowManager;->getScreenForZone(I)Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;

    move-result-object v4

    .line 473
    .local v4, "info":Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    if-eqz v4, :cond_2

    invoke-interface {v4}, Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;->getScreenId()I

    move-result v6

    .line 476
    .local v6, "stackId":I
    :goto_0
    if-lez v6, :cond_3

    .line 477
    iget-object v14, v2, Lcom/android/server/am/ActivityStack;->mStacks:Ljava/util/ArrayList;

    invoke-virtual {v14}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/android/server/am/ActivityStack;

    .line 478
    .local v5, "stack":Lcom/android/server/am/ActivityStack;
    iget v14, v5, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-ne v14, v6, :cond_1

    .line 479
    const-string v14, "SplitWindowManager"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "adjustStackFocus returns "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v5}, Lcom/android/server/am/ActivityStack;->toString()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 560
    .end local v2    # "focusedStack":Lcom/android/server/am/ActivityStack;
    .end local v3    # "i$":Ljava/util/Iterator;
    .end local v4    # "info":Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    .end local v5    # "stack":Lcom/android/server/am/ActivityStack;
    .end local v6    # "stackId":I
    .end local v13    # "zone":I
    :goto_1
    return-object v5

    .line 473
    .restart local v2    # "focusedStack":Lcom/android/server/am/ActivityStack;
    .restart local v4    # "info":Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    .restart local v13    # "zone":I
    :cond_2
    const/4 v6, -0x1

    goto :goto_0

    .line 485
    .restart local v6    # "stackId":I
    :cond_3
    const-string v14, "SplitWindowManager"

    const-string v15, "adjustStackFocus returns null"

    invoke-static {v14, v15}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 486
    const/4 v5, 0x0

    goto :goto_1

    .line 491
    .end local v4    # "info":Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    .end local v6    # "stackId":I
    .end local v13    # "zone":I
    :cond_4
    const/4 v1, 0x0

    .line 492
    .local v1, "existStack":Lcom/android/server/am/ActivityStack;
    const/4 v10, 0x0

    .line 493
    .local v10, "targetStack":Lcom/android/server/am/ActivityStack;
    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v14, :cond_5

    .line 494
    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v11, v14, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    .line 495
    .local v11, "taskStack":Lcom/android/server/am/ActivityStack;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v11}, Lcom/android/server/am/ActivityStack;->getStackId()I

    move-result v15

    invoke-virtual {v14, v15}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v1

    .line 496
    const-string v14, "SplitWindowManager"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, " existStack = "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v1}, Lcom/android/server/am/ActivityStack;->getStackId()I

    move-result v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 499
    if-eqz v1, :cond_5

    .line 500
    invoke-virtual {v2, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_5

    .line 502
    const-string v14, "SplitWindowManager"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, " -> task was on hidden stack = "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v1}, Lcom/android/server/am/ActivityStack;->getStackId()I

    move-result v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 503
    move-object v10, v1

    .line 510
    .end local v11    # "taskStack":Lcom/android/server/am/ActivityStack;
    :cond_5
    if-nez v10, :cond_b

    .line 511
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v14}, Lcom/android/server/am/ActivityStackSupervisor;->getStacks()Ljava/util/ArrayList;

    move-result-object v9

    .line 512
    .local v9, "stacks":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/am/ActivityStack;>;"
    const/4 v7, -0x1

    .line 513
    .local v7, "stackIdEmpty":I
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v14

    add-int/lit8 v8, v14, -0x1

    .local v8, "stackIdx":I
    :goto_2
    if-ltz v8, :cond_9

    .line 514
    invoke-virtual {v9, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/android/server/am/ActivityStack;

    .line 516
    .restart local v5    # "stack":Lcom/android/server/am/ActivityStack;
    if-eqz v5, :cond_6

    invoke-virtual {v5}, Lcom/android/server/am/ActivityStack;->isHomeStack()Z

    move-result v14

    if-nez v14, :cond_6

    invoke-virtual {v5, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_6

    .line 518
    iget-object v14, v5, Lcom/android/server/am/ActivityStack;->mTaskHistory:Ljava/util/ArrayList;

    invoke-virtual {v14}, Ljava/util/ArrayList;->size()I

    move-result v14

    if-nez v14, :cond_8

    .line 519
    if-lez v7, :cond_7

    .line 513
    :cond_6
    :goto_3
    add-int/lit8 v8, v8, -0x1

    goto :goto_2

    .line 519
    :cond_7
    iget v7, v5, Lcom/android/server/am/ActivityStack;->mStackId:I

    goto :goto_3

    .line 521
    :cond_8
    move-object v10, v5

    .line 522
    const-string v14, "SplitWindowManager"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, " -> found stack that can be splited: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v10}, Lcom/android/server/am/ActivityStack;->getStackId()I

    move-result v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 528
    .end local v5    # "stack":Lcom/android/server/am/ActivityStack;
    :cond_9
    if-nez v10, :cond_a

    if-lez v7, :cond_a

    .line 529
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v14, v7}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v10

    .line 530
    const-string v14, "SplitWindowManager"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "use empty stack "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 533
    :cond_a
    if-nez v10, :cond_b

    invoke-direct/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->createStack()Lcom/android/server/am/ActivityStack;

    move-result-object v10

    .line 537
    .end local v7    # "stackIdEmpty":I
    .end local v8    # "stackIdx":I
    .end local v9    # "stacks":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/am/ActivityStack;>;"
    :cond_b
    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    const/4 v15, 0x1

    move-object/from16 v0, p0

    invoke-direct {v0, v14, v10, v15}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    .line 540
    if-eqz v10, :cond_c

    .line 542
    sget-object v14, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    :goto_4
    move-object v5, v10

    .line 556
    goto/16 :goto_1

    .line 544
    :cond_c
    const-string v14, "SplitWindowManager"

    const-string v15, "adjustStackFocus cancel split request"

    invoke-static {v14, v15}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 545
    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v14}, Lcom/android/server/am/ActivitySplitInfo;->isRequested()Z

    move-result v14

    if-eqz v14, :cond_d

    .line 546
    move-object/from16 v0, p1

    iget-object v14, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v14}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    .line 548
    :cond_d
    invoke-direct/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->getFocusedTopActivitySplitInfo()Lcom/android/server/am/ActivitySplitInfo;

    move-result-object v12

    .line 549
    .local v12, "top":Lcom/android/server/am/ActivitySplitInfo;
    if-eqz v12, :cond_e

    invoke-virtual {v12}, Lcom/android/server/am/ActivitySplitInfo;->isRequested()Z

    move-result v14

    if-eqz v14, :cond_e

    .line 550
    invoke-virtual {v12}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    .line 552
    :cond_e
    sget-object v14, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    move-object/from16 v0, p0

    invoke-direct {v0, v14}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    goto :goto_4

    .line 560
    .end local v1    # "existStack":Lcom/android/server/am/ActivityStack;
    .end local v2    # "focusedStack":Lcom/android/server/am/ActivityStack;
    .end local v10    # "targetStack":Lcom/android/server/am/ActivityStack;
    .end local v12    # "top":Lcom/android/server/am/ActivitySplitInfo;
    :cond_f
    const/4 v5, 0x0

    goto/16 :goto_1
.end method

.method public bringStackToFrontLocked(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;)Z
    .locals 23
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "sourceRecord"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 1131
    invoke-virtual/range {p1 .. p1}, Lcom/android/server/am/ActivityRecord;->isHomeActivity()Z

    move-result v19

    if-nez v19, :cond_0

    invoke-virtual/range {p1 .. p1}, Lcom/android/server/am/ActivityRecord;->isRecentsActivity()Z

    move-result v19

    if-eqz v19, :cond_1

    .line 1132
    :cond_0
    const/16 v19, 0x0

    .line 1249
    :goto_0
    return v19

    .line 1134
    :cond_1
    const-string v19, "SplitWindowManager"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "bringStackToFront : "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1135
    if-eqz p1, :cond_2

    if-eqz p1, :cond_3

    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    if-nez v19, :cond_3

    .line 1136
    :cond_2
    const-string v19, "SplitWindowManager"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "bringStackToFront got wrong variable: "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1137
    const/16 v19, 0x0

    goto :goto_0

    .line 1145
    :cond_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v19, v0

    if-eqz v19, :cond_4

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-nez v19, :cond_4

    .line 1146
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    move-object/from16 v19, v0

    if-eqz v19, :cond_5

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    move-object/from16 v19, v0

    invoke-virtual/range {v19 .. v19}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v15

    .line 1147
    .local v15, "startComp":Landroid/content/ComponentName;
    :goto_1
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    move-object/from16 v19, v0

    if-eqz v19, :cond_6

    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    move-object/from16 v19, v0

    invoke-virtual/range {v19 .. v19}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v6

    .line 1149
    .local v6, "existComp":Landroid/content/ComponentName;
    :goto_2
    invoke-virtual {v15, v6}, Landroid/content/ComponentName;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_4

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v19, v0

    if-eqz v19, :cond_4

    .line 1150
    const-string v19, "SplitWindowManager"

    const-string v20, "Find same component but different activity when start"

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1151
    const-string v19, "SplitWindowManager"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "\t-"

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    const-string v21, "/ "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1152
    const-string v19, "SplitWindowManager"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "\t-"

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    const-string v21, "/ "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1153
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v19, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v20, v0

    invoke-virtual/range {v19 .. v20}, Lcom/android/server/am/ActivitySplitInfo;->inheritRequestedScreenZone(Lcom/android/server/am/ActivitySplitInfo;)V

    .line 1154
    move-object/from16 v0, p1

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    .line 1155
    const-string v19, "SplitWindowManager"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, " -> "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    const-string v21, "/ "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1159
    .end local v6    # "existComp":Landroid/content/ComponentName;
    .end local v15    # "startComp":Landroid/content/ComponentName;
    :cond_4
    move-object/from16 v0, p1

    iget-object v10, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    .line 1160
    .local v10, "info":Lcom/android/server/am/ActivitySplitInfo;
    invoke-direct/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v19

    sget-object v20, Lcom/android/server/am/SplitWindowManager$State;->REQUESTED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual/range {v19 .. v20}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_7

    invoke-virtual {v10}, Lcom/android/server/am/ActivitySplitInfo;->isRequested()Z

    move-result v19

    if-eqz v19, :cond_7

    const/4 v11, 0x1

    .line 1161
    .local v11, "isRequestedFromNATIVE":Z
    :goto_3
    invoke-direct/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v19

    sget-object v20, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual/range {v19 .. v20}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_b

    .line 1162
    if-eqz p2, :cond_8

    invoke-virtual/range {p2 .. p2}, Lcom/android/server/am/ActivityRecord;->isHomeActivity()Z

    move-result v19

    if-eqz v19, :cond_8

    .line 1163
    const/16 v19, 0x0

    goto/16 :goto_0

    .line 1146
    .end local v10    # "info":Lcom/android/server/am/ActivitySplitInfo;
    .end local v11    # "isRequestedFromNATIVE":Z
    :cond_5
    const/4 v15, 0x0

    goto/16 :goto_1

    .line 1147
    .restart local v15    # "startComp":Landroid/content/ComponentName;
    :cond_6
    const/4 v6, 0x0

    goto/16 :goto_2

    .line 1160
    .end local v15    # "startComp":Landroid/content/ComponentName;
    .restart local v10    # "info":Lcom/android/server/am/ActivitySplitInfo;
    :cond_7
    const/4 v11, 0x0

    goto :goto_3

    .line 1166
    .restart local v11    # "isRequestedFromNATIVE":Z
    :cond_8
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v4, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    .line 1167
    .local v4, "currentStack":Lcom/android/server/am/ActivityStack;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    move-object/from16 v19, v0

    invoke-virtual/range {v19 .. v19}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v7

    .line 1169
    .local v7, "focuedStack":Lcom/android/server/am/ActivityStack;
    if-nez p2, :cond_a

    move-object/from16 v17, v7

    .line 1170
    .local v17, "targetStack":Lcom/android/server/am/ActivityStack;
    :goto_4
    if-eqz v17, :cond_9

    invoke-virtual/range {v17 .. v17}, Lcom/android/server/am/ActivityStack;->isHomeStack()Z

    move-result v19

    if-nez v19, :cond_9

    move-object/from16 v0, v17

    invoke-virtual {v4, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-nez v19, :cond_9

    .line 1171
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    const/16 v20, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    move-object/from16 v2, v17

    move/from16 v3, v20

    invoke-direct {v0, v1, v2, v3}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    .line 1249
    .end local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    .end local v7    # "focuedStack":Lcom/android/server/am/ActivityStack;
    .end local v17    # "targetStack":Lcom/android/server/am/ActivityStack;
    :cond_9
    :goto_5
    const/16 v19, 0x0

    goto/16 :goto_0

    .line 1169
    .restart local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    .restart local v7    # "focuedStack":Lcom/android/server/am/ActivityStack;
    :cond_a
    move-object/from16 v0, p2

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    move-object/from16 v17, v0

    goto :goto_4

    .line 1173
    .end local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    .end local v7    # "focuedStack":Lcom/android/server/am/ActivityStack;
    :cond_b
    invoke-virtual/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v19

    if-nez v19, :cond_c

    if-eqz v11, :cond_9

    .line 1178
    :cond_c
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget v5, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 1179
    .local v5, "currentStackId":I
    invoke-direct/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->getFocusedTopActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v18

    .line 1180
    .local v18, "top":Lcom/android/server/am/ActivityRecord;
    if-nez v18, :cond_d

    .line 1181
    const-string v19, "SplitWindowManager"

    const-string v20, "bringStackToFront could not get FocusedTopActivity. cancel it"

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1182
    const/16 v19, 0x0

    goto/16 :goto_0

    .line 1185
    :cond_d
    move-object/from16 v0, v18

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    if-eqz v19, :cond_13

    move-object/from16 v0, v18

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget v8, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 1186
    .local v8, "focusedStackId":I
    :goto_6
    if-eqz p2, :cond_14

    move-object/from16 v0, p2

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget v13, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 1188
    .local v13, "sourceRecordStackId":I
    :goto_7
    const/16 v16, 0x0

    .line 1189
    .local v16, "targetSplitAct":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    move-object/from16 v20, v0

    monitor-enter v20

    .line 1190
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    move-object/from16 v19, v0

    invoke-virtual/range {v19 .. v19}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v9

    .local v9, "i$":Ljava/util/Iterator;
    :cond_e
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_f

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1191
    .local v12, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-virtual/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v19

    if-eqz v19, :cond_15

    invoke-virtual {v12}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getCurrentScreenZone()I

    move-result v19

    invoke-virtual {v10}, Lcom/android/server/am/ActivitySplitInfo;->getScreenZone()I

    move-result v21

    move/from16 v0, v19

    move/from16 v1, v21

    if-ne v0, v1, :cond_15

    .line 1193
    const-string v19, "SplitWindowManager"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v21

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, " exists and has zone number to come over "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1194
    move-object/from16 v16, v12

    .line 1204
    .end local v12    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_f
    :goto_8
    if-nez v16, :cond_11

    invoke-virtual/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v19

    if-eqz v19, :cond_11

    .line 1205
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    move-object/from16 v19, v0

    invoke-virtual/range {v19 .. v19}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :cond_10
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_11

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1206
    .restart local v12    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget v0, v12, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    move/from16 v19, v0

    move/from16 v0, v19

    if-ne v0, v13, :cond_10

    .line 1208
    const-string v19, "SplitWindowManager"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v21

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, " exists and just follow source record or focused stack"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1209
    move-object/from16 v16, v12

    .line 1215
    .end local v12    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_11
    if-eqz v16, :cond_18

    .line 1217
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-virtual {v0, v5}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v4

    .line 1218
    .restart local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    move-object/from16 v0, v16

    iget v0, v0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    move/from16 v19, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget v0, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    move/from16 v21, v0

    move/from16 v0, v19

    move/from16 v1, v21

    if-ne v0, v1, :cond_16

    .line 1219
    const-string v19, "SplitWindowManager"

    const-string v21, "just move task to front on same stack."

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1222
    if-eqz v11, :cond_12

    .line 1223
    sget-object v19, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    invoke-direct {v0, v1}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1225
    :cond_12
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    const/16 v21, 0x0

    const/16 v22, 0x0

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    move-object/from16 v2, v22

    invoke-virtual {v4, v0, v1, v2}, Lcom/android/server/am/ActivityStack;->moveTaskToFrontLocked(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityRecord;Landroid/os/Bundle;)V

    .line 1226
    const/16 v19, 0x1

    monitor-exit v20

    goto/16 :goto_0

    .line 1247
    .end local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    .end local v9    # "i$":Ljava/util/Iterator;
    :catchall_0
    move-exception v19

    monitor-exit v20
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v19

    .line 1185
    .end local v8    # "focusedStackId":I
    .end local v13    # "sourceRecordStackId":I
    .end local v16    # "targetSplitAct":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_13
    const/4 v8, -0x1

    goto/16 :goto_6

    .restart local v8    # "focusedStackId":I
    :cond_14
    move v13, v8

    .line 1186
    goto/16 :goto_7

    .line 1196
    .restart local v9    # "i$":Ljava/util/Iterator;
    .restart local v12    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .restart local v13    # "sourceRecordStackId":I
    .restart local v16    # "targetSplitAct":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_15
    if-eqz v11, :cond_e

    :try_start_1
    iget v0, v12, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    move/from16 v19, v0

    move/from16 v0, v19

    if-eq v0, v8, :cond_e

    .line 1197
    const-string v19, "SplitWindowManager"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "find "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, " as opposite screen to be split for "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1199
    move-object/from16 v16, v12

    .line 1200
    goto/16 :goto_8

    .line 1228
    .end local v12    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .restart local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    :cond_16
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget v0, v0, Lcom/android/server/am/TaskRecord;->taskId:I

    move/from16 v19, v0

    move-object/from16 v0, v16

    iget v0, v0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    move/from16 v21, v0

    const/16 v22, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v19

    move/from16 v2, v21

    move/from16 v3, v22

    invoke-direct {v0, v1, v2, v3}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(IIZ)Z

    .line 1231
    if-eqz v11, :cond_17

    .line 1232
    sget-object v19, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    invoke-direct {v0, v1}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1234
    :cond_17
    const/16 v19, 0x1

    monitor-exit v20

    goto/16 :goto_0

    .line 1235
    .end local v4    # "currentStack":Lcom/android/server/am/ActivityStack;
    :cond_18
    if-eqz v11, :cond_1a

    .line 1236
    const-string v19, "SplitWindowManager"

    const-string v21, "then we need to create stack and move task to there."

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1237
    invoke-direct/range {p0 .. p0}, Lcom/android/server/am/SplitWindowManager;->createStack()Lcom/android/server/am/ActivityStack;

    move-result-object v14

    .line 1238
    .local v14, "stack":Lcom/android/server/am/ActivityStack;
    if-nez v14, :cond_19

    .line 1239
    const-string v19, "SplitWindowManager"

    const-string v21, "Unable to create stack"

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1240
    const/16 v19, 0x0

    monitor-exit v20

    goto/16 :goto_0

    .line 1243
    :cond_19
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    move-object/from16 v19, v0

    const/16 v21, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    move/from16 v2, v21

    invoke-direct {v0, v1, v14, v2}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    .line 1244
    sget-object v19, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    invoke-direct {v0, v1}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1245
    const/16 v19, 0x1

    monitor-exit v20

    goto/16 :goto_0

    .line 1247
    .end local v14    # "stack":Lcom/android/server/am/ActivityStack;
    :cond_1a
    monitor-exit v20
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_5
.end method

.method public checkIsMultipleInstanceStart(Lcom/android/server/am/ActivityRecord;)Z
    .locals 14
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v10, 0x0

    .line 1978
    const/4 v0, 0x0

    .line 1979
    .local v0, "bIsMultipleStart":Z
    iget-object v11, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    invoke-direct {p0, v11}, Lcom/android/server/am/SplitWindowManager;->getMultipleTaskCountInTaskHistory(Ljava/lang/String;)I

    move-result v7

    .line 1980
    .local v7, "runningMultipleCount":I
    const-string v11, "SplitWindowManager"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "Activity is support multiple ? "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    iget-object v13, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v13}, Lcom/android/server/am/ActivitySplitInfo;->isSupportMultipleInstance()Z

    move-result v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, ", runningMultipleCount( "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    iget-object v13, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, ") : "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1982
    const/4 v11, 0x2

    if-gt v7, v11, :cond_0

    iget-object v11, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v11}, Lcom/android/server/am/ActivitySplitInfo;->isSupportMultipleInstance()Z

    move-result v11

    if-nez v11, :cond_1

    .line 2016
    :cond_0
    :goto_0
    return v10

    .line 1984
    :cond_1
    if-gez v7, :cond_2

    .line 1985
    const-string v11, "SplitWindowManager"

    const-string v12, "There are already two tasks in one stack."

    invoke-static {v11, v12}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1988
    :cond_2
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v10

    if-eqz v10, :cond_4

    .line 1989
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v10}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v2

    .line 1990
    .local v2, "focusedStack":Lcom/android/server/am/ActivityStack;
    if-eqz v2, :cond_3

    .line 1991
    iget v8, v2, Lcom/android/server/am/ActivityStack;->mStackId:I

    .line 1992
    .local v8, "sourceStackId":I
    invoke-direct {p0, v8}, Lcom/android/server/am/SplitWindowManager;->getOtherStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v4

    .line 1993
    .local v4, "otherStack":Lcom/android/server/am/ActivityStack;
    if-eqz v4, :cond_3

    .line 1994
    invoke-virtual {v4}, Lcom/android/server/am/ActivityStack;->topTask()Lcom/android/server/am/TaskRecord;

    move-result-object v5

    .line 1995
    .local v5, "otherStackTopTask":Lcom/android/server/am/TaskRecord;
    if-eqz v5, :cond_3

    .line 1996
    iget-object v10, v5, Lcom/android/server/am/TaskRecord;->realActivity:Landroid/content/ComponentName;

    invoke-virtual {v10}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 1997
    .local v3, "otherRealActivity":Ljava/lang/String;
    if-eqz v3, :cond_3

    iget-object v10, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    invoke-virtual {v3, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 1998
    const/4 v0, 0x1

    .line 1999
    const-string v10, "SplitWindowManager"

    const-string v11, "Multiple Instance start is true with SplitWindow state."

    invoke-static {v10, v11}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .end local v2    # "focusedStack":Lcom/android/server/am/ActivityStack;
    .end local v3    # "otherRealActivity":Ljava/lang/String;
    .end local v4    # "otherStack":Lcom/android/server/am/ActivityStack;
    .end local v5    # "otherStackTopTask":Lcom/android/server/am/TaskRecord;
    .end local v8    # "sourceStackId":I
    :cond_3
    :goto_1
    move v10, v0

    .line 2016
    goto :goto_0

    .line 2005
    :cond_4
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v10}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v1

    .line 2006
    .local v1, "currentStack":Lcom/android/server/am/ActivityStack;
    invoke-virtual {v1}, Lcom/android/server/am/ActivityStack;->topTask()Lcom/android/server/am/TaskRecord;

    move-result-object v9

    .line 2007
    .local v9, "topTask":Lcom/android/server/am/TaskRecord;
    if-eqz v9, :cond_3

    .line 2008
    iget-object v10, v9, Lcom/android/server/am/TaskRecord;->realActivity:Landroid/content/ComponentName;

    invoke-virtual {v10}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v6

    .line 2009
    .local v6, "realActivity":Ljava/lang/String;
    if-eqz v6, :cond_3

    iget-object v10, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    invoke-virtual {v6, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 2010
    const/4 v0, 0x1

    .line 2011
    const-string v10, "SplitWindowManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Multiple Instance start is true without SplitWindow state. realActivity : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", r.packageName : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p1, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public checkPauseBackStack(Lcom/android/server/am/ActivityStack;)Z
    .locals 8
    .param p1, "stack"    # Lcom/android/server/am/ActivityStack;

    .prologue
    const/4 v3, 0x0

    .line 1006
    iget v4, p1, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-nez v4, :cond_1

    .line 1007
    iget-object v1, p1, Lcom/android/server/am/ActivityStack;->mResumedActivity:Lcom/android/server/am/ActivityRecord;

    .line 1008
    .local v1, "r":Lcom/android/server/am/ActivityRecord;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/android/server/am/ActivityRecord;->isRecentsActivity()Z

    move-result v4

    if-eqz v4, :cond_0

    sget-object v4, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1009
    const-string v4, "SplitWindowManager"

    const-string v5, "recent is going down..."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1010
    sget-object v4, Lcom/android/server/am/SplitWindowManager$State;->SPLITED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v4}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1040
    .end local v1    # "r":Lcom/android/server/am/ActivityRecord;
    :cond_0
    :goto_0
    return v3

    .line 1015
    :cond_1
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v4

    sget-object v5, Lcom/android/server/am/SplitWindowManager$State;->PREPARED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v4, v5}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v4

    sget-object v5, Lcom/android/server/am/SplitWindowManager$State;->REQUESTED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v4, v5}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1018
    :cond_2
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v4

    .line 1019
    :try_start_0
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1020
    .local v2, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    iget v5, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    iget v6, p1, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-ne v5, v6, :cond_3

    invoke-virtual {v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isRequested()Z

    move-result v5

    if-nez v5, :cond_4

    invoke-virtual {v2}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isSplited()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 1024
    :cond_4
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v5

    if-eqz v5, :cond_6

    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    if-eqz v5, :cond_6

    .line 1025
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v5, v5, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v5

    if-nez v5, :cond_5

    .line 1026
    const-string v5, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "FullScreen is coming, go PAUSE "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1027
    monitor-exit v4

    goto :goto_0

    .line 1037
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3

    .line 1028
    .restart local v0    # "i$":Ljava/util/Iterator;
    .restart local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_5
    :try_start_1
    sget-object v5, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 1029
    const-string v5, "SplitWindowManager"

    const-string v6, "RecentApp is coming"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1030
    monitor-exit v4

    goto/16 :goto_0

    .line 1033
    :cond_6
    const-string v3, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/android/server/am/ActivityStack;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " is a part of split screen. It would not be paused"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1034
    const/4 v3, 0x1

    monitor-exit v4

    goto/16 :goto_0

    .line 1037
    .end local v2    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_7
    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_0
.end method

.method public completePause(Lcom/android/server/am/ActivityRecord;)V
    .locals 5
    .param p1, "pausedActivity"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 934
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

    if-eqz v2, :cond_0

    if-eqz p1, :cond_0

    .line 935
    iget-object v1, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    .line 938
    .local v1, "pausedTask":Lcom/android/server/am/TaskRecord;
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

    invoke-virtual {v2, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 939
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v0

    .line 940
    .local v0, "focusedStack":Lcom/android/server/am/ActivityStack;
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

    iget-object v2, v2, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    if-eq v0, v2, :cond_1

    .line 941
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Task of paused "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " is moving to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 942
    const/4 v2, 0x0

    invoke-direct {p0, v1, v0, v2}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    .line 946
    :goto_0
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

    .line 951
    .end local v0    # "focusedStack":Lcom/android/server/am/ActivityStack;
    .end local v1    # "pausedTask":Lcom/android/server/am/TaskRecord;
    :cond_0
    :goto_1
    return-void

    .line 944
    .restart local v0    # "focusedStack":Lcom/android/server/am/ActivityStack;
    .restart local v1    # "pausedTask":Lcom/android/server/am/TaskRecord;
    :cond_1
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Task of paused "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " is on focused stack. skip moving."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 948
    .end local v0    # "focusedStack":Lcom/android/server/am/ActivityStack;
    :cond_2
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

    invoke-virtual {v4}, Lcom/android/server/am/TaskRecord;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " is still wait to be paused"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public dumpStackTrace()V
    .locals 7

    .prologue
    .line 1785
    const-string v4, "SplitWindowManager"

    const-string v5, " # getStackTrace of current thread for debug (THIS IS NOT AN EXCEPTION!)"

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1786
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/StackTraceElement;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_0

    aget-object v1, v0, v2

    .line 1787
    .local v1, "element":Ljava/lang/StackTraceElement;
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\t"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v1}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1786
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1789
    .end local v1    # "element":Ljava/lang/StackTraceElement;
    :cond_0
    return-void
.end method

.method public ensureActivitiesVisibleLocked(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;I)V
    .locals 4
    .param p1, "top"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "starting"    # Lcom/android/server/am/ActivityRecord;
    .param p3, "configChanges"    # I

    .prologue
    .line 717
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->isNativeMode()Z

    move-result v0

    if-nez v0, :cond_0

    if-eqz p2, :cond_0

    const-string v1, "SplitWindowManager"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ensureVisible on stack#"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz p1, :cond_2

    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v0, :cond_2

    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    if-eqz v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v3, v3, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v3, v3, Lcom/android/server/am/ActivityStack;->mStackId:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "/starting:"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 721
    :cond_0
    if-ne p1, p2, :cond_3

    .line 722
    invoke-direct {p0, p1, p2}, Lcom/android/server/am/SplitWindowManager;->ensureFocusedStackVisible(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;)V

    .line 728
    :cond_1
    :goto_1
    return-void

    .line 717
    :cond_2
    const-string v0, "-1 "

    goto :goto_0

    .line 723
    :cond_3
    if-eqz p2, :cond_1

    .line 724
    invoke-direct {p0, p1, p2}, Lcom/android/server/am/SplitWindowManager;->ensureOppositeStackVisible(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;)V

    goto :goto_1
.end method

.method public exitSplitWindow()V
    .locals 1

    .prologue
    .line 2057
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2058
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v0}, Lcom/android/server/am/ActivityStackSupervisor;->getFocusedStack()Lcom/android/server/am/ActivityStack;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/server/am/SplitWindowManager;->moveStackToFront(Lcom/android/server/am/ActivityStack;)Z

    .line 2059
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    .line 2061
    :cond_0
    return-void
.end method

.method final getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    .locals 1

    .prologue
    .line 1338
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitPolicy:Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    if-eqz v0, :cond_0

    .line 1339
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitPolicy:Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    .line 1342
    :goto_0
    return-object v0

    .line 1341
    :cond_0
    invoke-static {}, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->getPolicyService()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitPolicy:Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    .line 1342
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mSplitPolicy:Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    goto :goto_0
.end method

.method public isMultipleStartedActivity(Lcom/android/server/am/ActivityRecord;)Z
    .locals 5
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v3, 0x0

    .line 2043
    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    if-eqz v4, :cond_0

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-nez v4, :cond_2

    :cond_0
    move v2, v3

    .line 2053
    :cond_1
    :goto_0
    return v2

    .line 2046
    :cond_2
    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    .line 2047
    .local v0, "intent":Landroid/content/Intent;
    const/4 v2, 0x0

    .line 2048
    .local v2, "result":Z
    if-eqz v0, :cond_1

    .line 2049
    invoke-virtual {v0}, Landroid/content/Intent;->getFlags()I

    move-result v1

    .line 2050
    .local v1, "launchFlags":I
    const/high16 v4, 0x8000000

    and-int/2addr v4, v1

    if-eqz v4, :cond_3

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4}, Lcom/android/server/am/ActivitySplitInfo;->isSupportMultipleInstance()Z

    move-result v4

    if-eqz v4, :cond_3

    const/4 v2, 0x1

    :goto_1
    goto :goto_0

    :cond_3
    move v2, v3

    goto :goto_1
.end method

.method public isSplitMode()Z
    .locals 2

    .prologue
    .line 270
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager;->mState:Lcom/android/server/am/SplitWindowManager$State;

    sget-object v1, Lcom/android/server/am/SplitWindowManager$State;->SPLITED:Lcom/android/server/am/SplitWindowManager$State;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isStackNeedResumed(Lcom/android/server/am/ActivityStack;)Z
    .locals 7
    .param p1, "stack"    # Lcom/android/server/am/ActivityStack;

    .prologue
    const/4 v2, 0x0

    .line 1830
    if-nez p1, :cond_0

    .line 1863
    :goto_0
    return v2

    .line 1834
    :cond_0
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v3

    .line 1835
    :try_start_0
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1836
    .local v1, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_1

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v4

    sget-object v5, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v4, v5}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget v4, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    iget v5, p1, Lcom/android/server/am/ActivityStack;->mStackId:I

    if-ne v4, v5, :cond_1

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isSplited()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isRequested()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1840
    :cond_2
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " is a part of Splited screen for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1842
    sget-object v4, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1843
    const-string v4, "SplitWindowManager"

    const-string v5, "but, RECENTAPP is on Top."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1844
    monitor-exit v3

    goto :goto_0

    .line 1861
    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 1845
    .restart local v0    # "i$":Ljava/util/Iterator;
    .restart local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_3
    :try_start_1
    sget-object v4, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 1846
    const-string v4, "SplitWindowManager"

    const-string v5, "but, it\'s INVISIBLE."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1847
    monitor-exit v3

    goto :goto_0

    .line 1848
    :cond_4
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    if-eqz v4, :cond_5

    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v4, v4, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v4, :cond_5

    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v4, v4, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v4

    if-nez v4, :cond_5

    .line 1850
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-boolean v4, v4, Lcom/android/server/am/ActivityRecord;->finishing:Z

    if-eqz v4, :cond_6

    .line 1851
    const-string v2, "SplitWindowManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mPreparedActivity is finishing. ignore and remove... "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1852
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    .line 1858
    :cond_5
    const/4 v2, 0x1

    monitor-exit v3

    goto/16 :goto_0

    .line 1854
    :cond_6
    const-string v4, "SplitWindowManager"

    const-string v5, "but, fullScreen is coming"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1855
    monitor-exit v3

    goto/16 :goto_0

    .line 1861
    .end local v1    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_7
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_0
.end method

.method public isStackVisible(Lcom/android/server/am/ActivityStack;)Z
    .locals 9
    .param p1, "stack"    # Lcom/android/server/am/ActivityStack;

    .prologue
    const/4 v5, 0x0

    .line 1800
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v6

    sget-object v7, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v6, v7}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    move v2, v5

    .line 1826
    :cond_0
    :goto_0
    return v2

    .line 1804
    :cond_1
    invoke-virtual {p0, p1}, Lcom/android/server/am/SplitWindowManager;->isStackNeedResumed(Lcom/android/server/am/ActivityStack;)Z

    move-result v2

    .line 1805
    .local v2, "needResume":Z
    if-nez v2, :cond_0

    .line 1806
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v6}, Lcom/android/server/am/ActivityStackSupervisor;->topRunningActivityLocked()Lcom/android/server/am/ActivityRecord;

    move-result-object v1

    .line 1808
    .local v1, "focusTopActivity":Lcom/android/server/am/ActivityRecord;
    if-eqz v1, :cond_0

    iget-object v6, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v6, :cond_0

    .line 1809
    if-eqz p1, :cond_0

    invoke-virtual {v1}, Lcom/android/server/am/ActivityRecord;->isApplicationActivity()Z

    move-result v6

    if-eqz v6, :cond_0

    iget-boolean v6, v1, Lcom/android/server/am/ActivityRecord;->fullscreen:Z

    if-nez v6, :cond_0

    .line 1810
    const/4 v6, 0x0

    invoke-virtual {p1, v6}, Lcom/android/server/am/ActivityStack;->topRunningActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/ActivityRecord;

    move-result-object v4

    .line 1811
    .local v4, "stackTopActivity":Lcom/android/server/am/ActivityRecord;
    if-eq v1, v4, :cond_0

    .line 1812
    iget-object v0, v1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    .line 1814
    .local v0, "focusTask":Lcom/android/server/am/TaskRecord;
    invoke-virtual {v0, v1}, Lcom/android/server/am/TaskRecord;->topRunningActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/ActivityRecord;

    move-result-object v3

    .line 1815
    .local v3, "sourceActivity":Lcom/android/server/am/ActivityRecord;
    if-eqz v3, :cond_2

    iget-object v6, v3, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v6, :cond_2

    iget-object v6, v3, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v6}, Lcom/android/server/am/ActivitySplitInfo;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v6

    sget-object v7, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_FULL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v6, v7}, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 1817
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "source activity "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is SPLITED_FULL. Does not need show "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v5

    .line 1818
    goto :goto_0

    .line 1820
    :cond_2
    const-string v5, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "not full screen Activity case. focusTopActivity : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", stackTopActivity : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1821
    const/4 v2, 0x1

    goto/16 :goto_0
.end method

.method isSupportSplit(Landroid/content/ComponentName;)Z
    .locals 6
    .param p1, "component"    # Landroid/content/ComponentName;

    .prologue
    .line 1319
    const/4 v0, 0x0

    .line 1320
    .local v0, "bIsSupportSplit":Z
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v2

    .line 1321
    .local v2, "splitWindowPolicy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-eqz v2, :cond_0

    .line 1323
    :try_start_0
    invoke-interface {v2, p1}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->supportSplitWindowByClass(Landroid/content/ComponentName;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 1330
    :goto_0
    return v0

    .line 1324
    :catch_0
    move-exception v1

    .line 1325
    .local v1, "e":Landroid/os/RemoteException;
    const-string v3, "SplitWindowManager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "can\'t find SplitWindowPolicyService: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1328
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v3, "SplitWindowManager"

    const-string v4, "can\'t find SplitWindowPolicyService."

    invoke-static {v3, v4}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public moveTaskToFrontByApp(ILcom/android/server/am/TaskRecord;I)Z
    .locals 5
    .param p1, "callingPid"    # I
    .param p2, "task"    # Lcom/android/server/am/TaskRecord;
    .param p3, "flags"    # I

    .prologue
    .line 2069
    const/4 v0, 0x0

    .line 2070
    .local v0, "didSomething":Z
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 2071
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v3}, Lcom/android/server/am/ActivityStackSupervisor;->topRunningActivityLocked()Lcom/android/server/am/ActivityRecord;

    move-result-object v2

    .line 2073
    .local v2, "focusedTopActivity":Lcom/android/server/am/ActivityRecord;
    if-eqz v2, :cond_0

    iget-object v3, v2, Lcom/android/server/am/ActivityRecord;->app:Lcom/android/server/am/ProcessRecord;

    if-eqz v3, :cond_0

    iget-object v3, v2, Lcom/android/server/am/ActivityRecord;->app:Lcom/android/server/am/ProcessRecord;

    iget v3, v3, Lcom/android/server/am/ProcessRecord;->pid:I

    if-ne v3, p1, :cond_0

    .line 2076
    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->findActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 2077
    .local v1, "focusedSplitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz p2, :cond_0

    iget-object v3, p2, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v3, v3, Lcom/android/server/am/ActivityStack;->mStackId:I

    iget v4, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    if-eq v3, v4, :cond_0

    .line 2078
    iget-object v3, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v3, v3, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    const/4 v4, 0x1

    invoke-direct {p0, p2, v3, v4}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    move-result v0

    .line 2079
    const/4 v0, 0x1

    .line 2084
    .end local v1    # "focusedSplitActivity":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    .end local v2    # "focusedTopActivity":Lcom/android/server/am/ActivityRecord;
    :cond_0
    return v0
.end method

.method public prepareSplitWindowLocked(Lcom/android/server/am/ActivityRecord;Landroid/content/Intent;Lcom/android/server/am/ActivityRecord;)V
    .locals 5
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "intent"    # Landroid/content/Intent;
    .param p3, "sourceRecord"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 360
    if-nez p3, :cond_1

    const/4 v2, 0x0

    :goto_0
    invoke-direct {p0, p2, v2}, Lcom/android/server/am/SplitWindowManager;->checkScreen(Landroid/content/Intent;Landroid/content/Intent;)Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;

    move-result-object v1

    .line 361
    .local v1, "screen":Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;
    if-nez v1, :cond_2

    .line 415
    :cond_0
    :goto_1
    return-void

    .line 360
    .end local v1    # "screen":Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;
    :cond_1
    iget-object v2, p3, Lcom/android/server/am/ActivityRecord;->intent:Landroid/content/Intent;

    goto :goto_0

    .line 365
    .restart local v1    # "screen":Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;
    :cond_2
    invoke-direct {p0, p1, v1}, Lcom/android/server/am/SplitWindowManager;->attachSplitInfo(Lcom/android/server/am/ActivityRecord;Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;)V

    .line 367
    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityStackSupervisor;->isInLockTaskMode()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 368
    const-string v2, "SplitWindowManager"

    const-string v3, "it\'s LockTaskMode."

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 372
    :cond_3
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 373
    invoke-virtual {p1}, Lcom/android/server/am/ActivityRecord;->isHomeActivity()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 374
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    .line 380
    :cond_4
    :goto_2
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 381
    const-string v2, "SplitWindowManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "update mPreparedActivity = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 382
    iput-object p1, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    .line 384
    invoke-virtual {p1}, Lcom/android/server/am/ActivityRecord;->isRecentsActivity()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 385
    const-string v2, "SplitWindowManager"

    const-string v3, "GET READY FOR RECENT!____"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 386
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    goto :goto_1

    .line 375
    :cond_5
    invoke-virtual {p1}, Lcom/android/server/am/ActivityRecord;->isRecentsActivity()Z

    move-result v2

    if-nez v2, :cond_4

    .line 376
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->SPLITED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    goto :goto_2

    .line 388
    :cond_6
    invoke-interface {v1}, Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;->getScreenZone()I

    move-result v2

    if-eqz v2, :cond_0

    .line 390
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getFocusedTopActivitySplitInfo()Lcom/android/server/am/ActivitySplitInfo;

    move-result-object v0

    .line 394
    .local v0, "currentTopInfo":Lcom/android/server/am/ActivitySplitInfo;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->canBeSplited()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 395
    sget-object v2, Lcom/android/server/am/SplitWindowManager$State;->REQUESTED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 396
    iget-object v2, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v2}, Lcom/android/server/am/ActivitySplitInfo;->setRequested()Z

    .line 397
    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setRequested()Z

    .line 399
    const-string v2, "SplitWindowManager"

    const-string v3, "GET READY FOR SPLIT!____"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 400
    const-string v2, "SplitWindowManager"

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getDumpstate()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1
.end method

.method public removeStackAndNeedHomeResume(Lcom/android/server/am/ActivityStack;)Z
    .locals 8
    .param p1, "stack"    # Lcom/android/server/am/ActivityStack;

    .prologue
    .line 1697
    const/4 v2, 0x1

    .line 1698
    .local v2, "needResumeHome":Z
    const/4 v1, 0x0

    .line 1699
    .local v1, "isSplitActivityRemoved":Z
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "removeStackAndNeedHomeResume "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1700
    iget-object v5, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v5

    .line 1701
    if-eqz p1, :cond_0

    .line 1702
    :try_start_0
    iget v4, p1, Lcom/android/server/am/ActivityStack;->mStackId:I

    invoke-direct {p0, v4}, Lcom/android/server/am/SplitWindowManager;->removeSplitActivityForStackIdLocked(I)Z

    move-result v1

    .line 1705
    :cond_0
    if-eqz v1, :cond_1

    sget-object v4, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v6

    invoke-virtual {v4, v6}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1707
    const-string v4, "SplitWindowManager"

    const-string v6, "it\'s splited but, a split-activity has been removed."

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1708
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    .line 1709
    const/4 v4, 0x1

    invoke-direct {p0, v4}, Lcom/android/server/am/SplitWindowManager;->checkAndSetCurrentStateIfNeeded(Z)V

    .line 1711
    const/4 v4, 0x0

    monitor-exit v5

    .line 1726
    :goto_0
    return v4

    .line 1715
    :cond_1
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1716
    .local v3, "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    invoke-virtual {v3}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v4

    sget-object v6, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->UN_SPLITING:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v4, v6, :cond_3

    .line 1717
    const-string v4, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " is UN_SPLITING... not resume home"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1718
    const/4 v2, 0x0

    goto :goto_1

    .line 1719
    :cond_3
    invoke-virtual {v3}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->isNative()Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-boolean v4, v4, Lcom/android/server/am/ActivityRecord;->finishing:Z

    if-nez v4, :cond_2

    .line 1721
    const-string v4, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " is NATIVE and RESUMED now, not sure that home should not be resumed..."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1722
    const/4 v2, 0x0

    goto :goto_1

    .line 1725
    .end local v3    # "sa":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_4
    monitor-exit v5

    move v4, v2

    .line 1726
    goto :goto_0

    .line 1725
    .end local v0    # "i$":Ljava/util/Iterator;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4
.end method

.method public replaceExistActivity(Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;)Z
    .locals 10
    .param p1, "source"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "exist"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    const/4 v9, 0x0

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 1057
    if-eqz p1, :cond_0

    if-nez p2, :cond_2

    .line 1058
    :cond_0
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->isNativeMode()Z

    move-result v5

    if-nez v5, :cond_1

    const-string v5, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "replaceExistActivity has null as arg: source= "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "/ exist= "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1116
    :cond_1
    :goto_0
    return v4

    .line 1062
    :cond_2
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {p1, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1063
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v6}, Lcom/android/server/am/ActivityStackSupervisor;->topRunningActivityLocked()Lcom/android/server/am/ActivityRecord;

    move-result-object v3

    .line 1064
    .local v3, "top":Lcom/android/server/am/ActivityRecord;
    if-eqz v3, :cond_6

    invoke-virtual {v3, p2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 1065
    const-string v6, "SplitWindowManager"

    const-string v7, "already resumed, remove mPreparedActivity"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1066
    iput-object v9, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    .line 1073
    .end local v3    # "top":Lcom/android/server/am/ActivityRecord;
    :cond_3
    :goto_1
    invoke-virtual {p1}, Lcom/android/server/am/ActivityRecord;->isHomeActivity()Z

    move-result v6

    if-nez v6, :cond_1

    .line 1077
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v6

    if-eqz v6, :cond_9

    .line 1078
    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v6}, Lcom/android/server/am/ActivitySplitInfo;->getScreenZone()I

    move-result v2

    .line 1079
    .local v2, "targetZone":I
    if-eq v2, v5, :cond_4

    const/4 v6, 0x2

    if-ne v2, v6, :cond_7

    .line 1080
    :cond_4
    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4, v2}, Lcom/android/server/am/ActivitySplitInfo;->setScreenZone(I)V

    .line 1115
    .end local v2    # "targetZone":I
    :cond_5
    :goto_2
    const-string v4, "SplitWindowManager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "findTaskLocked set "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " to "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    move v4, v5

    .line 1116
    goto :goto_0

    .line 1068
    .restart local v3    # "top":Lcom/android/server/am/ActivityRecord;
    :cond_6
    const-string v6, "SplitWindowManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "change mPreparedActivity("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ") to exist("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ")"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1069
    iput-object p2, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    goto :goto_1

    .line 1082
    .end local v3    # "top":Lcom/android/server/am/ActivityRecord;
    .restart local v2    # "targetZone":I
    :cond_7
    iget-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v6

    .line 1083
    :try_start_0
    invoke-direct {p0, p2}, Lcom/android/server/am/SplitWindowManager;->findActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 1084
    .local v1, "splitTop":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_8

    invoke-virtual {v1}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getCurrentScreenZone()I

    move-result v2

    .line 1085
    :goto_3
    monitor-exit v6
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1086
    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4, v2}, Lcom/android/server/am/ActivitySplitInfo;->setScreenZone(I)V

    goto :goto_2

    :cond_8
    move v2, v4

    .line 1084
    goto :goto_3

    .line 1085
    .end local v1    # "splitTop":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :catchall_0
    move-exception v4

    :try_start_1
    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v4

    .line 1088
    .end local v2    # "targetZone":I
    :cond_9
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v6

    sget-object v7, Lcom/android/server/am/SplitWindowManager$State;->REQUESTED:Lcom/android/server/am/SplitWindowManager$State;

    invoke-virtual {v6, v7}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 1090
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getFocusedTopActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v0

    .line 1091
    .local v0, "currentTop":Lcom/android/server/am/ActivityRecord;
    if-eqz v0, :cond_a

    invoke-virtual {v0, p2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_a

    invoke-virtual {p0, p1}, Lcom/android/server/am/SplitWindowManager;->isMultipleStartedActivity(Lcom/android/server/am/ActivityRecord;)Z

    move-result v6

    if-nez v6, :cond_a

    .line 1093
    sget-object v5, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v5}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1094
    iget-object v5, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v5}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    .line 1095
    iget-object v5, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v5}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    goto/16 :goto_0

    .line 1102
    :cond_a
    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v4, :cond_b

    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4, v9}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v4

    if-nez v4, :cond_b

    .line 1103
    const-string v4, "SplitWindowManager"

    const-string v6, "exist top is not support split. cancel it"

    invoke-static {v4, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1104
    sget-object v4, Lcom/android/server/am/SplitWindowManager$State;->NORMAL:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0, v4}, Lcom/android/server/am/SplitWindowManager;->setSplitMode(Lcom/android/server/am/SplitWindowManager$State;)V

    .line 1105
    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    .line 1106
    iget-object v4, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    .line 1108
    :cond_b
    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v4, :cond_5

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4}, Lcom/android/server/am/ActivitySplitInfo;->isRequested()Z

    move-result v4

    if-eqz v4, :cond_5

    .line 1111
    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    iget-object v6, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v6}, Lcom/android/server/am/ActivitySplitInfo;->getScreenZone()I

    move-result v6

    invoke-virtual {v4, v6}, Lcom/android/server/am/ActivitySplitInfo;->setScreenZone(I)V

    .line 1112
    iget-object v4, p2, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v4}, Lcom/android/server/am/ActivitySplitInfo;->setRequested()Z

    goto/16 :goto_2
.end method

.method public setFocusedStack(Z)V
    .locals 2
    .param p1, "homeToFront"    # Z

    .prologue
    .line 1675
    if-eqz p1, :cond_0

    .line 1676
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1677
    sget-object v0, Lcom/android/server/am/SplitWindowManager$State;->RECENTAPP:Lcom/android/server/am/SplitWindowManager$State;

    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->getSplitState()Lcom/android/server/am/SplitWindowManager$State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/am/SplitWindowManager$State;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1685
    :cond_0
    :goto_0
    return-void

    .line 1682
    :cond_1
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    goto :goto_0
.end method

.method public shouldResumeHome(Lcom/android/server/am/ActivityStack;Lcom/android/server/am/TaskRecord;)Z
    .locals 13
    .param p1, "stack"    # Lcom/android/server/am/ActivityStack;
    .param p2, "taskToBack"    # Lcom/android/server/am/TaskRecord;

    .prologue
    const/4 v5, 0x0

    const/4 v9, 0x0

    const/4 v8, 0x1

    .line 848
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v10

    if-nez v10, :cond_1

    if-nez p2, :cond_1

    .line 930
    :cond_0
    :goto_0
    return v8

    .line 850
    :cond_1
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->isSplitMode()Z

    move-result v10

    if-nez v10, :cond_9

    .line 852
    invoke-virtual {p2}, Lcom/android/server/am/TaskRecord;->isOverHomeStack()Z

    move-result v10

    if-nez v10, :cond_0

    .line 857
    if-eqz p1, :cond_3

    invoke-virtual {p1}, Lcom/android/server/am/ActivityStack;->topActivity()Lcom/android/server/am/ActivityRecord;

    move-result-object v6

    .line 858
    .local v6, "topActivity":Lcom/android/server/am/ActivityRecord;
    :goto_1
    if-eqz v6, :cond_4

    iget-object v7, v6, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    .line 861
    .local v7, "topTask":Lcom/android/server/am/TaskRecord;
    :goto_2
    if-eqz v6, :cond_0

    iget-object v10, v6, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v10, :cond_0

    iget-object v10, v6, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    invoke-virtual {v10}, Lcom/android/server/am/TaskRecord;->getTaskToReturnTo()I

    move-result v10

    if-nez v10, :cond_0

    .line 863
    const/4 v3, 0x0

    .line 864
    .local v3, "stackIdToFront":I
    iget-object v10, p1, Lcom/android/server/am/ActivityStack;->mStacks:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    add-int/lit8 v4, v10, -0x1

    .local v4, "stackNdx":I
    :goto_3
    if-ltz v4, :cond_6

    .line 865
    iget-object v10, p1, Lcom/android/server/am/ActivityStack;->mStacks:Ljava/util/ArrayList;

    invoke-virtual {v10, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/am/ActivityStack;

    .line 866
    .local v0, "nextStack":Lcom/android/server/am/ActivityStack;
    if-eqz v0, :cond_2

    invoke-virtual {p1, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_2

    invoke-virtual {v0}, Lcom/android/server/am/ActivityStack;->isHomeStack()Z

    move-result v10

    if-nez v10, :cond_2

    iget-object v10, v0, Lcom/android/server/am/ActivityStack;->mTaskHistory:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-nez v10, :cond_5

    .line 864
    :cond_2
    add-int/lit8 v4, v4, -0x1

    goto :goto_3

    .end local v0    # "nextStack":Lcom/android/server/am/ActivityStack;
    .end local v3    # "stackIdToFront":I
    .end local v4    # "stackNdx":I
    .end local v6    # "topActivity":Lcom/android/server/am/ActivityRecord;
    .end local v7    # "topTask":Lcom/android/server/am/TaskRecord;
    :cond_3
    move-object v6, v5

    .line 857
    goto :goto_1

    .restart local v6    # "topActivity":Lcom/android/server/am/ActivityRecord;
    :cond_4
    move-object v7, v5

    .line 858
    goto :goto_2

    .line 872
    .restart local v0    # "nextStack":Lcom/android/server/am/ActivityStack;
    .restart local v3    # "stackIdToFront":I
    .restart local v4    # "stackNdx":I
    .restart local v7    # "topTask":Lcom/android/server/am/TaskRecord;
    :cond_5
    if-lez v3, :cond_8

    .line 876
    .end local v0    # "nextStack":Lcom/android/server/am/ActivityStack;
    :cond_6
    :goto_4
    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    invoke-virtual {v10, v3}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v0

    .line 877
    .restart local v0    # "nextStack":Lcom/android/server/am/ActivityStack;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/server/am/ActivityStack;->isHomeStack()Z

    move-result v10

    if-nez v10, :cond_0

    .line 879
    iget-object v10, p1, Lcom/android/server/am/ActivityStack;->mTaskHistory:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-ne v10, v8, :cond_7

    invoke-virtual {p2, v7}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 881
    const-string v8, "SplitWindowManager"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " is only task on "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", to move it back to "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 882
    invoke-direct {p0, p2, v0, v9}, Lcom/android/server/am/SplitWindowManager;->moveTaskToStack(Lcom/android/server/am/TaskRecord;Lcom/android/server/am/ActivityStack;Z)Z

    .line 884
    :cond_7
    invoke-direct {p0, v0}, Lcom/android/server/am/SplitWindowManager;->moveStackToFront(Lcom/android/server/am/ActivityStack;)Z

    move v8, v9

    .line 885
    goto/16 :goto_0

    .line 872
    :cond_8
    iget v3, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    goto :goto_4

    .line 896
    .end local v0    # "nextStack":Lcom/android/server/am/ActivityStack;
    .end local v3    # "stackIdToFront":I
    .end local v4    # "stackNdx":I
    .end local v6    # "topActivity":Lcom/android/server/am/ActivityRecord;
    .end local v7    # "topTask":Lcom/android/server/am/TaskRecord;
    :cond_9
    iget-object v10, p1, Lcom/android/server/am/ActivityStack;->mResumedActivity:Lcom/android/server/am/ActivityRecord;

    if-eqz v10, :cond_a

    iget-object v2, p1, Lcom/android/server/am/ActivityStack;->mResumedActivity:Lcom/android/server/am/ActivityRecord;

    .line 897
    .local v2, "prev":Lcom/android/server/am/ActivityRecord;
    :goto_5
    if-nez v2, :cond_b

    .line 898
    const-string v9, "SplitWindowManager"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "shouldResumeHome doesnt know what to do... with "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {p1}, Lcom/android/server/am/ActivityStack;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ". Just go home."

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 896
    .end local v2    # "prev":Lcom/android/server/am/ActivityRecord;
    :cond_a
    iget-object v2, p1, Lcom/android/server/am/ActivityStack;->mLastPausedActivity:Lcom/android/server/am/ActivityRecord;

    goto :goto_5

    .line 903
    .restart local v2    # "prev":Lcom/android/server/am/ActivityRecord;
    :cond_b
    const-string v10, "SplitWindowManager"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "shouldResumeHome for "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 904
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->putLogState()V

    .line 907
    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->findActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v10

    if-eqz v10, :cond_0

    .line 909
    invoke-direct {p0, v2}, Lcom/android/server/am/SplitWindowManager;->findOppositeActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v1

    .line 910
    .local v1, "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v1, :cond_c

    iget-object v10, p0, Lcom/android/server/am/SplitWindowManager;->mStackSupervisor:Lcom/android/server/am/ActivityStackSupervisor;

    iget v11, v1, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {v10, v11}, Lcom/android/server/am/ActivityStackSupervisor;->getStack(I)Lcom/android/server/am/ActivityStack;

    move-result-object v5

    .line 911
    .local v5, "stackToFront":Lcom/android/server/am/ActivityStack;
    :cond_c
    if-eqz v5, :cond_e

    .line 912
    invoke-direct {p0, v5}, Lcom/android/server/am/SplitWindowManager;->moveStackToFront(Lcom/android/server/am/ActivityStack;)Z

    .line 914
    if-eqz p2, :cond_d

    iget-object v8, v2, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v8, v8, Lcom/android/server/am/TaskRecord;->taskId:I

    iget v10, p2, Lcom/android/server/am/TaskRecord;->taskId:I

    if-ne v8, v10, :cond_d

    .line 915
    iput-object p2, p0, Lcom/android/server/am/SplitWindowManager;->mTaskWaitToMove:Lcom/android/server/am/TaskRecord;

    .line 916
    const-string v8, "SplitWindowManager"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "waiting pause "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " to move to other stack."

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 918
    :cond_d
    const-string v8, "SplitWindowManager"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "setFocusedStack for "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 924
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->activitiesToUnSplited()V

    move v8, v9

    .line 925
    goto/16 :goto_0

    .line 920
    :cond_e
    const-string v9, "SplitWindowManager"

    const-string v10, "top activity found on list, but couldn\'t find opposite, then bring Home front."

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method public startActivityLocked(Lcom/android/server/am/ActivityRecord;)V
    .locals 0
    .param p1, "r"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 582
    return-void
.end method

.method public switchUser()V
    .locals 2

    .prologue
    .line 2064
    const-string v0, "SplitWindowManager"

    const-string v1, "switchUser causes exitSplitWindow..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2065
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager;->exitSplitWindow()V

    .line 2066
    return-void
.end method

.method updateActivityState(Lcom/android/server/am/ActivityRecord;Z)V
    .locals 7
    .param p1, "component"    # Lcom/android/server/am/ActivityRecord;
    .param p2, "resumed"    # Z

    .prologue
    const/4 v6, 0x0

    .line 1362
    if-nez p1, :cond_0

    .line 1412
    :goto_0
    return-void

    .line 1366
    :cond_0
    if-eqz p2, :cond_4

    .line 1367
    const/4 v0, 0x0

    .line 1368
    .local v0, "forceNormal":Z
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    if-eqz v3, :cond_5

    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    iget-object v3, v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v3, :cond_5

    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    iget-object v3, v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v3, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 1370
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v4

    .line 1372
    :try_start_0
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    invoke-direct {p0, v3}, Lcom/android/server/am/SplitWindowManager;->updateStartActivityToListLocked(Lcom/android/server/am/SplitWindowManager$SplitActivity;)V

    .line 1373
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    iget-object v3, v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-direct {p0, v3}, Lcom/android/server/am/SplitWindowManager;->findOppositeActivityLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    move-result-object v2

    .line 1374
    .local v2, "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    if-eqz v2, :cond_1

    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    iget-object v3, v3, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v5, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v3, v5}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1375
    iget v3, v2, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-direct {p0, v3}, Lcom/android/server/am/SplitWindowManager;->removeSplitActivityForStackIdLocked(I)Z

    .line 1380
    :cond_1
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mStartingActivity:Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1381
    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1393
    .end local v2    # "opposite":Lcom/android/server/am/SplitWindowManager$SplitActivity;
    :cond_2
    :goto_1
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    if-eqz v3, :cond_3

    .line 1394
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v3, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 1395
    const-string v3, "SplitWindowManager"

    const-string v4, "remove mPreparedActivity"

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1396
    iput-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    .line 1404
    :cond_3
    :goto_2
    invoke-direct {p0, v0}, Lcom/android/server/am/SplitWindowManager;->checkAndSetCurrentStateIfNeeded(Z)V

    .line 1406
    .end local v0    # "forceNormal":Z
    :cond_4
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mHandler:Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

    const/16 v4, 0x1f5

    invoke-virtual {v3, v4}, Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 1407
    .local v1, "msg":Landroid/os/Message;
    iput-object p1, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 1408
    if-eqz p2, :cond_8

    const/4 v3, 0x1

    :goto_3
    iput v3, v1, Landroid/os/Message;->arg1:I

    .line 1409
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mHandler:Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;

    invoke-virtual {v3, v1}, Lcom/android/server/am/SplitWindowManager$SplitWindowManagerHandler;->sendMessage(Landroid/os/Message;)Z

    .line 1411
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager;->putLogState()V

    goto :goto_0

    .line 1381
    .end local v1    # "msg":Landroid/os/Message;
    .restart local v0    # "forceNormal":Z
    :catchall_0
    move-exception v3

    :try_start_1
    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v3

    .line 1382
    :cond_5
    invoke-virtual {p1}, Lcom/android/server/am/ActivityRecord;->isHomeActivity()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 1384
    const/4 v0, 0x1

    goto :goto_1

    .line 1385
    :cond_6
    invoke-virtual {p1}, Lcom/android/server/am/ActivityRecord;->isApplicationActivity()Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p1, Lcom/android/server/am/ActivityRecord;->state:Lcom/android/server/am/ActivityStack$ActivityState;

    sget-object v4, Lcom/android/server/am/ActivityStack$ActivityState;->RESUMED:Lcom/android/server/am/ActivityStack$ActivityState;

    invoke-virtual {v3, v4}, Lcom/android/server/am/ActivityStack$ActivityState;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1387
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager;->mSplitActivityList:Ljava/util/ArrayList;

    monitor-enter v4

    .line 1389
    :try_start_2
    invoke-direct {p0, p1}, Lcom/android/server/am/SplitWindowManager;->updateStartActivityToListLocked(Lcom/android/server/am/ActivityRecord;)Lcom/android/server/am/SplitWindowManager$SplitActivity;

    .line 1390
    monitor-exit v4

    goto :goto_1

    :catchall_1
    move-exception v3

    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v3

    .line 1397
    :cond_7
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v3, v3, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v3, :cond_3

    iget-object v3, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    iget-object v3, v3, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v3, v3, Lcom/android/server/am/TaskRecord;->taskId:I

    iget-object v4, p1, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v4, v4, Lcom/android/server/am/TaskRecord;->taskId:I

    if-ne v3, v4, :cond_3

    .line 1398
    const-string v3, "SplitWindowManager"

    const-string v4, "remove mPreparedActivity"

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1399
    iput-object v6, p0, Lcom/android/server/am/SplitWindowManager;->mPreparedActivity:Lcom/android/server/am/ActivityRecord;

    goto :goto_2

    .line 1408
    .end local v0    # "forceNormal":Z
    .restart local v1    # "msg":Landroid/os/Message;
    :cond_8
    const/4 v3, 0x0

    goto :goto_3
.end method
