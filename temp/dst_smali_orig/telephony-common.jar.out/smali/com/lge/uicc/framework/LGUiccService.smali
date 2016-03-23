.class public Lcom/lge/uicc/framework/LGUiccService;
.super Lcom/lge/uicc/ILGUiccService$Stub;
.source "LGUiccService.java"


# static fields
.field private static mLooper:Landroid/os/Looper;

.field private static mUiccService:Lcom/lge/uicc/framework/LGUiccService;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/uicc/ILGUiccService$Stub;-><init>()V

    return-void
.end method

.method private checkMainThreadCalling()Z
    .locals 2

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/LGUiccService;->mLooper:Landroid/os/Looper;

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private dumpIccFileIO(Ljava/lang/String;Landroid/os/Bundle;Ljava/io/PrintWriter;)V
    .locals 5
    .param p1, "command"    # Ljava/lang/String;
    .param p2, "in"    # Landroid/os/Bundle;
    .param p3, "pw"    # Ljava/io/PrintWriter;

    .prologue
    const/4 v0, 0x0

    .local v0, "processed":Z
    new-instance v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;

    invoke-direct {v1, p0}, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;-><init>(Lcom/lge/uicc/framework/LGUiccService;)V

    .local v1, "reply":Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;
    :try_start_0
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    const-string v2, "read"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-static {p2, v1}, Lcom/lge/uicc/framework/IccFileIO;->read(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z

    move-result v0

    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    iget-boolean v2, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->notified:Z

    if-nez v2, :cond_1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V

    :cond_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_1
    iget-object v2, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    if-nez v2, :cond_5

    const-string v2, "Fail."

    invoke-virtual {p3, v2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    :cond_2
    :goto_2
    return-void

    :cond_3
    :try_start_2
    const-string v2, "update"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-static {p2, v1}, Lcom/lge/uicc/framework/IccFileIO;->update(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z

    move-result v0

    goto :goto_0

    :cond_4
    const-string v2, "envelope"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {p2, v1}, Lcom/lge/uicc/framework/IccFileIO;->envelope(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z

    move-result v0

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v2
    :try_end_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_0

    :catch_0
    move-exception v2

    goto :goto_1

    :cond_5
    iget-object v2, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v3, "byte[].result"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "byte[]: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v4, "byte[].result"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getByteArray(Ljava/lang/String;)[B

    move-result-object v3

    invoke-static {v3}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p3, v2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    :cond_6
    iget-object v2, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v3, "String.result"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "String: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v4, "String.result"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p3, v2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    :cond_7
    iget-object v2, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v3, "String[].result"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "String[]: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v4, "String[].result"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getStringArray(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p3, v2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    :cond_8
    iget-object v2, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v3, "boolean.result"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "boolean: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v1, Lcom/lge/uicc/framework/LGUiccService$1SyncCallback;->out:Landroid/os/Bundle;

    const-string v4, "boolean.result"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p3, v2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    goto/16 :goto_2
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LGUiccService] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LGUiccService] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method public static setupService(Landroid/content/Context;[Lcom/android/internal/telephony/RIL;)V
    .locals 2
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "cis"    # [Lcom/android/internal/telephony/RIL;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "setupService "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUiccService;->logd(Ljava/lang/String;)V

    array-length v0, p1

    invoke-static {p0, v0}, Lcom/lge/uicc/framework/LGUICC;->setup(Landroid/content/Context;I)V

    invoke-static {p0, p1}, Lcom/lge/uicc/framework/IccTools;->setup(Landroid/content/Context;[Lcom/android/internal/telephony/RIL;)V

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    sput-object v0, Lcom/lge/uicc/framework/LGUiccService;->mLooper:Landroid/os/Looper;

    sget-object v0, Lcom/lge/uicc/framework/LGUiccService;->mLooper:Landroid/os/Looper;

    invoke-static {v0}, Lcom/lge/uicc/framework/AsyncResultFetcher;->setup(Landroid/os/Looper;)V

    invoke-static {}, Lcom/lge/uicc/framework/SimPhonebookService;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/GenericIO;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccFileIO;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/RilHook;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccStateHandler;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccSwapDialog;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccidHandler;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccHandlerCommon;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/LGSubscriptionHelper;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->isMultiSimEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Lcom/lge/uicc/framework/IccRefreshHandler;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/ImsiHandler;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IsimRecordLoader;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccHandlerLGU;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccHandlerVZW;->setup()V

    invoke-static {}, Lcom/lge/uicc/framework/IccHandlerATT;->setup()V

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/LGUiccService;->mUiccService:Lcom/lge/uicc/framework/LGUiccService;

    if-nez v0, :cond_1

    new-instance v0, Lcom/lge/uicc/framework/LGUiccService;

    invoke-direct {v0}, Lcom/lge/uicc/framework/LGUiccService;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/LGUiccService;->mUiccService:Lcom/lge/uicc/framework/LGUiccService;

    :cond_1
    const-string v0, "lguicc"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    if-nez v0, :cond_2

    const-string v0, "lguicc"

    sget-object v1, Lcom/lge/uicc/framework/LGUiccService;->mUiccService:Lcom/lge/uicc/framework/LGUiccService;

    invoke-static {v0, v1}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    :cond_2
    return-void
.end method


# virtual methods
.method public dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
    .locals 10
    .param p1, "fd"    # Ljava/io/FileDescriptor;
    .param p2, "pw"    # Ljava/io/PrintWriter;
    .param p3, "args"    # [Ljava/lang/String;

    .prologue
    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getContext()Landroid/content/Context;

    move-result-object v0

    .local v0, "c":Landroid/content/Context;
    if-eqz v0, :cond_0

    const-string v8, "android.permission.DUMP"

    invoke-virtual {v0, v8}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v8

    if-eqz v8, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v8, "ro.build.type"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "user"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    const-string v8, "#lguicc_dump"

    invoke-static {v8}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "yes"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    :cond_2
    const/4 v1, 0x1

    .local v1, "can_dump":Z
    :goto_1
    array-length v8, p3

    if-lez v8, :cond_11

    const/4 v8, 0x0

    aget-object v2, p3, v8

    .local v2, "cmd":Ljava/lang/String;
    array-length v8, p3

    const/4 v9, 0x1

    if-le v8, v9, :cond_4

    const/4 v8, 0x1

    aget-object v4, p3, v8

    .local v4, "p1":Ljava/lang/String;
    :goto_2
    array-length v8, p3

    const/4 v9, 0x2

    if-le v8, v9, :cond_5

    const/4 v8, 0x2

    aget-object v5, p3, v8

    .local v5, "p2":Ljava/lang/String;
    :goto_3
    array-length v8, p3

    const/4 v9, 0x3

    if-le v8, v9, :cond_6

    const/4 v8, 0x3

    aget-object v6, p3, v8

    .local v6, "p3":Ljava/lang/String;
    :goto_4
    const-string v8, "all"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_7

    if-eqz v1, :cond_7

    invoke-static {p1, p2, p3}, Lcom/lge/uicc/framework/LGUICC;->dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V

    goto :goto_0

    .end local v1    # "can_dump":Z
    .end local v2    # "cmd":Ljava/lang/String;
    .end local v4    # "p1":Ljava/lang/String;
    .end local v5    # "p2":Ljava/lang/String;
    .end local v6    # "p3":Ljava/lang/String;
    :cond_3
    const/4 v1, 0x0

    goto :goto_1

    .restart local v1    # "can_dump":Z
    .restart local v2    # "cmd":Ljava/lang/String;
    :cond_4
    const-string v4, ""

    goto :goto_2

    .restart local v4    # "p1":Ljava/lang/String;
    :cond_5
    const-string v5, ""

    goto :goto_3

    .restart local v5    # "p2":Ljava/lang/String;
    :cond_6
    const-string v6, ""

    goto :goto_4

    .restart local v6    # "p3":Ljava/lang/String;
    :cond_7
    const-string v8, "setconf"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_9

    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_8

    const/4 v7, -0x1

    .local v7, "slot":I
    :goto_5
    invoke-static {v4, v7, v5}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]: ["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-static {v4, v7}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v7    # "slot":I
    :cond_8
    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    goto :goto_5

    :cond_9
    const-string v8, "setpref"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_a

    invoke-static {v4, v5}, Lcom/lge/uicc/framework/LGUICC;->setPreference(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "{"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "}: {"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUICC;->getPreference(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "}"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_a
    const-string v8, "read"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_c

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    .local v3, "in":Landroid/os/Bundle;
    const-string v9, "int.slot"

    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_b

    const/4 v8, 0x0

    :goto_6
    invoke-virtual {v3, v9, v8}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "int.efid"

    invoke-static {v4}, Lcom/lge/uicc/EfUtils;->hexStringToInt(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {v3, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "read"

    invoke-direct {p0, v8, v3, p2}, Lcom/lge/uicc/framework/LGUiccService;->dumpIccFileIO(Ljava/lang/String;Landroid/os/Bundle;Ljava/io/PrintWriter;)V

    goto/16 :goto_0

    :cond_b
    invoke-static {v5}, Lcom/lge/uicc/EfUtils;->hexStringToInt(Ljava/lang/String;)I

    move-result v8

    goto :goto_6

    .end local v3    # "in":Landroid/os/Bundle;
    :cond_c
    const-string v8, "update"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_e

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    .restart local v3    # "in":Landroid/os/Bundle;
    const-string v9, "int.slot"

    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_d

    const/4 v8, 0x0

    :goto_7
    invoke-virtual {v3, v9, v8}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "int.efid"

    invoke-static {v4}, Lcom/lge/uicc/EfUtils;->hexStringToInt(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {v3, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "byte[].data"

    invoke-static {v5}, Lcom/lge/uicc/EfUtils;->hexStringToBytes(Ljava/lang/String;)[B

    move-result-object v9

    invoke-virtual {v3, v8, v9}, Landroid/os/Bundle;->putByteArray(Ljava/lang/String;[B)V

    const-string v8, "update"

    invoke-direct {p0, v8, v3, p2}, Lcom/lge/uicc/framework/LGUiccService;->dumpIccFileIO(Ljava/lang/String;Landroid/os/Bundle;Ljava/io/PrintWriter;)V

    goto/16 :goto_0

    :cond_d
    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v8

    goto :goto_7

    .end local v3    # "in":Landroid/os/Bundle;
    :cond_e
    const-string v8, "update2"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_10

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    .restart local v3    # "in":Landroid/os/Bundle;
    const-string v9, "int.slot"

    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_f

    const/4 v8, 0x0

    :goto_8
    invoke-virtual {v3, v9, v8}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "int.efid"

    invoke-static {v4}, Lcom/lge/uicc/EfUtils;->hexStringToInt(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {v3, v8, v9}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v8, "String.data"

    invoke-virtual {v3, v8, v5}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v8, "update"

    invoke-direct {p0, v8, v3, p2}, Lcom/lge/uicc/framework/LGUiccService;->dumpIccFileIO(Ljava/lang/String;Landroid/os/Bundle;Ljava/io/PrintWriter;)V

    goto/16 :goto_0

    :cond_f
    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v8

    goto :goto_8

    .end local v3    # "in":Landroid/os/Bundle;
    :cond_10
    const-string v8, "envelope"

    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_0

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    .restart local v3    # "in":Landroid/os/Bundle;
    const-string v8, "String.envName"

    invoke-virtual {v3, v8, v4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v8, "String.data"

    invoke-virtual {v3, v8, v5}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v8, "envelope"

    invoke-direct {p0, v8, v3, p2}, Lcom/lge/uicc/framework/LGUiccService;->dumpIccFileIO(Ljava/lang/String;Landroid/os/Bundle;Ljava/io/PrintWriter;)V

    goto/16 :goto_0

    .end local v2    # "cmd":Ljava/lang/String;
    .end local v3    # "in":Landroid/os/Bundle;
    .end local v4    # "p1":Ljava/lang/String;
    .end local v5    # "p2":Ljava/lang/String;
    .end local v6    # "p3":Ljava/lang/String;
    :cond_11
    if-eqz v1, :cond_0

    invoke-static {p1, p2, p3}, Lcom/lge/uicc/framework/LGUICC;->dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method public genericIO(Ljava/lang/String;[B)[B
    .locals 3
    .param p1, "command"    # Ljava/lang/String;
    .param p2, "in"    # [B

    .prologue
    const/4 v0, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    const/16 v2, 0x7d0

    if-ne v1, v2, :cond_0

    :goto_0
    return-object v0

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "genericIO: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUiccService;->logd(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/uicc/framework/LGUiccService;->checkMainThreadCalling()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "reject service call that can cause a deadlock."

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    const/16 v1, 0xa

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUICC;->traceStack(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/GenericIO;->exchange(Ljava/lang/String;[B)[B

    move-result-object v0

    goto :goto_0
.end method

.method public getProperty(Ljava/lang/String;I)Ljava/lang/String;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "subid"    # I

    .prologue
    const/4 v0, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    const/16 v2, 0x7d0

    if-ne v1, v2, :cond_1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "pref."

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v0, "pref."

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->getPreference(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    invoke-static {p1, p2, v0}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public iccFileIO(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V
    .locals 6
    .param p1, "in"    # Landroid/os/Bundle;
    .param p2, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v4

    const/16 v5, 0x7d0

    if-ne v4, v5, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v4, "command"

    invoke-virtual {p1, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "command":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "processed":Z
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "iccFileIO: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUiccService;->logd(Ljava/lang/String;)V

    const/4 v3, 0x0

    .local v3, "reject":Z
    const-string v4, "sync"

    const/4 v5, 0x0

    invoke-virtual {p1, v4, v5}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v4, "read"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "update"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    :cond_2
    invoke-direct {p0}, Lcom/lge/uicc/framework/LGUiccService;->checkMainThreadCalling()Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v4, "reject service call that can cause a deadlock."

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    const/16 v4, 0xa

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUICC;->traceStack(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    const/4 v3, 0x1

    :cond_3
    if-nez v3, :cond_4

    const-string v4, "read"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccFileIO;->read(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z

    move-result v1

    :cond_4
    :goto_1
    if-nez v1, :cond_0

    if-eqz p2, :cond_0

    :try_start_0
    const-string v4, "iccFileIO: send empty result"

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    const/4 v4, 0x0

    invoke-interface {p2, v4}, Landroid/os/IRemoteCallback;->sendResult(Landroid/os/Bundle;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    .local v2, "re":Landroid/os/RemoteException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "iccFileIO: fail to reply: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    goto :goto_0

    .end local v2    # "re":Landroid/os/RemoteException;
    :cond_5
    const-string v4, "update"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccFileIO;->update(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z

    move-result v1

    goto :goto_1

    :cond_6
    const-string v4, "envelope"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccFileIO;->envelope(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z

    move-result v1

    goto :goto_1
.end method

.method public setProperty(Ljava/lang/String;ILjava/lang/String;)Z
    .locals 8
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "subid"    # I
    .param p3, "val"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v6

    const/16 v7, 0x7d0

    if-ne v6, v7, :cond_0

    const/4 v6, 0x0

    :goto_0
    return v6

    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_2

    :cond_1
    const/4 v6, 0x0

    goto :goto_0

    :cond_2
    const-string v6, "pref."

    invoke-virtual {p1, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    const-string v6, "pref."

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {p1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    const/16 v6, 0x9

    new-array v5, v6, [Ljava/lang/String;

    const/4 v6, 0x0

    const-string v7, "usim_perso_control_key"

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-string v7, "usim_perso_locked"

    aput-object v7, v5, v6

    const/4 v6, 0x2

    const-string v7, "usim_perso_imsi"

    aput-object v7, v5, v6

    const/4 v6, 0x3

    const-string v7, "skt_ota_usim_download"

    aput-object v7, v5, v6

    const/4 v6, 0x4

    const-string v7, "enable_menu_without_usim"

    aput-object v7, v5, v6

    const/4 v6, 0x5

    const-string v7, "sim_err_popup_msg"

    aput-object v7, v5, v6

    const/4 v6, 0x6

    const-string v7, "ota_usim_running"

    aput-object v7, v5, v6

    const/4 v6, 0x7

    const-string v7, "stk_install_intent"

    aput-object v7, v5, v6

    const/16 v6, 0x8

    const-string v7, "test"

    aput-object v7, v5, v6

    .local v5, "pref_allowed":[Ljava/lang/String;
    move-object v0, v5

    .local v0, "arr$":[Ljava/lang/String;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v4, :cond_4

    aget-object v3, v0, v2

    .local v3, "k":Ljava/lang/String;
    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-static {p1, p3}, Lcom/lge/uicc/framework/LGUICC;->setPreference(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v6, 0x1

    goto :goto_0

    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .end local v3    # "k":Ljava/lang/String;
    :cond_4
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "setProperty: not allowed: pref."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    const/4 v6, 0x0

    goto :goto_0

    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v4    # "len$":I
    .end local v5    # "pref_allowed":[Ljava/lang/String;
    :cond_5
    const/4 v6, 0x5

    new-array v1, v6, [Ljava/lang/String;

    const/4 v6, 0x0

    const-string v7, "simpin_secure"

    aput-object v7, v1, v6

    const/4 v6, 0x1

    const-string v7, "ota_csim_refresh_status"

    aput-object v7, v1, v6

    const/4 v6, 0x2

    const-string v7, "show_sim_pin_view"

    aput-object v7, v1, v6

    const/4 v6, 0x3

    const-string v7, "keyguard_simpin_skip"

    aput-object v7, v1, v6

    const/4 v6, 0x4

    const-string v7, "test"

    aput-object v7, v1, v6

    .local v1, "conf_allowed":[Ljava/lang/String;
    move-object v0, v1

    .restart local v0    # "arr$":[Ljava/lang/String;
    array-length v4, v0

    .restart local v4    # "len$":I
    const/4 v2, 0x0

    .restart local v2    # "i$":I
    :goto_2
    if-ge v2, v4, :cond_7

    aget-object v3, v0, v2

    .restart local v3    # "k":Ljava/lang/String;
    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-static {p1, p2, p3}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    const/4 v6, 0x1

    goto/16 :goto_0

    :cond_6
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .end local v3    # "k":Ljava/lang/String;
    :cond_7
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "setProperty: not allowed: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/lge/uicc/framework/LGUiccService;->loge(Ljava/lang/String;)V

    const/4 v6, 0x0

    goto/16 :goto_0
.end method
