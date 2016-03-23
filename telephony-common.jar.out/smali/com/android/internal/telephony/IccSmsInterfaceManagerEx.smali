.class public Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
.super Lcom/android/internal/telephony/IccSmsInterfaceManager;
.source "IccSmsInterfaceManagerEx.java"


# static fields
.field static final DBG:Z = true

.field private static final EVENT_COPY_SMS_DONE:I = 0xc

.field private static final EVENT_CTA_SECURITY_ALERTS:I = 0x82

.field private static final EVENT_GET_MAX_EF_SMS:I = 0x7d

.field private static final EVENT_GET_SMSCADDRESS:I = 0xb

.field private static final EVENT_UPDATE_SMS_STATUS_READ_DONE:I = 0x7e

.field private static final EVENT_UPDATE_SMS_STATUS_UPDATE_DONE:I = 0x7f

.field static final LOG_TAG:Ljava/lang/String; = "IccSmsInterfaceManagerEx"

.field private static final SMS_FORMAT_CSIM:I = 0x2

.field private static final SMS_FORMAT_USIM:I = 0x1


# instance fields
.field protected mHandlerEx:Landroid/os/Handler;

.field private mIndexOnIcc:I

.field private final mLock_CB:Ljava/lang/Object;

.field private mSCAddr:Ljava/lang/String;

.field private mUiccType:I

.field private recordSize:I


# direct methods
.method protected constructor <init>(Lcom/android/internal/telephony/PhoneBase;)V
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    .line 217
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManager;-><init>(Lcom/android/internal/telephony/PhoneBase;)V

    .line 68
    const/4 v0, -0x1

    iput v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    .line 79
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    .line 86
    new-instance v0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx$1;-><init>(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    .line 218
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    .prologue
    .line 53
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;[BILjava/lang/Boolean;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    .param p1, "x1"    # [B
    .param p2, "x2"    # I
    .param p3, "x3"    # Ljava/lang/Boolean;

    .prologue
    .line 53
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->updateSmsOnSimReadStatusWrite([BILjava/lang/Boolean;)V

    return-void
.end method

.method static synthetic access$202(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;I)I
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    .param p1, "x1"    # I

    .prologue
    .line 53
    iput p1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->recordSize:I

    return p1
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    .prologue
    .line 53
    iget v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    return v0
.end method

.method static synthetic access$302(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;I)I
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    .param p1, "x1"    # I

    .prologue
    .line 53
    iput p1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    return p1
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    .prologue
    .line 53
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$402(Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 53
    iput-object p1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    return-object p1
.end method

.method private getAppLabel()Ljava/lang/CharSequence;
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 939
    iget-object v6, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v6}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    .line 940
    .local v4, "pm":Landroid/content/pm/PackageManager;
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v5

    .line 941
    .local v5, "uid":I
    invoke-virtual {v4, v5}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    move-result-object v3

    .line 944
    .local v3, "packageNames":[Ljava/lang/String;
    if-eqz v3, :cond_0

    array-length v6, v3

    if-lez v6, :cond_0

    .line 946
    const/4 v6, 0x0

    :try_start_0
    aget-object v6, v3, v6

    const/4 v7, 0x0

    invoke-virtual {v4, v6, v7}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 947
    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    invoke-virtual {v0, v4}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 956
    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .local v1, "appLabel":Ljava/lang/CharSequence;
    :goto_0
    return-object v1

    .line 948
    .end local v1    # "appLabel":Ljava/lang/CharSequence;
    :catch_0
    move-exception v2

    .line 949
    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "PackageManager Name Not Found for package "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 950
    aget-object v1, v3, v8

    .line 951
    .restart local v1    # "appLabel":Ljava/lang/CharSequence;
    goto :goto_0

    .line 953
    .end local v1    # "appLabel":Ljava/lang/CharSequence;
    .end local v2    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Uid:"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "appLabel":Ljava/lang/CharSequence;
    goto :goto_0
.end method

.method private updateSmsOnSimReadStatusWrite([BILjava/lang/Boolean;)V
    .locals 6
    .param p1, "data"    # [B
    .param p2, "index"    # I
    .param p3, "read"    # Ljava/lang/Boolean;

    .prologue
    .line 222
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/16 v2, 0x7f

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v5

    .line 223
    .local v5, "response":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getIccFileHandler()Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 225
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 226
    const-string v1, "updateSmsOnSimReadStatusWrite(), Cannot load Sms records. No icc card?"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 233
    :goto_0
    return-void

    .line 230
    :cond_0
    const/4 v2, 0x0

    invoke-virtual {p3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    :goto_1
    int-to-byte v1, v1

    aput-byte v1, p1, v2

    .line 232
    const/16 v1, 0x6f3c

    const/4 v4, 0x0

    move v2, p2

    move-object v3, p1

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/uicc/IccFileHandler;->updateEFLinearFixed(II[BLjava/lang/String;Landroid/os/Message;)V

    goto :goto_0

    .line 230
    :cond_1
    const/4 v1, 0x3

    goto :goto_1
.end method


# virtual methods
.method public copySmsToIccEf(I[B[B)I
    .locals 6
    .param p1, "status"    # I
    .param p2, "pdu"    # [B
    .param p3, "smsc"    # [B

    .prologue
    .line 650
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copySmsToIccEf: status="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ==> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "pdu=("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p2}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), smsm=("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p3}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 653
    const-string v2, "Copying sms to UIcc"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enforceReceiveAndSend(Ljava/lang/String;)V

    .line 655
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 656
    const/4 v2, 0x0

    :try_start_0
    iput-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 657
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/16 v4, 0xc

    invoke-virtual {v2, v4}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 659
    .local v1, "response":Landroid/os/Message;
    const-string v2, "copySmsToIccEf(), IccSmsInterfaceManager --> RIL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 661
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-static {p3}, Lcom/android/internal/telephony/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v4

    invoke-static {p2}, Lcom/android/internal/telephony/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v2, p1, v4, v5, v1}, Lcom/android/internal/telephony/CommandsInterface;->writeSmsToSim(ILjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 665
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 669
    :goto_0
    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 672
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copyMessageToIccEf: mIndexOnIcc="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 674
    iget v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    return v2

    .line 666
    :catch_0
    move-exception v0

    .line 667
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v2, "interrupted while trying to update by index"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 669
    .end local v0    # "e":Ljava/lang/InterruptedException;
    .end local v1    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2
.end method

.method public copySmsToIccEfPrivate(I[B[BI)I
    .locals 6
    .param p1, "status"    # I
    .param p2, "pdu"    # [B
    .param p3, "smsc"    # [B
    .param p4, "sms_format"    # I

    .prologue
    .line 308
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copySmsToIccEfPrivate: status="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ==> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "pdu=("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p2}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), smsc=("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p3}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SMS_format : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 312
    const-string v2, "Copying sms to UIcc"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enforceReceiveAndSend(Ljava/lang/String;)V

    .line 314
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 316
    const/4 v2, 0x0

    :try_start_0
    iput-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 317
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/16 v4, 0xc

    invoke-virtual {v2, v4}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 319
    .local v1, "response":Landroid/os/Message;
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v4, "control_uicc_storage"

    invoke-static {v2, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 320
    const-string v2, "copySmsToIccEfPrivate(), KEY_CONTROL_UICC_STORAGE is Defined"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 321
    const/4 v2, 0x1

    if-ne p4, v2, :cond_1

    .line 322
    const-string v2, "copySmsToIccEfPrivate(), 3GPP SMS format-writeSmsToSim"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 323
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-static {p3}, Lcom/android/internal/telephony/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v4

    invoke-static {p2}, Lcom/android/internal/telephony/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v2, p1, v4, v5, v1}, Lcom/android/internal/telephony/CommandsInterface;->writeSmsToSim(ILjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 332
    :cond_0
    :goto_0
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 336
    :goto_1
    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 337
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copySmsToIccEfPrivate(), mIndexOnIcc = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 338
    iget v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mIndexOnIcc:I

    return v2

    .line 326
    :cond_1
    :try_start_3
    const-string v2, "copySmsToIccEfPrivate(), 3GPP2 SMS format-writeSmsToSim"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 327
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p1, p2, v1}, Lcom/android/internal/telephony/CommandsInterface;->writeSmsToCsim(I[BLandroid/os/Message;)V

    goto :goto_0

    .line 336
    .end local v1    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2

    .line 333
    .restart local v1    # "response":Landroid/os/Message;
    :catch_0
    move-exception v0

    .line 334
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_4
    const-string v2, "interrupted while trying to update by index"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1
.end method

.method public enableAutoDCDisconnect(I)V
    .locals 1
    .param p1, "timeOut"    # I

    .prologue
    .line 866
    const-string v0, "enableAutoDCDisconnect(), start"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    .line 867
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->enableAutoDCDisconnect(I)V

    .line 868
    return-void
.end method

.method public getMaxEfSms()I
    .locals 6

    .prologue
    .line 685
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v4, "android.permission.RECEIVE_SMS"

    const-string v5, "Reading messages from SIM"

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 688
    iget-object v4, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v4

    .line 689
    :try_start_0
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/16 v5, 0x7d

    invoke-virtual {v3, v5}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    .line 690
    .local v2, "response":Landroid/os/Message;
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getIccFileHandler()Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v1

    .line 692
    .local v1, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v1, :cond_0

    .line 693
    const/4 v3, -0x1

    monitor-exit v4

    .line 707
    :goto_0
    return v3

    .line 696
    :cond_0
    const/16 v3, 0x6f3c

    invoke-virtual {v1, v3, v2}, Lcom/android/internal/telephony/uicc/IccFileHandler;->getEFLinearRecordSize(ILandroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 699
    :try_start_1
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 703
    :goto_1
    :try_start_2
    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 705
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getMaxEfSms(), recordSize="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->recordSize:I

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 707
    iget v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->recordSize:I

    goto :goto_0

    .line 700
    :catch_0
    move-exception v0

    .line 701
    .local v0, "e":Ljava/lang/Exception;
    :try_start_3
    const-string v3, "getMaxEfSms(), getRecordsSize, interrupted while trying to load from the SIM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 703
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    .end local v2    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v3
.end method

.method public getSmscenterAddress()Ljava/lang/String;
    .locals 10

    .prologue
    .line 752
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getSmscenterAddress(), mSCAddr = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 755
    const-string v7, "getSmscAddress"

    invoke-virtual {p0, v7}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enforceReceiveAndSend(Ljava/lang/String;)V

    .line 756
    iget-object v8, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v8

    .line 757
    :try_start_0
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/16 v9, 0xb

    invoke-virtual {v7, v9}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    .line 758
    .local v3, "response":Landroid/os/Message;
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v7, v7, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v7, v3}, Lcom/android/internal/telephony/CommandsInterface;->getSmscAddress(Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 760
    :try_start_1
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v7}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 764
    :goto_0
    :try_start_2
    monitor-exit v8
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 765
    const-string v4, ""

    .line 767
    .local v4, "ret":Ljava/lang/String;
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    if-nez v7, :cond_0

    move-object v5, v4

    .line 796
    .end local v4    # "ret":Ljava/lang/String;
    .local v5, "ret":Ljava/lang/String;
    :goto_1
    return-object v5

    .line 761
    .end local v5    # "ret":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 762
    .local v1, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v7, "interrupted while trying to update by index"

    invoke-virtual {p0, v7}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 764
    .end local v1    # "e":Ljava/lang/InterruptedException;
    .end local v3    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v7

    monitor-exit v8
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v7

    .line 771
    .restart local v3    # "response":Landroid/os/Message;
    .restart local v4    # "ret":Ljava/lang/String;
    :cond_0
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    check-cast v7, Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v7}, Lcom/android/internal/telephony/PhoneBaseEx;->getIsQCT()Z

    move-result v7

    if-eqz v7, :cond_3

    .line 774
    :try_start_4
    const-string v6, ""

    .line 776
    .local v6, "temp":Ljava/lang/String;
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    const-string v8, ","

    invoke-virtual {v7, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 777
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    const-string v8, ","

    invoke-virtual {v7, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    aget-object v6, v7, v8

    .line 781
    :goto_2
    const/4 v7, 0x1

    new-array v0, v7, [C

    const/4 v7, 0x0

    const/16 v8, 0x22

    aput-char v8, v0, v7

    .line 782
    .local v0, "char_quote":[C
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v0}, Ljava/lang/String;-><init>([C)V

    .line 784
    .local v2, "quote":Ljava/lang/String;
    invoke-virtual {v6, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 785
    const/4 v7, 0x1

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v8

    add-int/lit8 v8, v8, -0x1

    invoke-virtual {v6, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    :try_end_4
    .catch Ljava/lang/NullPointerException; {:try_start_4 .. :try_end_4} :catch_1

    move-result-object v4

    .line 794
    .end local v0    # "char_quote":[C
    .end local v2    # "quote":Ljava/lang/String;
    .end local v6    # "temp":Ljava/lang/String;
    :cond_1
    :goto_3
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getSmscenterAddress(), SC Address = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    move-object v5, v4

    .line 796
    .end local v4    # "ret":Ljava/lang/String;
    .restart local v5    # "ret":Ljava/lang/String;
    goto :goto_1

    .line 779
    .end local v5    # "ret":Ljava/lang/String;
    .restart local v4    # "ret":Ljava/lang/String;
    .restart local v6    # "temp":Ljava/lang/String;
    :cond_2
    :try_start_5
    iget-object v6, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;
    :try_end_5
    .catch Ljava/lang/NullPointerException; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_2

    .line 787
    .end local v6    # "temp":Ljava/lang/String;
    :catch_1
    move-exception v1

    .line 788
    .local v1, "e":Ljava/lang/NullPointerException;
    invoke-virtual {v1}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_3

    .line 792
    .end local v1    # "e":Ljava/lang/NullPointerException;
    :cond_3
    iget-object v4, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    goto :goto_3
.end method

.method public getUiccType()I
    .locals 1

    .prologue
    .line 854
    iget v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mUiccType:I

    return v0
.end method

.method public insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 4
    .param p1, "destUri"    # Landroid/net/Uri;
    .param p2, "values"    # Landroid/content/ContentValues;

    .prologue
    .line 909
    const/4 v0, 0x0

    .line 910
    .local v0, "insertedUri":Landroid/net/Uri;
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 911
    invoke-static {}, Landroid/os/Binder;->clearCallingIdentity()J

    move-result-wide v2

    .line 913
    .local v2, "token":J
    :try_start_0
    const-string v1, "insertDBForLGMessage()"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    .line 914
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 916
    invoke-static {v2, v3}, Landroid/os/Binder;->restoreCallingIdentity(J)V

    .line 919
    .end local v2    # "token":J
    :cond_0
    return-object v0

    .line 916
    .restart local v2    # "token":J
    :catchall_0
    move-exception v1

    invoke-static {v2, v3}, Landroid/os/Binder;->restoreCallingIdentity(J)V

    throw v1
.end method

.method public isFdnEnabled()Z
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 873
    const/4 v1, 0x0

    .line 875
    .local v1, "uiccCardApp":Lcom/android/internal/telephony/uicc/UiccCardApplication;
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getPhoneType()I

    move-result v2

    if-ne v4, v2, :cond_0

    .line 876
    invoke-static {}, Lcom/android/internal/telephony/uicc/UiccController;->getInstance()Lcom/android/internal/telephony/uicc/UiccController;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v3

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/telephony/uicc/UiccController;->getUiccCardApplication(II)Lcom/android/internal/telephony/uicc/UiccCardApplication;

    move-result-object v1

    .line 881
    :goto_0
    if-eqz v1, :cond_1

    .line 882
    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getIccFdnEnabled()Z

    move-result v0

    .line 883
    .local v0, "fdnValue":Z
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isFdnEnabled(), uiccCardApp.getIccFdnEnabled()="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 887
    .end local v0    # "fdnValue":Z
    :goto_1
    return v0

    .line 878
    :cond_0
    invoke-static {}, Lcom/android/internal/telephony/uicc/UiccController;->getInstance()Lcom/android/internal/telephony/uicc/UiccController;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v3

    const/4 v4, 0x2

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/telephony/uicc/UiccController;->getUiccCardApplication(II)Lcom/android/internal/telephony/uicc/UiccCardApplication;

    move-result-object v1

    goto :goto_0

    .line 886
    :cond_1
    const-string v2, "isFdnEnabled(), uiccCardApp is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 887
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;)V
    .locals 14
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 444
    .local p4, "parts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p5, "sentIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .local p6, "deliveryIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v2, "android.permission.SEND_SMS"

    const-string v3, "Sending SMS message"

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 448
    const/4 v10, 0x0

    .line 450
    .local v10, "i":I
    invoke-interface/range {p4 .. p4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v12

    .local v12, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .line 451
    .local v13, "part":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendMultipartText: destAddr = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p2

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", srAddr = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p3

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", part["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    add-int/lit8 v11, v10, 0x1

    .end local v10    # "i":I
    .local v11, "i":I
    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    move v10, v11

    .line 452
    .end local v11    # "i":I
    .restart local v10    # "i":I
    goto :goto_0

    .line 455
    .end local v13    # "part":Ljava/lang/String;
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mAppOps:Landroid/app/AppOpsManager;

    const/16 v2, 0x14

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v1, v2, v3, p1}, Landroid/app/AppOpsManager;->noteOp(IILjava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_4

    .line 458
    const/4 v1, 0x0

    const-string v2, "cta_security_mo_sms_pop_up"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_3

    .line 459
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v2

    .line 460
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandler:Landroid/os/Handler;

    const/16 v4, 0x82

    invoke-direct {p0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getAppLabel()Ljava/lang/CharSequence;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 462
    const/4 v10, 0x0

    :try_start_1
    invoke-interface/range {p4 .. p4}, Ljava/util/List;->size()I

    move-result v8

    .local v8, "count":I
    :goto_1
    if-ge v10, v8, :cond_2

    .line 463
    if-eqz p5, :cond_1

    invoke-interface/range {p5 .. p5}, Ljava/util/List;->size()I

    move-result v1

    if-le v1, v10, :cond_1

    .line 464
    move-object/from16 v0, p5

    invoke-interface {v0, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/PendingIntent;

    const/16 v3, 0x8

    invoke-virtual {v1, v3}, Landroid/app/PendingIntent;->send(I)V
    :try_end_1
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 462
    :cond_1
    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    .line 467
    .end local v8    # "count":I
    :catch_0
    move-exception v9

    .line 468
    .local v9, "e":Landroid/app/PendingIntent$CanceledException;
    :try_start_2
    const-string v1, "sendEmailoverMultipartText: CanceledException while trying to do China CTA Security level 1 MO SMS Pop up"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 470
    .end local v9    # "e":Landroid/app/PendingIntent$CanceledException;
    :cond_2
    monitor-exit v2

    .line 477
    :cond_3
    :goto_2
    return-void

    .line 470
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    .line 475
    :cond_4
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    move-object/from16 v4, p4

    check-cast v4, Ljava/util/ArrayList;

    move-object/from16 v5, p5

    check-cast v5, Ljava/util/ArrayList;

    move-object/from16 v6, p6

    check-cast v6, Ljava/util/ArrayList;

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object v7, p1

    invoke-virtual/range {v1 .. v7}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;)V

    goto :goto_2
.end method

.method public sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    .locals 8
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "sentIntent"    # Landroid/app/PendingIntent;
    .param p6, "deliveryIntent"    # Landroid/app/PendingIntent;

    .prologue
    .line 346
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v1, "android.permission.SEND_SMS"

    const-string v2, "Sending SMS message"

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 350
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sendEmailoverText: destAddr = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " scAddr = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " text = \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\' sentIntent = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " deliveryIntent = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 352
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mAppOps:Landroid/app/AppOpsManager;

    const/16 v1, 0x14

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v2

    invoke-virtual {v0, v1, v2, p1}, Landroid/app/AppOpsManager;->noteOp(IILjava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_2

    .line 355
    const/4 v0, 0x0

    const-string v1, "cta_security_mo_sms_pop_up"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 356
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v1

    .line 357
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandler:Landroid/os/Handler;

    const/16 v3, 0x82

    invoke-direct {p0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getAppLabel()Ljava/lang/CharSequence;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 360
    if-eqz p5, :cond_0

    .line 361
    const/16 v0, 0x8

    :try_start_1
    invoke-virtual {p5, v0}, Landroid/app/PendingIntent;->send(I)V
    :try_end_1
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 366
    :cond_0
    :goto_0
    :try_start_2
    monitor-exit v1

    .line 372
    :cond_1
    :goto_1
    return-void

    .line 363
    :catch_0
    move-exception v7

    .line 364
    .local v7, "e":Landroid/app/PendingIntent$CanceledException;
    const-string v0, "sendEmailoverText: CanceledException while trying to do China CTA Security level 1 MO SMS Pop up"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    goto :goto_0

    .line 366
    .end local v7    # "e":Landroid/app/PendingIntent$CanceledException;
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 371
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    move-object v1, p2

    move-object v2, p3

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    move-object v6, p1

    invoke-virtual/range {v0 .. v6}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;IIIZ)V
    .locals 18
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p7, "replyAddr"    # Ljava/lang/String;
    .param p8, "confirmRead"    # I
    .param p9, "replyOption"    # I
    .param p10, "protocolId"    # I
    .param p11, "isExpectMore"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            "IIIZ)V"
        }
    .end annotation

    .prologue
    .line 502
    .local p4, "parts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p5, "sentIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .local p6, "deliveryIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v3, "android.permission.SEND_SMS"

    const-string v4, "Sending SMS message"

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 505
    const-string v2, "SMS"

    const/4 v3, 0x2

    invoke-static {v2, v3}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 506
    const/4 v14, 0x0

    .line 507
    .local v14, "i":I
    invoke-interface/range {p4 .. p4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v16

    .local v16, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v17

    check-cast v17, Ljava/lang/String;

    .line 508
    .local v17, "part":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sendMultipartTextLge: destAddr="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", srAddr="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p3

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", part["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    add-int/lit8 v15, v14, 0x1

    .end local v14    # "i":I
    .local v15, "i":I
    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v17

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", isExpectMore="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p11

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    move v14, v15

    .line 510
    .end local v15    # "i":I
    .restart local v14    # "i":I
    goto :goto_0

    .line 512
    .end local v14    # "i":I
    .end local v16    # "i$":Ljava/util/Iterator;
    .end local v17    # "part":Ljava/lang/String;
    :cond_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mAppOps:Landroid/app/AppOpsManager;

    const/16 v3, 0x14

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v4

    move-object/from16 v0, p1

    invoke-virtual {v2, v3, v4, v0}, Landroid/app/AppOpsManager;->noteOp(IILjava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_1

    .line 519
    :goto_1
    return-void

    .line 516
    :cond_1
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->filterDestAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 517
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    move-object/from16 v5, p4

    check-cast v5, Ljava/util/ArrayList;

    move-object/from16 v6, p5

    check-cast v6, Ljava/util/ArrayList;

    move-object/from16 v7, p6

    check-cast v7, Ljava/util/ArrayList;

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    move-object/from16 v8, p1

    move-object/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p9

    move/from16 v12, p10

    move/from16 v13, p11

    invoke-virtual/range {v2 .. v13}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;Ljava/lang/String;IIIZ)V

    goto :goto_1
.end method

.method public sendMultipartTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V
    .locals 12
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p7, "cbAddress"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 420
    .local p4, "parts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p5, "sentIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .local p6, "deliveryIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v2, "android.permission.SEND_SMS"

    const-string v3, "Sending SMS message"

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 423
    const-string v1, "SMS"

    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 424
    const/4 v8, 0x0

    .line 425
    .local v8, "i":I
    invoke-interface/range {p4 .. p4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v10

    .local v10, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .line 426
    .local v11, "part":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendMultipartText: destAddr="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", srAddr="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", part["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    add-int/lit8 v9, v8, 0x1

    .end local v8    # "i":I
    .local v9, "i":I
    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", cbAddress="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p7

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    move v8, v9

    .line 428
    .end local v9    # "i":I
    .restart local v8    # "i":I
    goto :goto_0

    .line 430
    .end local v8    # "i":I
    .end local v10    # "i$":Ljava/util/Iterator;
    .end local v11    # "part":Ljava/lang/String;
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    sput-object p7, Lcom/android/internal/telephony/SMSDispatcherEx;->sCBNumber:Ljava/lang/String;

    .line 431
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mAppOps:Landroid/app/AppOpsManager;

    const/16 v2, 0x14

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v1, v2, v3, p1}, Landroid/app/AppOpsManager;->noteOp(IILjava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_1

    .line 438
    :goto_1
    return-void

    .line 435
    :cond_1
    invoke-virtual {p0, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->filterDestAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 436
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    move-object/from16 v4, p4

    check-cast v4, Ljava/util/ArrayList;

    move-object/from16 v5, p5

    check-cast v5, Ljava/util/ArrayList;

    move-object/from16 v6, p6

    check-cast v6, Ljava/util/ArrayList;

    move-object v2, p2

    move-object v3, p3

    move-object v7, p1

    invoke-virtual/range {v1 .. v7}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;)V

    goto :goto_1
.end method

.method public sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V
    .locals 13
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "sentIntent"    # Landroid/app/PendingIntent;
    .param p6, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p7, "replyAddr"    # Ljava/lang/String;
    .param p8, "confirmRead"    # I
    .param p9, "replyOption"    # I
    .param p10, "protocolId"    # I
    .param p11, "isExpectMore"    # Z

    .prologue
    .line 483
    const-string v1, "sendTextLge(), iccinterface > sendTextLge > dispatcher"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 484
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v2, "android.permission.SEND_SMS"

    const-string v3, "Sending SMS message"

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 487
    const-string v1, "SMS"

    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 488
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendTextLge: destAddr="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " scAddr="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p3

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " text=\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p4

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' sentIntent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p5

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " deliveryIntent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p6

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", isExpectMore="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v0, p11

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 492
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mAppOps:Landroid/app/AppOpsManager;

    const/16 v2, 0x14

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v1, v2, v3, p1}, Landroid/app/AppOpsManager;->noteOp(IILjava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_1

    .line 498
    :goto_0
    return-void

    .line 496
    :cond_1
    invoke-virtual {p0, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->filterDestAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 497
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    move-object v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object v7, p1

    move-object/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    move/from16 v11, p10

    move/from16 v12, p11

    invoke-virtual/range {v1 .. v12}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;Ljava/lang/String;IIIZ)V

    goto :goto_0
.end method

.method public sendTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V
    .locals 13
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "sentIntent"    # Landroid/app/PendingIntent;
    .param p6, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p7, "cbAddress"    # Ljava/lang/String;

    .prologue
    .line 382
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v2, "android.permission.SEND_SMS"

    const-string v3, "Sending SMS message"

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 385
    const-string v1, "SMS"

    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 386
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendTextWithCbAddress: destAddr="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " scAddr="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p3

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " text=\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p4

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' sentIntent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p5

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " deliveryIntent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p6

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " cbAddress="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, p7

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 390
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    sput-object p7, Lcom/android/internal/telephony/SMSDispatcherEx;->sCBNumber:Ljava/lang/String;

    .line 391
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mAppOps:Landroid/app/AppOpsManager;

    const/16 v2, 0x14

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v1, v2, v3, p1}, Landroid/app/AppOpsManager;->noteOp(IILjava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_3

    .line 394
    const/4 v1, 0x0

    const-string v2, "cta_security_mo_sms_pop_up"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_2

    .line 395
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v2

    .line 396
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandler:Landroid/os/Handler;

    const/16 v4, 0x82

    invoke-direct {p0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getAppLabel()Ljava/lang/CharSequence;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 399
    if-eqz p5, :cond_1

    .line 400
    const/16 v1, 0x8

    :try_start_1
    move-object/from16 v0, p5

    invoke-virtual {v0, v1}, Landroid/app/PendingIntent;->send(I)V
    :try_end_1
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 405
    :cond_1
    :goto_0
    :try_start_2
    monitor-exit v2

    .line 412
    :cond_2
    :goto_1
    return-void

    .line 402
    :catch_0
    move-exception v12

    .line 403
    .local v12, "e":Landroid/app/PendingIntent$CanceledException;
    const-string v1, "sendTextWithCbAddress: CanceledException while trying to do China CTA Security level 1 MO SMS Pop up"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    goto :goto_0

    .line 405
    .end local v12    # "e":Landroid/app/PendingIntent$CanceledException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    .line 410
    :cond_3
    invoke-virtual {p0, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->filterDestAddress(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 411
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    const/4 v7, 0x0

    const/4 v9, -0x1

    const/4 v10, 0x0

    const/4 v11, -0x1

    move-object v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object v8, p1

    invoke-virtual/range {v1 .. v11}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/net/Uri;Ljava/lang/String;IZI)V

    goto :goto_1
.end method

.method protected setCdmaBroadcastActivation(Z)Z
    .locals 5
    .param p1, "activate"    # Z

    .prologue
    .line 614
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Calling setCdmaBroadcastActivation("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 616
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v3, "cmas_mlock_cb"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 617
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    monitor-enter v3

    .line 618
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/4 v4, 0x3

    invoke-virtual {v2, v4}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 620
    .local v1, "response":Landroid/os/Message;
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 621
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p1, v1}, Lcom/android/internal/telephony/CommandsInterface;->setCdmaBroadcastActivation(ZLandroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 624
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 628
    :goto_0
    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 633
    .end local v1    # "response":Landroid/os/Message;
    :goto_1
    iget-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    return v2

    .line 625
    .restart local v1    # "response":Landroid/os/Message;
    :catch_0
    move-exception v0

    .line 626
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v2, "interrupted while trying to set cdma broadcast activation"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 628
    .end local v0    # "e":Ljava/lang/InterruptedException;
    .end local v1    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2

    .line 630
    :cond_0
    invoke-super {p0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManager;->setCdmaBroadcastActivation(Z)Z

    goto :goto_1
.end method

.method protected setCdmaBroadcastConfig([Lcom/android/internal/telephony/cdma/CdmaSmsBroadcastConfigInfo;)Z
    .locals 5
    .param p1, "configs"    # [Lcom/android/internal/telephony/cdma/CdmaSmsBroadcastConfigInfo;

    .prologue
    .line 589
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Calling setCdmaBroadcastConfig with "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    array-length v3, p1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " configurations"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 591
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v3, "cmas_mlock_cb"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 592
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    monitor-enter v3

    .line 593
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/4 v4, 0x4

    invoke-virtual {v2, v4}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 595
    .local v1, "response":Landroid/os/Message;
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 596
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p1, v1}, Lcom/android/internal/telephony/CommandsInterface;->setCdmaBroadcastConfig([Lcom/android/internal/telephony/cdma/CdmaSmsBroadcastConfigInfo;Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 599
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 603
    :goto_0
    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 608
    .end local v1    # "response":Landroid/os/Message;
    :goto_1
    iget-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    return v2

    .line 600
    .restart local v1    # "response":Landroid/os/Message;
    :catch_0
    move-exception v0

    .line 601
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v2, "interrupted while trying to set cdma broadcast config"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 603
    .end local v0    # "e":Ljava/lang/InterruptedException;
    .end local v1    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2

    .line 605
    :cond_0
    invoke-super {p0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManager;->setCdmaBroadcastConfig([Lcom/android/internal/telephony/cdma/CdmaSmsBroadcastConfigInfo;)Z

    goto :goto_1
.end method

.method protected setCellBroadcastActivation(Z)Z
    .locals 5
    .param p1, "activate"    # Z

    .prologue
    .line 563
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Calling setCellBroadcastActivation("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x29

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 565
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v3, "cmas_mlock_cb"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 566
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    monitor-enter v3

    .line 567
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/4 v4, 0x3

    invoke-virtual {v2, v4}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 569
    .local v1, "response":Landroid/os/Message;
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 570
    const-string v2, "cbLockCellBroadcastActivation(), IccSmsInterfaceManager --> RIL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 571
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p1, v1}, Lcom/android/internal/telephony/CommandsInterface;->setGsmBroadcastActivation(ZLandroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 574
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 578
    :goto_0
    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 583
    .end local v1    # "response":Landroid/os/Message;
    :goto_1
    iget-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    return v2

    .line 575
    .restart local v1    # "response":Landroid/os/Message;
    :catch_0
    move-exception v0

    .line 576
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v2, "interrupted while trying to set cell broadcast activation"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 578
    .end local v0    # "e":Ljava/lang/InterruptedException;
    .end local v1    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2

    .line 580
    :cond_0
    invoke-super {p0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManager;->setCellBroadcastActivation(Z)Z

    goto :goto_1
.end method

.method protected setCellBroadcastConfig([Lcom/android/internal/telephony/gsm/SmsBroadcastConfigInfo;)Z
    .locals 5
    .param p1, "configs"    # [Lcom/android/internal/telephony/gsm/SmsBroadcastConfigInfo;

    .prologue
    .line 537
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Calling setGsmBroadcastConfig with "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    array-length v3, p1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " configurations"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 539
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mContext:Landroid/content/Context;

    const-string v3, "cmas_mlock_cb"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 540
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    monitor-enter v3

    .line 541
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/4 v4, 0x4

    invoke-virtual {v2, v4}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    .line 543
    .local v1, "response":Landroid/os/Message;
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 544
    const-string v2, "cbLockCellBroadcastConfig(), IccSmsInterfaceManager --> RIL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 545
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p1, v1}, Lcom/android/internal/telephony/CommandsInterface;->setGsmBroadcastConfig([Lcom/android/internal/telephony/gsm/SmsBroadcastConfigInfo;Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 548
    :try_start_1
    iget-object v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock_CB:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 552
    :goto_0
    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 557
    .end local v1    # "response":Landroid/os/Message;
    :goto_1
    iget-boolean v2, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    return v2

    .line 549
    .restart local v1    # "response":Landroid/os/Message;
    :catch_0
    move-exception v0

    .line 550
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v2, "interrupted while trying to set cell broadcast config"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 552
    .end local v0    # "e":Ljava/lang/InterruptedException;
    .end local v1    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v2

    .line 554
    :cond_0
    invoke-super {p0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManager;->setCellBroadcastConfig([Lcom/android/internal/telephony/gsm/SmsBroadcastConfigInfo;)Z

    goto :goto_1
.end method

.method public setMultipartTextValidityPeriod(I)V
    .locals 1
    .param p1, "validityperiod"    # I

    .prologue
    .line 529
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->setMultipartTextValidityPeriod(I)V

    .line 530
    return-void
.end method

.method public setSmsIsRoaming(Z)V
    .locals 1
    .param p1, "isRoaming"    # Z

    .prologue
    .line 900
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->setSmsIsRoaming(Z)V

    .line 901
    return-void
.end method

.method public setSmsPriority(I)V
    .locals 1
    .param p1, "priority"    # I

    .prologue
    .line 860
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->setSmsPriority(I)V

    .line 861
    return-void
.end method

.method public setSmscenterAddress(Ljava/lang/String;)Z
    .locals 12
    .param p1, "smsc"    # Ljava/lang/String;

    .prologue
    const/16 v11, 0x22

    const/4 v10, 0x0

    .line 806
    const-string v0, ""

    .line 808
    .local v0, "RilSmscvalue":Ljava/lang/String;
    iget-object v9, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    check-cast v9, Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v9}, Lcom/android/internal/telephony/PhoneBaseEx;->getIsQCT()Z

    move-result v9

    if-eqz v9, :cond_2

    .line 810
    const/4 v9, 0x1

    new-array v1, v9, [C

    aput-char v11, v1, v10

    .line 811
    .local v1, "char_quote":[C
    new-instance v5, Ljava/lang/String;

    invoke-direct {v5, v1}, Ljava/lang/String;-><init>([C)V

    .line 813
    .local v5, "quote":Ljava/lang/String;
    invoke-virtual {p1, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_1

    .line 814
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v7

    .line 815
    .local v7, "temp":[C
    array-length v4, v7

    .line 816
    .local v4, "length":I
    add-int/lit8 v9, v4, 0x2

    new-array v8, v9, [C

    .line 817
    .local v8, "temp1":[C
    aput-char v11, v8, v10

    .line 818
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_0
    if-gt v3, v4, :cond_0

    .line 819
    add-int/lit8 v9, v3, -0x1

    aget-char v9, v7, v9

    aput-char v9, v8, v3

    .line 820
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "setSmscenterAddress(), temp1[i] = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    aget-char v10, v8, v3

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 821
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "setSmscenterAddress(), temp[i-1] = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    add-int/lit8 v10, v3, -0x1

    aget-char v10, v7, v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 818
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 823
    :cond_0
    add-int/lit8 v9, v4, 0x1

    aput-char v11, v8, v9

    .line 824
    invoke-static {v8}, Ljava/lang/String;->copyValueOf([C)Ljava/lang/String;

    move-result-object v0

    .line 830
    .end local v1    # "char_quote":[C
    .end local v3    # "i":I
    .end local v4    # "length":I
    .end local v5    # "quote":Ljava/lang/String;
    .end local v7    # "temp":[C
    .end local v8    # "temp1":[C
    :cond_1
    :goto_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "setSmscenterAddress(), RilSmscvalue = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 832
    const-string v9, "setSmscenterAddress"

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enforceReceiveAndSend(Ljava/lang/String;)V

    .line 833
    iget-object v10, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v10

    .line 834
    const/4 v9, 0x0

    :try_start_0
    iput-boolean v9, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 835
    invoke-virtual {p0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->obtainMessageEventUpdateDone()Landroid/os/Message;

    move-result-object v6

    .line 836
    .local v6, "response":Landroid/os/Message;
    iget-object v9, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v9, v9, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v9, v0, v6}, Lcom/android/internal/telephony/CommandsInterface;->setSmscAddress(Ljava/lang/String;Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 838
    :try_start_1
    iget-object v9, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v9}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 842
    :goto_2
    :try_start_2
    monitor-exit v10
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 843
    iput-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSCAddr:Ljava/lang/String;

    .line 844
    iget-boolean v9, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    return v9

    .line 828
    .end local v6    # "response":Landroid/os/Message;
    :cond_2
    move-object v0, p1

    goto :goto_1

    .line 839
    .restart local v6    # "response":Landroid/os/Message;
    :catch_0
    move-exception v2

    .line 840
    .local v2, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v9, "interrupted while trying to update SCAddress"

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    goto :goto_2

    .line 842
    .end local v2    # "e":Ljava/lang/InterruptedException;
    .end local v6    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v9

    monitor-exit v10
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v9
.end method

.method public setUiccType(I)V
    .locals 0
    .param p1, "uiccType"    # I

    .prologue
    .line 850
    iput p1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mUiccType:I

    .line 851
    return-void
.end method

.method public smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z
    .locals 2
    .param p1, "isOnOff"    # Ljava/lang/String;

    .prologue
    .line 926
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[IccSmsInterfaceManagerEx] smsReceptionBlockingforNIAPPolicy(), isOnOff = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 927
    const-string v0, "1"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "0"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 928
    :cond_0
    const-string v0, "persist.radio.receivingblocking"

    invoke-static {v0, p1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 929
    iget-object v0, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mDispatcher:Lcom/android/internal/telephony/SMSDispatcherEx;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)V

    .line 930
    const/4 v0, 0x1

    .line 933
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public updateMessageOnIccEfMultiMode(II[BI)Z
    .locals 8
    .param p1, "index"    # I
    .param p2, "status"    # I
    .param p3, "pdu"    # [B
    .param p4, "smsformat"    # I

    .prologue
    .line 251
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "updateMessageOnIccEfMultiMode: index="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " status="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ==> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p3}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "smsformat = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V

    .line 255
    const-string v1, "Updating message on UIcc"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enforceReceiveAndSend(Ljava/lang/String;)V

    .line 256
    iget-object v7, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v7

    .line 257
    const/4 v1, 0x0

    :try_start_0
    iput-boolean v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 258
    invoke-virtual {p0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->obtainMessageEventUpdateDone()Landroid/os/Message;

    move-result-object v5

    .line 260
    .local v5, "response":Landroid/os/Message;
    if-nez p2, :cond_2

    .line 265
    const/4 v1, 0x2

    if-ne p4, v1, :cond_0

    .line 266
    const-string v1, "updateMessageOnIccEfMultiMode(), SMS_FORMAT_CSIM -> deleteSmsOnRuim()"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 267
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v1, v1, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p1, v5}, Lcom/android/internal/telephony/CommandsInterface;->deleteSmsOnRuim(ILandroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 287
    :goto_0
    :try_start_1
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 291
    :goto_1
    :try_start_2
    monitor-exit v7
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 292
    iget-boolean v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    :goto_2
    return v1

    .line 268
    :cond_0
    const/4 v1, 0x1

    if-ne p4, v1, :cond_1

    .line 269
    :try_start_3
    const-string v1, "updateMessageOnIccEfMultiMode(), SMS_FORMAT_USIM -> deleteSmsOnSim()"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 270
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v1, v1, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p1, v5}, Lcom/android/internal/telephony/CommandsInterface;->deleteSmsOnSim(ILandroid/os/Message;)V

    goto :goto_0

    .line 291
    .end local v5    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v1

    monitor-exit v7
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v1

    .line 272
    .restart local v5    # "response":Landroid/os/Message;
    :cond_1
    :try_start_4
    const-string v1, "updateMessageOnIccEfMultiMode(), SMS_FORMAT_NONE -> nothing"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 276
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getIccFileHandler()Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 277
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_3

    .line 278
    invoke-virtual {v5}, Landroid/os/Message;->recycle()V

    .line 279
    iget-boolean v1, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    monitor-exit v7

    goto :goto_2

    .line 281
    :cond_3
    invoke-virtual {p0, p2, p3}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->makeSmsRecordData(I[B)[B

    move-result-object v3

    .line 282
    .local v3, "record":[B
    const/16 v1, 0x6f3c

    const/4 v4, 0x0

    move v2, p1

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/uicc/IccFileHandler;->updateEFLinearFixed(II[BLjava/lang/String;Landroid/os/Message;)V

    goto :goto_0

    .line 288
    .end local v0    # "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    .end local v3    # "record":[B
    :catch_0
    move-exception v6

    .line 289
    .local v6, "e":Ljava/lang/InterruptedException;
    const-string v1, "interrupted while trying to update by index"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->log(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1
.end method

.method public updateSmsOnSimReadStatus(IZ)Z
    .locals 8
    .param p1, "index"    # I
    .param p2, "read"    # Z

    .prologue
    .line 720
    const-string v3, "Updating status of a SMS on SIM"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enforceReceiveAndSend(Ljava/lang/String;)V

    .line 721
    iget-object v4, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    monitor-enter v4

    .line 722
    const/4 v3, 0x0

    :try_start_0
    iput-boolean v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    .line 723
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mHandlerEx:Landroid/os/Handler;

    const/16 v5, 0x7e

    const/4 v6, 0x0

    new-instance v7, Ljava/lang/Boolean;

    invoke-direct {v7, p2}, Ljava/lang/Boolean;-><init>(Z)V

    invoke-virtual {v3, v5, p1, v6, v7}, Landroid/os/Handler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    .line 724
    .local v2, "response":Landroid/os/Message;
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getIccFileHandler()Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v1

    .line 726
    .local v1, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v1, :cond_0

    .line 727
    const-string v3, "updateSmsOnSimReadStatus(), Cannot load Sms records. No icc card?"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 728
    iget-boolean v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    monitor-exit v4

    .line 740
    :goto_0
    return v3

    .line 731
    :cond_0
    const/16 v3, 0x6f3c

    invoke-virtual {v1, v3, p1, v2}, Lcom/android/internal/telephony/uicc/IccFileHandler;->loadEFLinearFixed(IILandroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 734
    :try_start_1
    iget-object v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mLock:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 738
    :goto_1
    :try_start_2
    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 740
    iget-boolean v3, p0, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->mSuccess:Z

    goto :goto_0

    .line 735
    :catch_0
    move-exception v0

    .line 736
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v3, "updateSmsOnSimReadStatus(), interrupted while trying to update read status of sms on sim"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 738
    .end local v0    # "e":Ljava/lang/InterruptedException;
    .end local v1    # "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    .end local v2    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v3
.end method
