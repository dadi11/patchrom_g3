.class final Lcom/android/server/am/SplitWindowManager$SplitActivity;
.super Ljava/lang/Object;
.source "SplitWindowManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/am/SplitWindowManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "SplitActivity"
.end annotation


# instance fields
.field ar:Lcom/android/server/am/ActivityRecord;

.field stackId:I

.field taskId:I

.field final synthetic this$0:Lcom/android/server/am/SplitWindowManager;


# direct methods
.method public constructor <init>(Lcom/android/server/am/SplitWindowManager;Lcom/android/server/am/ActivityRecord;)V
    .locals 0
    .param p2, "ar"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 85
    iput-object p1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->this$0:Lcom/android/server/am/SplitWindowManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 86
    iput-object p2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    .line 87
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->updateStackInfo()Z

    .line 95
    return-void
.end method

.method private createScreenInfo()Z
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 98
    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getRequstedScreenZone()I

    move-result v2

    .line 99
    .local v2, "zone":I
    if-gez v2, :cond_0

    .line 100
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Cant get screenZone. for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 114
    :goto_0
    return v3

    .line 104
    :cond_0
    iget-object v4, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->this$0:Lcom/android/server/am/SplitWindowManager;

    invoke-virtual {v4}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    .line 105
    .local v1, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-eqz v1, :cond_1

    .line 107
    :try_start_0
    iget v4, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->getRequstedScreenZone()I

    move-result v5

    invoke-interface {v1, v4, v5}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->createScreen(II)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 114
    :cond_1
    const/4 v3, 0x1

    goto :goto_0

    .line 108
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Landroid/os/RemoteException;
    const-string v4, "SplitWindowManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Exception on createScreenInfo - "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public getCurrentScreenZone()I
    .locals 5

    .prologue
    .line 212
    const/4 v2, 0x0

    .line 213
    .local v2, "screenInfo":Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    iget-object v3, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->this$0:Lcom/android/server/am/SplitWindowManager;

    invoke-virtual {v3}, Lcom/android/server/am/SplitWindowManager;->getSplitWindowPolicy()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    .line 214
    .local v1, "policy":Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    if-eqz v1, :cond_0

    .line 216
    :try_start_0
    iget v3, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-interface {v1, v3}, Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;->getScreenInfo(I)Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 222
    :cond_0
    :goto_0
    if-eqz v2, :cond_1

    invoke-interface {v2}, Lcom/lge/loader/splitwindow/ISplitWindow$IScreenInfo;->getScreenZone()I

    move-result v3

    :goto_1
    return v3

    .line 217
    :catch_0
    move-exception v0

    .line 218
    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "SplitWindowManager"

    const-string v4, "Exception on getScreenInfo"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 222
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    const/4 v3, 0x0

    goto :goto_1
.end method

.method public getRequstedScreenZone()I
    .locals 1

    .prologue
    .line 226
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->getScreenZone()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    .locals 1

    .prologue
    .line 238
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    .line 239
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v0

    .line 241
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isNative()Z
    .locals 1

    .prologue
    .line 234
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->isNative()Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isRequested()Z
    .locals 1

    .prologue
    .line 201
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->isRequested()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSplited()Z
    .locals 1

    .prologue
    .line 230
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->isSplitWhatever()Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z
    .locals 1
    .param p1, "source"    # Lcom/android/server/am/ActivityRecord;

    .prologue
    .line 165
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0, p1}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit(Lcom/android/server/am/ActivityRecord;)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setFull()V
    .locals 3

    .prologue
    .line 131
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setFull()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 132
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setFull for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 133
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->this$0:Lcom/android/server/am/SplitWindowManager;

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->appToken:Landroid/view/IApplicationToken$Stub;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/android/server/wm/WindowManagerService;->setSplitFullscreenToWindow(Landroid/view/IApplicationToken;Z)V

    .line 137
    :goto_0
    return-void

    .line 135
    :cond_0
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "can not setFull "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setInvisible()V
    .locals 3

    .prologue
    .line 140
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setInvisible()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 141
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setInvisible for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 145
    :goto_0
    return-void

    .line 143
    :cond_0
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "can not setInvisible"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setNative()V
    .locals 3

    .prologue
    .line 157
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setNative()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 158
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setNormal for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 162
    :goto_0
    return-void

    .line 160
    :cond_0
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setNormal do nothing. "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setScreenZone(I)V
    .locals 1
    .param p1, "zone"    # I

    .prologue
    .line 205
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    .line 206
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0, p1}, Lcom/android/server/am/ActivitySplitInfo;->setScreenZone(I)V

    .line 209
    :cond_0
    return-void
.end method

.method public setSplit()V
    .locals 3

    .prologue
    .line 118
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_1

    .line 119
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setSplit()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 120
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setSplit for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    invoke-direct {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->createScreenInfo()Z

    .line 124
    :cond_0
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->this$0:Lcom/android/server/am/SplitWindowManager;

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->appToken:Landroid/view/IApplicationToken$Stub;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/android/server/wm/WindowManagerService;->setSplitFullscreenToWindow(Landroid/view/IApplicationToken;Z)V

    .line 128
    :goto_0
    return-void

    .line 126
    :cond_1
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "not splited, for already splited or something... "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/server/am/SplitWindowManager$SplitActivity;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setUnSplit(Z)V
    .locals 3
    .param p1, "force"    # Z

    .prologue
    .line 148
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v0}, Lcom/android/server/am/ActivitySplitInfo;->setUnSplit()Z

    move-result v0

    if-nez v0, :cond_0

    if-eqz p1, :cond_1

    .line 149
    :cond_0
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setUnSplit for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->this$0:Lcom/android/server/am/SplitWindowManager;

    iget-object v0, v0, Lcom/android/server/am/SplitWindowManager;->mWindowManager:Lcom/android/server/wm/WindowManagerService;

    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->appToken:Landroid/view/IApplicationToken$Stub;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/android/server/wm/WindowManagerService;->setSplitFullscreenToWindow(Landroid/view/IApplicationToken;Z)V

    .line 154
    :goto_0
    return-void

    .line 152
    :cond_1
    const-string v0, "SplitWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setUnSplit do nothing. "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public toDetailString()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 178
    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v1, :cond_1

    .line 179
    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v1}, Lcom/android/server/am/ActivitySplitInfo;->toString()Ljava/lang/String;

    move-result-object v0

    .line 180
    .local v0, "splitInfoDesc":Ljava/lang/String;
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityRecord;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " /t "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->taskId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " /s "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " /"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->state:Lcom/android/server/am/ActivityStack$ActivityState;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " /"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 183
    .end local v0    # "splitInfoDesc":Ljava/lang/String;
    :cond_1
    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 170
    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v1, :cond_1

    .line 171
    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v1, v1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-virtual {v1}, Lcom/android/server/am/ActivitySplitInfo;->getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    move-result-object v0

    .line 172
    .local v0, "splitState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    invoke-virtual {v2}, Lcom/android/server/am/ActivityRecord;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " /t:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->taskId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/s:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " /state: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v2, v2, Lcom/android/server/am/ActivityRecord;->state:Lcom/android/server/am/ActivityStack$ActivityState;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "+"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 174
    .end local v0    # "splitState":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    :cond_1
    return-object v0
.end method

.method public updateStackInfo()Z
    .locals 2

    .prologue
    const/4 v1, -0x1

    .line 187
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    if-eqz v0, :cond_0

    .line 188
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget-object v0, v0, Lcom/android/server/am/TaskRecord;->stack:Lcom/android/server/am/ActivityStack;

    iget v0, v0, Lcom/android/server/am/ActivityStack;->mStackId:I

    iput v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    .line 189
    iget-object v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->ar:Lcom/android/server/am/ActivityRecord;

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->task:Lcom/android/server/am/TaskRecord;

    iget v0, v0, Lcom/android/server/am/TaskRecord;->taskId:I

    iput v0, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->taskId:I

    .line 191
    const/4 v0, 0x1

    .line 197
    :goto_0
    return v0

    .line 193
    :cond_0
    iput v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->stackId:I

    .line 194
    iput v1, p0, Lcom/android/server/am/SplitWindowManager$SplitActivity;->taskId:I

    .line 195
    const-string v0, "SplitWindowManager"

    const-string v1, "updateStackInfo failed..."

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    const/4 v0, 0x0

    goto :goto_0
.end method
