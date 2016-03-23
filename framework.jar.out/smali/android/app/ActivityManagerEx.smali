.class public Landroid/app/ActivityManagerEx;
.super Landroid/app/ActivityManager;
.source "ActivityManagerEx.java"


# static fields
.field public static final REGISTER_ACTIVITY_TRIGGER_TRANSACTION:I = 0xfffffe

.field private static final TAG_EX:Ljava/lang/String; = "ActivityManagerEx"

.field private static localLOGV:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 22
    const/4 v0, 0x0

    sput-boolean v0, Landroid/app/ActivityManagerEx;->localLOGV:Z

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "handler"    # Landroid/os/Handler;

    .prologue
    .line 25
    invoke-direct {p0, p1, p2}, Landroid/app/ActivityManager;-><init>(Landroid/content/Context;Landroid/os/Handler;)V

    .line 26
    return-void
.end method


# virtual methods
.method getRemote()Landroid/os/IBinder;
    .locals 1

    .prologue
    .line 29
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v0

    invoke-interface {v0}, Landroid/app/IActivityManager;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    return-object v0
.end method

.method public registerActivityTrigger(Lcom/lge/frameworks/IActivityTrigger;)V
    .locals 5
    .param p1, "trigger"    # Lcom/lge/frameworks/IActivityTrigger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 34
    sget-boolean v2, Landroid/app/ActivityManagerEx;->localLOGV:Z

    if-eqz v2, :cond_0

    .line 35
    const-string v2, "ActivityManagerEx"

    const-string v3, "In registerActivityTrigger"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 38
    :cond_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 39
    .local v0, "data":Landroid/os/Parcel;
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 42
    .local v1, "reply":Landroid/os/Parcel;
    :try_start_0
    const-string v2, "android.app.IActivityManager"

    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 43
    if-eqz p1, :cond_1

    invoke-interface {p1}, Lcom/lge/frameworks/IActivityTrigger;->asBinder()Landroid/os/IBinder;

    move-result-object v2

    :goto_0
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    .line 44
    invoke-virtual {p0}, Landroid/app/ActivityManagerEx;->getRemote()Landroid/os/IBinder;

    move-result-object v2

    const v3, 0xfffffe

    const/4 v4, 0x0

    invoke-interface {v2, v3, v0, v1, v4}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    .line 45
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 47
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 48
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 50
    return-void

    .line 43
    :cond_1
    const/4 v2, 0x0

    goto :goto_0

    .line 47
    :catchall_0
    move-exception v2

    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 48
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    throw v2
.end method
