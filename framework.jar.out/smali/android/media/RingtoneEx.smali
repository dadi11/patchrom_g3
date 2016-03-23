.class public Landroid/media/RingtoneEx;
.super Landroid/media/Ringtone;
.source "RingtoneEx.java"


# static fields
.field private static final CUPSS_ALARM_FILEPATH:Ljava/lang/String;

.field private static final CUPSS_NOTIFICATION_FILEPATH:Ljava/lang/String;

.field private static final CUPSS_RINGTONE_FILEPATH:Ljava/lang/String;

.field public static final DEFAULT_ALARMS_FILEPATH:Ljava/lang/String;

.field public static final DEFAULT_NOTIFICATIONS_FILEPATH:Ljava/lang/String;

.field public static final DEFAULT_RINGTONES_FILEPATH:Ljava/lang/String;

.field private static final DEFAULT_RINGTONE_PROPERTY_PREFIX:Ljava/lang/String; = "ro.config."

.field private static final ERROR_CHECK_INIT:I = 0x0

.field private static final ERROR_CHECK_SETDEFAULT:I = 0x2

.field private static final ERROR_CHECK_START:I = 0x1

.field private static final LOGD:Z = true

.field private static final TAG:Ljava/lang/String; = "RingtoneEx"

.field private static final USER_RINGTONE_FILEPATH:Ljava/lang/String;


# instance fields
.field errorListener:Landroid/media/MediaPlayer$OnErrorListener;

.field private mDrmFile:I

.field private mDrmPath:Ljava/lang/String;

.field private mDrmValid:Z

.field private mErrorCheck:I

.field private mIsSoundException:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 61
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/system/media/audio/ringtones/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.ringtone"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->DEFAULT_RINGTONES_FILEPATH:Ljava/lang/String;

    .line 69
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/system/media/audio/notifications/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.notification_sound"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->DEFAULT_NOTIFICATIONS_FILEPATH:Ljava/lang/String;

    .line 72
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/system/media/audio/alarms/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.alarm_alert"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->DEFAULT_ALARMS_FILEPATH:Ljava/lang/String;

    .line 81
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "ro.lge.capp_cupss.rootdir"

    const-string v2, "/cust"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/media/audio/ringtones/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.ringtone"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->CUPSS_RINGTONE_FILEPATH:Ljava/lang/String;

    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "/data/local/media/audio/ringtones/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.ringtone"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->USER_RINGTONE_FILEPATH:Ljava/lang/String;

    .line 86
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "ro.lge.capp_cupss.rootdir"

    const-string v2, "/cust"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/media/audio/alarms/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.alarm_alert"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->CUPSS_ALARM_FILEPATH:Ljava/lang/String;

    .line 89
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "ro.lge.capp_cupss.rootdir"

    const-string v2, "/cust"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/media/audio/notifications/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "ro.config.notification_sound"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroid/media/RingtoneEx;->CUPSS_NOTIFICATION_FILEPATH:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Z)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "allowRemote"    # Z

    .prologue
    const/4 v1, 0x0

    .line 103
    invoke-direct {p0, p1, p2}, Landroid/media/Ringtone;-><init>(Landroid/content/Context;Z)V

    .line 46
    iput v1, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    .line 47
    iput-boolean v1, p0, Landroid/media/RingtoneEx;->mDrmValid:Z

    .line 50
    const/4 v0, 0x0

    iput-object v0, p0, Landroid/media/RingtoneEx;->mDrmPath:Ljava/lang/String;

    .line 55
    iput-boolean v1, p0, Landroid/media/RingtoneEx;->mIsSoundException:Z

    .line 774
    new-instance v0, Landroid/media/RingtoneEx$1;

    invoke-direct {v0, p0}, Landroid/media/RingtoneEx$1;-><init>(Landroid/media/RingtoneEx;)V

    iput-object v0, p0, Landroid/media/RingtoneEx;->errorListener:Landroid/media/MediaPlayer$OnErrorListener;

    .line 105
    iput v1, p0, Landroid/media/RingtoneEx;->mErrorCheck:I

    .line 108
    const-string/jumbo v0, "ro.lge.audio_soundexception"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroid/media/RingtoneEx;->mIsSoundException:Z

    .line 110
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;ZI)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "allowRemote"    # Z
    .param p3, "streamType"    # I

    .prologue
    .line 116
    invoke-direct {p0, p1, p2}, Landroid/media/RingtoneEx;-><init>(Landroid/content/Context;Z)V

    .line 117
    invoke-virtual {p0, p3}, Landroid/media/RingtoneEx;->setStreamType(I)V

    .line 118
    return-void
.end method

.method static synthetic access$000(Landroid/media/RingtoneEx;)I
    .locals 1
    .param p0, "x0"    # Landroid/media/RingtoneEx;

    .prologue
    .line 41
    iget v0, p0, Landroid/media/RingtoneEx;->mErrorCheck:I

    return v0
.end method

.method static synthetic access$002(Landroid/media/RingtoneEx;I)I
    .locals 0
    .param p0, "x0"    # Landroid/media/RingtoneEx;
    .param p1, "x1"    # I

    .prologue
    .line 41
    iput p1, p0, Landroid/media/RingtoneEx;->mErrorCheck:I

    return p1
.end method

.method static synthetic access$100(Landroid/media/RingtoneEx;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Landroid/media/RingtoneEx;

    .prologue
    .line 41
    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private checkDRM(Ljava/lang/String;)I
    .locals 6
    .param p1, "filename"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 550
    if-nez p1, :cond_1

    .line 583
    :cond_0
    :goto_0
    return v1

    .line 554
    :cond_1
    const/4 v4, 0x0

    invoke-static {v3, p1, v4}, Lcom/lge/lgdrm/DrmManager;->isSupportedExtension(ILjava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 558
    invoke-static {p1}, Lcom/lge/lgdrm/DrmManager;->isDRM(Ljava/lang/String;)I

    move-result v4

    iput v4, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    .line 559
    iget v4, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    const/16 v5, 0x10

    if-lt v4, v5, :cond_2

    iget v4, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    const/16 v5, 0x3000

    if-le v4, v5, :cond_3

    .line 560
    :cond_2
    iput v1, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    goto :goto_0

    .line 565
    :cond_3
    :try_start_0
    iget-object v1, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    invoke-static {p1, v1}, Lcom/lge/lgdrm/DrmManager;->createContentSession(Ljava/lang/String;Landroid/content/Context;)Lcom/lge/lgdrm/DrmContentSession;

    move-result-object v0

    .line 566
    .local v0, "session":Lcom/lge/lgdrm/DrmContentSession;
    if-nez v0, :cond_4

    move v1, v2

    .line 567
    goto :goto_0

    .line 570
    :cond_4
    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lcom/lge/lgdrm/DrmContentSession;->isActionSupported(I)Z

    move-result v1

    if-nez v1, :cond_5

    move v1, v2

    .line 571
    goto :goto_0

    .line 574
    :cond_5
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/lge/lgdrm/DrmContentSession;->setDecryptionInfo(Z)I

    move-result v1

    if-eqz v1, :cond_6

    move v1, v2

    .line 575
    goto :goto_0

    .line 578
    :cond_6
    const/4 v1, 0x1

    iput-boolean v1, p0, Landroid/media/RingtoneEx;->mDrmValid:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v1, v3

    .line 579
    goto :goto_0

    .line 580
    .end local v0    # "session":Lcom/lge/lgdrm/DrmContentSession;
    :catch_0
    move-exception v1

    move v1, v2

    .line 583
    goto :goto_0
.end method

.method private getDefaultAudioType()Ljava/lang/String;
    .locals 4

    .prologue
    .line 687
    const/4 v0, 0x0

    .line 689
    .local v0, "audioType":Ljava/lang/String;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 700
    :pswitch_0
    const-string v0, "is_ringtone"

    .line 705
    :goto_0
    const-string v1, "RingtoneEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getDefaultAudioType : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 707
    return-object v0

    .line 691
    :pswitch_1
    const-string v0, "is_ringtone"

    .line 692
    goto :goto_0

    .line 694
    :pswitch_2
    const-string v0, "is_notification"

    .line 695
    goto :goto_0

    .line 697
    :pswitch_3
    const-string v0, "is_alarm"

    .line 698
    goto :goto_0

    .line 689
    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private getDefaultPath()Ljava/lang/String;
    .locals 9

    .prologue
    .line 606
    const/4 v4, 0x0

    .line 607
    .local v4, "defaultRingtone":Ljava/lang/String;
    const/4 v3, 0x0

    .line 608
    .local v3, "custPath":Ljava/io/File;
    const/4 v5, 0x0

    .line 609
    .local v5, "userPath":Ljava/io/File;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v6

    packed-switch v6, :pswitch_data_0

    .line 655
    :pswitch_0
    sget-object v4, Landroid/media/RingtoneEx;->DEFAULT_NOTIFICATIONS_FILEPATH:Ljava/lang/String;

    .line 660
    :goto_0
    const-string v6, "RingtoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "default ringtone path: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 662
    return-object v4

    .line 612
    :pswitch_1
    iget-object v6, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    invoke-virtual {v6}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    sget v7, Lcom/lge/internal/R$bool;->config_chameleon_supported:I

    invoke-virtual {v6, v7}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    .line 614
    .local v0, "chameleonSupported":Z
    const-string v6, "RingtoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "chameleonSupported : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 617
    if-eqz v0, :cond_0

    .line 618
    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultRingtonePathChameleon()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 621
    :cond_0
    new-instance v3, Ljava/io/File;

    .end local v3    # "custPath":Ljava/io/File;
    sget-object v6, Landroid/media/RingtoneEx;->CUPSS_RINGTONE_FILEPATH:Ljava/lang/String;

    invoke-direct {v3, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 622
    .restart local v3    # "custPath":Ljava/io/File;
    new-instance v5, Ljava/io/File;

    .end local v5    # "userPath":Ljava/io/File;
    sget-object v6, Landroid/media/RingtoneEx;->USER_RINGTONE_FILEPATH:Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 623
    .restart local v5    # "userPath":Ljava/io/File;
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-virtual {v5}, Ljava/io/File;->canRead()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 624
    sget-object v4, Landroid/media/RingtoneEx;->USER_RINGTONE_FILEPATH:Ljava/lang/String;

    goto :goto_0

    .line 625
    :cond_1
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-virtual {v3}, Ljava/io/File;->canRead()Z

    move-result v6

    if-eqz v6, :cond_2

    .line 626
    sget-object v4, Landroid/media/RingtoneEx;->CUPSS_RINGTONE_FILEPATH:Ljava/lang/String;

    goto :goto_0

    .line 629
    :cond_2
    sget-object v4, Landroid/media/RingtoneEx;->DEFAULT_RINGTONES_FILEPATH:Ljava/lang/String;

    .line 633
    goto :goto_0

    .line 636
    .end local v0    # "chameleonSupported":Z
    :pswitch_2
    new-instance v2, Ljava/io/File;

    sget-object v6, Landroid/media/RingtoneEx;->CUPSS_NOTIFICATION_FILEPATH:Ljava/lang/String;

    invoke-direct {v2, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 637
    .local v2, "custNotification":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-virtual {v2}, Ljava/io/File;->canRead()Z

    move-result v6

    if-eqz v6, :cond_3

    .line 638
    sget-object v4, Landroid/media/RingtoneEx;->CUPSS_NOTIFICATION_FILEPATH:Ljava/lang/String;

    goto/16 :goto_0

    .line 641
    :cond_3
    sget-object v4, Landroid/media/RingtoneEx;->DEFAULT_NOTIFICATIONS_FILEPATH:Ljava/lang/String;

    .line 643
    goto/16 :goto_0

    .line 646
    .end local v2    # "custNotification":Ljava/io/File;
    :pswitch_3
    new-instance v1, Ljava/io/File;

    sget-object v6, Landroid/media/RingtoneEx;->CUPSS_ALARM_FILEPATH:Ljava/lang/String;

    invoke-direct {v1, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 647
    .local v1, "custAlarm":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-virtual {v1}, Ljava/io/File;->canRead()Z

    move-result v6

    if-eqz v6, :cond_4

    .line 648
    sget-object v4, Landroid/media/RingtoneEx;->CUPSS_ALARM_FILEPATH:Ljava/lang/String;

    goto/16 :goto_0

    .line 651
    :cond_4
    sget-object v4, Landroid/media/RingtoneEx;->DEFAULT_ALARMS_FILEPATH:Ljava/lang/String;

    .line 653
    goto/16 :goto_0

    .line 609
    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private getDefaultRingtonePathChameleon()Ljava/lang/String;
    .locals 6

    .prologue
    .line 668
    sget-object v2, Landroid/media/RingtoneEx;->DEFAULT_RINGTONES_FILEPATH:Ljava/lang/String;

    .line 669
    .local v2, "ringtone":Ljava/lang/String;
    const-string v1, "/carrier/media/ringtones/default_ringer.mp3"

    .line 670
    .local v1, "carrierRingtonePath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 672
    .local v0, "carrierRingtone":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 673
    const-string v3, "RingtoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Ringtone in CP, set to CP tone : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 674
    move-object v2, v1

    .line 680
    :goto_0
    return-object v2

    .line 676
    :cond_0
    const-string v3, "RingtoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "No Ringtone in CP, set to OEM : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Landroid/media/RingtoneEx;->DEFAULT_RINGTONES_FILEPATH:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 677
    sget-object v2, Landroid/media/RingtoneEx;->DEFAULT_RINGTONES_FILEPATH:Ljava/lang/String;

    goto :goto_0
.end method

.method private getDefaultTitle(Landroid/content/Context;)Ljava/lang/String;
    .locals 12
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x2

    const/4 v11, 0x1

    .line 716
    const/4 v6, 0x0

    .line 717
    .local v6, "cursor":Landroid/database/Cursor;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 719
    .local v0, "res":Landroid/content/ContentResolver;
    const/4 v9, 0x0

    .line 720
    .local v9, "title":Ljava/lang/String;
    const/4 v8, 0x0

    .line 721
    .local v8, "defaultPath":Ljava/lang/String;
    const/4 v7, 0x0

    .line 723
    .local v7, "defaultAudioType":Ljava/lang/String;
    iget-object v1, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-static {v1}, Lcom/lge/media/RingtoneManagerEx;->getDefaultType(Landroid/net/Uri;)I

    move-result v1

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-static {v1}, Lcom/lge/media/RingtoneManagerEx;->getDefaultType(Landroid/net/Uri;)I

    move-result v1

    const/16 v2, 0x10

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-static {v1}, Lcom/lge/media/RingtoneManagerEx;->getDefaultType(Landroid/net/Uri;)I

    move-result v1

    const/16 v2, 0x100

    if-ne v1, v2, :cond_2

    .line 726
    :cond_0
    sget-object v8, Landroid/media/RingtoneEx;->DEFAULT_NOTIFICATIONS_FILEPATH:Ljava/lang/String;

    .line 727
    const-string v7, "is_notification"

    .line 734
    :goto_0
    :try_start_0
    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->INTERNAL_CONTENT_URI:Landroid/net/Uri;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string/jumbo v4, "title"

    aput-object v4, v2, v3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_data =? AND mime_type =?  AND "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " =? "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v8, v4, v5

    const/4 v5, 0x1

    const-string v10, "application/ogg"

    aput-object v10, v4, v5

    const/4 v5, 0x2

    const-string v10, "1"

    aput-object v10, v4, v5

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v6

    .line 746
    :goto_1
    if-eqz v6, :cond_4

    :try_start_1
    invoke-interface {v6}, Landroid/database/Cursor;->getCount()I

    move-result v1

    if-ne v1, v11, :cond_4

    .line 748
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    .line 749
    const/4 v1, 0x0

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 750
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v1

    const/4 v2, 0x5

    if-ne v1, v2, :cond_3

    .line 751
    sget v1, Lcom/lge/internal/R$string;->notification_default_with_actual:I

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v9, v2, v3

    invoke-virtual {p1, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v9

    .line 764
    :goto_2
    if-eqz v6, :cond_1

    .line 765
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 769
    :cond_1
    return-object v9

    .line 729
    :cond_2
    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v8

    .line 730
    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultAudioType()Ljava/lang/String;

    move-result-object v7

    goto :goto_0

    .line 755
    :cond_3
    const v1, 0x10404b1

    const/4 v2, 0x1

    :try_start_2
    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v9, v2, v3

    invoke-virtual {p1, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    goto :goto_2

    .line 760
    :cond_4
    const-string v1, "RingtoneEx"

    const-string v2, "Default ringtone does NOT exist. "

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 761
    const v1, 0x10404b4

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v9

    goto :goto_2

    .line 764
    :catchall_0
    move-exception v1

    if-eqz v6, :cond_5

    .line 765
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_5
    throw v1

    .line 741
    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method protected static getTitle(Landroid/content/Context;Landroid/net/Uri;Z)Ljava/lang/String;
    .locals 12
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "followSettingsUri"    # Z

    .prologue
    .line 161
    const/4 v9, 0x0

    .line 162
    .local v9, "cursor":Landroid/database/Cursor;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 164
    .local v0, "res":Landroid/content/ContentResolver;
    const/4 v11, 0x0

    .line 166
    .local v11, "title":Ljava/lang/String;
    if-eqz p1, :cond_3

    .line 167
    invoke-virtual {p1}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v8

    .line 169
    .local v8, "authority":Ljava/lang/String;
    const-string/jumbo v1, "settings"

    invoke-virtual {v1, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 170
    if-eqz p2, :cond_3

    .line 172
    invoke-static {p1}, Lcom/lge/media/RingtoneManagerEx;->getDefaultType(Landroid/net/Uri;)I

    move-result v10

    .line 173
    .local v10, "ringToneType":I
    invoke-static {p0, v10}, Lcom/lge/media/RingtoneManagerEx;->getActualDefaultRingtoneUri(Landroid/content/Context;I)Landroid/net/Uri;

    move-result-object v7

    .line 174
    .local v7, "actualUri":Landroid/net/Uri;
    const/4 v1, 0x0

    invoke-static {p0, v7, v1}, Landroid/media/RingtoneEx;->getTitle(Landroid/content/Context;Landroid/net/Uri;Z)Ljava/lang/String;

    move-result-object v6

    .line 176
    .local v6, "actualTitle":Ljava/lang/String;
    if-nez v6, :cond_1

    .line 177
    const/4 v1, 0x0

    .line 219
    .end local v6    # "actualTitle":Ljava/lang/String;
    .end local v7    # "actualUri":Landroid/net/Uri;
    .end local v8    # "authority":Ljava/lang/String;
    .end local v10    # "ringToneType":I
    :cond_0
    :goto_0
    return-object v1

    .line 180
    .restart local v6    # "actualTitle":Ljava/lang/String;
    .restart local v7    # "actualUri":Landroid/net/Uri;
    .restart local v8    # "authority":Ljava/lang/String;
    .restart local v10    # "ringToneType":I
    :cond_1
    const/4 v1, 0x2

    if-eq v10, v1, :cond_2

    const/16 v1, 0x10

    if-eq v10, v1, :cond_2

    const/16 v1, 0x100

    if-ne v10, v1, :cond_4

    .line 182
    :cond_2
    sget v1, Lcom/lge/internal/R$string;->notification_default_with_actual:I

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v6, v2, v3

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    .end local v6    # "actualTitle":Ljava/lang/String;
    .end local v7    # "actualUri":Landroid/net/Uri;
    .end local v8    # "authority":Ljava/lang/String;
    .end local v10    # "ringToneType":I
    :cond_3
    :goto_1
    move-object v1, v11

    .line 219
    goto :goto_0

    .line 186
    .restart local v6    # "actualTitle":Ljava/lang/String;
    .restart local v7    # "actualUri":Landroid/net/Uri;
    .restart local v8    # "authority":Ljava/lang/String;
    .restart local v10    # "ringToneType":I
    :cond_4
    const v1, 0x10404b1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v6, v2, v3

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    goto :goto_1

    .line 194
    .end local v6    # "actualTitle":Ljava/lang/String;
    .end local v7    # "actualUri":Landroid/net/Uri;
    .end local v10    # "ringToneType":I
    :cond_5
    :try_start_0
    const-string/jumbo v1, "media"

    invoke-virtual {v1, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 195
    sget-object v2, Landroid/media/RingtoneEx;->MEDIA_COLUMNS:[Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p1

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v9

    .line 202
    :cond_6
    :goto_2
    if-eqz v9, :cond_7

    :try_start_1
    invoke-interface {v9}, Landroid/database/Cursor;->getCount()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_7

    .line 203
    invoke-interface {v9}, Landroid/database/Cursor;->moveToFirst()Z

    .line 204
    const/4 v1, 0x2

    invoke-interface {v9, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 213
    if-eqz v9, :cond_0

    .line 214
    invoke-interface {v9}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 209
    :cond_7
    const/4 v1, 0x0

    .line 213
    if-eqz v9, :cond_0

    .line 214
    invoke-interface {v9}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 213
    :catchall_0
    move-exception v1

    if-eqz v9, :cond_8

    .line 214
    invoke-interface {v9}, Landroid/database/Cursor;->close()V

    :cond_8
    throw v1

    .line 197
    :catch_0
    move-exception v1

    goto :goto_2
.end method

.method private setDataSourceFromResource(Landroid/content/res/Resources;Landroid/media/MediaPlayer;I)V
    .locals 7
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "player"    # Landroid/media/MediaPlayer;
    .param p3, "res"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 507
    invoke-virtual {p1, p3}, Landroid/content/res/Resources;->openRawResourceFd(I)Landroid/content/res/AssetFileDescriptor;

    move-result-object v6

    .line 508
    .local v6, "afd":Landroid/content/res/AssetFileDescriptor;
    if-eqz v6, :cond_0

    .line 509
    invoke-virtual {v6}, Landroid/content/res/AssetFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    invoke-virtual {v6}, Landroid/content/res/AssetFileDescriptor;->getStartOffset()J

    move-result-wide v2

    invoke-virtual {v6}, Landroid/content/res/AssetFileDescriptor;->getLength()J

    move-result-wide v4

    move-object v0, p2

    invoke-virtual/range {v0 .. v5}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V

    .line 511
    iget-object v0, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {p2, v0}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 512
    invoke-virtual {v6}, Landroid/content/res/AssetFileDescriptor;->close()V

    .line 514
    :cond_0
    return-void
.end method


# virtual methods
.method public getProperty(I)I
    .locals 4
    .param p1, "type"    # I

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 522
    if-ne p1, v0, :cond_2

    .line 524
    iget v2, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    if-nez v2, :cond_1

    .line 537
    :cond_0
    :goto_0
    return v0

    .line 527
    :cond_1
    iget-boolean v2, p0, Landroid/media/RingtoneEx;->mDrmValid:Z

    if-nez v2, :cond_0

    move v0, v1

    goto :goto_0

    .line 528
    :cond_2
    const/4 v2, 0x2

    if-ne p1, v2, :cond_4

    .line 530
    iget v2, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    if-eqz v2, :cond_3

    iget v2, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    const/16 v3, 0x31

    if-eq v2, v3, :cond_3

    iget v2, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    const/16 v3, 0x501

    if-eq v2, v3, :cond_3

    iget v2, p0, Landroid/media/RingtoneEx;->mDrmFile:I

    const/16 v3, 0x1800

    if-ne v2, v3, :cond_0

    :cond_3
    move v0, v1

    .line 533
    goto :goto_0

    :cond_4
    move v0, v1

    .line 537
    goto :goto_0
.end method

.method public getTitle(Landroid/content/Context;)Ljava/lang/String;
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 133
    const-string v0, ""

    .line 134
    .local v0, "mTitle":Ljava/lang/String;
    iget-object v2, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    if-eqz v2, :cond_0

    iget-object v2, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v2}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 136
    const v2, 0x10404b2

    invoke-virtual {p1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 148
    .end local v0    # "mTitle":Ljava/lang/String;
    .local v1, "mTitle":Ljava/lang/String;
    :goto_0
    return-object v1

    .line 141
    .end local v1    # "mTitle":Ljava/lang/String;
    .restart local v0    # "mTitle":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    const/4 v3, 0x1

    invoke-static {p1, v2, v3}, Landroid/media/RingtoneEx;->getTitle(Landroid/content/Context;Landroid/net/Uri;Z)Ljava/lang/String;

    move-result-object v0

    .line 143
    if-nez v0, :cond_1

    .line 145
    invoke-direct {p0, p1}, Landroid/media/RingtoneEx;->getDefaultTitle(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    :cond_1
    move-object v1, v0

    .line 148
    .end local v0    # "mTitle":Ljava/lang/String;
    .restart local v1    # "mTitle":Ljava/lang/String;
    goto :goto_0
.end method

.method public isPlaying()Z
    .locals 2

    .prologue
    .line 593
    iget-object v0, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    iget v0, p0, Landroid/media/RingtoneEx;->mErrorCheck:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 594
    const-string v0, "RingtoneEx"

    const-string v1, "Can\'t check isPlaying() during ErrorChecking"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 595
    const/4 v0, 0x0

    .line 599
    :goto_0
    return v0

    :cond_0
    invoke-super {p0}, Landroid/media/Ringtone;->isPlaying()Z

    move-result v0

    goto :goto_0
.end method

.method public play()V
    .locals 1

    .prologue
    .line 437
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/media/RingtoneEx;->play(Z)V

    .line 438
    return-void
.end method

.method public play(Z)V
    .locals 5
    .param p1, "loop"    # Z

    .prologue
    .line 448
    iget-object v2, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    if-eqz v2, :cond_2

    .line 453
    iget-object v2, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v3, p0, Landroid/media/RingtoneEx;->errorListener:Landroid/media/MediaPlayer$OnErrorListener;

    invoke-virtual {v2, v3}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 455
    iget-object v2, p0, Landroid/media/RingtoneEx;->mAudioManager:Landroid/media/AudioManager;

    iget-object v3, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-static {v3}, Landroid/media/AudioAttributes;->toLegacyStreamType(Landroid/media/AudioAttributes;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v2

    if-eqz v2, :cond_1

    .line 457
    iget-object v2, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v2, p1}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 458
    iget-object v2, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->start()V

    .line 481
    :cond_0
    :goto_0
    return-void

    .line 461
    :cond_1
    iget-boolean v2, p0, Landroid/media/RingtoneEx;->mIsSoundException:Z

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v2

    iget-object v3, p0, Landroid/media/RingtoneEx;->mAudioManager:Landroid/media/AudioManager;

    const/4 v3, 0x2

    if-ne v2, v3, :cond_0

    .line 462
    iget-object v2, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v2, p1}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 463
    iget-object v2, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->start()V

    goto :goto_0

    .line 467
    :cond_2
    iget-boolean v2, p0, Landroid/media/RingtoneEx;->mAllowRemote:Z

    if-eqz v2, :cond_3

    .line 468
    iget-object v2, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v2}, Landroid/net/Uri;->getCanonicalUri()Landroid/net/Uri;

    move-result-object v0

    .line 470
    .local v0, "canonicalUri":Landroid/net/Uri;
    :try_start_0
    iget-object v2, p0, Landroid/media/RingtoneEx;->mRemotePlayer:Landroid/media/IRingtonePlayer;

    iget-object v3, p0, Landroid/media/RingtoneEx;->mRemoteToken:Landroid/os/Binder;

    iget-object v4, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-interface {v2, v3, v0, v4}, Landroid/media/IRingtonePlayer;->play(Landroid/os/IBinder;Landroid/net/Uri;Landroid/media/AudioAttributes;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 471
    :catch_0
    move-exception v1

    .line 472
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->playFallbackRingtone()Z

    move-result v2

    if-nez v2, :cond_0

    .line 473
    const-string v2, "RingtoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Problem playing ringtone: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 477
    .end local v0    # "canonicalUri":Landroid/net/Uri;
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_3
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->playFallbackRingtone()Z

    move-result v2

    if-nez v2, :cond_0

    .line 478
    const-string v2, "RingtoneEx"

    const-string v3, "Neither local nor remote playback available"

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected playFallbackRingtone()Z
    .locals 6

    .prologue
    .line 812
    const-string v3, "RingtoneEx"

    const-string/jumbo v4, "playFallbackRingtone"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 813
    iget-object v3, p0, Landroid/media/RingtoneEx;->mAudioManager:Landroid/media/AudioManager;

    iget-object v4, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-static {v4}, Landroid/media/AudioAttributes;->toLegacyStreamType(Landroid/media/AudioAttributes;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v3

    if-nez v3, :cond_0

    iget-boolean v3, p0, Landroid/media/RingtoneEx;->mIsSoundException:Z

    if-eqz v3, :cond_1

    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v3

    iget-object v4, p0, Landroid/media/RingtoneEx;->mAudioManager:Landroid/media/AudioManager;

    const/4 v4, 0x2

    if-ne v3, v4, :cond_1

    .line 815
    :cond_0
    iget-object v3, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-static {v3}, Landroid/media/RingtoneManager;->getDefaultRingtoneSubIdByUri(Landroid/net/Uri;)I

    move-result v2

    .line 816
    .local v2, "subId":I
    const/4 v3, -0x1

    if-eq v2, v3, :cond_2

    iget-object v3, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    invoke-static {v3, v2}, Landroid/media/RingtoneManager;->getActualRingtoneUriBySubId(Landroid/content/Context;I)Landroid/net/Uri;

    move-result-object v3

    if-eqz v3, :cond_2

    .line 819
    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v0

    .line 820
    .local v0, "defaultPath":Ljava/lang/String;
    const-string v3, "RingtoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "playFallbackRingtone() path "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 821
    if-eqz v0, :cond_1

    .line 823
    :try_start_0
    new-instance v3, Landroid/media/MediaPlayer;

    invoke-direct {v3}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v3, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    .line 824
    iget-object v3, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v3, v0}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 825
    iget-object v3, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v4, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v3, v4}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 826
    iget-object v3, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    .line 827
    iget-object v3, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v3}, Landroid/media/MediaPlayer;->prepare()V

    .line 828
    iget-object v3, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v3}, Landroid/media/MediaPlayer;->start()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 829
    const/4 v3, 0x1

    .line 839
    .end local v0    # "defaultPath":Ljava/lang/String;
    .end local v2    # "subId":I
    :goto_0
    return v3

    .line 830
    .restart local v0    # "defaultPath":Ljava/lang/String;
    .restart local v2    # "subId":I
    :catch_0
    move-exception v1

    .line 831
    .local v1, "ex":Ljava/io/IOException;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->destroyLocalPlayer()V

    .line 832
    const-string v3, "RingtoneEx"

    const-string v4, "default filepath is not set"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 839
    .end local v0    # "defaultPath":Ljava/lang/String;
    .end local v1    # "ex":Ljava/io/IOException;
    .end local v2    # "subId":I
    :cond_1
    :goto_1
    const/4 v3, 0x0

    goto :goto_0

    .line 836
    .restart local v2    # "subId":I
    :cond_2
    const-string v3, "RingtoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "not playing fallback for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V
    .locals 2
    .param p1, "listener"    # Landroid/media/MediaPlayer$OnCompletionListener;

    .prologue
    .line 424
    iget-object v0, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 425
    const-string v0, "RingtoneEx"

    const-string/jumbo v1, "setOnCompletionListener"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 426
    iget-object v0, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    .line 428
    :cond_0
    return-void
.end method

.method public setUri(Landroid/net/Uri;)V
    .locals 14
    .param p1, "uri"    # Landroid/net/Uri;

    .prologue
    const/4 v13, 0x1

    .line 232
    const/4 v8, 0x0

    .line 233
    .local v8, "setDefault":Z
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->destroyLocalPlayer()V

    .line 235
    iput-object p1, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    .line 236
    iget-object v9, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    if-eqz v9, :cond_0

    iget-object v9, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    const-string v10, ""

    invoke-static {v10}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 398
    :cond_0
    :goto_0
    return-void

    .line 242
    :cond_1
    new-instance v9, Landroid/media/MediaPlayer;

    invoke-direct {v9}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    .line 245
    const/4 v4, 0x0

    .line 246
    .local v4, "path":Ljava/lang/String;
    const/4 v3, 0x0

    .line 248
    .local v3, "nStatus":I
    :try_start_0
    sget-boolean v9, Lcom/lge/config/ConfigBuildFlags;->CAPP_DRM:Z

    if-eqz v9, :cond_2

    .line 249
    iget-object v9, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v10}, Landroid/net/Uri;->getCanonicalUri()Landroid/net/Uri;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/lge/lgdrm/DrmFwExt;->getActualRingtoneUri(Landroid/content/Context;Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v4

    .line 250
    if-eqz v4, :cond_2

    .line 251
    iget-object v9, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    const/4 v10, 0x1

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-static {v9, v4, v10, v11, v12}, Lcom/lge/lgdrm/DrmFwExt;->checkDRMRingtone(Landroid/content/Context;Ljava/lang/String;ZZZ)I

    move-result v3

    .line 254
    :cond_2
    if-ne v3, v13, :cond_5

    .line 261
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 262
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 332
    :goto_1
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    .line 335
    const-string v9, "DCM"

    const-string/jumbo v10, "ro.build.target_operator"

    invoke-static {v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_4

    move-result v9

    if-eqz v9, :cond_c

    .line 337
    :try_start_1
    const-string v9, "RingtoneEx"

    const-string v10, "[hy] mLocalPlayer.prepare();"

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 338
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v9}, Landroid/media/MediaPlayer;->prepare()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_1 .. :try_end_1} :catch_4

    .line 377
    :cond_3
    :goto_2
    if-eqz v8, :cond_4

    .line 378
    const-string v9, "RingtoneEx"

    const-string v10, "Set default ringtone!"

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 380
    :try_start_2
    new-instance v9, Landroid/media/MediaPlayer;

    invoke-direct {v9}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    .line 381
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 382
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 383
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    .line 384
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v9}, Landroid/media/MediaPlayer;->prepare()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_6

    .line 392
    :cond_4
    :goto_3
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    if-eqz v9, :cond_d

    .line 393
    const-string v9, "RingtoneEx"

    const-string v10, "Successfully created local player"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 264
    :cond_5
    const/4 v9, 0x2

    if-ne v3, v9, :cond_6

    .line 265
    :try_start_3
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v9, v4}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 266
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 267
    iput-object v4, p0, Landroid/media/RingtoneEx;->mDrmPath:Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_3 .. :try_end_3} :catch_4

    goto :goto_1

    .line 356
    :catch_0
    move-exception v1

    .line 357
    .local v1, "e":Ljava/lang/SecurityException;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->destroyLocalPlayer()V

    .line 358
    iget-boolean v9, p0, Landroid/media/RingtoneEx;->mAllowRemote:Z

    if-nez v9, :cond_3

    .line 359
    const-string v9, "RingtoneEx"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Remote playback not allowed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 360
    const/4 v8, 0x1

    goto :goto_2

    .line 274
    .end local v1    # "e":Ljava/lang/SecurityException;
    :cond_6
    :try_start_4
    const-string v9, "RingtoneEx"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v11, "ringtone uri :"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "  path :"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 277
    iget-object v9, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v9}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v0

    .line 278
    .local v0, "authority":Ljava/lang/String;
    invoke-static {p1}, Lcom/lge/media/RingtoneManagerEx;->getDefaultType(Landroid/net/Uri;)I

    move-result v5

    .line 279
    .local v5, "ringToneType":I
    iget-object v9, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    invoke-static {v9, v5}, Lcom/lge/media/RingtoneManagerEx;->getActualDefaultRingtoneUri(Landroid/content/Context;I)Landroid/net/Uri;

    move-result-object v7

    .line 281
    .local v7, "ringtoneUri":Landroid/net/Uri;
    const-string/jumbo v9, "settings"

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_7

    if-nez v7, :cond_7

    .line 285
    new-instance v9, Landroid/content/res/Resources$NotFoundException;

    invoke-direct {v9}, Landroid/content/res/Resources$NotFoundException;-><init>()V

    throw v9
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_4 .. :try_end_4} :catch_4

    .line 324
    .end local v0    # "authority":Ljava/lang/String;
    .end local v5    # "ringToneType":I
    .end local v7    # "ringtoneUri":Landroid/net/Uri;
    :catch_1
    move-exception v2

    .line 325
    .local v2, "ex":Ljava/io/IOException;
    :try_start_5
    const-string v9, "RingtoneEx"

    const-string v10, "Problem setDataSource; try to play default ringtone"

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 326
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 327
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V
    :try_end_5
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_5 .. :try_end_5} :catch_4

    goto/16 :goto_1

    .line 362
    .end local v2    # "ex":Ljava/io/IOException;
    :catch_2
    move-exception v1

    .line 363
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->destroyLocalPlayer()V

    .line 364
    iget-boolean v9, p0, Landroid/media/RingtoneEx;->mAllowRemote:Z

    if-nez v9, :cond_3

    .line 365
    const-string v9, "RingtoneEx"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Remote playback not allowed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 366
    const/4 v8, 0x1

    goto/16 :goto_2

    .line 287
    .end local v1    # "e":Ljava/io/IOException;
    .restart local v0    # "authority":Ljava/lang/String;
    .restart local v5    # "ringToneType":I
    .restart local v7    # "ringtoneUri":Landroid/net/Uri;
    :cond_7
    if-eqz v4, :cond_8

    .line 288
    :try_start_6
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 289
    .local v6, "ringtoneFile":Ljava/io/File;
    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v9

    if-nez v9, :cond_8

    .line 290
    const-string v9, "RingtoneEx"

    const-string v10, "File not exists, Change path to null"

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_6 .. :try_end_6} :catch_4

    .line 291
    const/4 v4, 0x0

    .line 296
    .end local v6    # "ringtoneFile":Ljava/io/File;
    :cond_8
    if-nez v4, :cond_a

    .line 300
    :try_start_7
    iget-object v9, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    if-eqz v9, :cond_9

    .line 301
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    iget-object v11, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v9, v10, v11}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 302
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_7 .. :try_end_7} :catch_4

    goto/16 :goto_1

    .line 307
    :catch_3
    move-exception v1

    .line 308
    .local v1, "e":Ljava/lang/Exception;
    :try_start_8
    const-string v9, "RingtoneEx"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Problem setDataSource; try to play default ringtone e = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 309
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 310
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_8 .. :try_end_8} :catch_4

    goto/16 :goto_1

    .line 368
    .end local v0    # "authority":Ljava/lang/String;
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v5    # "ringToneType":I
    .end local v7    # "ringtoneUri":Landroid/net/Uri;
    :catch_4
    move-exception v1

    .line 369
    .local v1, "e":Landroid/content/res/Resources$NotFoundException;
    invoke-virtual {p0}, Landroid/media/RingtoneEx;->destroyLocalPlayer()V

    .line 370
    iget-boolean v9, p0, Landroid/media/RingtoneEx;->mAllowRemote:Z

    if-nez v9, :cond_3

    .line 371
    const-string v9, "RingtoneEx"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Remote playback not allowed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .line 304
    .end local v1    # "e":Landroid/content/res/Resources$NotFoundException;
    .restart local v0    # "authority":Ljava/lang/String;
    .restart local v5    # "ringToneType":I
    .restart local v7    # "ringtoneUri":Landroid/net/Uri;
    :cond_9
    :try_start_9
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 305
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_9 .. :try_end_9} :catch_4

    goto/16 :goto_1

    .line 315
    :cond_a
    :try_start_a
    const-string/jumbo v9, "settings"

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_b

    .line 316
    const-string v9, "RingtoneEx"

    const-string/jumbo v10, "setDataSource ActualUri"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 317
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    invoke-virtual {v9, v10, v7}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 322
    :goto_4
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    goto/16 :goto_1

    .line 319
    :cond_b
    const-string v9, "RingtoneEx"

    const-string/jumbo v10, "setDataSource mUri"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 320
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    iget-object v11, p0, Landroid/media/RingtoneEx;->mUri:Landroid/net/Uri;

    invoke-virtual {v9, v10, v11}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_a .. :try_end_a} :catch_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_a .. :try_end_a} :catch_4

    goto :goto_4

    .line 339
    .end local v0    # "authority":Ljava/lang/String;
    .end local v5    # "ringToneType":I
    .end local v7    # "ringtoneUri":Landroid/net/Uri;
    :catch_5
    move-exception v2

    .line 340
    .local v2, "ex":Ljava/lang/Exception;
    :try_start_b
    const-string v9, "RingtoneEx"

    const-string v10, "[run][hy] exception is occurred. mLocalPlayer.prepare() Error: Try to play a default Ringtone!!!"

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 342
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v9}, Landroid/media/MediaPlayer;->release()V

    .line 343
    const/4 v9, 0x0

    iput-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    .line 344
    new-instance v9, Landroid/media/MediaPlayer;

    invoke-direct {v9}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    .line 345
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-direct {p0}, Landroid/media/RingtoneEx;->getDefaultPath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setDataSource(Ljava/lang/String;)V

    .line 346
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    iget-object v10, p0, Landroid/media/RingtoneEx;->mAudioAttributes:Landroid/media/AudioAttributes;

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioAttributes(Landroid/media/AudioAttributes;)V

    .line 347
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/RingtoneEx;->getStreamType()I

    move-result v10

    invoke-virtual {v9, v10}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    .line 348
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v9}, Landroid/media/MediaPlayer;->prepare()V

    goto/16 :goto_2

    .line 351
    .end local v2    # "ex":Ljava/lang/Exception;
    :cond_c
    iget-object v9, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v9}, Landroid/media/MediaPlayer;->prepare()V
    :try_end_b
    .catch Ljava/lang/SecurityException; {:try_start_b .. :try_end_b} :catch_0
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_2
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_b .. :try_end_b} :catch_4

    goto/16 :goto_2

    .line 385
    :catch_6
    move-exception v1

    .line 386
    .local v1, "e":Ljava/io/IOException;
    const-string v9, "RingtoneEx"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v11, "setDefault Ringtone is errer:"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    .line 395
    .end local v1    # "e":Ljava/io/IOException;
    :cond_d
    const-string v9, "RingtoneEx"

    const-string v10, "Problem opening; delegating to remote player"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method public setVolume(F)V
    .locals 2
    .param p1, "volume"    # F

    .prologue
    .line 407
    iget-object v0, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 408
    iget-object v0, p0, Landroid/media/RingtoneEx;->mLocalPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1, p1}, Landroid/media/MediaPlayer;->setVolume(FF)V

    .line 414
    :goto_0
    return-void

    .line 409
    :cond_0
    iget-boolean v0, p0, Landroid/media/RingtoneEx;->mAllowRemote:Z

    if-eqz v0, :cond_1

    .line 410
    const-string v0, "RingtoneEx"

    const-string/jumbo v1, "setVolume is only supported by local playback"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 412
    :cond_1
    const-string v0, "RingtoneEx"

    const-string v1, "Neither local nor remote playback available"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public stop()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 491
    iget-object v0, p0, Landroid/media/RingtoneEx;->mDrmPath:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 493
    iget-object v0, p0, Landroid/media/RingtoneEx;->mContext:Landroid/content/Context;

    iget-object v1, p0, Landroid/media/RingtoneEx;->mDrmPath:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-static {v0, v1, v3, v2, v3}, Lcom/lge/lgdrm/DrmFwExt;->checkDRMRingtone(Landroid/content/Context;Ljava/lang/String;ZZZ)I

    .line 496
    :cond_0
    invoke-super {p0}, Landroid/media/Ringtone;->stop()V

    .line 497
    return-void
.end method