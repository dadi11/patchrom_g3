.class public Landroid/media/AudioManagerEx;
.super Landroid/media/AudioManager;
.source "AudioManagerEx.java"


# static fields
.field public static final ACTION_AUDIO_STOP_NOTIFICATION:Ljava/lang/String; = "com.lge.media.STOP_NOTIFICATION"

.field public static DEFAULT_STREAM_VOLUME_Ex:[I = null

.field public static final FLAG_DEAD_OBJECT:I = -0x64

.field public static final FLAG_EXPAND_VOLUME_PANEL:I = 0x200

.field public static final FLAG_IGNORE_QUIET_MODE_WARNING:I = 0x80

.field public static final FLAG_KEEP_RINGER_MODES:I = 0x100

.field public static final FLAG_TURNOFF_ALL_SOUNDS:I = 0x400

.field public static final FX_SWITCH_OFF:I = 0xb

.field public static final FX_SWITCH_ON:I = 0xa

.field public static final SPEAKER_PHONE_CHANGED_ACTION:Ljava/lang/String; = "com.lge.media.SPEAKER_PHONE_CHANGED_ACTION"

.field public static final STREAM_INCALL_MUSIC:I = 0xa

.field private static sService:Landroid/media/IAudioServiceEx;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/16 v0, 0xc

    sput v0, Landroid/media/AudioManagerEx;->NUM_SOUND_EFFECTS:I

    const/16 v0, 0xb

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Landroid/media/AudioManagerEx;->DEFAULT_STREAM_VOLUME_Ex:[I

    return-void

    :array_0
    .array-data 4
        0x4
        0x5
        0x5
        0x7
        0x6
        0x5
        0x7
        0x7
        0xb
        0xb
        0x4
    .end array-data
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0, p1}, Landroid/media/AudioManager;-><init>(Landroid/content/Context;)V

    sget-object v0, Landroid/media/AudioManagerEx;->DEFAULT_STREAM_VOLUME_Ex:[I

    sput-object v0, Landroid/media/AudioManagerEx;->DEFAULT_STREAM_VOLUME:[I

    return-void
.end method

.method protected static getServiceEx()Landroid/media/IAudioServiceEx;
    .locals 3

    .prologue
    sget-object v1, Landroid/media/AudioManagerEx;->sService:Landroid/media/IAudioServiceEx;

    if-eqz v1, :cond_0

    sget-object v1, Landroid/media/AudioManagerEx;->sService:Landroid/media/IAudioServiceEx;

    .local v0, "e":Ljava/lang/NullPointerException;
    :goto_0
    return-object v1

    .end local v0    # "e":Ljava/lang/NullPointerException;
    :cond_0
    :try_start_0
    const-string v1, "audio"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Landroid/media/IAudioServiceEx$Stub;->asInterface(Landroid/os/IBinder;)Landroid/media/IAudioServiceEx;

    move-result-object v1

    sput-object v1, Landroid/media/AudioManagerEx;->sService:Landroid/media/IAudioServiceEx;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    sget-object v1, Landroid/media/AudioManagerEx;->sService:Landroid/media/IAudioServiceEx;

    goto :goto_0

    :catch_0
    move-exception v0

    .restart local v0    # "e":Ljava/lang/NullPointerException;
    sget-object v1, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v2, "AudioServiceEx is null"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v1, 0x0

    goto :goto_0
.end method


# virtual methods
.method public closeRecordHooking(Ljava/io/FileDescriptor;)V
    .locals 1
    .param p1, "fd"    # Ljava/io/FileDescriptor;

    .prologue
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-static {v0, v0, v0}, Lcom/lge/media/LGAudioSystem;->setRecordHookingEnabled(III)Ljava/io/FileDescriptor;

    :cond_0
    return-void
.end method

.method public getActiveStreamType(I)I
    .locals 5
    .param p1, "suggestedStreamType"    # I

    .prologue
    const/16 v2, -0x64

    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1, p1}, Landroid/media/IAudioServiceEx;->getActiveStreamType(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "Dead object in getActiveStreamType"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "AudioService is null in getActiveStreamType"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getDevicesForStream(I)I
    .locals 1
    .param p1, "streamType"    # I

    .prologue
    invoke-super {p0, p1}, Landroid/media/AudioManager;->getDevicesForStream(I)I

    move-result v0

    return v0
.end method

.method public getPlayerList()Ljava/util/List;
    .locals 5
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
    const/4 v2, 0x0

    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1}, Landroid/media/IAudioServiceEx;->getPlayerList()Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "Dead object in getPlayerList"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "AudioService is null in getPlayerList"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getPlayerPlayBackState()Ljava/util/List;
    .locals 5
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
    const/4 v2, 0x0

    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1}, Landroid/media/IAudioServiceEx;->getPlayerPlayBackState()Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "Dead object in getPlayerPlayBackState"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "AudioService is null in getPlayerPlayBackState"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isBluetoothA2dpInputOn()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    sget-boolean v3, Lcom/lge/config/ConfigBuildFlags;->CAPP_AUDIO_A2DP_SINK:Z

    if-eqz v3, :cond_1

    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1}, Landroid/media/IAudioServiceEx;->isBluetoothA2dpInputOn()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "service":Landroid/media/IAudioServiceEx;
    :goto_0
    return v2

    .restart local v1    # "service":Landroid/media/IAudioServiceEx;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "Dead object in isBluetoothScoOn"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "AudioServiceEx is null in isBluetoothA2dpInputOn"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v1    # "service":Landroid/media/IAudioServiceEx;
    :cond_1
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "Don\'t support this API. Disable A2dp Sink."

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isRecording()Z
    .locals 2

    .prologue
    const-string v1, "audiorecording_state"

    invoke-static {v1}, Landroid/media/AudioSystem;->getParameters(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "isRecording":Ljava/lang/String;
    const-string v1, "off"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public isSpeakerOnForMedia()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1}, Landroid/media/IAudioServiceEx;->isSpeakerOnForMedia()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "Dead object in isSpeakerOnForMedia"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v3, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v4, "AudioService is null in isSpeakerOnForMedia"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public openRecordHooking(II)Ljava/io/FileDescriptor;
    .locals 1
    .param p1, "sampleRate"    # I
    .param p2, "flag"    # I

    .prologue
    const/4 v0, 0x1

    invoke-static {v0, p1, p2}, Lcom/lge/media/LGAudioSystem;->setRecordHookingEnabled(III)Ljava/io/FileDescriptor;

    move-result-object v0

    return-object v0
.end method

.method public setBluetoothA2dpInputOn(Z)V
    .locals 4
    .param p1, "on"    # Z

    .prologue
    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_AUDIO_A2DP_SINK:Z

    if-eqz v2, :cond_1

    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1, p1}, Landroid/media/IAudioServiceEx;->setBluetoothA2dpInputOn(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "service":Landroid/media/IAudioServiceEx;
    :goto_0
    return-void

    .restart local v1    # "service":Landroid/media/IAudioServiceEx;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "Dead object in setBluetoothA2dpInputOn"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "AudioServiceEx is null in setBluetoothA2dpInputOn"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v1    # "service":Landroid/media/IAudioServiceEx;
    :cond_1
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "Don\'t support this API. Disable A2dp Sink."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setMABLControl(II)V
    .locals 1
    .param p1, "currentLevel"    # I
    .param p2, "levelMax"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    const/16 v0, 0x3e

    invoke-static {p1, v0}, Lcom/lge/media/LGAudioSystem;->setMABLControl(II)I

    return-void
.end method

.method public setMABLEnable(I)V
    .locals 0
    .param p1, "enable"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    invoke-static {p1}, Lcom/lge/media/LGAudioSystem;->setMABLEnable(I)I

    return-void
.end method

.method public setSpeakerOnForMedia(Z)V
    .locals 4
    .param p1, "on"    # Z

    .prologue
    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1, p1}, Landroid/media/IAudioServiceEx;->setSpeakerOnForMedia(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "Dead object in setSpeakerOnForMedia"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "AudioService is null in setSpeakerOnForMedia"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setStreamVolumeAll(III)V
    .locals 4
    .param p1, "streamType"    # I
    .param p2, "index"    # I
    .param p3, "flags"    # I

    .prologue
    invoke-static {}, Landroid/media/AudioManagerEx;->getServiceEx()Landroid/media/IAudioServiceEx;

    move-result-object v1

    .local v1, "service":Landroid/media/IAudioServiceEx;
    if-eqz v1, :cond_1

    :try_start_0
    iget-boolean v2, p0, Landroid/media/AudioManagerEx;->mUseMasterVolume:Z

    if-eqz v2, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-interface {v1, p1, p2, p3}, Landroid/media/IAudioServiceEx;->setStreamVolumeAll(III)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "Dead object in setStreamVolumeAll"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    sget-object v2, Landroid/media/AudioManagerEx;->TAG:Ljava/lang/String;

    const-string v3, "AudioService is null in getVoiceActivationState"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
