.class public Landroid/mtp/LGMtpServer;
.super Ljava/lang/Object;
.source "LGMtpServer.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final TAG:Ljava/lang/String;

.field private mDatabase:Landroid/mtp/LGMtpDatabase;

.field private mNativeContext:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "hook_jni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Landroid/mtp/LGMtpDatabase;Z)V
    .locals 2
    .param p1, "database"    # Landroid/mtp/LGMtpDatabase;
    .param p2, "usePtp"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "LGMtpServer"

    iput-object v0, p0, Landroid/mtp/LGMtpServer;->TAG:Ljava/lang/String;

    const-string v0, "LGMtpServer"

    const-string v1, "LGMtpServer"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, p1, p2}, Landroid/mtp/LGMtpServer;->native_setup(Landroid/mtp/LGMtpDatabase;Z)V

    invoke-virtual {p1, p0}, Landroid/mtp/LGMtpDatabase;->setServer(Landroid/mtp/LGMtpServer;)V

    iput-object p1, p0, Landroid/mtp/LGMtpServer;->mDatabase:Landroid/mtp/LGMtpDatabase;

    return-void
.end method

.method private final native native_add_storage(Landroid/mtp/MtpStorage;)V
.end method

.method private final native native_cleanup()V
.end method

.method private final native native_object_info_changed(I)V
.end method

.method private final native native_remove_storage(I)V
.end method

.method private final native native_run()V
.end method

.method private final native native_send_device_property_changed(I)V
.end method

.method private final native native_send_object_added(I)V
.end method

.method private final native native_send_object_removed(I)V
.end method

.method private final native native_setup(Landroid/mtp/LGMtpDatabase;Z)V
.end method


# virtual methods
.method public addStorage(Landroid/mtp/MtpStorage;)V
    .locals 0
    .param p1, "storage"    # Landroid/mtp/MtpStorage;

    .prologue
    invoke-direct {p0, p1}, Landroid/mtp/LGMtpServer;->native_add_storage(Landroid/mtp/MtpStorage;)V

    return-void
.end method

.method public objectInfoChanged(I)V
    .locals 0
    .param p1, "handle"    # I

    .prologue
    invoke-direct {p0, p1}, Landroid/mtp/LGMtpServer;->native_object_info_changed(I)V

    return-void
.end method

.method public removeStorage(Landroid/mtp/MtpStorage;)V
    .locals 1
    .param p1, "storage"    # Landroid/mtp/MtpStorage;

    .prologue
    invoke-virtual {p1}, Landroid/mtp/MtpStorage;->getStorageId()I

    move-result v0

    invoke-direct {p0, v0}, Landroid/mtp/LGMtpServer;->native_remove_storage(I)V

    return-void
.end method

.method public run()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/mtp/LGMtpServer;->native_run()V

    invoke-direct {p0}, Landroid/mtp/LGMtpServer;->native_cleanup()V

    iget-object v0, p0, Landroid/mtp/LGMtpServer;->mDatabase:Landroid/mtp/LGMtpDatabase;

    invoke-virtual {v0}, Landroid/mtp/LGMtpDatabase;->callFinalize()V

    return-void
.end method

.method public sendDevicePropertyChanged(I)V
    .locals 0
    .param p1, "property"    # I

    .prologue
    invoke-direct {p0, p1}, Landroid/mtp/LGMtpServer;->native_send_device_property_changed(I)V

    return-void
.end method

.method public sendObjectAdded(I)V
    .locals 0
    .param p1, "handle"    # I

    .prologue
    invoke-direct {p0, p1}, Landroid/mtp/LGMtpServer;->native_send_object_added(I)V

    return-void
.end method

.method public sendObjectRemoved(I)V
    .locals 0
    .param p1, "handle"    # I

    .prologue
    invoke-direct {p0, p1}, Landroid/mtp/LGMtpServer;->native_send_object_removed(I)V

    return-void
.end method

.method public start()V
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/Thread;

    const-string v1, "LGMtpServer"

    invoke-direct {v0, p0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .local v0, "thread":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method
