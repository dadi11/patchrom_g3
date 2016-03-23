.class Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;
.super Landroid/content/BroadcastReceiver;
.source "FloatingWindowService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/app/floating/FloatingWindowService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "FloatingWindowEventReceiver"
.end annotation


# instance fields
.field mIsCalling:Ljava/lang/Boolean;

.field mIsQuickCoverClosed:Ljava/lang/Boolean;

.field mReceive_HIDE_INCALLFLOATING:Ljava/lang/Boolean;

.field mReceive_START_INCALLFLOATING:Ljava/lang/Boolean;

.field final synthetic this$0:Lcom/lge/app/floating/FloatingWindowService;


# direct methods
.method constructor <init>(Lcom/lge/app/floating/FloatingWindowService;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mReceive_START_INCALLFLOATING:Ljava/lang/Boolean;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mReceive_HIDE_INCALLFLOATING:Ljava/lang/Boolean;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    return-void
.end method

.method private handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V
    .locals 4
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "hide"    # Z
    .param p3, "pkgName"    # Ljava/lang/String;

    .prologue
    if-nez p3, :cond_0

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "intent FLOATING_WINDOW_ENTER_LOWPROFILE with NULL package name is ignored"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .end local p2    # "hide":Z
    :goto_0
    return-void

    .restart local p2    # "hide":Z
    :cond_0
    if-eqz p1, :cond_1

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleEnterLowProfile by "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mIsQuickCoverClosed : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    invoke-static {v1}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    .local v0, "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 p2, 0x1

    .end local p2    # "hide":Z
    :cond_2
    invoke-virtual {v0, p2, p3}, Lcom/lge/app/floating/FloatingWindowManager;->handleEnterLowProfile(ZLjava/lang/String;)V

    goto :goto_0
.end method

.method private handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V
    .locals 4
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "pkgName"    # Ljava/lang/String;

    .prologue
    if-nez p2, :cond_0

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "intent FLOATING_WINDOW_EXIT_LOWPROFILE with NULL package name is ignored"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    if-eqz p1, :cond_1

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleExitLowProfile by "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mIsQuickCoverClosed : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    invoke-static {v1}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    .local v0, "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_2

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Do not ExitLowProfile, Caused by Closed QuickCover Only lowProfileRequest updated."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0, p2}, Lcom/lge/app/floating/FloatingWindowManager;->removeLowProfileRequests(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    invoke-virtual {v0, p2}, Lcom/lge/app/floating/FloatingWindowManager;->handleExitLowProfile(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private setActionAccessoryEvent(Landroid/content/Intent;)V
    .locals 7
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x1

    const/4 v4, 0x0

    const-string v1, "com.lge.intent.extra.ACCESSORY_COVER_STATE"

    invoke-virtual {p1, v1, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .local v0, "state":I
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "state : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v0, :cond_1

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "EXTRA_ACCESSORY_STATE_FRONT_OPENED"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    const-string v1, "com.lge.coverapp"

    invoke-direct {p0, v6, v1}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_0

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Ensure enter lowprofile state when mIsCalling"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "phone"

    invoke-direct {p0, v6, v4, v1}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-eq v0, v5, :cond_2

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    :cond_2
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "EXTRA_ACCESSORY_STATE_FRONT_CLOSED || EXTRA_ACCESSORY_STATE_FRONT_HALFOPEN"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    const-string v1, "com.lge.coverapp"

    invoke-direct {p0, v6, v5, v1}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    goto :goto_0
.end method

.method private setActionCameraStarted(Landroid/content/Intent;)V
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v1, 0x1

    const-string v0, "isStart"

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "com.lge.camera"

    invoke-direct {p0, p1, v1, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "com.lge.camera"

    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private setActionEnterGuestMode(ZLcom/lge/app/floating/FloatingWindowManager;)V
    .locals 4
    .param p1, "isEnteringGuestMode"    # Z
    .param p2, "fwm"    # Lcom/lge/app/floating/FloatingWindowManager;

    .prologue
    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/app/floating/FloatingWindow;

    .local v1, "w":Lcom/lge/app/floating/FloatingWindow;
    if-nez p1, :cond_1

    iget-object v2, v1, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    sget-boolean v2, Lcom/lge/app/floating/FloatableActivity;->mIsInGuestMode:Z

    if-eqz v2, :cond_0

    :cond_1
    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow;->getActivity()Lcom/lge/app/floating/FloatableActivity;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.lge.ltecall"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Request Guest Mode...Finish Qslide App"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow;->closeInner()V

    goto :goto_0

    .end local v1    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_2
    return-void
.end method

.method private setActionFloatingWindowChanged(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V
    .locals 6
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "fwm"    # Lcom/lge/app/floating/FloatingWindowManager;

    .prologue
    const-string v3, "top-window"

    invoke-virtual {p1, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "topWindowActivityName":Ljava/lang/String;
    if-eqz v2, :cond_0

    invoke-virtual {p2, v2}, Lcom/lge/app/floating/FloatingWindowManager;->onTopWindowChanged(Ljava/lang/String;)V

    :cond_0
    const-string v3, "window-remove"

    invoke-virtual {p1, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "removedWindowActivityName":Ljava/lang/String;
    if-eqz v1, :cond_1

    const-string v3, "remove-reason"

    invoke-virtual {p1, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "removedReason":Ljava/lang/String;
    if-nez v0, :cond_2

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v3

    const-string v4, "Removed Reason value is null"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "removedReason":Ljava/lang/String;
    :cond_1
    :goto_0
    return-void

    .restart local v0    # "removedReason":Ljava/lang/String;
    :cond_2
    const-string v3, "fullmode"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Removed Reason : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p2, v1}, Lcom/lge/app/floating/FloatingWindowManager;->onWindowRemoved(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v3

    const-string v4, "Removed Reason is fullmode, do not handle new Top window."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private setActionFloatingWindowCloseRequested(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V
    .locals 8
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "fwm"    # Lcom/lge/app/floating/FloatingWindowManager;

    .prologue
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .local v0, "closeList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.intent.action.FLOATING_WINDOW_CLOSE_REQUESTED"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "target"

    invoke-virtual {p1, v5}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    :goto_0
    if-nez v0, :cond_1

    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/app/floating/FloatingWindow;

    .local v4, "w":Lcom/lge/app/floating/FloatingWindow;
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "FloatingWindow closes on request : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v4, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v5

    invoke-interface {v5}, Lcom/lge/app/floating/ITitleView;->performClose()V

    goto :goto_1

    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v4    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_0
    const-string v5, "com.lge.intent.extra.target"

    invoke-virtual {p1, v5}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .local v3, "packageName":Ljava/lang/String;
    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_3
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/app/floating/FloatingWindow;

    .restart local v4    # "w":Lcom/lge/app/floating/FloatingWindow;
    iget-object v5, v4, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    if-eqz v5, :cond_3

    iget-object v5, v4, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "FloatingWindow closes on request : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v5

    invoke-interface {v5}, Lcom/lge/app/floating/ITitleView;->performClose()V

    goto :goto_2

    .end local v2    # "i$":Ljava/util/Iterator;
    .end local v3    # "packageName":Ljava/lang/String;
    .end local v4    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_4
    return-void
.end method

.method private setActionFloatingWindowEnterLowprofile(Landroid/content/Intent;)V
    .locals 5
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v4, 0x0

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.lge.intent.action.FLOATING_WINDOW_ENTER_LOWPROFILE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "hide"

    invoke-virtual {p1, v2, v4}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    .local v0, "isHide":Z
    :goto_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.lge.intent.action.FLOATING_WINDOW_ENTER_LOWPROFILE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "package"

    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "pkgName":Ljava/lang/String;
    :goto_1
    invoke-direct {p0, p1, v0, v1}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    return-void

    .end local v0    # "isHide":Z
    .end local v1    # "pkgName":Ljava/lang/String;
    :cond_0
    const-string v2, "com.lge.intent.extra.hide"

    invoke-virtual {p1, v2, v4}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    goto :goto_0

    .restart local v0    # "isHide":Z
    :cond_1
    const-string v2, "com.lge.intent.extra.package"

    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1
.end method

.method private setActionFloatingWindowExitLowprofile(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V
    .locals 3
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "fwm"    # Lcom/lge/app/floating/FloatingWindowManager;

    .prologue
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    const-string v2, "com.lge.intent.action.FLOATING_WINDOW_EXIT_LOWPROFILE"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "package"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "pkgName":Ljava/lang/String;
    :goto_0
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_1

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "QuickCover is closed.... Do not Exit LowProfile. Only lowProfileRequest updated."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p2, v0}, Lcom/lge/app/floating/FloatingWindowManager;->removeLowProfileRequests(Ljava/lang/String;)V

    :goto_1
    return-void

    .end local v0    # "pkgName":Ljava/lang/String;
    :cond_0
    const-string v1, "com.lge.intent.extra.package"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .restart local v0    # "pkgName":Ljava/lang/String;
    :cond_1
    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V

    goto :goto_1
.end method

.method private setActionForceUndock(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V
    .locals 8
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "fwm"    # Lcom/lge/app/floating/FloatingWindowManager;

    .prologue
    const/4 v7, -0x1

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    const-string v6, "force UnDock"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "posX"

    invoke-virtual {p1, v5, v7}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    .local v1, "posX":I
    const-string v5, "posY"

    invoke-virtual {p1, v5, v7}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    .local v2, "posY":I
    const-string v5, "windowname"

    invoke-virtual {p1, v5}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "windowName":Ljava/lang/String;
    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/lge/app/floating/FloatingWindow;

    .local v3, "w":Lcom/lge/app/floating/FloatingWindow;
    invoke-virtual {v3}, Lcom/lge/app/floating/FloatingWindow;->getWindowName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    iget-object v5, v3, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Lcom/lge/app/floating/FloatingDockWindow;->updateDockState(I)V

    iget-object v5, v3, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v5, v1, v2}, Lcom/lge/app/floating/FloatingDockWindow;->onFinishingUndockAt(II)V

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatingWindow;->initFloatingDockWindow()V

    goto :goto_0

    .end local v3    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_1
    return-void
.end method

.method private setActionPhoneStateChanged(Landroid/content/Intent;)V
    .locals 10
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v9, 0x0

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    const-string v7, "com.lge.action.INCOMING_FULLSCREEN"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    const-string v7, "keyguard"

    invoke-virtual {v4, v7}, Lcom/lge/app/floating/FloatingWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/KeyguardManager;

    invoke-virtual {v4}, Landroid/app/KeyguardManager;->inKeyguardRestrictedInputMode()Z

    move-result v1

    .local v1, "isKeyguardOn":Z
    if-eqz v1, :cond_1

    move v4, v5

    :goto_0
    const-string v5, "phone"

    invoke-direct {p0, p1, v4, v5}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    .end local v1    # "isKeyguardOn":Z
    :cond_0
    :goto_1
    return-void

    .restart local v1    # "isKeyguardOn":Z
    :cond_1
    move v4, v6

    goto :goto_0

    .end local v1    # "isKeyguardOn":Z
    :cond_2
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    const-string v7, "com.lge.incallfloating.ACTION_REMOVEINCALLFLOATING"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "change call Flag \'false\' by intent com.lge.incallfloating.ACTION_REMOVEINCALLFLOATING"

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    goto :goto_1

    :cond_3
    const-string v4, "state"

    invoke-virtual {p1, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "state":Ljava/lang/String;
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "state : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v4, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v3, :cond_0

    sget-object v4, Landroid/telephony/TelephonyManager;->EXTRA_STATE_RINGING:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    # invokes: Lcom/lge/app/floating/FloatingWindowService;->isInTPhoneMode()Z
    invoke-static {v4}, Lcom/lge/app/floating/FloatingWindowService;->access$100(Lcom/lge/app/floating/FloatingWindowService;)Z

    move-result v4

    if-eqz v4, :cond_5

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v7, "enter low profile TPhone by intent android.telephony.TelephonyManager.EXTRA_STATE_RINGING"

    invoke-static {v4, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    const-string v7, "keyguard"

    invoke-virtual {v4, v7}, Lcom/lge/app/floating/FloatingWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/KeyguardManager;

    invoke-virtual {v4}, Landroid/app/KeyguardManager;->inKeyguardRestrictedInputMode()Z

    move-result v1

    .restart local v1    # "isKeyguardOn":Z
    if-eqz v1, :cond_4

    :goto_2
    const-string v4, "phone"

    invoke-direct {p0, v9, v5, v4}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    goto :goto_1

    :cond_4
    move v5, v6

    goto :goto_2

    .end local v1    # "isKeyguardOn":Z
    :cond_5
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "Do not action, just intent android.telephony.TelephonyManager.EXTRA_STATE_RINGING"

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :cond_6
    sget-object v4, Landroid/telephony/TelephonyManager;->EXTRA_STATE_OFFHOOK:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v7, "enter low profile by intent android.telephony.TelephonyManager.EXTRA_STATE_OFFHOOK"

    invoke-static {v4, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    const-string v7, "keyguard"

    invoke-virtual {v4, v7}, Lcom/lge/app/floating/FloatingWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/KeyguardManager;

    invoke-virtual {v4}, Landroid/app/KeyguardManager;->inKeyguardRestrictedInputMode()Z

    move-result v1

    .restart local v1    # "isKeyguardOn":Z
    const/4 v2, 0x1

    .local v2, "isKeyguardSecure":Z
    :try_start_0
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->sIsKeyguardSecure:Ljava/lang/reflect/Method;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$200()Ljava/lang/reflect/Method;

    move-result-object v4

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    const-string v8, "keyguard"

    invoke-virtual {v7, v8}, Lcom/lge/app/floating/FloatingWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    const/4 v8, 0x0

    new-array v8, v8, [Ljava/lang/Object;

    invoke-virtual {v4, v7, v8}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v7, "success to invoke isKeyguardSecure"

    invoke-static {v4, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_3
    if-eqz v1, :cond_7

    if-eqz v2, :cond_7

    const-string v4, "phone"

    invoke-direct {p0, v9, v5, v4}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    goto/16 :goto_1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v7, "fail to invoke isKeyguardSecure"

    invoke-static {v4, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v4, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_3

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_7
    const-string v4, "phone"

    invoke-direct {p0, v9, v6, v4}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    goto/16 :goto_1

    .end local v1    # "isKeyguardOn":Z
    .end local v2    # "isKeyguardSecure":Z
    :cond_8
    sget-object v4, Landroid/telephony/TelephonyManager;->EXTRA_STATE_IDLE:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "exit low profile by intent anandroid.telephony.TelephonyManager.EXTRA_STATE_IDLE"

    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    const-string v4, "phone"

    invoke-direct {p0, v9, v4}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V

    goto/16 :goto_1
.end method

.method private setActionStopFloatingWindowService(Landroid/content/Intent;)V
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Stop Floating Window Service"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowService;->stopSelf()V

    return-void
.end method

.method private setFloatingWindowAlreadyRunning(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V
    .locals 20
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "fwm"    # Lcom/lge/app/floating/FloatingWindowManager;

    .prologue
    const-string v16, "target"

    move-object/from16 v0, p1

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .local v11, "packageName":Ljava/lang/String;
    move-object/from16 v0, p2

    invoke-virtual {v0, v11}, Lcom/lge/app/floating/FloatingWindowManager;->getActivityNameForPackageName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "activityName":Ljava/lang/String;
    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindowFor(Ljava/lang/String;)Lcom/lge/app/floating/FloatingWindow;

    move-result-object v12

    .local v12, "targetWindow":Lcom/lge/app/floating/FloatingWindow;
    if-nez v12, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v16

    new-instance v17, Ljava/lang/StringBuilder;

    invoke-direct/range {v17 .. v17}, Ljava/lang/StringBuilder;-><init>()V

    const-string v18, "FloatingWindow for "

    invoke-virtual/range {v17 .. v18}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v17

    move-object/from16 v0, v17

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v17

    const-string v18, " is already running"

    invoke-virtual/range {v17 .. v18}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v17

    invoke-static/range {v16 .. v17}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v12}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v16

    if-eqz v16, :cond_2

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v16

    const-string v17, "release dock for request"

    invoke-static/range {v16 .. v17}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v16, 0x1

    move/from16 v0, v16

    invoke-virtual {v12, v2, v0}, Lcom/lge/app/floating/FloatingWindow;->releaseDockInner(Ljava/lang/String;Z)V

    goto :goto_0

    :cond_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Lcom/lge/app/floating/FloatingWindowService;->getApplicationContext()Landroid/content/Context;

    move-result-object v16

    invoke-static/range {v16 .. v16}, Lcom/lge/app/floating/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v8

    .local v8, "mResources":Landroid/content/res/Resources;
    const v16, 0x7f0a0002

    move/from16 v0, v16

    invoke-virtual {v8, v0}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v10

    .local v10, "msg":Ljava/lang/CharSequence;
    const/4 v3, 0x0

    .local v3, "appName":Ljava/lang/String;
    new-instance v6, Landroid/content/Intent;

    invoke-direct {v6}, Landroid/content/Intent;-><init>()V

    .local v6, "it":Landroid/content/Intent;
    const-string v16, "com.lge.intent.category.QSLIDE"

    move-object/from16 v0, v16

    invoke-virtual {v6, v0}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const-string v16, "android.intent.action.MAIN"

    move-object/from16 v0, v16

    invoke-virtual {v6, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Lcom/lge/app/floating/FloatingWindowService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v16

    const/16 v17, 0x80

    move-object/from16 v0, v16

    move/from16 v1, v17

    invoke-virtual {v0, v6, v1}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v7

    .local v7, "list":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .local v4, "i$":Ljava/util/Iterator;
    :cond_3
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/content/pm/ResolveInfo;

    .local v5, "info":Landroid/content/pm/ResolveInfo;
    iget-object v0, v5, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    move-object/from16 v16, v0

    move-object/from16 v0, v16

    iget-object v9, v0, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .local v9, "metaData":Landroid/os/Bundle;
    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v16

    invoke-virtual {v9}, Landroid/os/Bundle;->toString()Ljava/lang/String;

    move-result-object v17

    invoke-static/range {v16 .. v17}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, v5, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    move-object/from16 v16, v0

    move-object/from16 v0, v16

    iget-object v0, v0, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    move-object/from16 v16, v0

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_3

    iget-object v0, v5, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    move-object/from16 v16, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/lge/app/floating/FloatingWindowService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v17

    invoke-virtual/range {v16 .. v17}, Landroid/content/pm/ActivityInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v3

    .end local v3    # "appName":Ljava/lang/String;
    check-cast v3, Ljava/lang/String;

    .restart local v3    # "appName":Ljava/lang/String;
    goto :goto_1

    .end local v5    # "info":Landroid/content/pm/ResolveInfo;
    .end local v9    # "metaData":Landroid/os/Bundle;
    :cond_4
    if-nez v3, :cond_5

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Lcom/lge/app/floating/FloatingWindowService;->getResources()Landroid/content/res/Resources;

    move-result-object v16

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/lge/app/floating/FloatingWindowService;->getApplicationContext()Landroid/content/Context;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Landroid/content/pm/ApplicationInfo;->labelRes:I

    move/from16 v17, v0

    invoke-virtual/range {v16 .. v17}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    :cond_5
    const v16, 0x7f06000b

    move/from16 v0, v16

    invoke-virtual {v8, v0}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v15

    .local v15, "yOffset":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Lcom/lge/app/floating/FloatingWindowService;->getApplicationContext()Landroid/content/Context;

    move-result-object v16

    invoke-interface {v10}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v17

    const/16 v18, 0x1

    move/from16 v0, v18

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v18, v0

    const/16 v19, 0x0

    aput-object v3, v18, v19

    invoke-static/range {v17 .. v18}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v17

    const/16 v18, 0x0

    invoke-static/range {v16 .. v18}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v13

    .local v13, "toast":Landroid/widget/Toast;
    const/16 v16, 0x31

    const/16 v17, 0x0

    move/from16 v0, v16

    move/from16 v1, v17

    invoke-virtual {v13, v0, v1, v15}, Landroid/widget/Toast;->setGravity(III)V

    invoke-virtual {v13}, Landroid/widget/Toast;->show()V

    invoke-virtual/range {p2 .. p2}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v16

    invoke-interface/range {v16 .. v16}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_6
    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lcom/lge/app/floating/FloatingWindow;

    .local v14, "w":Lcom/lge/app/floating/FloatingWindow;
    iget-object v0, v14, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_6

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v16

    new-instance v17, Ljava/lang/StringBuilder;

    invoke-direct/range {v17 .. v17}, Ljava/lang/StringBuilder;-><init>()V

    const-string v18, "Ensure Exit Low Profile for : "

    invoke-virtual/range {v17 .. v18}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v17

    move-object/from16 v0, v17

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v17

    invoke-static/range {v16 .. v17}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct {v0, v1, v11}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V

    goto :goto_2
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Receive Intent : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->this$0:Lcom/lge/app/floating/FloatingWindowService;

    invoke-static {v5}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v0

    .local v0, "fwm":Lcom/lge/app/floating/FloatingWindowManager;
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.intent.action.FLOATING_WINDOW_CHANGED"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-direct {p0, p2, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionFloatingWindowChanged(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.camera.action.LGE_CAMERA_STARTED"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-direct {p0, p2}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionCameraStarted(Landroid/content/Intent;)V

    goto :goto_0

    :cond_2
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.intent.action.FLOATING_WINDOW_ENTER_LOWPROFILE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.android.intent.action.FLOATING_WINDOW_ENTER_LOWPROFILE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    :cond_3
    invoke-direct {p0, p2}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionFloatingWindowEnterLowprofile(Landroid/content/Intent;)V

    goto :goto_0

    :cond_4
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.intent.action.FLOATING_WINDOW_EXIT_LOWPROFILE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.android.intent.action.FLOATING_WINDOW_EXIT_LOWPROFILE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    :cond_5
    invoke-direct {p0, p2, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionFloatingWindowExitLowprofile(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V

    goto :goto_0

    :cond_6
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.softkeypad.intent.SHOW"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.softkeypad.intent.HIDE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_9

    :cond_7
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.softkeypad.intent.SHOW"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_8

    :goto_1
    invoke-virtual {v0, v3}, Lcom/lge/app/floating/FloatingWindowManager;->handleImeVisibilityChanged(Z)V

    goto :goto_0

    :cond_8
    move v3, v4

    goto :goto_1

    :cond_9
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.intent.action.FLOATING_WINDOW_CLOSE_REQUESTED"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_a

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.android.intent.action.FLOATING_WINDOW_CLOSE_REQUESTED"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_b

    :cond_a
    invoke-direct {p0, p2, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionFloatingWindowCloseRequested(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V

    goto/16 :goto_0

    :cond_b
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.action.INCOMING_FULLSCREEN"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_c

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.incallfloating.ACTION_REMOVEINCALLFLOATING"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_c

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "android.intent.action.PHONE_STATE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_d

    :cond_c
    invoke-direct {p0, p2}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionPhoneStateChanged(Landroid/content/Intent;)V

    goto/16 :goto_0

    :cond_d
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.intent.action.FLOATING_WINDOW_ALREADY_RUNNING"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_e

    invoke-direct {p0, p2, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setFloatingWindowAlreadyRunning(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V

    goto/16 :goto_0

    :cond_e
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.lockscreen.intent.action.START_KIDSHOME"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_f

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "android.intent.action.USER_SWITCHED"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_10

    :cond_f
    invoke-direct {p0, v3, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionEnterGuestMode(ZLcom/lge/app/floating/FloatingWindowManager;)V

    goto/16 :goto_0

    :cond_10
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.lockscreen.intent.action.LOCKSCREEN_CREATE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_11

    invoke-direct {p0, v4, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionEnterGuestMode(ZLcom/lge/app/floating/FloatingWindowManager;)V

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/app/floating/FloatingWindow;

    .local v2, "w":Lcom/lge/app/floating/FloatingWindow;
    const-string v4, "lockscreen"

    invoke-direct {p0, p2, v3, v4}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleEnterLowProfile(Landroid/content/Intent;ZLjava/lang/String;)V

    goto :goto_2

    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_11
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "com.lge.lockscreen.intent.action.START_STANDARD_HOME"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_12

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsQuickCoverClosed:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-nez v3, :cond_12

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->mIsCalling:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-nez v3, :cond_12

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .restart local v1    # "i$":Ljava/util/Iterator;
    :goto_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/app/floating/FloatingWindow;

    .restart local v2    # "w":Lcom/lge/app/floating/FloatingWindow;
    const-string v3, "lockscreen"

    invoke-direct {p0, p2, v3}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->handleExitLowProfile(Landroid/content/Intent;Ljava/lang/String;)V

    goto :goto_3

    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_12
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "com.lge.android.intent.action.ACCESSORY_COVER_EVENT"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_13

    invoke-direct {p0, p2}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionAccessoryEvent(Landroid/content/Intent;)V

    goto/16 :goto_0

    :cond_13
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "com.lge.intent.action.FORCE_UNDOCK"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_14

    invoke-direct {p0, p2, v0}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionForceUndock(Landroid/content/Intent;Lcom/lge/app/floating/FloatingWindowManager;)V

    goto/16 :goto_0

    :cond_14
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "com.lge.intent.action.APP_SWITCH_ACTION_DOWN"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_15

    # getter for: Lcom/lge/app/floating/FloatingWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindowService;->access$000()Ljava/lang/String;

    move-result-object v3

    const-string v4, "APP_SWITCH key ACTION_DOWN detected.\nLoose all focus about floating window"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->getFloatingWindows()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .restart local v1    # "i$":Ljava/util/Iterator;
    :goto_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/app/floating/FloatingWindow;

    .restart local v2    # "w":Lcom/lge/app/floating/FloatingWindow;
    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    goto :goto_4

    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "w":Lcom/lge/app/floating/FloatingWindow;
    :cond_15
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "com.lge.intent.action.STOP_FLOATING_WINDOW_SERVICE"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-direct {p0, p2}, Lcom/lge/app/floating/FloatingWindowService$FloatingWindowEventReceiver;->setActionStopFloatingWindowService(Landroid/content/Intent;)V

    goto/16 :goto_0
.end method
