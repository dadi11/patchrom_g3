.class public Lcom/android/server/MasterClearReceiver;
.super Landroid/content/BroadcastReceiver;
.source "MasterClearReceiver.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "MasterClear"

.field private static apnBackup:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/android/server/MasterClearReceiver;Landroid/content/Context;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/MasterClearReceiver;
    .param p1, "x1"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/server/MasterClearReceiver;->backup_disableofadmin(Landroid/content/Context;)V

    return-void
.end method

.method private static backupAPNForVZW(Landroid/content/Context;)V
    .locals 9
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    new-instance v4, Lcom/android/internal/telephony/lgdata/LGDBControl;

    invoke-direct {v4, p0}, Lcom/android/internal/telephony/lgdata/LGDBControl;-><init>(Landroid/content/Context;)V

    .local v4, "mLGDBControl":Lcom/android/internal/telephony/lgdata/LGDBControl;
    :try_start_0
    new-instance v5, Ljava/io/BufferedWriter;

    new-instance v6, Ljava/io/FileWriter;

    new-instance v7, Ljava/lang/String;

    const-string v8, "/persist-lg/apn2/apn_values_backup"

    invoke-direct {v7, v8}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    invoke-direct {v6, v7}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v6}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .local v5, "outApnFile":Ljava/io/BufferedWriter;
    const-string v1, ""

    .local v1, "buffer":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    const/4 v6, 0x5

    if-ge v3, v6, :cond_0

    invoke-virtual {v4, v3}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getAPNString(I)Ljava/lang/String;

    move-result-object v0

    .local v0, "APNValue":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .end local v0    # "APNValue":Ljava/lang/String;
    :cond_0
    invoke-virtual {v5, v1}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/BufferedWriter;->flush()V

    invoke-virtual {v5}, Ljava/io/BufferedWriter;->close()V

    const-string v6, "APN Backup"

    const-string v7, " Backup APN table!"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "buffer":Ljava/lang/String;
    .end local v3    # "i":I
    .end local v5    # "outApnFile":Ljava/io/BufferedWriter;
    :goto_1
    return-void

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/Exception;
    const-string v6, "APN Backup"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Backup APN table"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private backup_disableofadmin(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    :try_start_0
    new-instance v1, Ljava/io/BufferedWriter;

    new-instance v2, Ljava/io/FileWriter;

    new-instance v3, Ljava/lang/String;

    const-string v4, "/persist-lg/apn2/admin_apn_backup"

    invoke-direct {v3, v4}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .local v1, "outApnFile":Ljava/io/BufferedWriter;
    const-string v2, "APN Backup"

    const-string v3, "LGFactoryReset: Backup APN table Start!"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "lge.data.apn2-disable"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "APN Backup"

    const-string v3, "Backup APN2-disable to 1 !"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "1"

    invoke-virtual {v1, v2}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/android/server/MasterClearReceiver;->backupAPNForVZW(Landroid/content/Context;)V

    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedWriter;->flush()V

    invoke-virtual {v1}, Ljava/io/BufferedWriter;->close()V

    const-string v2, "APN Backup"

    const-string v3, "LGFactoryReset: Backup APN table End!"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "outApnFile":Ljava/io/BufferedWriter;
    :goto_1
    return-void

    .restart local v1    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_0
    const-string v2, "APN Backup"

    const-string v3, "Backup APN2-disable to 0 !"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "0"

    invoke-virtual {v1, v2}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/android/server/MasterClearReceiver;->backupAPNForVZW(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v1    # "outApnFile":Ljava/io/BufferedWriter;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "LGE_TEST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "LGFactoryReset: Factory Reset Flag write fail"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v3, 0x0

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    const-string v2, "com.google.android.c2dm.intent.RECEIVE"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "google.com"

    const-string v2, "from"

    invoke-virtual {p2, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "MasterClear"

    const-string v2, "Ignoring master clear request -- not from trusted server."

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_BACKUP_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "apnbackup"

    invoke-virtual {p2, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/android/server/MasterClearReceiver;->apnBackup:Ljava/lang/String;

    sget-object v1, Lcom/android/server/MasterClearReceiver;->apnBackup:Ljava/lang/String;

    if-nez v1, :cond_1

    const-string v1, "content://telephony/carriers/backup_apn"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    .local v6, "BACKUP_APN_URI":Landroid/net/Uri;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    new-instance v2, Landroid/content/ContentValues;

    invoke-direct {v2}, Landroid/content/ContentValues;-><init>()V

    invoke-virtual {v1, v6, v2, v3, v3}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v7

    .local v7, "result":I
    const/4 v1, 0x1

    if-ne v7, v1, :cond_2

    const-string v1, "MasterClear"

    const-string v2, "[backupApn] excuted backup apn!! "

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v6    # "BACKUP_APN_URI":Landroid/net/Uri;
    .end local v7    # "result":I
    :cond_1
    :goto_1
    const-string v1, "shutdown"

    const/4 v2, 0x0

    invoke-virtual {p2, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v4

    .local v4, "shutdown":Z
    const-string v1, "android.intent.extra.REASON"

    invoke-virtual {p2, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .local v5, "reason":Ljava/lang/String;
    const-string v1, "MasterClear"

    const-string v2, "!!! FACTORY RESET !!!"

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/android/server/MasterClearReceiver$1;

    const-string v2, "Reboot"

    move-object v1, p0

    move-object v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/android/server/MasterClearReceiver$1;-><init>(Lcom/android/server/MasterClearReceiver;Ljava/lang/String;Landroid/content/Context;ZLjava/lang/String;)V

    .local v0, "thr":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .end local v0    # "thr":Ljava/lang/Thread;
    .end local v4    # "shutdown":Z
    .end local v5    # "reason":Ljava/lang/String;
    .restart local v6    # "BACKUP_APN_URI":Landroid/net/Uri;
    .restart local v7    # "result":I
    :cond_2
    const-string v1, "MasterClear"

    const-string v2, "[backupApn] not backup apn!! "

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
