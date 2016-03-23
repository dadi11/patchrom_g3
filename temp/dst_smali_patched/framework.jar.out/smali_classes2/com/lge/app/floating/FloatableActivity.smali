.class public abstract Lcom/lge/app/floating/FloatableActivity;
.super Landroid/app/Activity;
.source "FloatableActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;,
        Lcom/lge/app/floating/FloatableActivity$State;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z

.field public static final EXTRA_LAUNCH_AS_FLOATING:Ljava/lang/String; = "com.lge.app.floating.launchAsFloating"

.field private static final EXTRA_LOWPROFILE_HIDE:Ljava/lang/String; = "com.lge.app.floating.lowProfileIsHidden"

.field private static final EXTRA_LOWPROFILE_REQUESTER:Ljava/lang/String; = "com.lge.app.floating.lowProfileRequester"

.field static final EXTRA_OPACITY:Ljava/lang/String; = "com.lge.app.floating.opacity"

.field public static final EXTRA_POSITION:Ljava/lang/String; = "com.lge.app.floating.position"

.field private static final EXTRA_RESTARTED:Ljava/lang/String; = "com.lge.app.floating.restarted"

.field private static final EXTRA_RETURN_FROM_FLOATING:Ljava/lang/String; = "com.lge.app.floating.returnFromFloating"

.field static final PREF_FILE_NAME:Ljava/lang/String; = "com.lge.app.floating.pref"

.field private static final TAG:Ljava/lang/String;

.field static mIsInGuestMode:Z


# instance fields
.field private mActivityName:Ljava/lang/String;

.field private mContentView:Landroid/view/View;

.field private mContentViewParent:Landroid/view/ViewGroup;

.field private mCurrentIntent:Landroid/content/Intent;

.field private mDontFinishActivity:Z

.field mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

.field private mHasActivityResultReceived:Z

.field private mIsAttached:Z

.field private mIsFullScreenInFullMode:Z

.field private mIsRestartedOrNewIntentCalled:Z

.field private mIsSetFullScreenFlag:Z

.field private mIsSwitchToFloatingModeCalled:Z

.field private volatile mIsSwitchingToFloatingMode:Z

.field private mIsWaitingActivityResult:Z

.field private mOldConfig:Landroid/content/res/Configuration;

.field private final mReceiverRegisterInfos:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;",
            ">;"
        }
    .end annotation
.end field

.field private mResources:Landroid/content/res/Resources;

.field private mSavedWindowBackground:Landroid/graphics/drawable/Drawable;

.field private mServiceStartRequested:Z

.field private mState:Lcom/lge/app/floating/FloatableActivity$State;

.field private mTaskId:I

.field private receiverListForUnregister:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;",
            ">;"
        }
    .end annotation
.end field

.field restartActivityhandler:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const-class v0, Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/lge/app/floating/FloatableActivity;->$assertionsDisabled:Z

    sput-boolean v1, Lcom/lge/app/floating/FloatableActivity;->mIsInGuestMode:Z

    const-class v0, Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    return-void

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSetFullScreenFlag:Z

    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->CREATE:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsRestartedOrNewIntentCalled:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mHasActivityResultReceived:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsWaitingActivityResult:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mServiceStartRequested:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsAttached:Z

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mContentViewParent:Landroid/view/ViewGroup;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->receiverListForUnregister:Ljava/util/List;

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mSavedWindowBackground:Landroid/graphics/drawable/Drawable;

    iput-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    new-instance v0, Lcom/lge/app/floating/FloatableActivity$2;

    invoke-direct {v0, p0}, Lcom/lge/app/floating/FloatableActivity$2;-><init>(Lcom/lge/app/floating/FloatableActivity;)V

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->restartActivityhandler:Landroid/os/Handler;

    return-void
.end method

.method static synthetic access$100()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$200(Lcom/lge/app/floating/FloatableActivity;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatableActivity;

    .prologue
    iget v0, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    return v0
.end method

.method private checkRtl(Ljava/util/Locale;)Z
    .locals 2
    .param p1, "locale"    # Ljava/util/Locale;

    .prologue
    const/4 v0, 0x1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->getLayoutDirectionFromLocale(Ljava/util/Locale;)I

    move-result v1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private createFloatingWindow(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)Lcom/lge/app/floating/FloatingWindow;
    .locals 5
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    const/4 v1, 0x0

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return-object v1

    :cond_1
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    .local v0, "activityName":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v2

    if-nez v2, :cond_0

    sget-object v2, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "create FloatingWindow of "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v2

    invoke-direct {v1, p0, v2, v0, p1}, Lcom/lge/app/floating/FloatingWindow;-><init>(Lcom/lge/app/floating/FloatableActivity;Lcom/lge/app/floating/FloatingWindowManager;Ljava/lang/String;Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .local v1, "window":Lcom/lge/app/floating/FloatingWindow;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Lcom/lge/app/floating/FloatingWindowManager;->addFloatingWindowFor(Ljava/lang/String;Lcom/lge/app/floating/FloatingWindow;)V

    goto :goto_0
.end method

.method private dismissCurrentActivity()V
    .locals 14

    .prologue
    const/4 v13, 0x1

    const/4 v12, 0x0

    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "dismiss current activity. activity="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", state="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    if-nez v9, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v9

    if-eqz v9, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v9

    invoke-virtual {v9}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v9

    if-eqz v9, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v9

    invoke-virtual {v9}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v9

    const-string v10, "Qwindow"

    invoke-virtual {v9, v10}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v9

    invoke-virtual {v9}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/view/ViewGroup;

    invoke-virtual {v9, v12}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v9

    iput-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    :cond_0
    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "DontFinishActivity = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-boolean v11, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v9, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-nez v9, :cond_3

    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v10, "finish current Activity"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    monitor-enter v10

    :try_start_0
    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_1
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    .local v4, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    iget-boolean v9, v4, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->isRegistered:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v9, :cond_1

    :try_start_1
    iget-object v9, v4, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    const/4 v11, 0x0

    invoke-direct {p0, v9, v11}, Lcom/lge/app/floating/FloatableActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;Z)V
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/IllegalArgumentException;
    :try_start_2
    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "receiver "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v4, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " is already unregistered"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v9, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    .end local v3    # "i$":Ljava/util/Iterator;
    .end local v4    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :catchall_0
    move-exception v9

    monitor-exit v10
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v9

    .restart local v3    # "i$":Ljava/util/Iterator;
    :cond_2
    :try_start_3
    monitor-exit v10
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finish()V

    .end local v3    # "i$":Ljava/util/Iterator;
    :goto_1
    return-void

    :cond_3
    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v10, "save current task ID and moveTaskToBack"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v9, "activity"

    invoke-virtual {p0, v9}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .local v0, "am":Landroid/app/ActivityManager;
    const/16 v9, 0x64

    invoke-virtual {v0, v9}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v6

    .local v6, "tasks":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .local v5, "mMatchedList":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    if-eqz v6, :cond_8

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .restart local v3    # "i$":Ljava/util/Iterator;
    :cond_4
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/app/ActivityManager$RunningTaskInfo;

    .local v7, "ti":Landroid/app/ActivityManager$RunningTaskInfo;
    iget-object v8, v7, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    .local v8, "topActivityName":Landroid/content/ComponentName;
    iget-object v1, v7, Landroid/app/ActivityManager$RunningTaskInfo;->baseActivity:Landroid/content/ComponentName;

    .local v1, "baseActivityName":Landroid/content/ComponentName;
    invoke-virtual {v8}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_5

    invoke-virtual {v1}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    :cond_5
    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mMatchedList ( "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v8}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " , "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v11, v7, Landroid/app/ActivityManager$RunningTaskInfo;->id:I

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " ) "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v5, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .end local v1    # "baseActivityName":Landroid/content/ComponentName;
    .end local v7    # "ti":Landroid/app/ActivityManager$RunningTaskInfo;
    .end local v8    # "topActivityName":Landroid/content/ComponentName;
    :cond_6
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v9

    if-nez v9, :cond_a

    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "No Task exists. "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7
    :goto_3
    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "task id="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v11, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v3    # "i$":Ljava/util/Iterator;
    :cond_8
    if-eqz v6, :cond_9

    iget v9, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    const/4 v10, -0x1

    if-ne v9, v10, :cond_9

    sget-object v9, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v10, "cannot find the task id of this activity. Defaulting it to foreground task."

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v6, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/app/ActivityManager$RunningTaskInfo;

    iget v9, v9, Landroid/app/ActivityManager$RunningTaskInfo;->id:I

    iput v9, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    :cond_9
    invoke-virtual {p0, v13}, Lcom/lge/app/floating/FloatableActivity;->moveTaskToBack(Z)Z

    goto/16 :goto_1

    .restart local v3    # "i$":Ljava/util/Iterator;
    :cond_a
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v9

    if-ne v9, v13, :cond_b

    invoke-interface {v5, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/app/ActivityManager$RunningTaskInfo;

    iget v9, v9, Landroid/app/ActivityManager$RunningTaskInfo;->id:I

    iput v9, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    goto :goto_3

    :cond_b
    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_c
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/app/ActivityManager$RunningTaskInfo;

    .restart local v7    # "ti":Landroid/app/ActivityManager$RunningTaskInfo;
    iget-object v8, v7, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    .restart local v8    # "topActivityName":Landroid/content/ComponentName;
    iget-object v1, v7, Landroid/app/ActivityManager$RunningTaskInfo;->baseActivity:Landroid/content/ComponentName;

    .restart local v1    # "baseActivityName":Landroid/content/ComponentName;
    invoke-virtual {v8}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_d

    invoke-virtual {v1}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_c

    :cond_d
    iget v9, v7, Landroid/app/ActivityManager$RunningTaskInfo;->id:I

    iput v9, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    goto/16 :goto_3
.end method

.method private ensureMaximumFloatingWindows()Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    sget-object v2, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v3, "ensureMaximumFloatingWindows"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/lge/app/floating/FloatingWindowManager;->isTooManyFloatingWindows(Z)Z

    move-result v0

    .local v0, "noMore":Z
    sget-object v2, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isTooManyFloatingWindows? "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v2, "MaximumFloatingWindow limitation. Finish current Activity."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finish()V

    :cond_0
    const/4 v1, 0x0

    :cond_1
    return v1
.end method

.method private ensureQSlideModeIsAllowed()Z
    .locals 6

    .prologue
    const/4 v2, 0x1

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v4, "ensureQSlideModeIsAllowed"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "isAllowed":Z
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v3

    invoke-virtual {v3, v2}, Lcom/lge/app/floating/FloatingWindowManager;->isQSlideModeEnabled(Z)Z

    move-result v1

    .local v1, "isQSlideEnabled":Z
    if-nez v1, :cond_0

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isQSlideEnabled? "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    :cond_0
    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v2

    if-eqz v2, :cond_1

    sget-object v2, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v3, "Qslide is not allowed. Finish this Activity."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finish()V

    :cond_1
    const/4 v2, 0x0

    :cond_2
    return v2
.end method

.method private fakeLoadersNotStarted(Z)V
    .locals 7
    .param p1, "notStarted"    # Z

    .prologue
    const/4 v5, 0x1

    const/4 v6, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isSwitchingToFloatingMode()Z

    move-result v4

    if-eqz v4, :cond_0

    if-nez p1, :cond_1

    move v4, v5

    :goto_0
    invoke-static {p0, v4}, Lcom/lge/app/floating/FloatingFunctionReflect;->setActivityMLoadersStarted(Landroid/app/Activity;Z)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/app/floating/FloatingFunctionReflect;->getFragmentList(Landroid/app/FragmentManager;)Ljava/util/List;

    move-result-object v2

    .local v2, "fragments":Ljava/util/List;, "Ljava/util/List<Landroid/app/Fragment;>;"
    if-nez v2, :cond_2

    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v5, "no fragment to load exists"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v2    # "fragments":Ljava/util/List;, "Ljava/util/List<Landroid/app/Fragment;>;"
    :cond_0
    :goto_1
    return-void

    :cond_1
    move v4, v6

    goto :goto_0

    .restart local v2    # "fragments":Ljava/util/List;, "Ljava/util/List<Landroid/app/Fragment;>;"
    :cond_2
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Fragment;

    .local v1, "frag":Landroid/app/Fragment;
    if-nez p1, :cond_3

    move v4, v5

    :goto_3
    invoke-static {v1, v4}, Lcom/lge/app/floating/FloatingFunctionReflect;->setFragmentMLoadersStarted(Landroid/app/Fragment;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .end local v1    # "frag":Landroid/app/Fragment;
    .end local v2    # "fragments":Ljava/util/List;, "Ljava/util/List<Landroid/app/Fragment;>;"
    .end local v3    # "i$":Ljava/util/Iterator;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "frag":Landroid/app/Fragment;
    .restart local v2    # "fragments":Ljava/util/List;, "Ljava/util/List<Landroid/app/Fragment;>;"
    .restart local v3    # "i$":Ljava/util/Iterator;
    :cond_3
    move v4, v6

    goto :goto_3
.end method

.method private findRegisterInfo(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    .locals 4
    .param p1, "receiver"    # Landroid/content/BroadcastReceiver;
    .param p2, "filter"    # Landroid/content/IntentFilter;

    .prologue
    iget-object v3, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    monitor-enter v3

    :try_start_0
    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    .local v1, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    iget-object v2, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    if-ne v2, p1, :cond_0

    iget-object v2, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->filter:Landroid/content/IntentFilter;

    invoke-virtual {v2, p2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    monitor-exit v3

    .end local v1    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :goto_0
    return-object v1

    :cond_1
    monitor-exit v3

    const/4 v1, 0x0

    goto :goto_0

    .end local v0    # "i$":Ljava/util/Iterator;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method

.method private forceSwitchToFloatingMode(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V
    .locals 14
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    const v13, 0x7f060009

    const/4 v12, 0x2

    const/4 v11, 0x1

    const/4 v10, 0x0

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "forceSwitchToFloatingMode with intent "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v11, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v0

    .local v0, "currentSystemUiVisibility":I
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "forceSwitchToFloatingMode. Current flag : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " Set SYSTEM_UI_FLAG_LAYOUT_STABLE flag"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    or-int/lit16 v0, v0, 0x100

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    .local v1, "display":Landroid/util/DisplayMetrics;
    iget v7, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    sub-int/2addr v7, v8

    div-int/lit8 v7, v7, 0x2

    int-to-float v7, v7

    invoke-static {v7}, Ljava/lang/Math;->round(F)I

    move-result v7

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v7

    iget v7, v7, Landroid/content/res/Configuration;->orientation:I

    if-ne v7, v12, :cond_0

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v13}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mResources:Landroid/content/res/Resources;

    const v9, 0x7f060002

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v8

    add-int/2addr v7, v8

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    :cond_0
    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    div-int/lit8 v8, v8, 0x2

    add-int/2addr v7, v8

    int-to-float v7, v7

    iget v8, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v8, v8

    div-float v5, v7, v8

    .local v5, "tmpHorRatio":F
    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    div-int/lit8 v8, v8, 0x2

    add-int/2addr v7, v8

    int-to-float v7, v7

    iget v8, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v8, v8

    div-float v6, v7, v8

    .local v6, "tmpVerRatio":F
    const-string v7, "com.lge.app.floating.pref"

    invoke-virtual {p0, v7, v10}, Lcom/lge/app/floating/FloatableActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    .local v3, "prefs":Landroid/content/SharedPreferences;
    const-string v7, "floating_w"

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-interface {v3, v7, v8}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v7

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    const-string v7, "floating_h"

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-interface {v3, v7, v8}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v7

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    const-string v7, "floating_hor_ratio"

    invoke-interface {v3, v7, v5}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v7

    iget v8, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v8, v8

    mul-float/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Math;->round(F)I

    move-result v7

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    div-int/lit8 v8, v8, 0x2

    sub-int/2addr v7, v8

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    const-string v7, "floating_ver_ratio"

    invoke-interface {v3, v7, v6}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v7

    iget v8, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v8, v8

    mul-float/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Math;->round(F)I

    move-result v7

    iget v8, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    div-int/lit8 v8, v8, 0x2

    sub-int v4, v7, v8

    .local v4, "tempY":I
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v13}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    if-lt v4, v7, :cond_1

    iput v4, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    :cond_1
    sget-boolean v7, Lcom/lge/app/floating/FloatableActivity;->$assertionsDisabled:Z

    if-nez v7, :cond_2

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-eqz v7, :cond_2

    new-instance v7, Ljava/lang/AssertionError;

    invoke-direct {v7}, Ljava/lang/AssertionError;-><init>()V

    throw v7

    :cond_2
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v7, :cond_4

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.position"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->getIntArrayExtra(Ljava/lang/String;)[I

    move-result-object v2

    .local v2, "initialPosition":[I
    if-eqz v2, :cond_3

    array-length v7, v2

    if-ne v7, v12, :cond_3

    aget v7, v2, v10

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    aget v7, v2, v11

    iput v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    :cond_3
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.returnFromFloating"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .end local v2    # "initialPosition":[I
    :cond_4
    invoke-direct {p0, p1}, Lcom/lge/app/floating/FloatableActivity;->createFloatingWindow(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v7

    iput-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->RESUME:Lcom/lge/app/floating/FloatableActivity$State;

    if-ne v7, v8, :cond_5

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->dismissCurrentActivity()V

    :cond_5
    return-void
.end method

.method private getOrderingForStartActivity()I
    .locals 9

    .prologue
    const-string v5, "com.lge.app.floating.FloatingWindowService"

    .local v5, "serviceName":Ljava/lang/String;
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v3

    .local v3, "pid":I
    const/4 v2, 0x0

    .local v2, "order":I
    const-string v7, "activity"

    invoke-virtual {p0, v7}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager;

    .local v1, "manager":Landroid/app/ActivityManager;
    const v7, 0x7fffffff

    invoke-virtual {v1, v7}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object v6

    .local v6, "services":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningServiceInfo;>;"
    if-nez v6, :cond_1

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v8, "Cannot get Ordering For Start Activity"

    invoke-static {v7, v8}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v2

    :cond_1
    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/ActivityManager$RunningServiceInfo;

    .local v4, "service":Landroid/app/ActivityManager$RunningServiceInfo;
    iget-object v7, v4, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    if-nez v7, :cond_3

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v8, "Exception - RunningServiceInfo : null"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_3
    iget-object v7, v4, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v7}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    iget v7, v4, Landroid/app/ActivityManager$RunningServiceInfo;->pid:I

    if-eq v7, v3, :cond_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method

.method private handleDuplicatedStart()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleDuplicatedStart brings activity "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " from background to foreground"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsRestartedOrNewIntentCalled:Z

    if-eqz v1, :cond_1

    invoke-virtual {p0, v4}, Lcom/lge/app/floating/FloatableActivity;->moveTaskToBack(Z)Z

    :goto_0
    iput-boolean v5, p0, Lcom/lge/app/floating/FloatableActivity;->mIsRestartedOrNewIntentCalled:Z

    :cond_0
    return-void

    :cond_1
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mHasActivityResultReceived:Z

    if-eqz v1, :cond_2

    iput-boolean v5, p0, Lcom/lge/app/floating/FloatableActivity;->mHasActivityResultReceived:Z

    invoke-virtual {p0, v4}, Lcom/lge/app/floating/FloatableActivity;->moveTaskToBack(Z)Z

    goto :goto_0

    :cond_2
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsWaitingActivityResult:Z

    if-nez v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    .local v0, "window":Lcom/lge/app/floating/FloatingWindow;
    invoke-virtual {v0, v4}, Lcom/lge/app/floating/FloatingWindow;->closeInner(Z)V

    goto :goto_0
.end method

.method private handleStartedAsFloatingMode()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->onStartedAsFloatingMode()Z

    move-result v1

    .local v1, "proceed":Z
    if-eqz v1, :cond_1

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Activity "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " started as floating mode. Automatically switching to floating mode"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v0, v6}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    .local v0, "nullDrwable":Landroid/graphics/drawable/ColorDrawable;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/app/floating/FloatableActivity;->mSavedWindowBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-boolean v3, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    if-nez v3, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->switchToFloatingMode()V

    iput-boolean v6, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    .end local v0    # "nullDrwable":Landroid/graphics/drawable/ColorDrawable;
    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Activity "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " started as floating mode, but app decided not to enter into floating mode"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v3, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    if-eqz v3, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v2

    .local v2, "window":Lcom/lge/app/floating/FloatingWindow;
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->closeInner()V

    :cond_2
    iput-boolean v6, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    goto :goto_0
.end method

.method private isServiceRunning(Ljava/lang/String;I)Z
    .locals 8
    .param p1, "serviceName"    # Ljava/lang/String;
    .param p2, "pid"    # I

    .prologue
    const/4 v4, 0x0

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v6, "Check isServiceRunning"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "activity"

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager;

    .local v1, "manager":Landroid/app/ActivityManager;
    const v5, 0x7fffffff

    invoke-virtual {v1, v5}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object v3

    .local v3, "services":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningServiceInfo;>;"
    if-nez v3, :cond_1

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v6, "Cannot get  RunningServiceInfo."

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v4

    :cond_1
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/ActivityManager$RunningServiceInfo;

    .local v2, "service":Landroid/app/ActivityManager$RunningServiceInfo;
    iget-object v5, v2, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v5}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "serviceName , pid : ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v2, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v7}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " , "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v2, Landroid/app/ActivityManager$RunningServiceInfo;->pid:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v5, v2, Landroid/app/ActivityManager$RunningServiceInfo;->pid:I

    if-ne v5, p2, :cond_3

    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Service Pid matched. pid = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v4, 0x1

    goto :goto_0

    :cond_3
    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Service Pid not matched. current pid = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "find service pid = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v2, Landroid/app/ActivityManager$RunningServiceInfo;->pid:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1
.end method

.method private startFloatingService()V
    .locals 3

    .prologue
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mServiceStartRequested:Z

    if-nez v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "com.lge.app.floating.FloatingWindowService"

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v2

    invoke-direct {p0, v1, v2}, Lcom/lge/app/floating/FloatableActivity;->isServiceRunning(Ljava/lang/String;I)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mServiceStartRequested:Z

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/lge/app/floating/FloatingWindowService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "ActivityName"

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatableActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_0
    return-void
.end method

.method private switchToFloatingMode(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V
    .locals 11
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    .param p2, "temp"    # Z

    .prologue
    const/16 v10, 0x400

    const/4 v9, 0x0

    const/4 v8, 0x1

    iput-boolean v8, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v5

    if-eqz v5, :cond_1

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Activity "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " is currently in floating mode. Do nothing."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-boolean v5, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v5, :cond_2

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Activity "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " is currently switching to floating mode. Ignoring duplicated request."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v6, Lcom/lge/app/floating/FloatableActivity$State;->PAUSE:Lcom/lge/app/floating/FloatableActivity$State;

    if-eq v5, v6, :cond_3

    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v6, Lcom/lge/app/floating/FloatableActivity$State;->STOP:Lcom/lge/app/floating/FloatableActivity$State;

    if-eq v5, v6, :cond_3

    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v6, Lcom/lge/app/floating/FloatableActivity$State;->DESTROY:Lcom/lge/app/floating/FloatableActivity$State;

    if-ne v5, v6, :cond_4

    :cond_3
    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Activity "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " is currnently in "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " mode. In this mode, switching to floating mode is not possible."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    const/4 v3, 0x0

    .local v3, "ignoreMaxFloating":Z
    :try_start_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x80

    invoke-virtual {v5, v6, v7}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .local v0, "ai":Landroid/content/pm/ApplicationInfo;
    iget-object v5, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v6, "ignoreMaxFloating"

    const/4 v7, 0x0

    invoke-virtual {v5, v6, v7}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .end local v0    # "ai":Landroid/content/pm/ApplicationInfo;
    :goto_1
    if-nez v3, :cond_6

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->ensureMaximumFloatingWindows()Z

    move-result v5

    if-eqz v5, :cond_0

    :goto_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .local v1, "attrs":Landroid/view/WindowManager$LayoutParams;
    iget v5, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v5, v5, 0x400

    if-ne v5, v10, :cond_7

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v6, "FLAG_FULLSCREEN in full mode."

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v8, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    :goto_3
    iput-boolean v8, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSetFullScreenFlag:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    .local v4, "window":Lcom/lge/app/floating/FloatingWindow;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v5

    if-eqz v5, :cond_5

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_5

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x12

    if-lt v5, v6, :cond_5

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v6, "addFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v5

    invoke-virtual {v5, v10}, Landroid/view/Window;->addFlags(I)V

    :cond_5
    if-eqz v4, :cond_9

    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "There already is a floating window for activity "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v5

    if-eqz v5, :cond_8

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->gainFocus()V

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->moveToTop()V

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finish()V

    goto/16 :goto_0

    .end local v1    # "attrs":Landroid/view/WindowManager$LayoutParams;
    .end local v4    # "window":Lcom/lge/app/floating/FloatingWindow;
    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/Exception;
    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Failed to get ApplicationInfo of "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v2    # "e":Ljava/lang/Exception;
    :cond_6
    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "MaxFloating is ignored by app "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .restart local v1    # "attrs":Landroid/view/WindowManager$LayoutParams;
    :cond_7
    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v6, "Not FLAG_FULLSCREEN in full mode."

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v9, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    goto/16 :goto_3

    .restart local v4    # "window":Lcom/lge/app/floating/FloatingWindow;
    :cond_8
    sget-object v5, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v6, "Activity is originally started as a normal mode and there is a floating window for this activity...Close late one"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->closeInner()V

    goto/16 :goto_0

    :cond_9
    invoke-direct {p0, p1}, Lcom/lge/app/floating/FloatableActivity;->forceSwitchToFloatingMode(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    goto/16 :goto_0
.end method

.method private unregisterReceiver(Landroid/content/BroadcastReceiver;Z)V
    .locals 7
    .param p1, "receiver"    # Landroid/content/BroadcastReceiver;
    .param p2, "dontRemember"    # Z

    .prologue
    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "unregister receiver: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " dontRemember : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p1, :cond_0

    invoke-super {p0, p1}, Landroid/app/Activity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :goto_0
    return-void

    :cond_0
    const/4 v0, 0x0

    .local v0, "done":Z
    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    .local v3, "unregisteredReceivers":Ljava/util/Set;, "Ljava/util/Set<Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;>;"
    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    monitor-enter v5

    :try_start_0
    iget-object v4, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_1
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    .local v2, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    iget-object v4, v2, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    if-ne v4, p1, :cond_1

    iget-boolean v4, v2, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->isRegistered:Z

    if-eqz v4, :cond_2

    if-nez v0, :cond_2

    invoke-super {p0, p1}, Landroid/app/Activity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    const/4 v0, 0x1

    :cond_2
    const/4 v4, 0x0

    iput-boolean v4, v2, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->isRegistered:Z

    invoke-interface {v3, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_3
    if-eqz p2, :cond_4

    :try_start_1
    iget-object v4, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->removeAll(Ljava/util/Collection;)Z

    :cond_4
    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method


# virtual methods
.method public findViewById(I)Landroid/view/View;
    .locals 3
    .param p1, "id"    # I

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-super {p0, p1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    const-string v2, "tag_frame_layout"

    invoke-virtual {v1, v2}, Lcom/lge/app/floating/FloatingWindow;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .local v0, "targetView":Landroid/view/View;
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public finishFloatingMode()V
    .locals 3

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Activity "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is currently not in floating mode, thus finishing is impossible."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Activity "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " finishFloatingMode"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindow;->closeInner()V

    goto :goto_0
.end method

.method public getContentViewForFloatingMode()Landroid/view/View;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    return-object v0
.end method

.method public getFloatingWindow()Lcom/lge/app/floating/FloatingWindow;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    return-object v0
.end method

.method public getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    return-object v0
.end method

.method handleAttachToFloatingWindow(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 14
    .param p1, "w"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    const/high16 v13, 0x3f800000    # 1.0f

    const/4 v12, 0x1

    const/4 v11, 0x0

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "handleAttachToFloatingWindow="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "("

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ")"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-boolean v7, Lcom/lge/app/floating/FloatableActivity;->$assertionsDisabled:Z

    if-nez v7, :cond_0

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-nez v7, :cond_0

    new-instance v7, Ljava/lang/AssertionError;

    invoke-direct {v7}, Ljava/lang/AssertionError;-><init>()V

    throw v7

    :cond_0
    iput-boolean v12, p0, Lcom/lge/app/floating/FloatableActivity;->mIsAttached:Z

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    if-nez v7, :cond_1

    new-instance v7, Landroid/content/res/Configuration;

    invoke-direct {v7}, Landroid/content/res/Configuration;-><init>()V

    iput-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/content/res/Configuration;->setTo(Landroid/content/res/Configuration;)V

    :cond_1
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v7, :cond_2

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.launchAsFloating"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    :cond_2
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    if-eqz v7, :cond_4

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v8, "view is being transferred from full-screen window to floating window"

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    invoke-virtual {v7}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v5

    .local v5, "p":Landroid/view/ViewParent;
    if-eqz v5, :cond_3

    instance-of v7, v5, Landroid/view/ViewGroup;

    if-eqz v7, :cond_3

    move-object v7, v5

    check-cast v7, Landroid/view/ViewGroup;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    invoke-virtual {v7, v8}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    check-cast v5, Landroid/view/ViewGroup;

    .end local v5    # "p":Landroid/view/ViewParent;
    iput-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mContentViewParent:Landroid/view/ViewGroup;

    :cond_3
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    invoke-virtual {v7, v8}, Lcom/lge/app/floating/FloatingWindow;->setContentView(Landroid/view/View;)V

    :cond_4
    iget-boolean v7, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-nez v7, :cond_7

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "re-registering receivers for activity"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    .local v3, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "receiver="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v7

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatingWindowManager;->getServiceContext()Landroid/content/Context;

    move-result-object v0

    .local v0, "c":Landroid/content/Context;
    if-nez v0, :cond_5

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    :cond_5
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "register to service context: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    iget-object v8, v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->filter:Landroid/content/IntentFilter;

    iget-object v9, v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->broadcastPermission:Ljava/lang/String;

    iget-object v10, v3, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->scheduler:Landroid/os/Handler;

    invoke-virtual {v0, v7, v8, v9, v10}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    goto :goto_0

    .end local v0    # "c":Landroid/content/Context;
    .end local v3    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :cond_6
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->receiverListForUnregister:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->clear()V

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->receiverListForUnregister:Ljava/util/List;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v7, v8}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .end local v2    # "i$":Ljava/util/Iterator;
    :cond_7
    iget-boolean v7, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-nez v7, :cond_a

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->PAUSE:Lcom/lge/app/floating/FloatableActivity$State;

    if-ne v7, v8, :cond_9

    :cond_8
    :goto_1
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v8, "callback onAttachedToFloatingWindow()"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, p1}, Lcom/lge/app/floating/FloatableActivity;->onAttachedToFloatingWindow(Lcom/lge/app/floating/FloatingWindow;)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v7, :cond_d

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.lowProfileRequester"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .local v6, "previousLowProfileRequester":Ljava/lang/String;
    if-eqz v6, :cond_b

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.lowProfileIsHidden"

    invoke-virtual {v7, v8, v11}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    .local v1, "hide":Z
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "recover last low profile mode as hide="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " by previous LowProfile requester "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v7

    invoke-virtual {v7, v1, v6}, Lcom/lge/app/floating/FloatingWindowManager;->handleEnterLowProfile(ZLjava/lang/String;)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.lowProfileRequester"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.lowProfileIsHidden"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .end local v1    # "hide":Z
    .end local v6    # "previousLowProfileRequester":Ljava/lang/String;
    :goto_2
    return-void

    :cond_9
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->STOP:Lcom/lge/app/floating/FloatableActivity$State;

    if-eq v7, v8, :cond_8

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->DESTROY:Lcom/lge/app/floating/FloatableActivity$State;

    if-ne v7, v8, :cond_8

    iput-boolean v11, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    goto :goto_1

    :cond_a
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->PAUSE:Lcom/lge/app/floating/FloatableActivity$State;

    if-eq v7, v8, :cond_8

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->STOP:Lcom/lge/app/floating/FloatableActivity$State;

    if-ne v7, v8, :cond_8

    iput-boolean v11, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    goto :goto_1

    .restart local v6    # "previousLowProfileRequester":Ljava/lang/String;
    :cond_b
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.opacity"

    invoke-virtual {v7, v8, v13}, Landroid/content/Intent;->getFloatExtra(Ljava/lang/String;F)F

    move-result v4

    .local v4, "opacity":F
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "show opacity "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    cmpg-float v7, v4, v13

    if-gez v7, :cond_c

    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "apply opacity "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " saved in intent"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7, v12}, Lcom/lge/app/floating/FloatingWindow;->setOverlay(Z)V

    new-instance v7, Landroid/os/Handler;

    invoke-direct {v7}, Landroid/os/Handler;-><init>()V

    new-instance v8, Lcom/lge/app/floating/FloatableActivity$1;

    invoke-direct {v8, p0}, Lcom/lge/app/floating/FloatableActivity$1;-><init>(Lcom/lge/app/floating/FloatableActivity;)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7, v4}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(F)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.opacity"

    invoke-virtual {v7, v8}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    :cond_c
    iget-object v7, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7, v12}, Lcom/lge/app/floating/FloatingWindow;->updateTitleBackground(Z)V

    goto/16 :goto_2

    .end local v4    # "opacity":F
    .end local v6    # "previousLowProfileRequester":Ljava/lang/String;
    :cond_d
    sget-object v7, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v8, "Current intent is NULL"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2
.end method

.method handleDetachFromFloatingWindow(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 23
    .param p1, "w"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "isReturningToFullScreen"    # Z

    .prologue
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "handleDetachFromFloatingWindow="

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    const-string v21, "("

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, v20

    move/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v20

    const-string v21, ")"

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p2}, Lcom/lge/app/floating/FloatableActivity;->onDetachedFromFloatingWindow(Lcom/lge/app/floating/FloatingWindow;Z)Z

    move-result v4

    .local v4, "autoRelaunch":Z
    const/16 v19, 0x0

    move/from16 v0, v19

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/lge/app/floating/FloatableActivity;->mIsAttached:Z

    const/16 v19, 0x0

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    const/16 v19, 0x0

    move/from16 v0, v19

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    const/16 v19, 0x0

    move/from16 v0, v19

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v7

    .local v7, "display":Landroid/util/DisplayMetrics;
    invoke-virtual/range {p1 .. p1}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v16

    .local v16, "params":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    if-nez v16, :cond_1

    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v20, "FloatingWindow.LayoutParams params == null"

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    move-object/from16 v0, v16

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    move/from16 v19, v0

    move-object/from16 v0, v16

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v20, v0

    div-int/lit8 v20, v20, 0x2

    add-int v19, v19, v20

    move/from16 v0, v19

    int-to-float v0, v0

    move/from16 v19, v0

    iget v0, v7, Landroid/util/DisplayMetrics;->widthPixels:I

    move/from16 v20, v0

    move/from16 v0, v20

    int-to-float v0, v0

    move/from16 v20, v0

    div-float v10, v19, v20

    .local v10, "horRatio":F
    move-object/from16 v0, v16

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v19, v0

    move-object/from16 v0, v16

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v20, v0

    div-int/lit8 v20, v20, 0x2

    add-int v19, v19, v20

    move/from16 v0, v19

    int-to-float v0, v0

    move/from16 v19, v0

    iget v0, v7, Landroid/util/DisplayMetrics;->heightPixels:I

    move/from16 v20, v0

    move/from16 v0, v20

    int-to-float v0, v0

    move/from16 v20, v0

    div-float v18, v19, v20

    .local v18, "verRatio":F
    const-string v19, "com.lge.app.floating.pref"

    const/16 v20, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    move/from16 v2, v20

    invoke-virtual {v0, v1, v2}, Lcom/lge/app/floating/FloatableActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v17

    .local v17, "prefs":Landroid/content/SharedPreferences;
    invoke-interface/range {v17 .. v17}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v9

    .local v9, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v19, "floating_hor_ratio"

    move-object/from16 v0, v19

    invoke-interface {v9, v0, v10}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    const-string v19, "floating_ver_ratio"

    move-object/from16 v0, v19

    move/from16 v1, v18

    invoke-interface {v9, v0, v1}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    const-string v19, "floating_w"

    move-object/from16 v0, v16

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v20, v0

    move-object/from16 v0, v19

    move/from16 v1, v20

    invoke-interface {v9, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    const-string v19, "floating_h"

    move-object/from16 v0, v16

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v20, v0

    move-object/from16 v0, v19

    move/from16 v1, v20

    invoke-interface {v9, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v9}, Landroid/content/SharedPreferences$Editor;->commit()Z

    if-eqz p2, :cond_2

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    move/from16 v19, v0

    if-nez v19, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v19

    if-eqz v19, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v19

    if-eqz v19, :cond_2

    sget v19, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v20, 0x12

    move/from16 v0, v19

    move/from16 v1, v20

    if-lt v0, v1, :cond_2

    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v20, "clearFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v19

    const/16 v20, 0x400

    invoke-virtual/range {v19 .. v20}, Landroid/view/Window;->clearFlags(I)V

    :cond_2
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "DontFinishActivity = "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    move/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    move/from16 v19, v0

    if-nez v19, :cond_5

    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "unregistering receivers for activity"

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->receiverListForUnregister:Ljava/util/List;

    move-object/from16 v20, v0

    monitor-enter v20

    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->receiverListForUnregister:Ljava/util/List;

    move-object/from16 v19, v0

    invoke-interface/range {v19 .. v19}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v11

    .local v11, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_4

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    .local v12, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "receiver="

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    iget-object v0, v12, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    move-object/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Lcom/lge/app/floating/FloatingWindowManager;->getServiceContext()Landroid/content/Context;

    move-result-object v5

    .local v5, "c":Landroid/content/Context;
    if-nez v5, :cond_3

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    :cond_3
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "unregister from service context: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    iget-object v0, v12, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    move-object/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, v12, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-virtual {v5, v0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .end local v5    # "c":Landroid/content/Context;
    :catch_0
    move-exception v8

    .local v8, "e":Ljava/lang/IllegalArgumentException;
    :try_start_2
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "receiver "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    iget-object v0, v12, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    move-object/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, " is already unregistered"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v8    # "e":Ljava/lang/IllegalArgumentException;
    .end local v11    # "i$":Ljava/util/Iterator;
    .end local v12    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :catchall_0
    move-exception v19

    monitor-exit v20
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v19

    .restart local v11    # "i$":Ljava/util/Iterator;
    :cond_4
    :try_start_3
    monitor-exit v20
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->receiverListForUnregister:Ljava/util/List;

    move-object/from16 v19, v0

    invoke-interface/range {v19 .. v19}, Ljava/util/List;->clear()V

    .end local v11    # "i$":Ljava/util/Iterator;
    :cond_5
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "AutoRelaunch = "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v4, :cond_0

    if-eqz p2, :cond_e

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    move/from16 v19, v0

    if-nez v19, :cond_7

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    if-eqz v19, :cond_6

    new-instance v13, Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    .local v13, "intent":Landroid/content/Intent;
    :goto_2
    const-string v19, "com.lge.app.floating.launchAsFloating"

    move-object/from16 v0, v19

    invoke-virtual {v13, v0}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    const-string v19, "com.lge.app.floating.returnFromFloating"

    const/16 v20, 0x1

    move-object/from16 v0, v19

    move/from16 v1, v20

    invoke-virtual {v13, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "relaunching. intent="

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual {v13}, Landroid/content/Intent;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    invoke-virtual {v0, v13}, Lcom/lge/app/floating/FloatableActivity;->startActivity(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v13    # "intent":Landroid/content/Intent;
    :cond_6
    new-instance v13, Landroid/content/Intent;

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getIntent()Landroid/content/Intent;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    goto :goto_2

    :cond_7
    invoke-virtual/range {p1 .. p1}, Lcom/lge/app/floating/FloatingWindow;->getContentView()Landroid/view/View;

    move-result-object v14

    .local v14, "myView":Landroid/view/View;
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/view/ViewGroup;

    .local v6, "decorView":Landroid/view/ViewGroup;
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "decor view="

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v19, 0x0

    move-object/from16 v0, p1

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatingWindow;->setContentView(Landroid/view/View;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mSavedWindowBackground:Landroid/graphics/drawable/Drawable;

    move-object/from16 v19, v0

    if-eqz v19, :cond_8

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mSavedWindowBackground:Landroid/graphics/drawable/Drawable;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-virtual {v6, v0}, Landroid/view/ViewGroup;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_8
    if-eqz v14, :cond_9

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mContentViewParent:Landroid/view/ViewGroup;

    move-object/from16 v19, v0

    if-eqz v19, :cond_b

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mContentViewParent:Landroid/view/ViewGroup;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-virtual {v0, v14}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    const/16 v19, 0x0

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/lge/app/floating/FloatableActivity;->mContentViewParent:Landroid/view/ViewGroup;

    :cond_9
    :goto_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    if-eqz v19, :cond_a

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    const-string v20, "com.lge.app.floating.launchAsFloating"

    invoke-virtual/range {v19 .. v20}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    const-string v20, "com.lge.app.floating.returnFromFloating"

    const/16 v21, 0x1

    invoke-virtual/range {v19 .. v21}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    :cond_a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    move-object/from16 v19, v0

    sget-object v20, Lcom/lge/app/floating/FloatableActivity$State;->RESUME:Lcom/lge/app/floating/FloatableActivity$State;

    move-object/from16 v0, v19

    move-object/from16 v1, v20

    if-eq v0, v1, :cond_c

    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "move activity "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    const-string v21, " to foreground"

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v19, "activity"

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/ActivityManager;

    .local v3, "am":Landroid/app/ActivityManager;
    move-object/from16 v0, p0

    iget v0, v0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    move/from16 v19, v0

    const/16 v20, 0x0

    move/from16 v0, v19

    move/from16 v1, v20

    invoke-virtual {v3, v0, v1}, Landroid/app/ActivityManager;->moveTaskToFront(II)V

    goto/16 :goto_0

    .end local v3    # "am":Landroid/app/ActivityManager;
    :cond_b
    invoke-virtual {v6, v14}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    goto :goto_3

    :cond_c
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, "re-launch activity "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    if-eqz v19, :cond_d

    new-instance v13, Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    .restart local v13    # "intent":Landroid/content/Intent;
    :goto_4
    const/high16 v19, 0x20000000

    move/from16 v0, v19

    invoke-virtual {v13, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-object/from16 v0, p0

    invoke-virtual {v0, v13}, Lcom/lge/app/floating/FloatableActivity;->startActivity(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v13    # "intent":Landroid/content/Intent;
    :cond_d
    new-instance v13, Landroid/content/Intent;

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getIntent()Landroid/content/Intent;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    goto :goto_4

    .end local v6    # "decorView":Landroid/view/ViewGroup;
    .end local v14    # "myView":Landroid/view/View;
    :cond_e
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    move/from16 v19, v0

    if-eqz v19, :cond_0

    new-instance v15, Landroid/graphics/drawable/ColorDrawable;

    const/16 v19, 0x0

    move/from16 v0, v19

    invoke-direct {v15, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    .local v15, "nullDrwable":Landroid/graphics/drawable/ColorDrawable;
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v19

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/lge/app/floating/FloatableActivity;->mSavedWindowBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v15}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget v19, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v20, 0xf

    move/from16 v0, v19

    move/from16 v1, v20

    if-gt v0, v1, :cond_f

    const-string v19, "activity"

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/ActivityManager;

    .restart local v3    # "am":Landroid/app/ActivityManager;
    move-object/from16 v0, p0

    iget v0, v0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    move/from16 v19, v0

    const/16 v20, 0x0

    move/from16 v0, v19

    move/from16 v1, v20

    invoke-virtual {v3, v0, v1}, Landroid/app/ActivityManager;->moveTaskToFront(II)V

    .end local v3    # "am":Landroid/app/ActivityManager;
    :cond_f
    sget-object v19, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v20, "(DontFinishActivity && AutoRestart) == true , finish Activity."

    invoke-static/range {v19 .. v20}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatableActivity;->finish()V

    goto/16 :goto_0
.end method

.method public isInFloatingMode()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsAttached:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isStartedAsFloating()Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    iget-object v1, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v2, "com.lge.app.floating.launchAsFloating"

    invoke-virtual {v1, v2, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public isSwitchingToFloatingMode()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSwitchingToFullMode()Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    iget-object v1, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v2, "com.lge.app.floating.returnFromFloating"

    invoke-virtual {v1, v2, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isSwitchingToFloatingMode()Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsWaitingActivityResult:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mHasActivityResultReceived:Z

    :cond_0
    return-void
.end method

.method public onAttachedToFloatingWindow(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "w"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onAttachedToWindow()V
    .locals 3

    .prologue
    invoke-super {p0}, Landroid/app/Activity;->onAttachedToWindow()V

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on attached from window activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 3
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "configuration is changed. newconfig="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/content/res/Configuration;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 15
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v14, 0x1

    const/4 v13, 0x0

    invoke-super/range {p0 .. p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-static {p0}, Lcom/lge/app/floating/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mResources:Landroid/content/res/Resources;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity$State;->CREATE:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getIntent()Landroid/content/Intent;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "QSlide framework version is "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-static {p0}, Lcom/lge/app/floating/Res;->getVersion(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " [ code : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-static {p0}, Lcom/lge/app/floating/Res;->getVersionCode(Landroid/content/Context;)I

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " ]"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "on create activity="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "started as floating="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p0}, Lcom/lge/app/floating/FloatingWindowService;->checkExistence(Landroid/content/Context;)Z

    move-result v8

    if-nez v8, :cond_0

    const-string v8, "FloatingWindowService cannot be found. Please see logcat for further information."

    invoke-static {p0, v8, v14}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/Toast;->show()V

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v8

    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v6

    .local v6, "window":Lcom/lge/app/floating/FloatingWindow;
    if-eqz v6, :cond_3

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v8

    if-eqz v8, :cond_1

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "we already have docked floating window for "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v9

    invoke-virtual {v6, v8, v9}, Lcom/lge/app/floating/FloatingWindow;->releaseDockInner(Ljava/lang/String;Z)V

    :goto_0
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v9, "There is already floating window for another activity... Finish current Activity."

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finish()V

    :goto_1
    return-void

    :cond_1
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, " we already have floating window for "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mResources:Landroid/content/res/Resources;

    const v9, 0x7f0a0002

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v4

    .local v4, "msg":Ljava/lang/CharSequence;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v9

    iget v9, v9, Landroid/content/pm/ApplicationInfo;->labelRes:I

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    .local v1, "appName":Ljava/lang/String;
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mResources:Landroid/content/res/Resources;

    const v9, 0x7f06000b

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v7

    .local v7, "yOffset":I
    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v8

    new-array v9, v14, [Ljava/lang/Object;

    aput-object v1, v9, v13

    invoke-static {v8, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-static {p0, v8, v13}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v5

    .local v5, "toast":Landroid/widget/Toast;
    const/16 v8, 0x31

    invoke-virtual {v5, v8, v13, v7}, Landroid/widget/Toast;->setGravity(III)V

    invoke-virtual {v5}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .end local v1    # "appName":Ljava/lang/String;
    .end local v4    # "msg":Ljava/lang/CharSequence;
    .end local v5    # "toast":Landroid/widget/Toast;
    .end local v7    # "yOffset":I
    :cond_2
    invoke-virtual {v6, v14}, Lcom/lge/app/floating/FloatingWindow;->closeInner(Z)V

    goto :goto_1

    :cond_3
    const-string v2, ""

    .local v2, "checkKids":Ljava/lang/String;
    :try_start_0
    const-string v8, "android.os.SystemProperties"

    invoke-static {v8}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    const-string v9, "get"

    const/4 v10, 0x2

    new-array v10, v10, [Ljava/lang/Class;

    const/4 v11, 0x0

    const-class v12, Ljava/lang/String;

    aput-object v12, v10, v11

    const/4 v11, 0x1

    const-class v12, Ljava/lang/String;

    aput-object v12, v10, v11

    invoke-virtual {v8, v9, v10}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .local v3, "getSystemPropertiesMethod":Ljava/lang/reflect/Method;
    const/4 v8, 0x1

    invoke-virtual {v3, v8}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    const/4 v8, 0x0

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    const-string v11, "service.plushome.currenthome"

    aput-object v11, v9, v10

    const/4 v10, 0x1

    aput-object v2, v9, v10

    invoke-virtual {v3, v8, v9}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    move-object v0, v8

    check-cast v0, Ljava/lang/String;

    move-object v2, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v3    # "getSystemPropertiesMethod":Ljava/lang/reflect/Method;
    :goto_2
    const-string v8, "kids"

    invoke-virtual {v8, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_4

    sput-boolean v14, Lcom/lge/app/floating/FloatableActivity;->mIsInGuestMode:Z

    :goto_3
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "mIsInGuestMode set :"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    sget-boolean v10, Lcom/lge/app/floating/FloatableActivity;->mIsInGuestMode:Z

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :cond_4
    const-string v8, "kids"

    const-string v9, "standard"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_5

    sput-boolean v13, Lcom/lge/app/floating/FloatableActivity;->mIsInGuestMode:Z

    goto :goto_3

    :cond_5
    sput-boolean v13, Lcom/lge/app/floating/FloatableActivity;->mIsInGuestMode:Z

    goto :goto_3

    :catch_0
    move-exception v8

    goto :goto_2
.end method

.method protected onDestroy()V
    .locals 3

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->DESTROY:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on destroy activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsAttached:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    :cond_0
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finishFloatingMode()V

    :cond_1
    return-void
.end method

.method public onDetachedFromFloatingWindow(Lcom/lge/app/floating/FloatingWindow;Z)Z
    .locals 1
    .param p1, "w"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "isReturningToFullScreen"    # Z

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public onDetachedFromWindow()V
    .locals 3

    .prologue
    invoke-super {p0}, Landroid/app/Activity;->onDetachedFromWindow()V

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on detached from window activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 3
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->NEWINTENT:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object p1, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsRestartedOrNewIntentCalled:Z

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on new intent activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "started as floating="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->handleStartedAsFloatingMode()V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatingWindowManager;->removeFloatingWindow(Lcom/lge/app/floating/FloatingWindow;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    goto :goto_0
.end method

.method protected onPause()V
    .locals 4

    .prologue
    const/16 v3, 0x400

    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->PAUSE:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on pause activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/lge/app/floating/FloatableActivity;->fakeLoadersNotStarted(Z)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "isInFloatingMode - addFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/Window;->addFlags(I)V

    :cond_0
    :goto_0
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->startFloatingService()V

    return-void

    :cond_1
    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "!isInFloatingMode "

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    if-eqz v0, :cond_2

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "addFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/Window;->addFlags(I)V

    goto :goto_0

    :cond_2
    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "clearFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/Window;->clearFlags(I)V

    goto :goto_0
.end method

.method protected onPostCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v3, 0x0

    invoke-super {p0, p1}, Landroid/app/Activity;->onPostCreate(Landroid/os/Bundle;)V

    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v2, "onPostCreate"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSetFullScreenFlag:Z

    if-nez v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .local v0, "attrs":Landroid/view/WindowManager$LayoutParams;
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v1, v1, 0x400

    const/16 v2, 0x400

    if-ne v1, v2, :cond_1

    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v2, "FLAG_FULLSCREEN in full mode."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    :goto_0
    iput-boolean v3, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSetFullScreenFlag:Z

    .end local v0    # "attrs":Landroid/view/WindowManager$LayoutParams;
    :cond_0
    return-void

    .restart local v0    # "attrs":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v2, "Not FLAG_FULLSCREEN in full mode."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v3, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    goto :goto_0
.end method

.method protected onPostResume()V
    .locals 3

    .prologue
    invoke-super {p0}, Landroid/app/Activity;->onPostResume()V

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onPostResume activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mServiceStartRequested:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->handleDuplicatedStart()V

    :cond_0
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->dismissCurrentActivity()V

    :cond_1
    return-void
.end method

.method protected onRestart()V
    .locals 8

    .prologue
    const/16 v7, 0x400

    const/4 v6, 0x1

    invoke-super {p0}, Landroid/app/Activity;->onRestart()V

    sget-object v3, Lcom/lge/app/floating/FloatableActivity$State;->RESTART:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v3, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    iput-boolean v6, p0, Lcom/lge/app/floating/FloatableActivity;->mIsRestartedOrNewIntentCalled:Z

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "on restart activity="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "("

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "started as floating="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "release dock floating window for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v2

    .local v2, "window":Lcom/lge/app/floating/FloatingWindow;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v4

    invoke-virtual {v2, v3, v4}, Lcom/lge/app/floating/FloatingWindow;->releaseDockInner(Ljava/lang/String;Z)V

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    .local v1, "currentSystemUiVisibility":I
    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onRestart. Current flag : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " Unset SYSTEM_UI_FLAG_LAYOUT_STABLE flag"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    and-int/lit16 v1, v1, -0x101

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .end local v1    # "currentSystemUiVisibility":I
    :cond_1
    iget-object v3, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-nez v3, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .local v0, "attrs":Landroid/view/WindowManager$LayoutParams;
    iget v3, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v3, v3, 0x400

    if-ne v3, v7, :cond_4

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v4, "FLAG_FULLSCREEN in full mode."

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v6, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    .end local v0    # "attrs":Landroid/view/WindowManager$LayoutParams;
    :cond_2
    :goto_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v3

    if-nez v3, :cond_3

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x12

    if-lt v3, v4, :cond_3

    iget-boolean v3, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    if-eqz v3, :cond_3

    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v4, "addFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3, v7}, Landroid/view/Window;->addFlags(I)V

    :cond_3
    return-void

    .restart local v0    # "attrs":Landroid/view/WindowManager$LayoutParams;
    :cond_4
    sget-object v3, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v4, "Not FLAG_FULLSCREEN in full mode."

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    goto :goto_0
.end method

.method protected onResume()V
    .locals 3

    .prologue
    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->RESUME:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on resume activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    return-void
.end method

.method protected onStart()V
    .locals 3

    .prologue
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->START:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on start activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "started as floating="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mServiceStartRequested:Z

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    const-string v1, "com.lge.app.floating.restarted"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->handleStartedAsFloatingMode()V

    :cond_1
    return-void
.end method

.method protected onStartedAsFloatingMode()Z
    .locals 1

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method protected onStop()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const/16 v3, 0x400

    sget-object v0, Lcom/lge/app/floating/FloatableActivity$State;->STOP:Lcom/lge/app/floating/FloatableActivity$State;

    iput-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on stop activity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v4}, Lcom/lge/app/floating/FloatableActivity;->fakeLoadersNotStarted(Z)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "isInFloatingMode - addFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/Window;->addFlags(I)V

    :cond_0
    :goto_0
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->startFloatingService()V

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsAttached:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-eqz v0, :cond_1

    iput-boolean v4, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    :cond_1
    return-void

    :cond_2
    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "!isInFloatingMode "

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsFullScreenInFullMode:Z

    if-eqz v0, :cond_3

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "addFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/Window;->addFlags(I)V

    goto :goto_0

    :cond_3
    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v1, "clearFlags(LayoutParams.FLAG_FULLSCREEN)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/Window;->clearFlags(I)V

    goto :goto_0
.end method

.method public registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    .locals 1
    .param p1, "receiver"    # Landroid/content/BroadcastReceiver;
    .param p2, "filter"    # Landroid/content/IntentFilter;

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, v0}, Lcom/lge/app/floating/FloatableActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    move-result-object v0

    return-object v0
.end method

.method public registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;
    .locals 7
    .param p1, "receiver"    # Landroid/content/BroadcastReceiver;
    .param p2, "filter"    # Landroid/content/IntentFilter;
    .param p3, "broadcastPermission"    # Ljava/lang/String;
    .param p4, "scheduler"    # Landroid/os/Handler;

    .prologue
    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "register receiver="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " filter="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " permission="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    .local v3, "result":Landroid/content/Intent;
    :try_start_0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/app/Activity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    :goto_0
    if-nez p1, :cond_1

    :cond_0
    :goto_1
    return-object v3

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/IllegalStateException;
    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v5, "IllegalStateException in registerReceiver"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Receiver "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " registered with differing handler."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/IllegalStateException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "registerReceiver Exception : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/lge/app/floating/FloatableActivity;->findRegisterInfo(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    move-result-object v1

    .local v1, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    if-eqz v1, :cond_2

    iget-boolean v4, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->isRegistered:Z

    if-nez v4, :cond_0

    :cond_2
    iget-object v5, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    monitor-enter v5

    if-nez v1, :cond_3

    :try_start_1
    new-instance v2, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;

    const/4 v4, 0x0

    invoke-direct {v2, v4}, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;-><init>(Lcom/lge/app/floating/FloatableActivity$1;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v1    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    .local v2, "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :try_start_2
    iget-object v4, p0, Lcom/lge/app/floating/FloatableActivity;->mReceiverRegisterInfos:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v1, v2

    .end local v2    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    .restart local v1    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :cond_3
    :try_start_3
    iput-object p1, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->receiver:Landroid/content/BroadcastReceiver;

    iput-object p2, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->filter:Landroid/content/IntentFilter;

    iput-object p3, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->broadcastPermission:Ljava/lang/String;

    iput-object p4, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->scheduler:Landroid/os/Handler;

    const/4 v4, 0x1

    iput-boolean v4, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->isRegistered:Z

    iput-object v3, v1, Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;->intent:Landroid/content/Intent;

    monitor-exit v5

    goto :goto_1

    :catchall_0
    move-exception v4

    :goto_2
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v4

    .end local v1    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    .restart local v2    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    :catchall_1
    move-exception v4

    move-object v1, v2

    .end local v2    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    .restart local v1    # "info":Lcom/lge/app/floating/FloatableActivity$ReceiverRegisterInfo;
    goto :goto_2
.end method

.method restartIfNecessary(Landroid/content/res/Configuration;)V
    .locals 13
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    const/4 v10, 0x0

    const/4 v9, 0x1

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    if-nez v8, :cond_0

    new-instance v8, Landroid/content/res/Configuration;

    invoke-direct {v8}, Landroid/content/res/Configuration;-><init>()V

    iput-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v11

    invoke-virtual {v11}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v11

    invoke-virtual {v8, v11}, Landroid/content/res/Configuration;->setTo(Landroid/content/res/Configuration;)V

    :cond_0
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "mOldConfig="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {v12}, Landroid/content/res/Configuration;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v8, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "newConfig ="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {p1}, Landroid/content/res/Configuration;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v8, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "compare="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {v12, p1}, Landroid/content/res/Configuration;->compareTo(Landroid/content/res/Configuration;)I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v8, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {v8, p1}, Landroid/content/res/Configuration;->compareTo(Landroid/content/res/Configuration;)I

    move-result v8

    if-nez v8, :cond_2

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v9, "Do not restart"

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v8, v8, Landroid/content/res/Configuration;->screenHeightDp:I

    iget v11, p1, Landroid/content/res/Configuration;->screenHeightDp:I

    if-ne v8, v11, :cond_3

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v8, v8, Landroid/content/res/Configuration;->screenWidthDp:I

    iget v11, p1, Landroid/content/res/Configuration;->screenWidthDp:I

    if-ne v8, v11, :cond_4

    :cond_3
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v8, v8, Landroid/content/res/Configuration;->screenWidthDp:I

    iget v11, p1, Landroid/content/res/Configuration;->screenWidthDp:I

    if-ne v8, v11, :cond_5

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v8, v8, Landroid/content/res/Configuration;->screenHeightDp:I

    iget v11, p1, Landroid/content/res/Configuration;->screenHeightDp:I

    if-eq v8, v11, :cond_5

    :cond_4
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v9, "Do not restart for hide Navigation Bar "

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {v8, p1}, Landroid/content/res/Configuration;->setTo(Landroid/content/res/Configuration;)V

    goto :goto_0

    :cond_5
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v8, v8, Landroid/content/res/Configuration;->orientation:I

    iget v11, p1, Landroid/content/res/Configuration;->orientation:I

    if-ne v8, v11, :cond_6

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v8, v8, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    iget v11, p1, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    if-eq v8, v11, :cond_7

    :cond_6
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "not restarting "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {v8, p1}, Landroid/content/res/Configuration;->setTo(Landroid/content/res/Configuration;)V

    goto :goto_0

    :cond_7
    const/4 v3, 0x0

    .local v3, "isGallery":Z
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    .local v0, "className":Ljava/lang/String;
    if-eqz v0, :cond_8

    const-string v8, "FloatingGallery"

    invoke-virtual {v0, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    :cond_8
    if-eqz v3, :cond_9

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v9, "Gallery no restarted"

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v8, v8, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingDockWindow;->isDocked()Z

    move-result v8

    if-eqz v8, :cond_1

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v8, v8, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingDockWindow;->updateDockIcon()V

    goto/16 :goto_0

    :cond_9
    iget-boolean v8, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    if-eqz v8, :cond_10

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v8

    if-eqz v8, :cond_10

    move v5, v9

    .local v5, "needRestart":Z
    :goto_1
    if-eqz v5, :cond_a

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v11, "need restart because mDontFinishActivity=true and isInFloatingMode now"

    invoke-static {v8, v11}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_a
    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v11, 0x11

    if-lt v8, v11, :cond_11

    iget v8, p1, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit16 v8, v8, 0xc0

    iget-object v11, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v11, v11, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit16 v11, v11, 0xc0

    if-eq v8, v11, :cond_b

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "need restart for layout direction change from "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget v12, p1, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit16 v12, v12, 0xc0

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " to "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget v12, v12, Landroid/content/res/Configuration;->screenLayout:I

    and-int/lit16 v12, v12, 0xc0

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v8, v11}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, 0x1

    :cond_b
    :goto_2
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v8, v8, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    if-eqz v8, :cond_c

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v8, v8, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingDockWindow;->isDocked()Z

    move-result v8

    or-int/2addr v5, v8

    :cond_c
    if-eqz v5, :cond_d

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v11, "needRestart. saveLowProfileRequest to restore it"

    invoke-static {v8, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v8

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingWindowManager;->saveLowProfileRequest()V

    :cond_d
    if-eqz v5, :cond_f

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "restarting "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v8, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    if-eqz v8, :cond_14

    new-instance v2, Landroid/content/Intent;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mCurrentIntent:Landroid/content/Intent;

    invoke-direct {v2, v8}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    .local v2, "intent":Landroid/content/Intent;
    :goto_3
    const-string v8, "com.lge.app.floating.launchAsFloating"

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.restarted"

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v8

    if-nez v8, :cond_15

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingWindow;->isInLowProfile()Z

    move-result v8

    if-eqz v8, :cond_15

    const-string v8, "com.lge.app.floating.lowProfileRequester"

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v9

    iget-object v9, v9, Lcom/lge/app/floating/FloatingWindowManager;->mLastLowProfileRequester:Ljava/lang/String;

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v8, "com.lge.app.floating.lowProfileIsHidden"

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v9

    iget-boolean v9, v9, Lcom/lge/app/floating/FloatingWindowManager;->mLastLowProfileIsHidden:Z

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    :cond_e
    :goto_4
    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;->getOrderingForStartActivity()I

    move-result v1

    .local v1, "delay":I
    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v9, "finishFloatingMode to restart"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->finishFloatingMode()V

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v9, "startActivity to restart"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " : wait for "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    mul-int/lit16 v10, v1, 0xbb8

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v4, Landroid/os/Message;

    invoke-direct {v4}, Landroid/os/Message;-><init>()V

    .local v4, "msg":Landroid/os/Message;
    iput-object v2, v4, Landroid/os/Message;->obj:Ljava/lang/Object;

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->restartActivityhandler:Landroid/os/Handler;

    mul-int/lit16 v9, v1, 0xbb8

    int-to-long v10, v9

    invoke-virtual {v8, v4, v10, v11}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .end local v1    # "delay":I
    .end local v2    # "intent":Landroid/content/Intent;
    .end local v4    # "msg":Landroid/os/Message;
    :cond_f
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    invoke-virtual {v8, p1}, Landroid/content/res/Configuration;->setTo(Landroid/content/res/Configuration;)V

    goto/16 :goto_0

    .end local v5    # "needRestart":Z
    :cond_10
    move v5, v10

    goto/16 :goto_1

    .restart local v5    # "needRestart":Z
    :cond_11
    iget-object v8, p1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-direct {p0, v8}, Lcom/lge/app/floating/FloatableActivity;->checkRtl(Ljava/util/Locale;)Z

    move-result v6

    .local v6, "newLanguageRtl":Z
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mOldConfig:Landroid/content/res/Configuration;

    iget-object v8, v8, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-direct {p0, v8}, Lcom/lge/app/floating/FloatableActivity;->checkRtl(Ljava/util/Locale;)Z

    move-result v7

    .local v7, "oldLanguageRtl":Z
    if-eq v6, v7, :cond_b

    sget-object v11, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "need restart for layout direction change from "

    invoke-virtual {v8, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    if-eqz v7, :cond_12

    const-string v8, "rtl"

    :goto_5
    invoke-virtual {v12, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v12, " to "

    invoke-virtual {v8, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    if-eqz v6, :cond_13

    const-string v8, "rtl"

    :goto_6
    invoke-virtual {v12, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v11, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, 0x1

    goto/16 :goto_2

    :cond_12
    const-string v8, "ltr"

    goto :goto_5

    :cond_13
    const-string v8, "ltr"

    goto :goto_6

    .end local v6    # "newLanguageRtl":Z
    .end local v7    # "oldLanguageRtl":Z
    :cond_14
    new-instance v2, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getIntent()Landroid/content/Intent;

    move-result-object v8

    invoke-direct {v2, v8}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    goto/16 :goto_3

    .restart local v2    # "intent":Landroid/content/Intent;
    :cond_15
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v8, v8, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    if-eqz v8, :cond_16

    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v8

    if-eqz v8, :cond_16

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "restarting intent contains NEED_TO_DOCK, direction of "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v12}, Lcom/lge/app/floating/FloatingWindow;->getDockDirection()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v8, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v8, "com.lge.floating.NEED_TO_DOCK"

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v8, "com.lge.floating.DOCK_POSX"

    iget-object v11, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v11, v11, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v11}, Lcom/lge/app/floating/FloatingDockWindow;->getDockWindowPosition()[I

    move-result-object v11

    aget v10, v11, v10

    invoke-virtual {v2, v8, v10}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v8, "com.lge.floating.DOCK_POSY"

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v10, v10, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v10}, Lcom/lge/app/floating/FloatingDockWindow;->getDockWindowPosition()[I

    move-result-object v10

    aget v9, v10, v9

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    :cond_16
    iget-object v8, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v8

    if-eqz v8, :cond_e

    sget-object v8, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "restarting intent contains alpha "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v10}, Lcom/lge/app/floating/FloatingWindow;->getUserOpacity()F

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v8, "com.lge.app.floating.opacity"

    iget-object v9, p0, Lcom/lge/app/floating/FloatableActivity;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v9}, Lcom/lge/app/floating/FloatingWindow;->getUserOpacity()F

    move-result v9

    invoke-virtual {v2, v8, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;F)Landroid/content/Intent;

    goto/16 :goto_4
.end method

.method public setContentViewForFloatingMode(I)V
    .locals 3
    .param p1, "resId"    # I

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, p1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .local v0, "v":Landroid/view/View;
    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatableActivity;->setContentViewForFloatingMode(Landroid/view/View;)V

    :cond_0
    return-void
.end method

.method public setContentViewForFloatingMode(Landroid/view/View;)V
    .locals 2
    .param p1, "contentView"    # Landroid/view/View;

    .prologue
    iput-object p1, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/app/floating/FloatableActivity;->mContentView:Landroid/view/View;

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatingWindow;->setContentView(Landroid/view/View;)V

    :cond_0
    return-void
.end method

.method public setDontFinishOnFloatingMode(Z)V
    .locals 3
    .param p1, "dontfinish"    # Z

    .prologue
    if-eqz p1, :cond_0

    sget-object v0, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Activity "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is configured to not be destroyed when in floating mode."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iput-boolean p1, p0, Lcom/lge/app/floating/FloatableActivity;->mDontFinishActivity:Z

    return-void
.end method

.method public setRequestedOrientation(I)V
    .locals 1
    .param p1, "requestedOrientation"    # I

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isStartedAsFloating()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v0

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchingToFloatingMode:Z

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-super {p0, p1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0
.end method

.method public setViewForConfigChanged()V
    .locals 0

    .prologue
    return-void
.end method

.method public setViewForConfigChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    return-void
.end method

.method public startActivityForResult(Landroid/content/Intent;I)V
    .locals 5
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "requestCode"    # I

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->isInFloatingMode()Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v2, -0x1

    if-eq p2, v2, :cond_0

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/lge/app/floating/FloatableActivity;->mIsWaitingActivityResult:Z

    const-string v2, "activity"

    invoke-virtual {p0, v2}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .local v0, "am":Landroid/app/ActivityManager;
    sget-object v2, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "moveTaskToFront : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatableActivity;->mActivityName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iget v2, p0, Lcom/lge/app/floating/FloatableActivity;->mTaskId:I

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/app/ActivityManager;->moveTaskToFront(II)V

    invoke-super {p0, p1, p2}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    .end local v0    # "am":Landroid/app/ActivityManager;
    :goto_0
    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindowManager;->getServiceContext()Landroid/content/Context;

    move-result-object v1

    .local v1, "c":Landroid/content/Context;
    if-nez v1, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatableActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    :cond_1
    const/high16 v2, 0x10000000

    invoke-virtual {p1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {v1, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .end local v1    # "c":Landroid/content/Context;
    :cond_2
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_0
.end method

.method public switchToFloatingMode()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, v2, v0, v2, v1}, Lcom/lge/app/floating/FloatableActivity;->switchToFloatingMode(ZZZLandroid/graphics/Rect;)V

    return-void
.end method

.method public switchToFloatingMode(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V
    .locals 3
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v2, "Switch to floating mode requested"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "activity"

    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .local v0, "am":Landroid/app/ActivityManager;
    invoke-virtual {v0}, Landroid/app/ActivityManager;->isInLockTaskMode()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    const-string v2, "Current is in LockTaskMode. Prevent switch to floating mode"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    const/4 v1, 0x1

    invoke-direct {p0, p1, v1}, Lcom/lge/app/floating/FloatableActivity;->switchToFloatingMode(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableActivity;->mIsSwitchToFloatingModeCalled:Z

    goto :goto_0
.end method

.method public switchToFloatingMode(ZZZLandroid/graphics/Rect;)V
    .locals 4
    .param p1, "useOverlay"    # Z
    .param p2, "useOverlappingTitle"    # Z
    .param p3, "isResizable"    # Z
    .param p4, "initialRegion"    # Landroid/graphics/Rect;

    .prologue
    new-instance v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    invoke-direct {v0, p0}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;-><init>(Landroid/content/Context;)V

    .local v0, "params":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    iput-boolean p1, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useOverlay:Z

    iput-boolean p2, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useOverlappingTitle:Z

    if-eqz p3, :cond_1

    const/4 v1, 0x3

    :goto_0
    iput v1, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    if-eqz p4, :cond_0

    sget-object v1, Lcom/lge/app/floating/FloatableActivity;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "switchToFloatingMode in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget v1, p4, Landroid/graphics/Rect;->left:I

    iput v1, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v1, p4, Landroid/graphics/Rect;->top:I

    iput v1, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual {p4}, Landroid/graphics/Rect;->width()I

    move-result v1

    iput v1, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-virtual {p4}, Landroid/graphics/Rect;->height()I

    move-result v1

    iput v1, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    :cond_0
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatableActivity;->switchToFloatingMode(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    return-void

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    .locals 2
    .param p1, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    :try_start_0
    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v1, Lcom/lge/app/floating/FloatableActivity$State;->STOP:Lcom/lge/app/floating/FloatableActivity$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FloatableActivity;->mState:Lcom/lge/app/floating/FloatableActivity$State;

    sget-object v1, Lcom/lge/app/floating/FloatableActivity$State;->DESTROY:Lcom/lge/app/floating/FloatableActivity$State;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatableActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;Z)V

    :goto_0
    return-void

    :cond_1
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatableActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;Z)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method
