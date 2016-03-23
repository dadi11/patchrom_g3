.class final Landroid/media/AudioServiceEx$ExtendedBinderInternal;
.super Landroid/media/IAudioServiceEx$Stub;
.source "AudioServiceEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/AudioServiceEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "ExtendedBinderInternal"
.end annotation


# instance fields
.field final synthetic this$0:Landroid/media/AudioServiceEx;


# direct methods
.method private constructor <init>(Landroid/media/AudioServiceEx;)V
    .locals 0

    .prologue
    iput-object p1, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    invoke-direct {p0}, Landroid/media/IAudioServiceEx$Stub;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Landroid/media/AudioServiceEx;Landroid/media/AudioServiceEx$1;)V
    .locals 0
    .param p1, "x0"    # Landroid/media/AudioServiceEx;
    .param p2, "x1"    # Landroid/media/AudioServiceEx$1;

    .prologue
    invoke-direct {p0, p1}, Landroid/media/AudioServiceEx$ExtendedBinderInternal;-><init>(Landroid/media/AudioServiceEx;)V

    return-void
.end method


# virtual methods
.method public getActiveStreamType(I)I
    .locals 1
    .param p1, "suggestedStreamType"    # I

    .prologue
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    invoke-virtual {v0, p1}, Landroid/media/AudioServiceEx;->getActiveStreamType(I)I

    move-result v0

    return v0
.end method

.method public getPlayerList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v0, v0, Landroid/media/AudioServiceEx;->mMediaFocusControl:Landroid/media/MediaFocusControl;

    check-cast v0, Landroid/media/MediaFocusControlEx;

    invoke-virtual {v0}, Landroid/media/MediaFocusControlEx;->getPlayerList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getPlayerPlayBackState()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v0, v0, Landroid/media/AudioServiceEx;->mMediaFocusControl:Landroid/media/MediaFocusControl;

    check-cast v0, Landroid/media/MediaFocusControlEx;

    invoke-virtual {v0}, Landroid/media/MediaFocusControlEx;->getPlayerPlayBackState()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getRemoteStreamMaxVolume()I
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v0, v0, Landroid/media/AudioServiceEx;->mMediaFocusControl:Landroid/media/MediaFocusControl;

    invoke-virtual {v0}, Landroid/media/MediaFocusControl;->getRemoteStreamMaxVolume()I

    move-result v0

    return v0
.end method

.method public getRemoteStreamVolume()I
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v0, v0, Landroid/media/AudioServiceEx;->mMediaFocusControl:Landroid/media/MediaFocusControl;

    invoke-virtual {v0}, Landroid/media/MediaFocusControl;->getRemoteStreamVolume()I

    move-result v0

    return v0
.end method

.method public isBluetoothA2dpInputOn()Z
    .locals 2

    .prologue
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mBluetoothA2dpInputEnabledLock:Ljava/lang/Object;
    invoke-static {v0}, Landroid/media/AudioServiceEx;->access$1600(Landroid/media/AudioServiceEx;)Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mBluetoothA2dpInputEnabled:Z
    invoke-static {v0}, Landroid/media/AudioServiceEx;->access$1500(Landroid/media/AudioServiceEx;)Z

    move-result v0

    monitor-exit v1

    return v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public isSpeakerOnForMedia()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    iget-object v1, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mForcedUseForMedia:I
    invoke-static {v1}, Landroid/media/AudioServiceEx;->access$1300(Landroid/media/AudioServiceEx;)I

    move-result v1

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setBluetoothA2dpInputOn(Z)V
    .locals 3
    .param p1, "on"    # Z

    .prologue
    const-string v0, "AudioServiceEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setBluetoothA2dpInputOn  on:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    const-string v1, "setBluetoothA2dpInputOn()"

    invoke-virtual {v0, v1}, Landroid/media/AudioServiceEx;->checkAudioSettingsPermission(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # setter for: Landroid/media/AudioServiceEx;->mBluetoothA2dpInputEnabled:Z
    invoke-static {v0, p1}, Landroid/media/AudioServiceEx;->access$1502(Landroid/media/AudioServiceEx;Z)Z

    if-eqz p1, :cond_1

    const-string v0, "A2dpInputEnable=1"

    invoke-static {v0}, Landroid/media/AudioSystem;->setParameters(Ljava/lang/String;)I

    :goto_1
    const-string v0, "AudioServiceEx"

    const-string v1, "setBluetoothA2dpInputOn done"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    const-string v0, "A2dpInputEnable=0"

    invoke-static {v0}, Landroid/media/AudioSystem;->setParameters(Ljava/lang/String;)I

    goto :goto_1
.end method

.method public setSpeakerOnForMedia(Z)V
    .locals 7
    .param p1, "on"    # Z

    .prologue
    const/16 v2, 0xa

    const/4 v6, 0x0

    const/4 v3, 0x1

    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    const-string v1, "setSpeakerOnForMedia()"

    invoke-virtual {v0, v1}, Landroid/media/AudioServiceEx;->checkAudioSettingsPermission(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "AudioServiceEx"

    const-string v1, "setSpeakerOnForMedia() permission denied!"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    if-eqz p1, :cond_1

    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # setter for: Landroid/media/AudioServiceEx;->mForcedUseForMedia:I
    invoke-static {v0, v3}, Landroid/media/AudioServiceEx;->access$1302(Landroid/media/AudioServiceEx;I)I

    :goto_1
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    invoke-static {v3}, Landroid/media/AudioSystem;->getForceUse(I)I

    move-result v1

    # setter for: Landroid/media/AudioServiceEx;->mPrevForcedUseForMedia:I
    invoke-static {v0, v1}, Landroid/media/AudioServiceEx;->access$1402(Landroid/media/AudioServiceEx;I)I

    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v0, v0, Landroid/media/AudioServiceEx;->mAudioHandler:Landroid/media/AudioService$AudioHandler;

    const/16 v1, 0x8

    const/4 v2, 0x2

    iget-object v4, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mForcedUseForMedia:I
    invoke-static {v4}, Landroid/media/AudioServiceEx;->access$1300(Landroid/media/AudioServiceEx;)I

    move-result v4

    const/4 v5, 0x0

    invoke-static/range {v0 .. v6}, Landroid/media/AudioService;->sendMsg(Landroid/os/Handler;IIIILjava/lang/Object;I)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mPrevForcedUseForMedia:I
    invoke-static {v0}, Landroid/media/AudioServiceEx;->access$1400(Landroid/media/AudioServiceEx;)I

    move-result v0

    if-ne v0, v2, :cond_2

    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # setter for: Landroid/media/AudioServiceEx;->mForcedUseForMedia:I
    invoke-static {v0, v2}, Landroid/media/AudioServiceEx;->access$1302(Landroid/media/AudioServiceEx;I)I

    goto :goto_1

    :cond_2
    iget-object v0, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    # setter for: Landroid/media/AudioServiceEx;->mForcedUseForMedia:I
    invoke-static {v0, v6}, Landroid/media/AudioServiceEx;->access$1302(Landroid/media/AudioServiceEx;I)I

    goto :goto_1
.end method

.method public setStreamVolumeAll(III)V
    .locals 7
    .param p1, "streamType"    # I
    .param p2, "index"    # I
    .param p3, "flags"    # I

    .prologue
    const/4 v6, 0x1

    iget-object v3, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    invoke-virtual {v3, p1}, Landroid/media/AudioServiceEx;->ensureValidStreamType(I)V

    const/4 v0, 0x2

    .local v0, "device":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    const/4 v3, 0x4

    if-ge v1, v3, :cond_4

    if-nez v1, :cond_1

    const/4 v0, 0x2

    :cond_0
    :goto_1
    iget-object v3, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    mul-int/lit8 v4, p2, 0xa

    iget-object v5, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v5, v5, Landroid/media/AudioServiceEx;->mStreamVolumeAlias:[I

    aget v5, v5, p1

    invoke-virtual {v3, v4, p1, v5}, Landroid/media/AudioServiceEx;->rescaleIndex(III)I

    move-result v2

    .local v2, "indexTemp":I
    iget-object v3, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v4, p0, Landroid/media/AudioServiceEx$ExtendedBinderInternal;->this$0:Landroid/media/AudioServiceEx;

    iget-object v4, v4, Landroid/media/AudioServiceEx;->mStreamVolumeAlias:[I

    aget v4, v4, p1

    invoke-virtual {v3, v4, v2, v0, v6}, Landroid/media/AudioServiceEx;->setStreamVolumeInt(IIIZ)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v2    # "indexTemp":I
    :cond_1
    if-ne v1, v6, :cond_2

    const/4 v0, 0x4

    goto :goto_1

    :cond_2
    const/4 v3, 0x2

    if-ne v1, v3, :cond_3

    const/16 v0, 0x8

    goto :goto_1

    :cond_3
    const/4 v3, 0x3

    if-ne v1, v3, :cond_0

    const/4 v0, 0x1

    goto :goto_1

    :cond_4
    return-void
.end method
