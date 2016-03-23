.class final Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;
.super Landroid/content/BroadcastReceiver;
.source "VolumePreferenceEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "LGVolumePreferenceReceiver"
.end annotation


# instance fields
.field private mListening:Z

.field final synthetic this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;


# direct methods
.method private constructor <init>(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)V
    .locals 1

    .prologue
    iput-object p1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->mListening:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;Lcom/lge/preference/VolumePreferenceEx$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;
    .param p2, "x1"    # Lcom/lge/preference/VolumePreferenceEx$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;-><init>(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)V

    return-void
.end method

.method private onActionHeadsetPlug(I)V
    .locals 4
    .param p1, "headsetState"    # I

    .prologue
    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    :try_start_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    const-wide/16 v2, 0x64

    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mAudioManager:Landroid/media/AudioManager;
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1200(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Landroid/media/AudioManager;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mStreamType:I
    invoke-static {v2}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1100(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v0

    .local v0, "newOriginalvolume":I
    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mSeekBar:Landroid/widget/SeekBar;
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1300(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Landroid/widget/SeekBar;

    move-result-object v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mAudioManager:Landroid/media/AudioManager;
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1400(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Landroid/media/AudioManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/media/AudioManager;->getRingerMode()I

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mStreamType:I
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1500(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)I

    move-result v1

    const/4 v2, 0x3

    if-ne v1, v2, :cond_2

    :cond_1
    const-string v1, "SeekBarVolumizerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ACTION_HEADSET_PLUG: Org vol: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mOriginalStreamVolume:I
    invoke-static {v3}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1600(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", New vol"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mSeekBar:Landroid/widget/SeekBar;
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1700(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Landroid/widget/SeekBar;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # setter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mOriginalStreamVolume:I
    invoke-static {v1, v0}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1802(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;I)I

    :cond_2
    return-void

    .end local v0    # "newOriginalvolume":I
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private onActionPhoneStateChanged(Ljava/lang/String;)V
    .locals 1
    .param p1, "state"    # Ljava/lang/String;

    .prologue
    if-eqz p1, :cond_0

    sget-object v0, Landroid/telephony/TelephonyManager;->EXTRA_STATE_RINGING:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    invoke-virtual {v0}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->stopSample()V

    :cond_0
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v5, 0x2

    const-string v2, "SeekBarVolumizerEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onReceive() action:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "android.intent.action.HEADSET_PLUG"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "state"

    const/4 v3, 0x0

    invoke-virtual {p2, v2, v3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .local v0, "headsetState":I
    invoke-direct {p0, v0}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->onActionHeadsetPlug(I)V

    .end local v0    # "headsetState":I
    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "android.intent.action.PHONE_STATE"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "state"

    invoke-virtual {p2, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "state":Ljava/lang/String;
    invoke-direct {p0, v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->onActionPhoneStateChanged(Ljava/lang/String;)V

    goto :goto_0

    .end local v1    # "state":Ljava/lang/String;
    :cond_2
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "android.media.RINGER_MODE_CHANGED"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "android.media.EXTRA_RINGER_MODE"

    invoke-virtual {p2, v2, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    if-eq v2, v5, :cond_0

    iget-object v2, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    invoke-virtual {v2}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->isSamplePlaying()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    invoke-virtual {v2}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->stopSample()V

    goto :goto_0
.end method

.method public setListening(Z)V
    .locals 4
    .param p1, "listening"    # Z

    .prologue
    const-string v1, "SeekBarVolumizerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setListening() listening = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->mListening:Z

    if-ne v1, p1, :cond_0

    :goto_0
    return-void

    :cond_0
    iput-boolean p1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->mListening:Z

    if-eqz p1, :cond_1

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.HEADSET_PLUG"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.PHONE_STATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.media.RINGER_MODE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$900(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mReceiver:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;
    invoke-static {v2}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$800(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    goto :goto_0

    .end local v0    # "filter":Landroid/content/IntentFilter;
    :cond_1
    iget-object v1, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$1000(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;->this$1:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;

    # getter for: Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->mReceiver:Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;
    invoke-static {v2}, Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;->access$800(Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx;)Lcom/lge/preference/VolumePreferenceEx$SeekBarVolumizerEx$LGVolumePreferenceReceiver;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    goto :goto_0
.end method
