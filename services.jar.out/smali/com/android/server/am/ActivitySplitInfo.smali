.class public Lcom/android/server/am/ActivitySplitInfo;
.super Ljava/lang/Object;
.source "ActivitySplitInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    }
.end annotation


# static fields
.field static final DEBUG:Z = true

.field static final FLAG_SPLIT_AUTO_SPLIT:I = 0x2000

.field static final FLAG_SPLIT_MULTIPLE_INSTANCE:I = 0x8000

.field static final FLAG_SPLIT_SUPPORT_AS_SOURCE:I = 0x4000

.field static final FLAG_SPLIT_SUPPORT_SPLIT:I = 0x1000

.field static final TAG:Ljava/lang/String; = "SplitInfo"


# instance fields
.field private mFlag:I

.field private mScreenZone:I

.field private mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;


# direct methods
.method public constructor <init>(Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;)V
    .locals 3
    .param p1, "screen"    # Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;

    .prologue
    const/4 v1, 0x0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    .line 33
    sget-object v0, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 34
    iput v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    .line 35
    if-eqz p1, :cond_1

    .line 36
    iget v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    invoke-interface {p1}, Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;->isSupportSplit()Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 v0, 0x1000

    :goto_0
    or-int/2addr v0, v2

    iput v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    .line 37
    iget v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    invoke-interface {p1}, Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;->isAutoSplit()Z

    move-result v0

    if-eqz v0, :cond_3

    const/16 v0, 0x2000

    :goto_1
    or-int/2addr v0, v2

    iput v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    .line 40
    iget v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    invoke-interface {p1}, Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;->isSupportMultipleInstance()Z

    move-result v2

    if-eqz v2, :cond_0

    const v1, 0x8000

    :cond_0
    or-int/2addr v0, v1

    iput v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    .line 42
    invoke-interface {p1}, Lcom/lge/loader/splitwindow/ISplitWindow$ILaunchedScreen;->getScreenZone()I

    move-result v0

    iput v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    .line 44
    :cond_1
    const-string v0, "SplitInfo"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "new ActivitySplitInfo : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 45
    return-void

    :cond_2
    move v0, v1

    .line 36
    goto :goto_0

    :cond_3
    move v0, v1

    .line 37
    goto :goto_1
.end method

.method private isSupportSplit()Z
    .locals 1

    .prologue
    .line 68
    iget v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    and-int/lit16 v0, v0, 0x1000

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public canBeSplited()Z
    .locals 2

    .prologue
    .line 81
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v0, v1, :cond_0

    invoke-direct {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getScreenZone()I
    .locals 1

    .prologue
    .line 48
    iget v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    return v0
.end method

.method public getState()Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    .locals 1

    .prologue
    .line 212
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    return-object v0
.end method

.method public inheritRequestedScreenZone(Lcom/android/server/am/ActivitySplitInfo;)V
    .locals 3
    .param p1, "prev"    # Lcom/android/server/am/ActivitySplitInfo;

    .prologue
    .line 99
    if-nez p1, :cond_0

    .line 104
    :goto_0
    return-void

    .line 102
    :cond_0
    iget v0, p1, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    iput v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    .line 103
    const-string v0, "SplitInfo"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "inheriteScreen as "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isAutoSplit()Z
    .locals 1

    .prologue
    .line 56
    iget v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    and-int/lit16 v0, v0, 0x2000

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isFullScreen()Z
    .locals 2

    .prologue
    .line 92
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v0, v1, :cond_1

    .line 94
    :cond_0
    const/4 v0, 0x0

    .line 95
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public isNative()Z
    .locals 2

    .prologue
    .line 201
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isRequested()Z
    .locals 2

    .prologue
    .line 197
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NORMAL_REQUESTED:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSplitNormal()Z
    .locals 2

    .prologue
    .line 216
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSplitWhatever()Z
    .locals 2

    .prologue
    .line 85
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_FULL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSupportAsSource()Z
    .locals 1

    .prologue
    .line 60
    iget v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    and-int/lit16 v0, v0, 0x4000

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSupportMultipleInstance()Z
    .locals 2

    .prologue
    .line 64
    iget v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    const v1, 0x8000

    and-int/2addr v0, v1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

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
    .line 72
    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportAsSource()Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p1, Lcom/android/server/am/ActivityRecord;->splitInfo:Lcom/android/server/am/ActivitySplitInfo;

    invoke-direct {v0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit()Z

    move-result v0

    .line 76
    :goto_0
    return v0

    :cond_0
    invoke-direct {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit()Z

    move-result v0

    goto :goto_0
.end method

.method public setFull()Z
    .locals 1

    .prologue
    .line 119
    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportAsSource()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/server/am/ActivitySplitInfo;->setFull(Z)Z

    move-result v0

    return v0
.end method

.method public setFull(Z)Z
    .locals 4
    .param p1, "force"    # Z

    .prologue
    .line 148
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 149
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v1, v2, :cond_0

    invoke-direct {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit()Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    if-eqz p1, :cond_2

    .line 150
    :cond_1
    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_FULL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 153
    :cond_2
    const-string v1, "SplitInfo"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setSplit "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " -> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_3

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_3
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setInvisible()Z
    .locals 1

    .prologue
    .line 123
    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportAsSource()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/server/am/ActivitySplitInfo;->setInvisible(Z)Z

    move-result v0

    return v0
.end method

.method public setInvisible(Z)Z
    .locals 4
    .param p1, "force"    # Z

    .prologue
    .line 158
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 159
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v1, v2, :cond_0

    if-eqz p1, :cond_1

    .line 160
    :cond_0
    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 163
    :cond_1
    const-string v1, "SplitInfo"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setSplit "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " -> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 164
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_2

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_2
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setNative()Z
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 180
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 181
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 182
    iput v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    .line 184
    const-string v2, "SplitInfo"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setNative "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " -> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 185
    iget-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v2, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1
.end method

.method public setRequested()Z
    .locals 3

    .prologue
    .line 189
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 190
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v1, v2, :cond_0

    invoke-direct {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportSplit()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 191
    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NORMAL_REQUESTED:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 193
    :cond_0
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_1

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setScreenZone(I)V
    .locals 0
    .param p1, "zone"    # I

    .prologue
    .line 52
    iput p1, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    .line 53
    return-void
.end method

.method public setSplit()Z
    .locals 1

    .prologue
    .line 115
    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->isSupportAsSource()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/server/am/ActivitySplitInfo;->setSplit(Z)Z

    move-result v0

    return v0
.end method

.method public setSplit(Z)Z
    .locals 5
    .param p1, "force"    # Z

    .prologue
    const/4 v1, 0x0

    .line 128
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 129
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    iget-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v3, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NORMAL_REQUESTED:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v2, v3, :cond_0

    iget-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v3, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->NATIVE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v2, v3, :cond_4

    .line 131
    :cond_0
    if-nez p1, :cond_2

    invoke-virtual {p0}, Lcom/android/server/am/ActivitySplitInfo;->getScreenZone()I

    move-result v2

    if-nez v2, :cond_2

    .line 132
    const-string v2, "SplitInfo"

    const-string v3, "Cant be split. ScreenZone is not specified."

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    :cond_1
    :goto_0
    return v1

    .line 135
    :cond_2
    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 143
    :cond_3
    :goto_1
    const-string v2, "SplitInfo"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setSplit "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " -> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    iget-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v2, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    .line 136
    :cond_4
    iget-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v3, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_FULL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v2, v3, :cond_5

    iget-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v3, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v2, v3, :cond_6

    .line 138
    :cond_5
    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    goto :goto_1

    .line 139
    :cond_6
    if-eqz p1, :cond_3

    .line 140
    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v2, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    goto :goto_1
.end method

.method public setState(Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;)Z
    .locals 4
    .param p1, "_state"    # Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .prologue
    .line 108
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 109
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    iput-object p1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 110
    const-string v1, "SplitInfo"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setSplit "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " -> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setSupportAsSource(Z)V
    .locals 3
    .param p1, "b"    # Z

    .prologue
    .line 220
    iget v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    if-eqz p1, :cond_0

    const/16 v0, 0x4000

    :goto_0
    or-int/2addr v0, v1

    iput v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    .line 221
    const-string v0, "SplitInfo"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setSupportAsSource: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 222
    return-void

    .line 220
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setUnSplit()Z
    .locals 4

    .prologue
    .line 168
    iget-object v0, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 169
    .local v0, "_old":Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_INVISIBLE:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_FULL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    sget-object v2, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->SPLITED_NORMAL:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-ne v1, v2, :cond_1

    .line 172
    :cond_0
    sget-object v1, Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;->UN_SPLITING:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    iput-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    .line 175
    :cond_1
    const-string v1, "SplitInfo"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setUnSplit "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " -> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    if-eq v0, v1, :cond_2

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_2
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 206
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ActivitySplitInfo [screenZone="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mScreenZone:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/ flag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mFlag:I

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/ state="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/am/ActivitySplitInfo;->mState:Lcom/android/server/am/ActivitySplitInfo$ActivitySplitState;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
