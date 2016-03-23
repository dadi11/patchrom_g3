.class Lcom/android/server/LGEncryptionService;
.super Landroid/os/storage/ILGEncryptionService$Stub;
.source "LGEncryptionService.java"

# interfaces
.implements Lcom/android/server/INativeDaemonConnectorCallbacks;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/LGEncryptionService$VoldResponseCode;
    }
.end annotation


# static fields
.field public static final CRYPTO_TYPES:[Ljava/lang/String;

.field private static final DEBUG_EVENTS:Z = false

.field private static final ENCRYPTED_SDCARD_MSG:Ljava/lang/String; = "com.android.settings.EncryptedSDCardDialogActivity"

.field private static final ENCRYPTION_WARNING_MSG:Ljava/lang/String; = "com.android.settings.EncryptWarningDialogActivity"

.field private static final MAX_CONTAINERS:I = 0xfa

.field private static final OTHER_DEVICE_MSG:Ljava/lang/String; = "com.android.settings.OtherDeviceDialogActivity"

.field private static final TAG:Ljava/lang/String; = "LGEncryptionService"

.field private static final VOLD_TAG:Ljava/lang/String; = "VoldConnector4"

.field private static mNoPopup:Z


# instance fields
.field WarningDialogHandler:Landroid/os/Handler;

.field private final mConnectedSignal:Ljava/util/concurrent/CountDownLatch;

.field private mConnector:Lcom/android/server/NativeDaemonConnector;

.field private mContext:Landroid/content/Context;

.field mountService:Landroid/os/storage/IMountService;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 40
    sput-boolean v2, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    .line 45
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "password"

    aput-object v1, v0, v2

    const/4 v1, 0x1

    const-string v2, "default"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "pattern"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "pin"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/server/LGEncryptionService;->CRYPTO_TYPES:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 180
    invoke-direct {p0}, Landroid/os/storage/ILGEncryptionService$Stub;-><init>()V

    .line 49
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v0, p0, Lcom/android/server/LGEncryptionService;->mConnectedSignal:Ljava/util/concurrent/CountDownLatch;

    .line 95
    new-instance v0, Lcom/android/server/LGEncryptionService$2;

    invoke-direct {v0, p0}, Lcom/android/server/LGEncryptionService$2;-><init>(Lcom/android/server/LGEncryptionService;)V

    iput-object v0, p0, Lcom/android/server/LGEncryptionService;->WarningDialogHandler:Landroid/os/Handler;

    .line 181
    iput-object p1, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    .line 182
    new-instance v0, Lcom/android/server/NativeDaemonConnector;

    const-string v2, "vold"

    const/16 v3, 0x1f4

    const-string v4, "VoldConnector4"

    const/16 v5, 0x19

    const/4 v6, 0x0

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/android/server/NativeDaemonConnector;-><init>(Lcom/android/server/INativeDaemonConnectorCallbacks;Ljava/lang/String;ILjava/lang/String;ILandroid/os/PowerManager$WakeLock;)V

    iput-object v0, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    .line 183
    new-instance v7, Ljava/lang/Thread;

    iget-object v0, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v1, "VoldConnector4"

    invoke-direct {v7, v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 184
    .local v7, "thread":Ljava/lang/Thread;
    invoke-virtual {v7}, Ljava/lang/Thread;->start()V

    .line 185
    return-void
.end method

.method static synthetic access$000(Lcom/android/server/LGEncryptionService;)Ljava/util/concurrent/CountDownLatch;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/LGEncryptionService;

    .prologue
    .line 27
    iget-object v0, p0, Lcom/android/server/LGEncryptionService;->mConnectedSignal:Ljava/util/concurrent/CountDownLatch;

    return-object v0
.end method

.method static synthetic access$100(Lcom/android/server/LGEncryptionService;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/LGEncryptionService;

    .prologue
    .line 27
    iget-object v0, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method private getExternalSDCardMountPath()Ljava/lang/String;
    .locals 9

    .prologue
    const/4 v5, 0x0

    .line 211
    :try_start_0
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->getVolumeList()[Landroid/os/storage/StorageVolume;

    move-result-object v4

    .line 212
    .local v4, "mVolumes":[Landroid/os/storage/StorageVolume;
    if-nez v4, :cond_1

    .line 227
    .end local v4    # "mVolumes":[Landroid/os/storage/StorageVolume;
    :cond_0
    :goto_0
    return-object v5

    .line 215
    .restart local v4    # "mVolumes":[Landroid/os/storage/StorageVolume;
    :cond_1
    array-length v2, v4

    .line 217
    .local v2, "length":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    if-ge v1, v2, :cond_0

    .line 218
    aget-object v3, v4, v1

    .line 219
    .local v3, "mStorageVolume":Landroid/os/storage/StorageVolume;
    invoke-virtual {v3}, Landroid/os/storage/StorageVolume;->isRemovable()Z

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_2

    .line 220
    invoke-virtual {v3}, Landroid/os/storage/StorageVolume;->getPath()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    goto :goto_0

    .line 217
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 225
    .end local v1    # "i":I
    .end local v2    # "length":I
    .end local v3    # "mStorageVolume":Landroid/os/storage/StorageVolume;
    .end local v4    # "mVolumes":[Landroid/os/storage/StorageVolume;
    :catch_0
    move-exception v0

    .line 226
    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "LGEncryptionService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getExternalSDCardMountPath...exception : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private getVolumeList()[Landroid/os/storage/StorageVolume;
    .locals 9

    .prologue
    const/4 v7, 0x0

    .line 188
    const-string v6, "mount"

    invoke-static {v6}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v5

    .line 189
    .local v5, "service":Landroid/os/IBinder;
    if-nez v5, :cond_1

    .line 190
    const-string v6, "LGEncryptionService"

    const-string v8, "getInternalSDCardMountPath...service null"

    invoke-static {v6, v8}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v4, v7

    .line 205
    :cond_0
    :goto_0
    return-object v4

    .line 193
    :cond_1
    invoke-static {v5}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;

    move-result-object v6

    iput-object v6, p0, Lcom/android/server/LGEncryptionService;->mountService:Landroid/os/storage/IMountService;

    .line 195
    :try_start_0
    iget-object v6, p0, Lcom/android/server/LGEncryptionService;->mountService:Landroid/os/storage/IMountService;

    invoke-interface {v6}, Landroid/os/storage/IMountService;->getVolumeList()[Landroid/os/storage/StorageVolume;

    move-result-object v3

    .line 196
    .local v3, "list":[Landroid/os/Parcelable;
    if-nez v3, :cond_2

    const/4 v6, 0x0

    new-array v4, v6, [Landroid/os/storage/StorageVolume;

    goto :goto_0

    .line 197
    :cond_2
    array-length v2, v3

    .line 198
    .local v2, "length":I
    new-array v4, v2, [Landroid/os/storage/StorageVolume;

    .line 199
    .local v4, "result":[Landroid/os/storage/StorageVolume;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    if-ge v1, v2, :cond_0

    .line 200
    aget-object v6, v3, v1

    check-cast v6, Landroid/os/storage/StorageVolume;

    aput-object v6, v4, v1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 199
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 203
    .end local v1    # "i":I
    .end local v2    # "length":I
    .end local v3    # "list":[Landroid/os/Parcelable;
    .end local v4    # "result":[Landroid/os/storage/StorageVolume;
    :catch_0
    move-exception v0

    .line 204
    .local v0, "e":Landroid/os/RemoteException;
    const-string v6, "LGEncryptionService"

    const-string v8, "Failed to get volume list"

    invoke-static {v6, v8, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object v4, v7

    .line 205
    goto :goto_0
.end method

.method private toHex(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    .line 232
    if-nez p1, :cond_0

    .line 233
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1}, Ljava/lang/String;-><init>()V

    .line 238
    :goto_0
    return-object v1

    .line 235
    :cond_0
    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 236
    .local v0, "bytes":[B
    new-instance v1, Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/codec/binary/Hex;->encodeHex([B)[C

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/String;-><init>([C)V

    .line 237
    .local v1, "hexPassword":Ljava/lang/String;
    const/4 v2, 0x0

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([BB)V

    goto :goto_0
.end method

.method private waitForLatch(Ljava/util/concurrent/CountDownLatch;)V
    .locals 4
    .param p1, "latch"    # Ljava/util/concurrent/CountDownLatch;

    .prologue
    .line 57
    :goto_0
    const-wide/16 v2, 0x1388

    :try_start_0
    sget-object v1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p1, v2, v3, v1}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 58
    return-void

    .line 60
    :cond_0
    const-string v1, "LGEncryptionService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Thread "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " still waiting for MountService ready..."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 63
    :catch_0
    move-exception v0

    .line 64
    .local v0, "e":Ljava/lang/InterruptedException;
    const-string v1, "LGEncryptionService"

    const-string v2, "Interrupt while waiting for MountService to be ready."

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private waitForReady()V
    .locals 1

    .prologue
    .line 51
    iget-object v0, p0, Lcom/android/server/LGEncryptionService;->mConnectedSignal:Ljava/util/concurrent/CountDownLatch;

    invoke-direct {p0, v0}, Lcom/android/server/LGEncryptionService;->waitForLatch(Ljava/util/concurrent/CountDownLatch;)V

    .line 52
    return-void
.end method


# virtual methods
.method public LGencryptStorage(ILjava/lang/String;)I
    .locals 8
    .param p1, "type"    # I
    .param p2, "password"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 290
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 291
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "password cannot be empty"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 294
    :cond_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 297
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 304
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "cryptfs"

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "enablelgcrypto"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "inplace"

    aput-object v6, v4, v5

    const/4 v5, 0x2

    sget-object v6, Lcom/android/server/LGEncryptionService;->CRYPTO_TYPES:[Ljava/lang/String;

    aget-object v6, v6, p1

    aput-object v6, v4, v5

    const/4 v5, 0x3

    new-instance v6, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p2}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 310
    :goto_0
    return v1

    .line 305
    :catch_0
    move-exception v0

    .line 307
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public changepw(Ljava/lang/String;)I
    .locals 8
    .param p1, "passwd"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 439
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 442
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 443
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "password cannot be empty"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 446
    :cond_0
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 453
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "sdcryptfs"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "changepw"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    new-instance v6, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p1}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 457
    :goto_0
    return v1

    .line 454
    :catch_0
    move-exception v0

    .line 455
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public isExistSDEncMetaFile()Z
    .locals 10

    .prologue
    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 461
    iget-object v5, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v6, "android.permission.CRYPT_KEEPER"

    const-string v7, "no permission to access the crypt keeper"

    invoke-virtual {v5, v6, v7}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 465
    const/4 v2, 0x0

    .line 467
    .local v2, "ret":I
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 474
    :try_start_0
    iget-object v5, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v6, "sdcryptfs"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    const-string v9, "check_km_meta"

    aput-object v9, v7, v8

    invoke-virtual {v5, v6, v7}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;

    move-result-object v1

    .line 475
    .local v1, "event":Lcom/android/server/NativeDaemonEvent;
    invoke-virtual {v1}, Lcom/android/server/NativeDaemonEvent;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 479
    .end local v1    # "event":Lcom/android/server/NativeDaemonEvent;
    :goto_0
    if-nez v2, :cond_0

    .line 482
    :goto_1
    return v3

    .line 476
    :catch_0
    move-exception v0

    .line 477
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v2

    goto :goto_0

    .end local v0    # "e":Lcom/android/server/NativeDaemonConnectorException;
    :cond_0
    move v3, v4

    .line 482
    goto :goto_1
.end method

.method public load_or_create_master_key(Ljava/lang/String;I)I
    .locals 9
    .param p1, "passwd"    # Ljava/lang/String;
    .param p2, "createFlag"    # I

    .prologue
    .line 413
    iget-object v3, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v4, "android.permission.CRYPT_KEEPER"

    const-string v5, "no permission to access the crypt keeper"

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 417
    const/4 v2, -0x1

    .line 419
    .local v2, "ret":I
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 420
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "password cannot be empty"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 423
    :cond_0
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 430
    :try_start_0
    iget-object v3, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v4, "sdcryptfs"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    const-string v7, "load_or_create_master_key"

    aput-object v7, v5, v6

    const/4 v6, 0x1

    new-instance v7, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p1}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v7, v5, v6

    const/4 v6, 0x2

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;

    move-result-object v1

    .line 431
    .local v1, "event":Lcom/android/server/NativeDaemonEvent;
    invoke-virtual {v1}, Lcom/android/server/NativeDaemonEvent;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 435
    .end local v1    # "event":Lcom/android/server/NativeDaemonEvent;
    :goto_0
    return v2

    .line 432
    :catch_0
    move-exception v0

    .line 433
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v2

    goto :goto_0
.end method

.method public lockDevice()I
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 388
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 391
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 398
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "sdcryptfs"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "delete_km_meta"

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 404
    :try_start_1
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "sdcryptfs"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "clear_master_key"

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_1
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_1 .. :try_end_1} :catch_1

    .line 409
    :goto_0
    return v1

    .line 399
    :catch_0
    move-exception v0

    .line 400
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0

    .line 405
    .end local v0    # "e":Lcom/android/server/NativeDaemonConnectorException;
    :catch_1
    move-exception v0

    .line 406
    .restart local v0    # "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public onCheckHoldWakeLock(I)Z
    .locals 1
    .param p1, "code"    # I

    .prologue
    .line 89
    const/4 v0, 0x0

    return v0
.end method

.method public onDaemonConnected()V
    .locals 2

    .prologue
    .line 77
    new-instance v0, Lcom/android/server/LGEncryptionService$1;

    const-string v1, "MountService#onDaemonConnected"

    invoke-direct {v0, p0, v1}, Lcom/android/server/LGEncryptionService$1;-><init>(Lcom/android/server/LGEncryptionService;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/android/server/LGEncryptionService$1;->start()V

    .line 83
    return-void
.end method

.method public onEvent(ILjava/lang/String;[Ljava/lang/String;)Z
    .locals 9
    .param p1, "code"    # I
    .param p2, "raw"    # Ljava/lang/String;
    .param p3, "cooked"    # [Ljava/lang/String;

    .prologue
    const/16 v8, 0x28c

    const/16 v7, 0x28b

    const/16 v6, 0x28a

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 123
    sget-boolean v5, Lcom/lge/config/ConfigBuildFlags;->CAPP_SDENCRYPTION_USERKEY:Z

    if-eqz v5, :cond_5

    .line 124
    sget-boolean v5, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    if-eqz v5, :cond_2

    if-eq p1, v6, :cond_0

    if-eq p1, v8, :cond_0

    const/16 v5, 0x28d

    if-eq p1, v5, :cond_0

    const/16 v5, 0x28e

    if-ne p1, v5, :cond_2

    .line 128
    :cond_0
    const-string v5, "LGEncryptionService"

    const-string v6, "No Encryption Popup"

    invoke-static {v5, v6}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 129
    sput-boolean v4, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    .line 177
    :cond_1
    :goto_0
    return v3

    .line 131
    :cond_2
    sget-boolean v5, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    if-eqz v5, :cond_3

    if-ne p1, v7, :cond_3

    .line 132
    sput-boolean v4, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    .line 145
    :cond_3
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v1

    .line 146
    .local v1, "msg":Landroid/os/Message;
    if-ne p1, v6, :cond_4

    .line 147
    const-string v5, "LGEncryptionService"

    const-string v6, "SDCryptNewSDCardInserted"

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 148
    const-string v5, "com.android.settings.EncryptWarningDialogActivity"

    iput-object v5, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 149
    iget-object v5, p0, Lcom/android/server/LGEncryptionService;->WarningDialogHandler:Landroid/os/Handler;

    invoke-virtual {v5, v1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 151
    :cond_4
    if-ne p1, v7, :cond_8

    .line 152
    const-string v5, "LGEncryptionService"

    const-string v6, "SDCryptOtherDeviceEncrypted"

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 153
    const-string v5, "com.android.settings.OtherDeviceDialogActivity"

    iput-object v5, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 154
    iget-object v5, p0, Lcom/android/server/LGEncryptionService;->WarningDialogHandler:Landroid/os/Handler;

    invoke-virtual {v5, v1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    .line 155
    sget-boolean v5, Lcom/lge/config/ConfigBuildFlags;->CAPP_SDENCRYPTION_USERKEY:Z

    if-nez v5, :cond_8

    .line 156
    const-string v5, "mount"

    invoke-static {v5}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    .line 157
    .local v2, "service":Landroid/os/IBinder;
    if-nez v2, :cond_7

    .line 158
    const-string v3, "LGEncryptionService"

    const-string v5, "SDCryptOtherDeviceEnCrypted...service null"

    invoke-static {v3, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v4

    .line 159
    goto :goto_0

    .line 135
    .end local v1    # "msg":Landroid/os/Message;
    .end local v2    # "service":Landroid/os/IBinder;
    :cond_5
    sget-boolean v5, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    if-eqz v5, :cond_3

    if-eq p1, v6, :cond_6

    if-eq p1, v7, :cond_6

    if-eq p1, v8, :cond_6

    const/16 v5, 0x28d

    if-ne p1, v5, :cond_3

    .line 139
    :cond_6
    const-string v5, "LGEncryptionService"

    const-string v6, "No Encryption Popup"

    invoke-static {v5, v6}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 140
    sput-boolean v4, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    goto :goto_0

    .line 161
    .restart local v1    # "msg":Landroid/os/Message;
    .restart local v2    # "service":Landroid/os/IBinder;
    :cond_7
    invoke-static {v2}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;

    move-result-object v5

    iput-object v5, p0, Lcom/android/server/LGEncryptionService;->mountService:Landroid/os/storage/IMountService;

    .line 163
    :try_start_0
    iget-object v5, p0, Lcom/android/server/LGEncryptionService;->mountService:Landroid/os/storage/IMountService;

    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->getExternalSDCardMountPath()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x1

    const/4 v8, 0x0

    invoke-interface {v5, v6, v7, v8}, Landroid/os/storage/IMountService;->unmountVolume(Ljava/lang/String;ZZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 167
    invoke-static {v2}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;

    move-result-object v4

    iput-object v4, p0, Lcom/android/server/LGEncryptionService;->mountService:Landroid/os/storage/IMountService;

    .line 170
    .end local v2    # "service":Landroid/os/IBinder;
    :cond_8
    sget-boolean v4, Lcom/lge/config/ConfigBuildFlags;->CAPP_SDENCRYPTION_USERKEY:Z

    if-eqz v4, :cond_1

    .line 171
    const/16 v4, 0x28e

    if-ne p1, v4, :cond_1

    .line 172
    const-string v4, "LGEncryptionService"

    const-string v5, "SDCryptEncryptedSDCardInserted"

    invoke-static {v4, v5}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    const-string v4, "com.android.settings.EncryptedSDCardDialogActivity"

    iput-object v4, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 174
    iget-object v4, p0, Lcom/android/server/LGEncryptionService;->WarningDialogHandler:Landroid/os/Handler;

    invoke-virtual {v4, v1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto/16 :goto_0

    .line 164
    .restart local v2    # "service":Landroid/os/IBinder;
    :catch_0
    move-exception v0

    .line 165
    .local v0, "e":Landroid/os/RemoteException;
    const-string v3, "LGEncryptionService"

    const-string v5, "Error occured while unmounting external SD card"

    invoke-static {v3, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v4

    .line 166
    goto/16 :goto_0
.end method

.method public quickencryptStorage(Ljava/lang/String;)I
    .locals 8
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 266
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 267
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "password cannot be empty"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 270
    :cond_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 273
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 280
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "cryptfs"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "enableqcrypto"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "inplace"

    aput-object v6, v4, v5

    const/4 v5, 0x2

    new-instance v6, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p1}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 286
    :goto_0
    return v1

    .line 281
    :catch_0
    move-exception v0

    .line 283
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public quickunencryptStorage(Ljava/lang/String;)I
    .locals 8
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 314
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 315
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "password cannot be empty"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 318
    :cond_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 321
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 328
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "cryptfs"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "disableqcrypto"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "inplace"

    aput-object v6, v4, v5

    const/4 v5, 0x2

    new-instance v6, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p1}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 334
    :goto_0
    return v1

    .line 329
    :catch_0
    move-exception v0

    .line 331
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public setNoPopupWhenEncryption(Z)V
    .locals 0
    .param p1, "noPopup"    # Z

    .prologue
    .line 384
    sput-boolean p1, Lcom/android/server/LGEncryptionService;->mNoPopup:Z

    .line 385
    return-void
.end method

.method public unencryptStorage(Ljava/lang/String;)I
    .locals 8
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 242
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 243
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "password cannot be empty"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 246
    :cond_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 249
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 256
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "cryptfs"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "disablecrypto"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "inplace"

    aput-object v6, v4, v5

    const/4 v5, 0x2

    new-instance v6, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p1}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 262
    :goto_0
    return v1

    .line 257
    :catch_0
    move-exception v0

    .line 259
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public unencryptWipeStorage(Ljava/lang/String;)I
    .locals 8
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 338
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 339
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "password cannot be empty"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 342
    :cond_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 345
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 352
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "cryptfs"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "disableqcrypto"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const-string v6, "reset"

    aput-object v6, v4, v5

    const/4 v5, 0x2

    new-instance v6, Lcom/android/server/NativeDaemonConnector$SensitiveArg;

    invoke-direct {p0, p1}, Lcom/android/server/LGEncryptionService;->toHex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/android/server/NativeDaemonConnector$SensitiveArg;-><init>(Ljava/lang/Object;)V

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 358
    :goto_0
    return v1

    .line 353
    :catch_0
    move-exception v0

    .line 355
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method

.method public userSwitchWithUID(I)I
    .locals 7
    .param p1, "uid"    # I

    .prologue
    const/4 v1, 0x0

    .line 362
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.CRYPT_KEEPER"

    const-string v4, "no permission to access the crypt keeper"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 365
    invoke-direct {p0}, Lcom/android/server/LGEncryptionService;->waitForReady()V

    .line 372
    :try_start_0
    iget-object v2, p0, Lcom/android/server/LGEncryptionService;->mConnector:Lcom/android/server/NativeDaemonConnector;

    const-string v3, "sdcryptfs"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "user_switch"

    aput-object v6, v4, v5

    const/4 v5, 0x1

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/android/server/NativeDaemonConnector;->execute(Ljava/lang/String;[Ljava/lang/Object;)Lcom/android/server/NativeDaemonEvent;
    :try_end_0
    .catch Lcom/android/server/NativeDaemonConnectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 377
    :goto_0
    return v1

    .line 373
    :catch_0
    move-exception v0

    .line 374
    .local v0, "e":Lcom/android/server/NativeDaemonConnectorException;
    invoke-virtual {v0}, Lcom/android/server/NativeDaemonConnectorException;->getCode()I

    move-result v1

    goto :goto_0
.end method
