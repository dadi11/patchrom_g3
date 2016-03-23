.class public Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;
.super Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;
.source "CdmaServiceStateTrackerEx.java"


# static fields
.field protected static final LOSSOFSERVICE:I = 0x3e8

.field private static mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

.field public static prev_alertId:I


# instance fields
.field private final EXTENDED_NETWORK_PATH:Ljava/lang/String;

.field private final LOSS_OF_SERVICE_PATH:Ljava/lang/String;

.field private final NETWORK_EXTENDER_PATH:Ljava/lang/String;

.field private final ROAMING_PATH:Ljava/lang/String;

.field private final VERIZON_WIRELESS_PATH:Ljava/lang/String;

.field hasChangedRoamingIndicator:Z

.field hasChangedSystemIDNetworkID:Z

.field hasStateChanged:Z

.field private isBTorHeadsetConnected:Z

.field public isEriSoundForMTCall:Z

.field protected isInShutDown:Z

.field public isVZWERISoundPlaying:Z

.field private mAudioManager:Landroid/media/AudioManager;

.field private mCellLocationObserver:Landroid/database/ContentObserver;

.field protected mCurShowPlmn:Z

.field protected mCurShowSpn:Z

.field protected mCurSpn:Ljava/lang/String;

.field public mDefaultRoamingIndicator_data:I

.field public mEmergencyOnly:Z

.field private mError:Ljava/lang/String;

.field protected mFirstUpdateSpn:Z

.field protected mHDRRoamingIndicator:I

.field private mIntentReceiver:Landroid/content/BroadcastReceiver;

.field public mIsInPrl_data:Z

.field private mIsRoamingIndicator_data:Z

.field protected mLteEhrpdForced:Ljava/lang/String;

.field private mMediaPlayer:Landroid/media/MediaPlayer;

.field public mNetworkType_data:I

.field public mRoamingIndicator_data:I

.field private mZone:Ljava/lang/String;

.field private restoreVolume:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 66
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    .line 91
    const/4 v0, -0x1

    sput v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->prev_alertId:I

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/cdma/CDMAPhone;)V
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/cdma/CDMAPhone;

    .prologue
    .line 179
    new-instance v0, Landroid/telephony/CellInfoCdma;

    invoke-direct {v0}, Landroid/telephony/CellInfoCdma;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhone;Landroid/telephony/CellInfo;)V

    .line 180
    return-void
.end method

.method protected constructor <init>(Lcom/android/internal/telephony/cdma/CDMAPhone;Landroid/telephony/CellInfo;)V
    .locals 10
    .param p1, "phone"    # Lcom/android/internal/telephony/cdma/CDMAPhone;
    .param p2, "cellInfo"    # Landroid/telephony/CellInfo;

    .prologue
    const-wide/16 v8, 0x0

    const/4 v6, 0x1

    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 183
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhone;Landroid/telephony/CellInfo;)V

    .line 70
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mFirstUpdateSpn:Z

    .line 73
    iput-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurSpn:Ljava/lang/String;

    .line 74
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurShowPlmn:Z

    .line 75
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurShowSpn:Z

    .line 76
    iput-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mError:Ljava/lang/String;

    .line 77
    iput-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZone:Ljava/lang/String;

    .line 93
    iput v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->restoreVolume:I

    .line 94
    const-string v1, "/system/media/audio/eri/LossofService.wav"

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->LOSS_OF_SERVICE_PATH:Ljava/lang/String;

    .line 95
    const-string v1, "/system/media/audio/eri/Roaming.wav"

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->ROAMING_PATH:Ljava/lang/String;

    .line 96
    const-string v1, "/system/media/audio/eri/ExtendedNetwork.wav"

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->EXTENDED_NETWORK_PATH:Ljava/lang/String;

    .line 97
    const-string v1, "/system/media/audio/eri/NetworkExtender.wav"

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->NETWORK_EXTENDER_PATH:Ljava/lang/String;

    .line 98
    const-string v1, "/system/media/audio/eri/VerizonWireless.wav"

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->VERIZON_WIRELESS_PATH:Ljava/lang/String;

    .line 99
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isInShutDown:Z

    .line 100
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    .line 101
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isVZWERISoundPlaying:Z

    .line 102
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    .line 103
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedSystemIDNetworkID:Z

    .line 104
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedRoamingIndicator:Z

    .line 106
    iput v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator_data:I

    .line 108
    iput v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator_data:I

    .line 109
    iput v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNetworkType_data:I

    .line 110
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isBTorHeadsetConnected:Z

    .line 114
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    .line 117
    new-instance v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;-><init>(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)V

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    .line 169
    new-instance v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$2;

    new-instance v2, Landroid/os/Handler;

    invoke-direct {v2}, Landroid/os/Handler;-><init>()V

    invoke-direct {v1, p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$2;-><init>(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;Landroid/os/Handler;)V

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCellLocationObserver:Landroid/database/ContentObserver;

    .line 878
    iput-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsRoamingIndicator_data:Z

    .line 186
    const-string v1, "sprint_hdr_roaming"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 187
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x69

    invoke-interface {v1, p0, v2, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForHDRRoamingIndicator(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 192
    :cond_0
    const-string v1, "sprint_ehrpd_forced"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 193
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x6a

    invoke-interface {v1, p0, v2, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForLteEhrpdForcedChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 198
    :cond_1
    const-string v1, "sprint_location_spec"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 199
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCr:Landroid/content/ContentResolver;

    const-string v2, "location_providers_allowed"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCellLocationObserver:Landroid/database/ContentObserver;

    invoke-virtual {v1, v2, v6, v3}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 207
    :cond_2
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 208
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.LOCALE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 211
    const-string v1, "android.intent.action.ACTION_RADIO_OFF"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 215
    const-string v1, "vzw_eri"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 216
    new-instance v1, Landroid/media/MediaPlayer;

    invoke-direct {v1}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    .line 217
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "audio"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/AudioManager;

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    .line 218
    const-string v1, "android.intent.action.ACTION_SHUTDOWN"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 223
    :cond_3
    const-string v1, "VZW"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 224
    const-string v1, "com.lge.vzwnetworktest"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 227
    :cond_4
    invoke-virtual {p1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 231
    const-string v1, "MANAGED_TIME_SETTING"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 232
    sget-object v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-nez v1, :cond_5

    .line 233
    invoke-static {}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->getDefault()Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    move-result-object v1

    sput-object v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    .line 236
    :cond_5
    sget-object v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-eqz v1, :cond_6

    .line 237
    sget-object v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-virtual {p0, v1, v6, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->registerForNetworkAttached(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 238
    sget-object v1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-virtual {v1, p0}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->setServiceStateTracker(Lcom/android/internal/telephony/ServiceStateTracker;)V

    .line 244
    :cond_6
    invoke-static {}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSavedNeedFixZone()Z

    move-result v1

    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNeedFixZone:Z

    .line 245
    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNeedFixZone:Z

    if-eqz v1, :cond_7

    .line 246
    invoke-static {}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSavedZoneOffset()I

    move-result v1

    iput v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZoneOffset:I

    .line 247
    invoke-static {}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSavedZoneDst()Z

    move-result v1

    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZoneDst:Z

    .line 248
    invoke-static {}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSavedZoneTime()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZoneTime:J

    .line 249
    invoke-static {}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSavedTime()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSavedTime:J

    .line 250
    invoke-static {}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSavedAtTime()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSavedAtTime:J

    .line 251
    const-string v1, "TimeZone correction was delayed by Phone Switching!"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 254
    invoke-static {v4}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedNeedFixZone(Z)V

    .line 255
    invoke-static {v4}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedZoneOffset(I)V

    .line 256
    invoke-static {v4}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedZoneDst(Z)V

    .line 257
    invoke-static {v8, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedZoneTime(J)V

    .line 258
    invoke-static {v8, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedTime(J)V

    .line 259
    invoke-static {v8, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedAtTime(J)V

    .line 262
    :cond_7
    return-void
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;
    .param p1, "x1"    # Z

    .prologue
    .line 63
    iput-boolean p1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z

    return p1
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;Landroid/content/Intent;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;
    .param p1, "x1"    # Landroid/content/Intent;

    .prologue
    .line 63
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setFakeNetworkValues(Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    .prologue
    .line 63
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mFakeRI:I

    return v0
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)Lcom/android/internal/telephony/CommandsInterface;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    .prologue
    .line 63
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    return-object v0
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    .prologue
    .line 63
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->sendBroadcastForEriFinish()V

    return-void
.end method

.method private checkDataSourceForERI(I)Z
    .locals 4
    .param p1, "alertId"    # I

    .prologue
    const/4 v1, 0x1

    .line 1138
    const/16 v2, 0x3e8

    if-ne p1, v2, :cond_0

    .line 1139
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const-string v3, "/system/media/audio/eri/LossofService.wav"

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 1162
    :goto_0
    return v1

    .line 1140
    :cond_0
    const/4 v2, 0x5

    if-ne p1, v2, :cond_1

    .line 1141
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const-string v3, "/system/media/audio/eri/Roaming.wav"

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_4

    goto :goto_0

    .line 1151
    :catch_0
    move-exception v0

    .line 1152
    .local v0, "e":Ljava/io/FileNotFoundException;
    const-string v2, "FileNotFoundException"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1142
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    :cond_1
    const/4 v2, 0x4

    if-ne p1, v2, :cond_2

    .line 1143
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const-string v3, "/system/media/audio/eri/ExtendedNetwork.wav"

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_4

    goto :goto_0

    .line 1153
    :catch_1
    move-exception v0

    .line 1154
    .local v0, "e":Ljava/io/IOException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MediaPlayer IOException: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1144
    .end local v0    # "e":Ljava/io/IOException;
    :cond_2
    if-ne p1, v1, :cond_3

    .line 1145
    :try_start_2
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const-string v3, "/system/media/audio/eri/NetworkExtender.wav"

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_4

    goto :goto_0

    .line 1155
    :catch_2
    move-exception v0

    .line 1156
    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v2, "LG_SYS:Error1"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1146
    .end local v0    # "e":Ljava/lang/NullPointerException;
    :cond_3
    if-nez p1, :cond_4

    .line 1147
    :try_start_3
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const-string v3, "/system/media/audio/eri/VerizonWireless.wav"

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/lang/IllegalStateException; {:try_start_3 .. :try_end_3} :catch_4

    goto :goto_0

    .line 1157
    :catch_3
    move-exception v0

    .line 1158
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MediaPlayer IllegalArgumentException: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1149
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :cond_4
    const/4 v1, 0x0

    goto :goto_0

    .line 1159
    :catch_4
    move-exception v0

    .line 1160
    .local v0, "e":Ljava/lang/IllegalStateException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MediaPlayer IllegalStateException: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private getErrorNoServiceLGU(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "tmperror"    # Ljava/lang/String;

    .prologue
    const/4 v9, 0x0

    .line 643
    move-object v0, p1

    .line 645
    .local v0, "error":Ljava/lang/String;
    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v6}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v6

    if-eqz v6, :cond_3

    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v6}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v6

    if-eqz v6, :cond_3

    .line 647
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getMsgFromStatusId()Ljava/lang/String;

    move-result-object v4

    .line 648
    .local v4, "rejectMsg":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 649
    move-object v0, v4

    .line 653
    :cond_0
    const/4 v6, 0x0

    const-string v7, "lgu_global_roaming"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 654
    const-string v6, "true"

    const-string v7, "ril.cdma.maintreq"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .line 655
    .local v3, "isLockOrder":Z
    const-string v6, "true"

    const-string v7, "ril.cdma.authlock"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 657
    .local v2, "isAuthLock":Z
    const-string v6, "CdmaSST"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "isLockOrder = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", isAuthLock = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 659
    if-nez v3, :cond_1

    if-eqz v2, :cond_2

    .line 660
    :cond_1
    if-eqz v3, :cond_4

    .line 661
    const-string v6, "lgt_unregister"

    invoke-static {v6}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 669
    .end local v2    # "isAuthLock":Z
    .end local v3    # "isLockOrder":Z
    :cond_2
    :goto_0
    const-string v6, "gsm.lge.lte_reject_cause"

    invoke-static {v6, v9}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v5

    .line 670
    .local v5, "rejectNum":I
    const-string v6, "gsm.lge.lte_esm_reject_cause"

    invoke-static {v6, v9}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 671
    .local v1, "esmRejectNum":I
    if-lez v5, :cond_3

    .line 672
    const-string v6, "true"

    const-string v7, "persist.radio.isroaming"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 673
    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->toLteRejectCauseStringforRoaming(I)Ljava/lang/String;

    move-result-object v0

    .line 678
    :goto_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "updateSpnDisplayLGU: plmn by lte reject : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 682
    .end local v1    # "esmRejectNum":I
    .end local v4    # "rejectMsg":Ljava/lang/String;
    .end local v5    # "rejectNum":I
    :cond_3
    return-object v0

    .line 662
    .restart local v2    # "isAuthLock":Z
    .restart local v3    # "isLockOrder":Z
    .restart local v4    # "rejectMsg":Ljava/lang/String;
    :cond_4
    if-eqz v2, :cond_2

    .line 663
    const-string v6, "lgt_unauthenticated"

    invoke-static {v6}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 675
    .end local v2    # "isAuthLock":Z
    .end local v3    # "isLockOrder":Z
    .restart local v1    # "esmRejectNum":I
    .restart local v5    # "rejectNum":I
    :cond_5
    invoke-static {v5, v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->toLteRejectCauseString(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private getMsgFromStatusId()Ljava/lang/String;
    .locals 4

    .prologue
    .line 482
    const/4 v0, 0x0

    .line 484
    .local v0, "msg":Ljava/lang/String;
    const-string v2, "ril.gsm.reject_cause"

    const/4 v3, 0x0

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 485
    .local v1, "statusId":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getMsgFromStatusId : statusId :"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 487
    sparse-switch v1, :sswitch_data_0

    .line 553
    :goto_0
    return-object v0

    .line 489
    :sswitch_0
    const-string v2, "UPLUS_NRC_02_IMSI_UNKNOWN_IN_HLR"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 490
    goto :goto_0

    .line 492
    :sswitch_1
    const-string v2, "UPLUS_NRC_03_ILLEGAL_MS"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 493
    goto :goto_0

    .line 495
    :sswitch_2
    const-string v2, "UPLUS_NRC_06_ILLEGAL_ME"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 496
    goto :goto_0

    .line 498
    :sswitch_3
    const-string v2, "UPLUS_NRC_07_GPRS_NOT_ALLOWED"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 499
    goto :goto_0

    .line 501
    :sswitch_4
    const-string v2, "UPLUS_NRC_08_GPRS_AND_NON_GPRS_NOT_ALLOWED"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 502
    goto :goto_0

    .line 504
    :sswitch_5
    const-string v2, "UPLUS_NRC_11_PLMN_NOT_ALLOWED"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 505
    goto :goto_0

    .line 507
    :sswitch_6
    const-string v2, "UPLUS_NRC_12_LOCATION_AREA_NOT_ALLOWED"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 508
    goto :goto_0

    .line 510
    :sswitch_7
    const-string v2, "UPLUS_NRC_13_ROAMING_NOT_ALLOWED_IN_THIS_LOCATION_AREA"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 511
    goto :goto_0

    .line 513
    :sswitch_8
    const-string v2, "UPLUS_NRC_14_GPRS_NOT_ALLOWED_IN_THIS_PLMN"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 514
    goto :goto_0

    .line 516
    :sswitch_9
    const-string v2, "UPLUS_NRC_15_NO_SUITABLE_CELLS_IN_LOCATION_AREA"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 517
    goto :goto_0

    .line 519
    :sswitch_a
    const-string v2, "UPLUS_NRC_16_MSC_TEMPORARILY_NOT_REACHABLE"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 520
    goto :goto_0

    .line 522
    :sswitch_b
    const-string v2, "UPLUS_NRC_17_NETWORK_FAILURE"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 523
    goto :goto_0

    .line 525
    :sswitch_c
    const-string v2, "UPLUS_NRC_22_INTER_CONGESTION"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 526
    goto :goto_0

    .line 548
    :sswitch_d
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UPLUS_NRC_ETC"

    invoke-static {v3}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 549
    goto :goto_0

    .line 487
    nop

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_0
        0x3 -> :sswitch_1
        0x4 -> :sswitch_d
        0x5 -> :sswitch_d
        0x6 -> :sswitch_2
        0x7 -> :sswitch_3
        0x8 -> :sswitch_4
        0x9 -> :sswitch_d
        0xa -> :sswitch_d
        0xb -> :sswitch_5
        0xc -> :sswitch_6
        0xd -> :sswitch_7
        0xe -> :sswitch_8
        0xf -> :sswitch_9
        0x10 -> :sswitch_a
        0x11 -> :sswitch_b
        0x14 -> :sswitch_d
        0x15 -> :sswitch_d
        0x16 -> :sswitch_c
        0x17 -> :sswitch_d
        0x20 -> :sswitch_d
        0x21 -> :sswitch_d
        0x22 -> :sswitch_d
        0x26 -> :sswitch_d
        0x28 -> :sswitch_d
        0x30 -> :sswitch_d
        0x3f -> :sswitch_d
        0x5f -> :sswitch_d
        0x60 -> :sswitch_d
        0x61 -> :sswitch_d
        0x62 -> :sswitch_d
        0x63 -> :sswitch_d
        0x65 -> :sswitch_d
        0x6f -> :sswitch_d
    .end sparse-switch
.end method

.method private getPlmnInServiceLGU(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "tmpplmn"    # Ljava/lang/String;

    .prologue
    .line 590
    move-object v0, p1

    .line 596
    .local v0, "plmn":Ljava/lang/String;
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 597
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v0

    .line 604
    :goto_0
    return-object v0

    .line 598
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 599
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 601
    :cond_1
    const-string v0, "LG U+"

    goto :goto_0
.end method

.method private getPlmnNoServiceLGU(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "tmpplmn"    # Ljava/lang/String;
    .param p2, "spn"    # Ljava/lang/String;

    .prologue
    .line 686
    move-object v0, p1

    .line 689
    .local v0, "plmn":Ljava/lang/String;
    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 690
    const-string v1, "emergency_calls_only_kt"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 692
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "updateSpnDisplayLGU: emergency only and radio is on plmn=\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 697
    :cond_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 698
    const-string v1, "service_disabled"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 702
    :cond_1
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 703
    const-string v1, "service_disabled"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 706
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v1

    if-eqz v1, :cond_3

    .line 708
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 709
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Not Normal Service PLMN Empty to service_disabled - state = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", plmn="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 710
    const-string v1, "service_disabled"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 720
    :cond_3
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "airplane_mode_on"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_4

    .line 721
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x1040109

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 724
    :cond_4
    return-object v0

    .line 711
    :cond_5
    const-string v1, "null"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 712
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Not Normal Service PLMN null to service_disabled - state = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", plmn="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 713
    const-string v1, "service_disabled"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private getSpnInServiceLGU(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "tmpspn"    # Ljava/lang/String;

    .prologue
    .line 632
    move-object v0, p1

    .line 635
    .local v0, "spn":Ljava/lang/String;
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v1, v1, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v1

    if-nez v1, :cond_1

    .line 637
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v1, v1, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/internal/telephony/uicc/IccRecords;

    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccRecords;->getServiceProviderName()Ljava/lang/String;

    move-result-object v0

    .line 640
    :cond_1
    return-object v0
.end method

.method private getZoneInServiceLGU(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "tmpzone"    # Ljava/lang/String;

    .prologue
    .line 608
    move-object v1, p1

    .line 611
    .local v1, "zone":Ljava/lang/String;
    const-string v2, "true"

    const-string v3, "gsm.operator.isroaming"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 612
    const-string v2, "lgu.imsi_type"

    const-string v3, ""

    invoke-static {v2, v3}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 614
    .local v0, "imsi_type":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "imsi_type == "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 617
    const-string v2, "HOME"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 618
    const-string v1, "(Zone1)"

    .line 628
    .end local v0    # "imsi_type":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object v1

    .line 619
    .restart local v0    # "imsi_type":Ljava/lang/String;
    :cond_1
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 621
    const-string v2, "no Imsi zone"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 624
    :cond_2
    const-string v1, "(Zone2)"

    goto :goto_0
.end method

.method private sendBroadcastForEriFinish()V
    .locals 3

    .prologue
    .line 1166
    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 1167
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.finishEriSound"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1168
    .local v0, "finishEriSound":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1169
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    .line 1171
    .end local v0    # "finishEriSound":Landroid/content/Intent;
    :cond_0
    return-void
.end method

.method private setMediaPlayerForEriSound()V
    .locals 3

    .prologue
    .line 1175
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->prepare()V

    .line 1176
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    .line 1177
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 1178
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isVZWERISoundPlaying:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1183
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    new-instance v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$3;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$3;-><init>(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)V

    invoke-virtual {v1, v2}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    .line 1190
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    new-instance v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$4;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$4;-><init>(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)V

    invoke-virtual {v1, v2}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 1200
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->start()V

    .line 1201
    return-void

    .line 1179
    :catch_0
    move-exception v0

    .line 1180
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MediaPlayer IOException: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private shouldPlayERISound()Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 1123
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v3}, Landroid/media/AudioManager;->getRingerMode()I

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v3}, Landroid/media/AudioManager;->getRingerMode()I

    move-result v3

    if-ne v3, v2, :cond_8

    :cond_0
    move v0, v2

    .line 1125
    .local v0, "isRingerMute":Z
    :goto_0
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v3}, Landroid/media/AudioManager;->isBluetoothA2dpOn()Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v3}, Landroid/media/AudioManager;->isBluetoothScoOn()Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v3}, Landroid/media/AudioManager;->isWiredHeadsetOn()Z

    move-result v3

    if-eqz v3, :cond_9

    :cond_1
    move v3, v2

    :goto_1
    iput-boolean v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isBTorHeadsetConnected:Z

    .line 1127
    sget-boolean v3, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v3, :cond_2

    const-string v3, "CdmaSST"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mAudioManager.getRingerMode() = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v5}, Landroid/media/AudioManager;->getRingerMode()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1128
    :cond_2
    sget-boolean v3, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v3, :cond_3

    const-string v3, "CdmaSST"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mAudioManager.isBluetoothA2dpOn() = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v5}, Landroid/media/AudioManager;->isBluetoothA2dpOn()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1129
    :cond_3
    sget-boolean v3, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v3, :cond_4

    const-string v3, "CdmaSST"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mAudioManager.isBluetoothScoOn() = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v5}, Landroid/media/AudioManager;->isBluetoothScoOn()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1130
    :cond_4
    sget-boolean v3, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v3, :cond_5

    const-string v3, "CdmaSST"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mAudioManager.isWiredHeadsetOn() = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v5}, Landroid/media/AudioManager;->isWiredHeadsetOn()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1132
    :cond_5
    if-eqz v0, :cond_6

    iget-boolean v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    if-ne v3, v2, :cond_a

    iget-boolean v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isBTorHeadsetConnected:Z

    if-eqz v3, :cond_a

    :cond_6
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/PhoneConstants$State;->RINGING:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v3, v4, :cond_7

    iget-boolean v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    if-ne v3, v2, :cond_a

    :cond_7
    iget-boolean v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isVZWERISoundPlaying:Z

    if-nez v3, :cond_a

    :goto_2
    return v2

    .end local v0    # "isRingerMute":Z
    :cond_8
    move v0, v1

    .line 1123
    goto/16 :goto_0

    .restart local v0    # "isRingerMute":Z
    :cond_9
    move v3, v1

    .line 1125
    goto/16 :goto_1

    :cond_a
    move v2, v1

    .line 1132
    goto :goto_2
.end method

.method private updateFemtoCellIndicator()V
    .locals 3

    .prologue
    .line 840
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.provider.Telephony.SPN_STRINGS_UPDATED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 841
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 842
    const-string v1, "showSpn"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 843
    const-string v1, "spn"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 844
    const-string v1, "showPlmn"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 845
    const-string v1, "plmn"

    const-string v2, "Network Extender"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 846
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getPhoneId()I

    move-result v1

    invoke-static {v0, v1}, Landroid/telephony/SubscriptionManager;->putPhoneIdAndSubIdExtra(Landroid/content/Intent;I)V

    .line 847
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 848
    const-string v1, "Network Extender"

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    .line 849
    return-void
.end method

.method private updateNetworkIndicator(Ljava/lang/String;ZLjava/lang/String;Z)V
    .locals 3
    .param p1, "plmn"    # Ljava/lang/String;
    .param p2, "showPlmn"    # Z
    .param p3, "spn"    # Ljava/lang/String;
    .param p4, "showSpn"    # Z

    .prologue
    .line 826
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.provider.Telephony.SPN_STRINGS_UPDATED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 827
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 828
    const-string v1, "showSpn"

    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 829
    const-string v1, "spn"

    invoke-virtual {v0, v1, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 830
    const-string v1, "showPlmn"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 831
    const-string v1, "plmn"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 832
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getPhoneId()I

    move-result v1

    invoke-static {v0, v1}, Landroid/telephony/SubscriptionManager;->putPhoneIdAndSubIdExtra(Landroid/content/Intent;I)V

    .line 833
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 834
    iput-object p1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    .line 835
    return-void
.end method

.method private updateSpnDisplayLGU()V
    .locals 12

    .prologue
    const/4 v9, 0x0

    const/4 v6, 0x1

    .line 729
    iput-boolean v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mFirstUpdateSpn:Z

    .line 730
    iget-object v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v3

    .line 731
    .local v3, "plmn":Ljava/lang/String;
    const/4 v0, 0x0

    .line 732
    .local v0, "error":Ljava/lang/String;
    const/4 v8, 0x0

    .line 734
    .local v8, "zone":Ljava/lang/String;
    iget-object v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v10, v10, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v10}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v10

    if-nez v10, :cond_0

    .line 735
    invoke-direct {p0, v3, v8}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->updateSpnDisplayWithoutIccLGU(Ljava/lang/String;Ljava/lang/String;)V

    .line 821
    :goto_0
    return-void

    .line 739
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    .line 740
    .local v1, "iccRecords":Lcom/android/internal/telephony/uicc/IccRecords;
    if-eqz v1, :cond_9

    iget-object v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v10}, Lcom/android/internal/telephony/uicc/IccRecords;->getDisplayRule(Ljava/lang/String;)I

    move-result v4

    .line 741
    .local v4, "rule":I
    :goto_1
    if-eqz v1, :cond_a

    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccRecords;->getServiceProviderName()Ljava/lang/String;

    move-result-object v7

    .line 756
    .local v7, "spn":Ljava/lang/String;
    :goto_2
    iget-object v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v10

    if-eqz v10, :cond_1

    iget-object v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v10

    if-nez v10, :cond_2

    .line 757
    :cond_1
    invoke-direct {p0, v3}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getPlmnInServiceLGU(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 758
    invoke-direct {p0, v8}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getZoneInServiceLGU(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 762
    :cond_2
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "updateSpnDisplayLGU: Global Roaming LG U+ plmn = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", short = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v11}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", long = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v11}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", mSS.getVoiceRegState() = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v11}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", mSS.getDataRegState() = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v11}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {p0, v10}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 769
    invoke-direct {p0, v7}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getSpnInServiceLGU(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 771
    invoke-direct {p0, v3, v7}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getPlmnNoServiceLGU(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 772
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getErrorNoServiceLGU(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 774
    iget-boolean v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    if-nez v10, :cond_b

    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_b

    and-int/lit8 v10, v4, 0x1

    if-ne v10, v6, :cond_b

    iget-object v10, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getState()I

    move-result v10

    if-nez v10, :cond_b

    .line 779
    .local v6, "showSpn":Z
    :goto_3
    const/4 v5, 0x1

    .line 782
    .local v5, "showPlmn":Z
    iget-boolean v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurShowPlmn:Z

    if-ne v5, v9, :cond_3

    iget-boolean v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurShowSpn:Z

    if-ne v6, v9, :cond_3

    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurSpn:Ljava/lang/String;

    invoke-static {v7, v9}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_3

    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    invoke-static {v3, v9}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_3

    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mError:Ljava/lang/String;

    invoke-static {v0, v9}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_3

    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZone:Ljava/lang/String;

    invoke-static {v8, v9}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_8

    .line 786
    :cond_3
    if-eqz v6, :cond_6

    if-eqz v5, :cond_6

    if-eqz v7, :cond_4

    invoke-virtual {v7, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_5

    :cond_4
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_6

    .line 787
    :cond_5
    const/4 v6, 0x0

    .line 791
    :cond_6
    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v9}, Landroid/telephony/ServiceState;->getState()I

    move-result v9

    if-eqz v9, :cond_7

    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v9}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v9

    if-nez v9, :cond_c

    .line 792
    :cond_7
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Normal Service - showPlmn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " showSpn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 793
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Normal Service - plmn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " spn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 801
    :goto_4
    new-instance v2, Landroid/content/Intent;

    const-string v9, "android.provider.Telephony.SPN_STRINGS_UPDATED"

    invoke-direct {v2, v9}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 802
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v9, 0x20000000

    invoke-virtual {v2, v9}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 803
    const-string v9, "showSpn"

    invoke-virtual {v2, v9, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 804
    const-string v9, "spn"

    invoke-virtual {v2, v9, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 805
    const-string v9, "showPlmn"

    invoke-virtual {v2, v9, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 806
    const-string v9, "plmn"

    invoke-virtual {v2, v9, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 809
    const-string v9, "error"

    invoke-virtual {v2, v9, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 810
    const-string v9, "zone"

    invoke-virtual {v2, v9, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 811
    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v9}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getPhoneId()I

    move-result v9

    invoke-static {v2, v9}, Landroid/telephony/SubscriptionManager;->putPhoneIdAndSubIdExtra(Landroid/content/Intent;I)V

    .line 812
    iget-object v9, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v9}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v9

    sget-object v10, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v9, v2, v10}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 813
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Broadcast showPlmn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", plmn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", zone = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", showSpn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", spn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", error = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 815
    .end local v2    # "intent":Landroid/content/Intent;
    :cond_8
    iput-boolean v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurShowSpn:Z

    .line 816
    iput-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurShowPlmn:Z

    .line 817
    iput-object v7, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurSpn:Ljava/lang/String;

    .line 818
    iput-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    .line 819
    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mError:Ljava/lang/String;

    .line 820
    iput-object v8, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZone:Ljava/lang/String;

    goto/16 :goto_0

    .end local v4    # "rule":I
    .end local v5    # "showPlmn":Z
    .end local v6    # "showSpn":Z
    .end local v7    # "spn":Ljava/lang/String;
    :cond_9
    move v4, v9

    .line 740
    goto/16 :goto_1

    .line 741
    .restart local v4    # "rule":I
    :cond_a
    const-string v7, ""

    goto/16 :goto_2

    .restart local v7    # "spn":Ljava/lang/String;
    :cond_b
    move v6, v9

    .line 774
    goto/16 :goto_3

    .line 795
    .restart local v5    # "showPlmn":Z
    .restart local v6    # "showSpn":Z
    :cond_c
    const/4 v5, 0x1

    .line 796
    const/4 v6, 0x0

    .line 797
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Not Normal Service - showPlmn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " showSpn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 798
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Not Normal Service - plmn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " spn = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto/16 :goto_4
.end method

.method private updateSpnDisplayWithoutIccLGU(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "tmpplmn"    # Ljava/lang/String;
    .param p2, "zone"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    .line 558
    move-object v1, p1

    .line 561
    .local v1, "plmn":Ljava/lang/String;
    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v2

    invoke-virtual {v2}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 562
    const-string v2, "emergency_calls_only_kt"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 564
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "updateSpnDisplayLGU: emergency only and radio is on plmn = \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 573
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    invoke-static {v1, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 574
    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.provider.Telephony.SPN_STRINGS_UPDATED"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 575
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v2, 0x20000000

    invoke-virtual {v0, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 576
    const-string v2, "showPlmn"

    invoke-virtual {v0, v2, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 577
    const-string v2, "plmn"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 580
    const-string v2, "zone"

    invoke-virtual {v0, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 581
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getPhoneId()I

    move-result v2

    invoke-static {v0, v2}, Landroid/telephony/SubscriptionManager;->putPhoneIdAndSubIdExtra(Landroid/content/Intent;I)V

    .line 582
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v0, v3}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 585
    .end local v0    # "intent":Landroid/content/Intent;
    :cond_1
    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    .line 586
    return-void

    .line 566
    :cond_2
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    if-ne v2, v4, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v2

    invoke-virtual {v2}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 567
    const-string v2, "service_disabled"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 569
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "updateSpnDisplayLGU: STATE_OUT_OF_SERVICE plmn ="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method


# virtual methods
.method public PlayVZWERISound(I)V
    .locals 5
    .param p1, "alertId"    # I

    .prologue
    const/4 v4, 0x3

    const/4 v3, 0x0

    .line 1204
    sget-boolean v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v0, :cond_0

    const-string v0, "CdmaSST"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PlayVZWERISound Received alertId :"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->prev_alertId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1207
    :cond_0
    sget v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->prev_alertId:I

    if-ne p1, v0, :cond_1

    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    if-eqz v0, :cond_2

    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "lg_eri_set"

    invoke-static {v0, v1, v3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    if-nez v0, :cond_3

    .line 1242
    :cond_2
    :goto_0
    return-void

    .line 1212
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    if-nez v0, :cond_4

    .line 1213
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    .line 1216
    :cond_4
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->shouldPlayERISound()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 1217
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    if-nez v0, :cond_6

    .line 1218
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    .line 1223
    :goto_1
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    invoke-virtual {v0, v4}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->restoreVolume:I

    .line 1225
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isBTorHeadsetConnected:Z

    if-eqz v0, :cond_5

    .line 1226
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    iget v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->restoreVolume:I

    add-int/lit8 v1, v1, -0x3

    invoke-virtual {v0, v4, v1, v3}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 1229
    :cond_5
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->checkDataSourceForERI(I)Z

    move-result v0

    if-nez v0, :cond_7

    .line 1230
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->clearVZWERISound()V

    .line 1231
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->sendBroadcastForEriFinish()V

    goto :goto_0

    .line 1220
    :cond_6
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V

    goto :goto_1

    .line 1235
    :cond_7
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setMediaPlayerForEriSound()V

    .line 1236
    sput p1, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->prev_alertId:I

    goto :goto_0

    .line 1238
    :cond_8
    sget-boolean v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v0, :cond_9

    const-string v0, "CdmaSST"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PlayVZWERISound Skip alertId :"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->prev_alertId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1239
    :cond_9
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->clearVZWERISound()V

    .line 1240
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->sendBroadcastForEriFinish()V

    goto/16 :goto_0
.end method

.method public PlayVZWERISoundforMTCall(I)V
    .locals 2
    .param p1, "alertId"    # I

    .prologue
    .line 1098
    sget-boolean v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v0, :cond_0

    const-string v0, "CdmaSST"

    const-string v1, "PlayVZWERISoundforMTCall"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1099
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    .line 1100
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->PlayVZWERISound(I)V

    .line 1101
    return-void
.end method

.method public StopVZWERISound()V
    .locals 2

    .prologue
    .line 1104
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1105
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->clearVZWERISound()V

    .line 1106
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isEriSoundForMTCall:Z

    .line 1108
    :cond_0
    return-void
.end method

.method protected addHomeRoamingIndicators(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "homeRoamIndicators"    # Ljava/lang/String;

    .prologue
    .line 927
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 928
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 929
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getCdmaEriHomeSystems()Ljava/lang/String;

    move-result-object p1

    .line 935
    :cond_0
    :goto_0
    return-object p1

    .line 931
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 932
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getCdmaEriHomeSystems()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method protected changePlmnForOperater(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "plmn"    # Ljava/lang/String;

    .prologue
    .line 467
    const-string v0, "SPR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 468
    const-string v0, "Chameleon"

    invoke-static {p1, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 470
    const-string p1, "LG"

    .line 471
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 476
    :cond_0
    return-object p1
.end method

.method public clearVZWERISound()V
    .locals 5

    .prologue
    .line 1112
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAudioManager:Landroid/media/AudioManager;

    const/4 v2, 0x3

    iget v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->restoreVolume:I

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v3, v4}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 1113
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->stop()V

    .line 1114
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->release()V

    .line 1115
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isVZWERISoundPlaying:Z

    .line 1116
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mMediaPlayer:Landroid/media/MediaPlayer;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1120
    :goto_0
    return-void

    .line 1117
    :catch_0
    move-exception v0

    .line 1118
    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v1, "mMediaPlayer has NullPointer Exception."

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public dispose()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 267
    const-string v0, "sprint_location_spec"

    invoke-static {v2, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 268
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCellLocationObserver:Landroid/database/ContentObserver;

    if-eqz v0, :cond_0

    .line 269
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCr:Landroid/content/ContentResolver;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCellLocationObserver:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V

    .line 275
    :cond_0
    const-string v0, "sprint_hdr_roaming"

    invoke-static {v2, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 276
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForHDRRoamingIndicator(Landroid/os/Handler;)V

    .line 281
    :cond_1
    const-string v0, "sprint_ehrpd_forced"

    invoke-static {v2, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 282
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForLteEhrpdForcedChanged(Landroid/os/Handler;)V

    .line 287
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_3

    .line 288
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 293
    :cond_3
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNeedFixZone:Z

    if-eqz v0, :cond_4

    .line 294
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNeedFixZone:Z

    invoke-static {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedNeedFixZone(Z)V

    .line 295
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZoneOffset:I

    invoke-static {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedZoneOffset(I)V

    .line 296
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZoneDst:Z

    invoke-static {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedZoneDst(Z)V

    .line 297
    iget-wide v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mZoneTime:J

    invoke-static {v0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedZoneTime(J)V

    .line 298
    iget-wide v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSavedTime:J

    invoke-static {v0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedTime(J)V

    .line 299
    iget-wide v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSavedAtTime:J

    invoke-static {v0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setSavedAtTime(J)V

    .line 300
    const-string v0, "TimeZone correction is needed after Phone Switching!"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 304
    :cond_4
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->dispose()V

    .line 305
    return-void
.end method

.method protected getEriTextForOperator(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "eriText"    # Ljava/lang/String;

    .prologue
    .line 1300
    const-string v0, "CTC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1301
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getPlmnforCTC()Ljava/lang/String;

    move-result-object p1

    .line 1304
    :cond_0
    return-object p1
.end method

.method public getHDRRoamingIndicator()I
    .locals 1

    .prologue
    .line 1288
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mHDRRoamingIndicator:I

    return v0
.end method

.method public getLteEhrpdForced()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1294
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mLteEhrpdForced:Ljava/lang/String;

    return-object v0
.end method

.method protected getOperatorNumericForSprintSlate(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    .line 1279
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1280
    const-string p1, "31000"

    .line 1282
    :cond_0
    return-object p1
.end method

.method protected getTimeZoneBySid(Ljava/util/TimeZone;IZJ)Ljava/util/TimeZone;
    .locals 4
    .param p1, "zone"    # Ljava/util/TimeZone;
    .param p2, "mZoneOffset"    # I
    .param p3, "mZoneDst"    # Z
    .param p4, "mZoneTime"    # J

    .prologue
    .line 970
    const-string v1, "US"

    const-string v2, "SPR"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 971
    if-nez p1, :cond_0

    .line 974
    :try_start_0
    const-string v1, "fixTimeZone: try again with System ID"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 975
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 976
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/telephony/LGReferenceCountry;->getMccCode()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x3

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/android/internal/telephony/MccTable;->countryCodeForMcc(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p2, p3, p4, p5, v1}, Landroid/util/TimeUtils;->getTimeZone(IZJLjava/lang/String;)Ljava/util/TimeZone;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    .line 985
    :cond_0
    :goto_0
    return-object p1

    .line 980
    :catch_0
    move-exception v0

    .line 981
    .local v0, "ex":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x0

    .line 312
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-boolean v2, v2, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIsTheCurrentActivePhone:Z

    if-nez v2, :cond_3

    .line 313
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Received message "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " while being destroyed. Ignoring."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->loge(Ljava/lang/String;)V

    .line 315
    const/4 v2, 0x0

    const-string v3, "MANAGED_TIME_SETTING"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 316
    if-eqz p1, :cond_1

    iget v2, p1, Landroid/os/Message;->what:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_1

    .line 317
    const-string v2, "NITZ received while disposing CDMAPhone!!"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 319
    sget-object v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-nez v2, :cond_0

    .line 320
    invoke-static {}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->getDefault()Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    move-result-object v2

    sput-object v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    .line 323
    :cond_0
    sget-object v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-eqz v2, :cond_1

    .line 324
    const-string v2, "Save NITZ info. to restore it after phone-switching"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 325
    sget-object v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    invoke-static {v2}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->setLostNitzInfo(Landroid/os/AsyncResult;)V

    .line 331
    :cond_1
    iget v2, p1, Landroid/os/Message;->what:I

    const/16 v3, 0x2b

    if-ne v2, v3, :cond_2

    .line 332
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    .line 367
    :cond_2
    :goto_0
    return-void

    .line 338
    :cond_3
    iget v2, p1, Landroid/os/Message;->what:I

    packed-switch v2, :pswitch_data_0

    .line 364
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 341
    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 342
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_2

    .line 343
    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .line 344
    .local v1, "ints":[I
    aget v2, v1, v3

    iput v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mHDRRoamingIndicator:I

    .line 346
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[CDMAServiceStateTracker] mHDRRoamingIndicator = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mHDRRoamingIndicator:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 354
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "ints":[I
    :pswitch_1
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 355
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_2

    .line 356
    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .line 357
    .restart local v1    # "ints":[I
    aget v2, v1, v3

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mLteEhrpdForced:Ljava/lang/String;

    .line 358
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[CDMAServiceStateTracker] mLteEhrpdForced = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mLteEhrpdForced:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 338
    :pswitch_data_0
    .packed-switch 0x69
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected isAlphaLongFromEriText()Z
    .locals 1

    .prologue
    .line 1029
    const/4 v0, 0x1

    return v0
.end method

.method protected isRoamIndForHomeSystem_data(Ljava/lang/String;)Z
    .locals 6
    .param p1, "roamInd"    # Ljava/lang/String;

    .prologue
    .line 939
    const-string v2, "66,67,69,71,72,74"

    .line 940
    .local v2, "homeRoamIndicators":Ljava/lang/String;
    const-string v5, ","

    invoke-virtual {v2, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_0
    if-ge v3, v4, :cond_1

    aget-object v1, v0, v3

    .line 941
    .local v1, "homeRoamInd":Ljava/lang/String;
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 942
    const/4 v5, 0x1

    .line 945
    .end local v1    # "homeRoamInd":Ljava/lang/String;
    :goto_1
    return v5

    .line 940
    .restart local v1    # "homeRoamInd":Ljava/lang/String;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 945
    .end local v1    # "homeRoamInd":Ljava/lang/String;
    :cond_1
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isRoamIndForHomeSystem(Ljava/lang/String;)Z

    move-result v5

    goto :goto_1
.end method

.method protected runEriChanged(Ljava/lang/String;)V
    .locals 5
    .param p1, "eriText"    # Ljava/lang/String;

    .prologue
    .line 1066
    const/4 v2, 0x0

    const-string v3, "vzw_eri"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 1067
    const/4 v0, -0x1

    .line 1068
    .local v0, "alertId":I
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v2

    if-nez v2, :cond_c

    .line 1069
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getAlertId()I

    move-result v0

    .line 1074
    :cond_0
    :goto_0
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_1

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "pollStateDone: eriText = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1075
    :cond_1
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_2

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "1. mNewSS.getNetworkId() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getNetworkId()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mSS.getNetworkId() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getNetworkId()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1076
    :cond_2
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_3

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "2. mNewSS.getSystemId() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getSystemId()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mSS.getSystemId() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getSystemId()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1077
    :cond_3
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_4

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "3. mSS.getVoiceRegState() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1078
    :cond_4
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_5

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "4. hasStateChanged = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1079
    :cond_5
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_6

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "5. isInShutDown = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isInShutDown:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1081
    :cond_6
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 1083
    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    if-nez v2, :cond_7

    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedRoamingIndicator:Z

    if-eqz v2, :cond_8

    :cond_7
    const/4 v2, -0x1

    sput v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->prev_alertId:I

    .line 1084
    :cond_8
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_d

    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    if-eqz v2, :cond_d

    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isInShutDown:Z

    if-nez v2, :cond_d

    .line 1085
    sget-boolean v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->DBG_CALL:Z

    if-eqz v2, :cond_9

    const-string v2, "CdmaSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isInShutDown : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isInShutDown:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", hasStateChanged : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1086
    :cond_9
    const/16 v2, 0x3e8

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->PlayVZWERISound(I)V

    .line 1092
    :cond_a
    :goto_1
    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.EriChanged"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1093
    .local v1, "erichanged":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v1, v3}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1095
    .end local v0    # "alertId":I
    .end local v1    # "erichanged":Landroid/content/Intent;
    :cond_b
    return-void

    .line 1070
    .restart local v0    # "alertId":I
    :cond_c
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v2

    const/4 v3, 0x3

    if-ne v2, v3, :cond_0

    .line 1071
    const/4 p1, 0x0

    goto/16 :goto_0

    .line 1087
    :cond_d
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    if-nez v2, :cond_a

    .line 1088
    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedSystemIDNetworkID:Z

    if-nez v2, :cond_e

    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedRoamingIndicator:Z

    if-nez v2, :cond_e

    iget-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    if-eqz v2, :cond_a

    .line 1089
    :cond_e
    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->PlayVZWERISound(I)V

    goto :goto_1
.end method

.method protected setAlphaLongWithEriTextLGU(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "eriText"    # Ljava/lang/String;

    .prologue
    .line 991
    const/4 v0, 0x0

    const-string v1, "LGU_CDMA_ERI_TEXT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 992
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getState()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    if-nez v0, :cond_5

    .line 994
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v0

    if-nez v0, :cond_3

    .line 995
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 996
    const-string p1, "LG U+"

    .line 997
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 999
    const-string v0, "[KEY_LGU_CDMA_ERI_TEXT]short,long operatorAlpha is empty! : hardcoded value(LG U+)"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1019
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[KEY_LGU_CDMA_ERI_TEXT],"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1022
    :cond_2
    return-object p1

    .line 1002
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getCdmaEriText()Ljava/lang/String;

    move-result-object p1

    .line 1003
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 1005
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[KEY_LGU_CDMA_ERI_TEXT]roaming, set CdmaEriText : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1011
    :cond_5
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x10400cd

    invoke-virtual {v0, v1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    .line 1014
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, p1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 1016
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[KEY_LGU_CDMA_ERI_TEXT] Not ServiceState.STATE_IN_SERVICE : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected setCdmaRoamingIndicatorDuringDataOnlyState()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 896
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 897
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsRoamingIndicator_data:Z

    if-ne v0, v2, :cond_0

    .line 898
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    const/16 v1, 0x63

    if-ne v0, v1, :cond_1

    .line 899
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    iget v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setCdmaRoamingIndicator(I)V

    .line 906
    :goto_0
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNetworkType_data:I

    const/16 v1, 0xe

    if-ne v0, v1, :cond_0

    .line 907
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 908
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setCdmaRoamingIndicator(I)V

    .line 915
    :cond_0
    :goto_1
    return-void

    .line 900
    :cond_1
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsInPrl:Z

    if-nez v0, :cond_2

    .line 901
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    iget v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator:I

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setCdmaRoamingIndicator(I)V

    goto :goto_0

    .line 903
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    iget v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setCdmaRoamingIndicator(I)V

    goto :goto_0

    .line 910
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, v2}, Landroid/telephony/ServiceState;->setCdmaRoamingIndicator(I)V

    goto :goto_1
.end method

.method protected setChangedValueForEri()V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1047
    const/4 v0, 0x0

    const-string v3, "vzw_eri"

    invoke-static {v0, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1048
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    .line 1049
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v3

    if-eq v0, v3, :cond_2

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasStateChanged:Z

    .line 1050
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getNetworkId()I

    move-result v0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getNetworkId()I

    move-result v3

    if-ne v0, v3, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getSystemId()I

    move-result v0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getSystemId()I

    move-result v3

    if-eq v0, v3, :cond_3

    :cond_0
    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedSystemIDNetworkID:Z

    .line 1052
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getCdmaRoamingIndicator()I

    move-result v0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getCdmaRoamingIndicator()I

    move-result v3

    if-eq v0, v3, :cond_4

    :goto_2
    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->hasChangedRoamingIndicator:Z

    .line 1054
    :cond_1
    return-void

    :cond_2
    move v0, v2

    .line 1049
    goto :goto_0

    :cond_3
    move v0, v2

    .line 1050
    goto :goto_1

    :cond_4
    move v1, v2

    .line 1052
    goto :goto_2
.end method

.method protected setDataRoamingIndicator()V
    .locals 2

    .prologue
    .line 880
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsRoamingIndicator_data:Z

    .line 881
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 882
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    if-nez v0, :cond_0

    .line 884
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator_data:I

    iput v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator:I

    .line 885
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsInPrl_data:Z

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsInPrl:Z

    .line 886
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator_data:I

    iput v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    .line 887
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsRoamingIndicator_data:Z

    .line 889
    const-string v0, "[ERI] 1x no service and do only case !"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 890
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mDefaultRoamingIndicator = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",  mIsInPrl = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsInPrl:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",  mRoamingIndicator = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 893
    :cond_0
    return-void
.end method

.method protected setEmergencyOnlyForPhoneSwitchingLGU(I)V
    .locals 2
    .param p1, "registrationState"    # I

    .prologue
    .line 951
    const/4 v0, 0x0

    const-string v1, "lgu_global_roaming"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 952
    const/16 v0, 0xa

    if-eq p1, v0, :cond_0

    const/16 v0, 0xc

    if-eq p1, v0, :cond_0

    const/16 v0, 0xd

    if-eq p1, v0, :cond_0

    const/16 v0, 0xe

    if-eq p1, v0, :cond_0

    const/4 v0, 0x3

    if-ne p1, v0, :cond_2

    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/PhoneConstants$State;->OFFHOOK:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v0, v1, :cond_2

    .line 958
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    .line 962
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mEmergencyOnly = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 963
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setEmergencyOnly(Z)V

    .line 965
    :cond_1
    return-void

    .line 960
    :cond_2
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mEmergencyOnly:Z

    goto :goto_0
.end method

.method protected setEriTextOnDataOnlyState(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "eriText"    # Ljava/lang/String;

    .prologue
    .line 1057
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1058
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    if-nez v0, :cond_0

    .line 1059
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getCdmaEriText()Ljava/lang/String;

    move-result-object p1

    .line 1062
    :cond_0
    return-object p1
.end method

.method protected setFemtoCellRoamingIndicator(I)V
    .locals 3
    .param p1, "roamingIndicator"    # I

    .prologue
    .line 918
    const/16 v0, 0x63

    if-ne p1, v0, :cond_0

    .line 919
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 920
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0, p1}, Landroid/telephony/ServiceState;->setCdmaRoamingIndicator(I)V

    .line 921
    const-string v0, "CdmaSST"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "set femto ON, ignore other ERI mapping"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 924
    :cond_0
    return-void
.end method

.method public setNetworkName()V
    .locals 5

    .prologue
    const/16 v4, 0x63

    .line 1247
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v0

    if-nez v0, :cond_1

    .line 1248
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    if-ne v0, v4, :cond_0

    .line 1249
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    const-string v1, "Network Extender"

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setVoiceNetworkName(Ljava/lang/String;)V

    .line 1257
    :goto_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    if-nez v0, :cond_5

    .line 1258
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNetworkType_data:I

    const/16 v1, 0xe

    if-ne v0, v1, :cond_2

    .line 1259
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    const-string v1, "Verizon Wireless"

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setDataNetworkName(Ljava/lang/String;)V

    .line 1272
    :goto_1
    return-void

    .line 1251
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v1, v1, Lcom/android/internal/telephony/cdma/CDMAPhone;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    iget v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator:I

    iget v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator:I

    invoke-virtual {v1, v2, v3}, Lcom/android/internal/telephony/cdma/EriManager;->getCdmaEriText(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setVoiceNetworkName(Ljava/lang/String;)V

    goto :goto_0

    .line 1254
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setVoiceNetworkName(Ljava/lang/String;)V

    goto :goto_0

    .line 1260
    :cond_2
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNetworkType_data:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_3

    .line 1261
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setDataNetworkName(Ljava/lang/String;)V

    goto :goto_1

    .line 1263
    :cond_3
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator_data:I

    if-ne v0, v4, :cond_4

    .line 1264
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    const-string v1, "Network Extender"

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setDataNetworkName(Ljava/lang/String;)V

    goto :goto_1

    .line 1266
    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v1, v1, Lcom/android/internal/telephony/cdma/CDMAPhone;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    iget v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator_data:I

    iget v3, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator_data:I

    invoke-virtual {v1, v2, v3}, Lcom/android/internal/telephony/cdma/EriManager;->getCdmaEriText(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setDataNetworkName(Ljava/lang/String;)V

    goto :goto_1

    .line 1270
    :cond_5
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setDataNetworkName(Ljava/lang/String;)V

    goto :goto_1
.end method

.method protected setOperatorNumericPropertyForUSC()V
    .locals 3

    .prologue
    .line 1035
    const-string v0, "US"

    const-string v1, "USC"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1036
    const/4 v0, 0x1

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getLteOnCdmaMode()I

    move-result v1

    if-ne v0, v1, :cond_1

    .line 1037
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    const-string v1, "gsm.operator.numeric"

    const-string v2, "311580"

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 1042
    :cond_0
    :goto_0
    return-void

    .line 1039
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    const-string v1, "gsm.operator.numeric"

    const-string v2, "311220"

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected setPowerStateToDesired()V
    .locals 10

    .prologue
    const/4 v9, 0x0

    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 373
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mDeviceShuttingDown = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDeviceShuttingDown:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 374
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mDesiredPowerState = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDesiredPowerState:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 375
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getRadioState = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v6}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 376
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mPowerOffDelayNeed = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPowerOffDelayNeed:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 377
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mAlarmSwitch = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 380
    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z

    if-eqz v5, :cond_0

    .line 382
    const-string v5, "mAlarmSwitch == true"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 384
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 385
    .local v1, "context":Landroid/content/Context;
    const-string v5, "alarm"

    invoke-virtual {v1, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 386
    .local v0, "am":Landroid/app/AlarmManager;
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRadioOffIntent:Landroid/app/PendingIntent;

    invoke-virtual {v0, v5}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 387
    iput-boolean v7, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z

    .line 391
    .end local v0    # "am":Landroid/app/AlarmManager;
    .end local v1    # "context":Landroid/content/Context;
    :cond_0
    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDesiredPowerState:Z

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v5}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v5

    sget-object v6, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_OFF:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    if-ne v5, v6, :cond_2

    .line 393
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v5, v8, v9}, Lcom/android/internal/telephony/CommandsInterface;->setRadioPower(ZLandroid/os/Message;)V

    .line 427
    :cond_1
    :goto_0
    return-void

    .line 394
    :cond_2
    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDesiredPowerState:Z

    if-nez v5, :cond_5

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v5}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v5

    invoke-virtual {v5}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v5

    if-eqz v5, :cond_5

    .line 396
    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPowerOffDelayNeed:Z

    if-eqz v5, :cond_4

    .line 397
    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mImsRegistrationOnOff:Z

    if-eqz v5, :cond_3

    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z

    if-nez v5, :cond_3

    .line 399
    const-string v5, "mImsRegistrationOnOff == true"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 401
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 402
    .restart local v1    # "context":Landroid/content/Context;
    const-string v5, "alarm"

    invoke-virtual {v1, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 404
    .restart local v0    # "am":Landroid/app/AlarmManager;
    new-instance v4, Landroid/content/Intent;

    const-string v5, "android.intent.action.ACTION_RADIO_OFF"

    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 405
    .local v4, "intent":Landroid/content/Intent;
    invoke-static {v1, v7, v4, v7}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRadioOffIntent:Landroid/app/PendingIntent;

    .line 407
    iput-boolean v8, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z

    .line 409
    const-string v5, "Alarm setting"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 411
    const/4 v5, 0x2

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    const-wide/16 v8, 0xbb8

    add-long/2addr v6, v8

    iget-object v8, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRadioOffIntent:Landroid/app/PendingIntent;

    invoke-virtual {v0, v5, v6, v7, v8}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    .line 414
    new-instance v3, Landroid/content/Intent;

    const-string v5, "com.lge.intent.action.radio_off"

    invoke-direct {v3, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 415
    .local v3, "imsIntent":Landroid/content/Intent;
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget-object v6, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v5, v3, v6}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0

    .line 417
    .end local v0    # "am":Landroid/app/AlarmManager;
    .end local v1    # "context":Landroid/content/Context;
    .end local v3    # "imsIntent":Landroid/content/Intent;
    .end local v4    # "intent":Landroid/content/Intent;
    :cond_3
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v2, v5, Lcom/android/internal/telephony/cdma/CDMAPhone;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .line 418
    .local v2, "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->powerOffRadioSafely(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V

    goto :goto_0

    .line 421
    .end local v2    # "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    :cond_4
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v2, v5, Lcom/android/internal/telephony/cdma/CDMAPhone;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .line 422
    .restart local v2    # "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->powerOffRadioSafely(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V

    goto :goto_0

    .line 424
    .end local v2    # "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    :cond_5
    iget-boolean v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDeviceShuttingDown:Z

    if-eqz v5, :cond_1

    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v5}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v5

    invoke-virtual {v5}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isAvailable()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 425
    iget-object v5, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v5, v9}, Lcom/android/internal/telephony/CommandsInterface;->requestShutdown(Landroid/os/Message;)V

    goto/16 :goto_0
.end method

.method protected setRoamingIndicatorByData([Ljava/lang/String;)V
    .locals 7
    .param p1, "states"    # [Ljava/lang/String;

    .prologue
    const/16 v6, 0xd

    const/16 v5, 0xc

    const/4 v1, 0x1

    const/16 v4, 0xb

    const/4 v2, 0x0

    .line 854
    const/4 v0, 0x0

    const-string v3, "vzw_eri"

    invoke-static {v0, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 855
    array-length v0, p1

    const/4 v3, 0x4

    if-lt v0, v3, :cond_0

    const/4 v0, 0x3

    aget-object v0, p1, v0

    if-eqz v0, :cond_0

    .line 856
    const/4 v0, 0x3

    aget-object v0, p1, v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mNetworkType_data:I

    .line 858
    :cond_0
    array-length v0, p1

    const/16 v3, 0xe

    if-lt v0, v3, :cond_3

    .line 859
    aget-object v0, p1, v4

    if-eqz v0, :cond_1

    aget-object v0, p1, v4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 860
    aget-object v0, p1, v4

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mRoamingIndicator_data:I

    .line 863
    aget-object v0, p1, v2

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->regCodeIsRoaming(I)Z

    move-result v0

    if-eqz v0, :cond_4

    aget-object v0, p1, v4

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isRoamIndForHomeSystem_data(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mLgDataRoaming:Z

    .line 866
    aget-object v0, p1, v2

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->regCodeIsRoaming(I)Z

    move-result v0

    if-eqz v0, :cond_5

    aget-object v0, p1, v4

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isRoamIndForHomeSystem_data(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDataRoaming:Z

    .line 868
    :cond_1
    aget-object v0, p1, v5

    if-eqz v0, :cond_2

    aget-object v0, p1, v5

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_2

    .line 869
    aget-object v0, p1, v5

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_6

    :goto_2
    iput-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mIsInPrl_data:Z

    .line 871
    :cond_2
    aget-object v0, p1, v6

    if-eqz v0, :cond_3

    aget-object v0, p1, v6

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_3

    .line 872
    aget-object v0, p1, v6

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mDefaultRoamingIndicator_data:I

    .line 876
    :cond_3
    return-void

    :cond_4
    move v0, v2

    .line 863
    goto :goto_0

    :cond_5
    move v0, v2

    .line 866
    goto :goto_1

    :cond_6
    move v2, v1

    .line 869
    goto :goto_2
.end method

.method protected updateSpnDisplay()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 433
    const-string v1, "KR"

    const-string v2, "LGU"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 434
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->updateSpnDisplayLGU()V

    .line 462
    :goto_0
    return-void

    .line 440
    :cond_0
    const-string v1, "VZW"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "LRA"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 441
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v1

    if-nez v1, :cond_2

    .line 442
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCr:Landroid/content/ContentResolver;

    const-string v2, "apn2_disable"

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    if-ne v1, v4, :cond_2

    .line 443
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x1040393

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 444
    .local v0, "plmnEco":Ljava/lang/String;
    const-string v1, ""

    invoke-direct {p0, v0, v4, v1, v3}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->updateNetworkIndicator(Ljava/lang/String;ZLjava/lang/String;Z)V

    goto :goto_0

    .line 452
    .end local v0    # "plmnEco":Ljava/lang/String;
    :cond_2
    const/4 v1, 0x0

    const-string v2, "vzw_eri"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 453
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getCdmaRoamingIndicator()I

    move-result v1

    const/16 v2, 0x63

    if-ne v1, v2, :cond_3

    .line 454
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "updateFemtoCellIndicator() : mCurPlmn = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mCurPlmn:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 455
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->updateFemtoCellIndicator()V

    goto :goto_0

    .line 461
    :cond_3
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->updateSpnDisplay()V

    goto :goto_0
.end method
