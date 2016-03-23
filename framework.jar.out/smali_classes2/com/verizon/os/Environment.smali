.class public Lcom/verizon/os/Environment;
.super Ljava/lang/Object;
.source "Environment.java"


# static fields
.field private static final DATA_DIRECTORY:Ljava/io/File;

.field public static DIRECTORY_ALARMS:Ljava/lang/String; = null

.field public static DIRECTORY_DCIM:Ljava/lang/String; = null

.field public static DIRECTORY_DOWNLOADS:Ljava/lang/String; = null

.field public static DIRECTORY_MOVIES:Ljava/lang/String; = null

.field public static DIRECTORY_MUSIC:Ljava/lang/String; = null

.field public static DIRECTORY_NOTIFICATIONS:Ljava/lang/String; = null

.field public static DIRECTORY_PICTURES:Ljava/lang/String; = null

.field public static DIRECTORY_PODCASTS:Ljava/lang/String; = null

.field public static DIRECTORY_RINGTONES:Ljava/lang/String; = null

.field private static final DOWNLOAD_CACHE_DIRECTORY:Ljava/io/File;

.field private static final EXTERNAL_STORAGE_ANDROID_DATA_DIRECTORY:Ljava/io/File;

.field private static final EXTERNAL_STORAGE_ANDROID_MEDIA_DIRECTORY:Ljava/io/File;

.field private static final EXTERNAL_STORAGE_ANDROID_OBB_DIRECTORY:Ljava/io/File;

.field private static final EXTERNAL_STORAGE_DIRECTORY:Ljava/io/File;

.field public static final MEDIA_BAD_REMOVAL:Ljava/lang/String; = "bad_removal"

.field public static final MEDIA_CHECKING:Ljava/lang/String; = "checking"

.field public static final MEDIA_EJECT:Ljava/lang/String; = "eject"

.field public static final MEDIA_MOUNTED:Ljava/lang/String; = "mounted"

.field public static final MEDIA_MOUNTED_READ_ONLY:Ljava/lang/String; = "mounted_ro"

.field public static final MEDIA_NOFS:Ljava/lang/String; = "nofs"

.field public static final MEDIA_REMOVED:Ljava/lang/String; = "removed"

.field public static final MEDIA_SHARED:Ljava/lang/String; = "shared"

.field private static final MEDIA_STORAGE_DIRECTORY:Ljava/io/File;

.field public static final MEDIA_UNMOUNTABLE:Ljava/lang/String; = "unmountable"

.field public static final MEDIA_UNMOUNTED:Ljava/lang/String; = "unmounted"

.field private static final ROOT_DIRECTORY:Ljava/io/File;

.field private static final SECURE_DATA_DIRECTORY:Ljava/io/File;

.field private static final SYSTEM_PROPERTY_EFS_ENABLED:Ljava/lang/String; = "persist.security.efs.enabled"

.field private static final TAG:Ljava/lang/String; = "VZWEnvironment"

.field private static final mLock:Ljava/lang/Object;

.field private static volatile mPrimaryVolume:Landroid/os/storage/StorageVolume;

.field private static final mStorageFiles:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private static final mStorageVolumes:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/os/storage/StorageVolume;",
            ">;"
        }
    .end annotation
.end field

.field private static mVolumeCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    .line 35
    const-string v0, "ANDROID_ROOT"

    const-string v1, "/system"

    invoke-static {v0, v1}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    sput-object v0, Lcom/verizon/os/Environment;->ROOT_DIRECTORY:Ljava/io/File;

    .line 40
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/verizon/os/Environment;->mLock:Ljava/lang/Object;

    .line 42
    const/4 v0, 0x0

    sput-object v0, Lcom/verizon/os/Environment;->mPrimaryVolume:Landroid/os/storage/StorageVolume;

    .line 44
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    .line 45
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/verizon/os/Environment;->mStorageVolumes:Ljava/util/ArrayList;

    .line 46
    const/4 v0, 0x0

    sput v0, Lcom/verizon/os/Environment;->mVolumeCount:I

    .line 184
    const-string v0, "ANDROID_DATA"

    const-string v1, "/data"

    invoke-static {v0, v1}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    sput-object v0, Lcom/verizon/os/Environment;->DATA_DIRECTORY:Ljava/io/File;

    .line 190
    const-string v0, "ANDROID_SECURE_DATA"

    const-string v1, "/data/secure"

    invoke-static {v0, v1}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    sput-object v0, Lcom/verizon/os/Environment;->SECURE_DATA_DIRECTORY:Ljava/io/File;

    .line 194
    const-string v0, "MEDIA_STORAGE"

    const-string v1, "/data/media"

    invoke-static {v0, v1}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    sput-object v0, Lcom/verizon/os/Environment;->MEDIA_STORAGE_DIRECTORY:Ljava/io/File;

    .line 197
    const-string v0, "EXTERNAL_STORAGE"

    const-string v1, "/storage/sdcard0"

    invoke-static {v0, v1}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    sput-object v0, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_DIRECTORY:Ljava/io/File;

    .line 200
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    const-string v2, "EXTERNAL_STORAGE"

    const-string v3, "/storage/sdcard0"

    invoke-static {v2, v3}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    const-string v3, "Android"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v2, "data"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_DATA_DIRECTORY:Ljava/io/File;

    .line 203
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    const-string v2, "EXTERNAL_STORAGE"

    const-string v3, "/storage/sdcard0"

    invoke-static {v2, v3}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    const-string v3, "Android"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v2, "media"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_MEDIA_DIRECTORY:Ljava/io/File;

    .line 206
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    const-string v2, "EXTERNAL_STORAGE"

    const-string v3, "/storage/sdcard0"

    invoke-static {v2, v3}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    const-string v3, "Android"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v2, "obb"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_OBB_DIRECTORY:Ljava/io/File;

    .line 209
    const-string v0, "DOWNLOAD_CACHE"

    const-string v1, "/cache"

    invoke-static {v0, v1}, Lcom/verizon/os/Environment;->getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    sput-object v0, Lcom/verizon/os/Environment;->DOWNLOAD_CACHE_DIRECTORY:Ljava/io/File;

    .line 270
    const-string v0, "Music"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_MUSIC:Ljava/lang/String;

    .line 282
    const-string v0, "Podcasts"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_PODCASTS:Ljava/lang/String;

    .line 294
    const-string v0, "Ringtones"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_RINGTONES:Ljava/lang/String;

    .line 306
    const-string v0, "Alarms"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_ALARMS:Ljava/lang/String;

    .line 318
    const-string v0, "Notifications"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_NOTIFICATIONS:Ljava/lang/String;

    .line 326
    const-string v0, "Pictures"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_PICTURES:Ljava/lang/String;

    .line 334
    const-string v0, "Movies"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_MOVIES:Ljava/lang/String;

    .line 344
    const-string v0, "Download"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_DOWNLOADS:Ljava/lang/String;

    .line 351
    const-string v0, "DCIM"

    sput-object v0, Lcom/verizon/os/Environment;->DIRECTORY_DCIM:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDataDirectory()Ljava/io/File;
    .locals 1

    .prologue
    .line 216
    sget-object v0, Lcom/verizon/os/Environment;->DATA_DIRECTORY:Ljava/io/File;

    return-object v0
.end method

.method static getDirectory(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;
    .locals 2
    .param p0, "variableName"    # Ljava/lang/String;
    .param p1, "defaultPath"    # Ljava/lang/String;

    .prologue
    .line 547
    invoke-static {p0}, Ljava/lang/System;->getenv(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 548
    .local v0, "path":Ljava/lang/String;
    if-nez v0, :cond_0

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    :goto_0
    return-object v1

    :cond_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static getDownloadCacheDirectory()Ljava/io/File;
    .locals 1

    .prologue
    .line 435
    sget-object v0, Lcom/verizon/os/Environment;->DOWNLOAD_CACHE_DIRECTORY:Ljava/io/File;

    return-object v0
.end method

.method public static getExternalStorage()[Ljava/io/File;
    .locals 9

    .prologue
    const/4 v5, 0x0

    .line 53
    sget-object v6, Lcom/verizon/os/Environment;->mLock:Ljava/lang/Object;

    monitor-enter v6

    .line 54
    :try_start_0
    sget-object v4, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v4

    if-nez v4, :cond_3

    .line 56
    :try_start_1
    const-string v4, "mount"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v2

    .line 58
    .local v2, "mountService":Landroid/os/storage/IMountService;
    if-nez v2, :cond_0

    :try_start_2
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v4, v5

    .line 82
    :goto_0
    return-object v4

    .line 59
    :cond_0
    :try_start_3
    invoke-interface {v2}, Landroid/os/storage/IMountService;->getVolumeList()[Landroid/os/storage/StorageVolume;

    move-result-object v3

    .line 61
    .local v3, "volumes":[Landroid/os/Parcelable;
    array-length v4, v3

    sput v4, Lcom/verizon/os/Environment;->mVolumeCount:I

    .line 62
    const-string v4, "VZWEnvironment"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "mVolumeCount = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget v8, Lcom/verizon/os/Environment;->mVolumeCount:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v4, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 63
    sget v4, Lcom/verizon/os/Environment;->mVolumeCount:I

    if-lez v4, :cond_2

    .line 64
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    sget v4, Lcom/verizon/os/Environment;->mVolumeCount:I

    if-ge v1, v4, :cond_1

    .line 65
    sget-object v7, Lcom/verizon/os/Environment;->mStorageVolumes:Ljava/util/ArrayList;

    aget-object v4, v3, v1

    check-cast v4, Landroid/os/storage/StorageVolume;

    invoke-virtual {v7, v1, v4}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 66
    const-string v7, "VZWEnvironment"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "StorageVolumes["

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, "] PATH="

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v4, Lcom/verizon/os/Environment;->mStorageVolumes:Ljava/util/ArrayList;

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/os/storage/StorageVolume;

    invoke-virtual {v4}, Landroid/os/storage/StorageVolume;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v7, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    sget-object v7, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    new-instance v8, Ljava/io/File;

    sget-object v4, Lcom/verizon/os/Environment;->mStorageVolumes:Ljava/util/ArrayList;

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/os/storage/StorageVolume;

    invoke-virtual {v4}, Landroid/os/storage/StorageVolume;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v8, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v1, v8}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 64
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 69
    :cond_1
    sget-object v4, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/io/File;

    invoke-virtual {v4, v7}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Ljava/io/File;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    monitor-exit v6

    goto/16 :goto_0

    .line 81
    .end local v1    # "i":I
    .end local v3    # "volumes":[Landroid/os/Parcelable;
    :catchall_0
    move-exception v4

    monitor-exit v6
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v4

    .line 72
    .restart local v3    # "volumes":[Landroid/os/Parcelable;
    :cond_2
    :try_start_5
    const-string v4, "VZWEnvironment"

    const-string v7, "VolumeList is not available"

    invoke-static {v4, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 81
    .end local v3    # "volumes":[Landroid/os/Parcelable;
    :goto_2
    :try_start_6
    monitor-exit v6

    move-object v4, v5

    .line 82
    goto/16 :goto_0

    .line 74
    :catch_0
    move-exception v0

    .line 75
    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "VZWEnvironment"

    const-string v7, "couldn\'t talk to MountService"

    invoke-static {v4, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_2

    .line 78
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v2    # "mountService":Landroid/os/storage/IMountService;
    :cond_3
    const-string v4, "VZWEnvironment"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getExternalStorage() : mStorageFiles.size() = "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v7, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 79
    sget-object v4, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/io/File;

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Ljava/io/File;

    monitor-exit v6
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto/16 :goto_0
.end method

.method public static getExternalStorageAndroidDataDir()Ljava/io/File;
    .locals 1

    .prologue
    .line 386
    sget-object v0, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_DATA_DIRECTORY:Ljava/io/File;

    return-object v0
.end method

.method public static getExternalStorageAppCacheDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 3
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 427
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    sget-object v2, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_DATA_DIRECTORY:Ljava/io/File;

    invoke-direct {v1, v2, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v2, "cache"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalStorageAppDataDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 2
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 394
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_DATA_DIRECTORY:Ljava/io/File;

    invoke-direct {v0, v1, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalStorageAppFilesDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 3
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 418
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    sget-object v2, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_DATA_DIRECTORY:Ljava/io/File;

    invoke-direct {v1, v2, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const-string v2, "files"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalStorageAppMediaDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 2
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 402
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_MEDIA_DIRECTORY:Ljava/io/File;

    invoke-direct {v0, v1, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalStorageAppObbDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 2
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 410
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_ANDROID_OBB_DIRECTORY:Ljava/io/File;

    invoke-direct {v0, v1, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalStorageDirectory()Ljava/io/File;
    .locals 1

    .prologue
    .line 258
    sget-object v0, Lcom/verizon/os/Environment;->EXTERNAL_STORAGE_DIRECTORY:Ljava/io/File;

    return-object v0
.end method

.method public static getExternalStorageDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 3
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 89
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    sget v1, Lcom/verizon/os/Environment;->mVolumeCount:I

    if-ge v0, v1, :cond_1

    .line 90
    sget-object v1, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 91
    new-instance v2, Ljava/io/File;

    sget-object v1, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v1, v2

    .line 94
    :goto_1
    return-object v1

    .line 89
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 94
    :cond_1
    const/4 v1, 0x0

    goto :goto_1
.end method

.method public static getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;
    .locals 2
    .param p0, "type"    # Ljava/lang/String;

    .prologue
    .line 378
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/verizon/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getExternalStorageState()Ljava/lang/String;
    .locals 3

    .prologue
    .line 505
    :try_start_0
    const-string v2, "mount"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;

    move-result-object v0

    .line 507
    .local v0, "mountService":Landroid/os/storage/IMountService;
    if-nez v0, :cond_0

    const/4 v2, 0x0

    .line 511
    :goto_0
    return-object v2

    .line 508
    :cond_0
    invoke-static {}, Lcom/verizon/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Landroid/os/storage/IMountService;->getVolumeState(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    goto :goto_0

    .line 510
    :catch_0
    move-exception v1

    .line 511
    .local v1, "rex":Ljava/lang/Exception;
    const-string v2, "removed"

    goto :goto_0
.end method

.method public static getMediaStorageDirectory()Ljava/io/File;
    .locals 1

    .prologue
    .line 171
    sget-object v0, Lcom/verizon/os/Environment;->MEDIA_STORAGE_DIRECTORY:Ljava/io/File;

    return-object v0
.end method

.method private static getPrimaryVolume()Landroid/os/storage/StorageVolume;
    .locals 6

    .prologue
    .line 109
    sget-object v3, Lcom/verizon/os/Environment;->mPrimaryVolume:Landroid/os/storage/StorageVolume;

    if-nez v3, :cond_2

    .line 110
    sget-object v4, Lcom/verizon/os/Environment;->mLock:Ljava/lang/Object;

    monitor-enter v4

    .line 111
    :try_start_0
    sget-object v3, Lcom/verizon/os/Environment;->mPrimaryVolume:Landroid/os/storage/StorageVolume;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_1

    .line 113
    :try_start_1
    const-string v3, "mount"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 115
    .local v1, "mountService":Landroid/os/storage/IMountService;
    if-nez v1, :cond_0

    const/4 v3, 0x0

    :try_start_2
    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 124
    :goto_0
    return-object v3

    .line 116
    :cond_0
    :try_start_3
    invoke-interface {v1}, Landroid/os/storage/IMountService;->getVolumeList()[Landroid/os/storage/StorageVolume;

    move-result-object v2

    .line 117
    .local v2, "volumes":[Landroid/os/Parcelable;
    const/4 v3, 0x0

    aget-object v3, v2, v3

    check-cast v3, Landroid/os/storage/StorageVolume;

    sput-object v3, Lcom/verizon/os/Environment;->mPrimaryVolume:Landroid/os/storage/StorageVolume;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 122
    .end local v2    # "volumes":[Landroid/os/Parcelable;
    :cond_1
    :goto_1
    :try_start_4
    monitor-exit v4
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 124
    :cond_2
    sget-object v3, Lcom/verizon/os/Environment;->mPrimaryVolume:Landroid/os/storage/StorageVolume;

    goto :goto_0

    .line 118
    :catch_0
    move-exception v0

    .line 119
    .local v0, "e":Ljava/lang/Exception;
    :try_start_5
    const-string v3, "VZWEnvironment"

    const-string v5, "couldn\'t talk to MountService"

    invoke-static {v3, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 122
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v3
.end method

.method public static getRootDirectory()Ljava/io/File;
    .locals 1

    .prologue
    .line 131
    sget-object v0, Lcom/verizon/os/Environment;->ROOT_DIRECTORY:Ljava/io/File;

    return-object v0
.end method

.method public static getSecureDataDirectory()Ljava/io/File;
    .locals 1

    .prologue
    .line 157
    invoke-static {}, Lcom/verizon/os/Environment;->isEncryptedFilesystemEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 158
    sget-object v0, Lcom/verizon/os/Environment;->SECURE_DATA_DIRECTORY:Ljava/io/File;

    .line 160
    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/verizon/os/Environment;->DATA_DIRECTORY:Ljava/io/File;

    goto :goto_0
.end method

.method public static getSystemSecureDirectory()Ljava/io/File;
    .locals 3

    .prologue
    .line 142
    invoke-static {}, Lcom/verizon/os/Environment;->isEncryptedFilesystemEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 143
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/verizon/os/Environment;->SECURE_DATA_DIRECTORY:Ljava/io/File;

    const-string v2, "system"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 145
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/verizon/os/Environment;->DATA_DIRECTORY:Ljava/io/File;

    const-string v2, "system"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static isEncryptedFilesystemEnabled()Z
    .locals 2

    .prologue
    .line 181
    const-string v0, "persist.security.efs.enabled"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public static isExternalStorageEmulated()Z
    .locals 2

    .prologue
    .line 542
    invoke-static {}, Lcom/verizon/os/Environment;->getPrimaryVolume()Landroid/os/storage/StorageVolume;

    move-result-object v0

    .line 543
    .local v0, "volume":Landroid/os/storage/StorageVolume;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/os/storage/StorageVolume;->isEmulated()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static isExternalStorageRemovable()Z
    .locals 2

    .prologue
    .line 524
    invoke-static {}, Lcom/verizon/os/Environment;->getPrimaryVolume()Landroid/os/storage/StorageVolume;

    move-result-object v0

    .line 525
    .local v0, "volume":Landroid/os/storage/StorageVolume;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/os/storage/StorageVolume;->isRemovable()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static isExternalStorageRemovable(Ljava/lang/String;)Z
    .locals 2
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    .line 100
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    sget v1, Lcom/verizon/os/Environment;->mVolumeCount:I

    if-ge v0, v1, :cond_1

    .line 101
    sget-object v1, Lcom/verizon/os/Environment;->mStorageFiles:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 102
    sget-object v1, Lcom/verizon/os/Environment;->mStorageVolumes:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/storage/StorageVolume;

    invoke-virtual {v1}, Landroid/os/storage/StorageVolume;->isRemovable()Z

    move-result v1

    .line 104
    :goto_1
    return v1

    .line 100
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 104
    :cond_1
    const/4 v1, 0x0

    goto :goto_1
.end method
