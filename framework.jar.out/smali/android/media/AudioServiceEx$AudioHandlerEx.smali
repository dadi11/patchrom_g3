.class public Landroid/media/AudioServiceEx$AudioHandlerEx;
.super Landroid/media/AudioService$AudioHandler;
.source "AudioServiceEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/AudioServiceEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "AudioHandlerEx"
.end annotation


# instance fields
.field final synthetic this$0:Landroid/media/AudioServiceEx;


# direct methods
.method protected constructor <init>(Landroid/media/AudioServiceEx;)V
    .locals 0

    .prologue
    .line 1133
    iput-object p1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    invoke-direct {p0, p1}, Landroid/media/AudioService$AudioHandler;-><init>(Landroid/media/AudioService;)V

    return-void
.end method

.method private handleForMediaServerDied()V
    .locals 4

    .prologue
    .line 1155
    const-string v1, "AudioServiceEx"

    const-string v2, "AudioServiceEx() handleMessage MEDIA_SERVER_DIED"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1157
    invoke-static {}, Landroid/media/AudioSystem;->checkAudioFlinger()I

    move-result v1

    if-nez v1, :cond_0

    .line 1158
    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # invokes: Landroid/media/AudioServiceEx;->readPersistedMABL()V
    invoke-static {v1}, Landroid/media/AudioServiceEx;->access$800(Landroid/media/AudioServiceEx;)V

    .line 1162
    :cond_0
    const-string v1, "AudioServiceEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AudioServiceEx() Reset AllSoundOff. allSoundEnable = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mIsAllSoundOff:Z
    invoke-static {v3}, Landroid/media/AudioServiceEx;->access$900(Landroid/media/AudioServiceEx;)Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1163
    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mIsAllSoundOff:Z
    invoke-static {v1}, Landroid/media/AudioServiceEx;->access$900(Landroid/media/AudioServiceEx;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    iget-object v1, v1, Landroid/media/AudioServiceEx;->mCameraSoundForced:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1164
    const-string v1, "TurnOffAllSound=1"

    invoke-static {v1}, Landroid/media/AudioSystem;->setParameters(Ljava/lang/String;)I

    .line 1168
    :cond_1
    const-string/jumbo v1, "tablet"

    const-string/jumbo v2, "ro.build.characteristics"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1169
    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mWatchingRotation:Z
    invoke-static {v1}, Landroid/media/AudioServiceEx;->access$1000(Landroid/media/AudioServiceEx;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mWindowManager:Landroid/view/IWindowManager;
    invoke-static {v1}, Landroid/media/AudioServiceEx;->access$1100(Landroid/media/AudioServiceEx;)Landroid/view/IWindowManager;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 1171
    :try_start_0
    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mWindowManager:Landroid/view/IWindowManager;
    invoke-static {v1}, Landroid/media/AudioServiceEx;->access$1100(Landroid/media/AudioServiceEx;)Landroid/view/IWindowManager;

    move-result-object v1

    iget-object v2, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    # getter for: Landroid/media/AudioServiceEx;->mRotationWatcher:Landroid/view/IRotationWatcher;
    invoke-static {v2}, Landroid/media/AudioServiceEx;->access$1200(Landroid/media/AudioServiceEx;)Landroid/view/IRotationWatcher;

    move-result-object v2

    invoke-interface {v1, v2}, Landroid/view/IWindowManager;->removeRotationWatcher(Landroid/view/IRotationWatcher;)V

    .line 1172
    iget-object v1, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    const/4 v2, 0x0

    # setter for: Landroid/media/AudioServiceEx;->mWatchingRotation:Z
    invoke-static {v1, v2}, Landroid/media/AudioServiceEx;->access$1002(Landroid/media/AudioServiceEx;Z)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1179
    :cond_2
    :goto_0
    return-void

    .line 1173
    :catch_0
    move-exception v0

    .line 1174
    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "AudioServiceEx"

    const-string v2, "Remote exception when removing rotation watcher"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x1

    .line 1135
    iget v0, p1, Landroid/os/Message;->what:I

    if-ne v0, v2, :cond_1

    .line 1136
    const-string v0, "AudioServiceEx"

    const-string v1, "handlemesasge: MSG_PERSIST_VOLUME"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1137
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioService$VolumeStreamState;

    iget v1, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {p0, v0, v1}, Landroid/media/AudioServiceEx$AudioHandlerEx;->persistVolume(Landroid/media/AudioService$VolumeStreamState;I)V

    .line 1138
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioService$VolumeStreamState;

    iget v0, v0, Landroid/media/AudioService$VolumeStreamState;->mStreamType:I

    if-ne v0, v2, :cond_0

    .line 1139
    const-string/jumbo v1, "persist.sys.system_volume"

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioService$VolumeStreamState;

    iget v2, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, v2}, Landroid/media/AudioService$VolumeStreamState;->getIndex(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x5

    div-int/lit8 v0, v0, 0xa

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 1141
    const-string v1, "AudioServiceEx"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "persistVolume vol: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioService$VolumeStreamState;

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, v3}, Landroid/media/AudioService$VolumeStreamState;->getIndex(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x5

    div-int/lit8 v0, v0, 0xa

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1152
    :cond_0
    :goto_0
    return-void

    .line 1143
    :cond_1
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0x1d

    if-ne v0, v1, :cond_2

    .line 1144
    const-string v0, "AudioServiceEx"

    const-string v1, "MSG_SHOW_VOLUME_INFO"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1145
    iget-object v0, p0, Landroid/media/AudioServiceEx$AudioHandlerEx;->this$0:Landroid/media/AudioServiceEx;

    iget v1, p1, Landroid/os/Message;->arg1:I

    iget v2, p1, Landroid/os/Message;->arg2:I

    # invokes: Landroid/media/AudioServiceEx;->onShowVolumeInfo(II)V
    invoke-static {v0, v1, v2}, Landroid/media/AudioServiceEx;->access$700(Landroid/media/AudioServiceEx;II)V

    goto :goto_0

    .line 1146
    :cond_2
    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_3

    .line 1147
    invoke-super {p0, p1}, Landroid/media/AudioService$AudioHandler;->handleMessage(Landroid/os/Message;)V

    .line 1148
    invoke-direct {p0}, Landroid/media/AudioServiceEx$AudioHandlerEx;->handleForMediaServerDied()V

    goto :goto_0

    .line 1150
    :cond_3
    invoke-super {p0, p1}, Landroid/media/AudioService$AudioHandler;->handleMessage(Landroid/os/Message;)V

    goto :goto_0
.end method

.method protected persistRingerMode(I)V
    .locals 2
    .param p1, "ringerMode"    # I

    .prologue
    .line 1183
    invoke-super {p0, p1}, Landroid/media/AudioService$AudioHandler;->persistRingerMode(I)V

    .line 1184
    const-string/jumbo v0, "persist.sys.sound_enable"

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 1185
    return-void
.end method
