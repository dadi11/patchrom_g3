.class public Landroid/media/AudioPlaybackHook;
.super Ljava/lang/Object;
.source "AudioPlaybackHook.java"


# static fields
.field public static final ERROR:I = -0x1

.field public static final ERROR_BAD_VALUE:I = -0x2

.field public static final ERROR_INVALID_OPERATION:I = -0x3

.field public static final STATE_HOOKING:I = 0x2

.field public static final STATE_INITIALIZED:I = 0x1

.field public static final STATE_UNINITIALIZED:I = 0x0

.field public static final SUCCESS:I = 0x0

.field private static final TAG:Ljava/lang/String; = "AudioHook-Java"


# instance fields
.field private mBufferSize:I

.field private mFlags:I

.field private mNativeCallbackCookie:J

.field private mNativeHookInJavaObj:J

.field private mState:I

.field private mStateLock:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "hook_jni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(II)V
    .locals 3
    .param p1, "bufferSize"    # I
    .param p2, "flags"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v1, 0x1000

    iput v1, p0, Landroid/media/AudioPlaybackHook;->mBufferSize:I

    iput v2, p0, Landroid/media/AudioPlaybackHook;->mFlags:I

    iput v2, p0, Landroid/media/AudioPlaybackHook;->mState:I

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Landroid/media/AudioPlaybackHook;->mStateLock:Ljava/lang/Object;

    iput p1, p0, Landroid/media/AudioPlaybackHook;->mBufferSize:I

    iput p2, p0, Landroid/media/AudioPlaybackHook;->mFlags:I

    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-direct {p0, v1, p1, p2}, Landroid/media/AudioPlaybackHook;->native_setup(Ljava/lang/Object;II)I

    move-result v0

    .local v0, "initResult":I
    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Error code "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " when initializing native AudioHook object."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/media/AudioPlaybackHook;->loge(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    iget-object v2, p0, Landroid/media/AudioPlaybackHook;->mStateLock:Ljava/lang/Object;

    monitor-enter v2

    const/4 v1, 0x1

    :try_start_0
    iput v1, p0, Landroid/media/AudioPlaybackHook;->mState:I

    monitor-exit v2

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public static native bufferSize(I)I
.end method

.method public static native getMixerOutput()I
.end method

.method public static native getMixerOutputFormat(I)I
.end method

.method public static native getMixerSampleRate(I)I
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 3
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const-string v0, "AudioHook-Java"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ android.media.AudioPlaybackHook ] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 3
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const-string v0, "AudioHook-Java"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ android.media.AudioPlaybackHook ] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private final native native_finalize()V
.end method

.method private final native native_release()V
.end method

.method private final native native_setup(Ljava/lang/Object;II)I
.end method

.method private final native native_start()I
.end method

.method private final native native_stop()V
.end method


# virtual methods
.method protected finalize()V
    .locals 0

    .prologue
    invoke-direct {p0}, Landroid/media/AudioPlaybackHook;->native_finalize()V

    return-void
.end method

.method public getBufferSize()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/media/AudioPlaybackHook;->mBufferSize:I

    return v0
.end method

.method public getFlags()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/media/AudioPlaybackHook;->mFlags:I

    return v0
.end method

.method public getState()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/media/AudioPlaybackHook;->mState:I

    return v0
.end method

.method public release()V
    .locals 2

    .prologue
    :try_start_0
    invoke-virtual {p0}, Landroid/media/AudioPlaybackHook;->stop()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v1, p0, Landroid/media/AudioPlaybackHook;->mStateLock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_1
    invoke-direct {p0}, Landroid/media/AudioPlaybackHook;->native_release()V

    const/4 v0, 0x0

    iput v0, p0, Landroid/media/AudioPlaybackHook;->mState:I

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public start()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    iget-object v1, p0, Landroid/media/AudioPlaybackHook;->mStateLock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    invoke-direct {p0}, Landroid/media/AudioPlaybackHook;->native_start()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x2

    iput v0, p0, Landroid/media/AudioPlaybackHook;->mState:I

    :cond_0
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public stop()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    iget-object v1, p0, Landroid/media/AudioPlaybackHook;->mStateLock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    invoke-direct {p0}, Landroid/media/AudioPlaybackHook;->native_stop()V

    const/4 v0, 0x1

    iput v0, p0, Landroid/media/AudioPlaybackHook;->mState:I

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
