.class Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;
.super Ljava/lang/Object;
.source "FingerprintService.java"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/fingerprint/FingerprintService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TokenWatcher"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/fingerprint/FingerprintService;

.field token:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Landroid/os/IBinder;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/android/server/fingerprint/FingerprintService;Landroid/os/IBinder;)V
    .locals 1
    .param p2, "token"    # Landroid/os/IBinder;

    .prologue
    .line 91
    iput-object p1, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->this$0:Lcom/android/server/fingerprint/FingerprintService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 92
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->token:Ljava/lang/ref/WeakReference;

    .line 93
    return-void
.end method


# virtual methods
.method public binderDied()V
    .locals 2

    .prologue
    .line 97
    iget-object v0, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->this$0:Lcom/android/server/fingerprint/FingerprintService;

    # getter for: Lcom/android/server/fingerprint/FingerprintService;->mClients:Landroid/util/ArrayMap;
    invoke-static {v0}, Lcom/android/server/fingerprint/FingerprintService;->access$000(Lcom/android/server/fingerprint/FingerprintService;)Landroid/util/ArrayMap;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->token:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0, v1}, Landroid/util/ArrayMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 98
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->token:Ljava/lang/ref/WeakReference;

    .line 99
    return-void
.end method

.method protected finalize()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 103
    :try_start_0
    iget-object v0, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->token:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    .line 105
    iget-object v0, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->this$0:Lcom/android/server/fingerprint/FingerprintService;

    # getter for: Lcom/android/server/fingerprint/FingerprintService;->mClients:Landroid/util/ArrayMap;
    invoke-static {v0}, Lcom/android/server/fingerprint/FingerprintService;->access$000(Lcom/android/server/fingerprint/FingerprintService;)Landroid/util/ArrayMap;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->token:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0, v1}, Landroid/util/ArrayMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 108
    :cond_0
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 110
    return-void

    .line 108
    :catchall_0
    move-exception v0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v0
.end method

.method getToken()Landroid/os/IBinder;
    .locals 1

    .prologue
    .line 95
    iget-object v0, p0, Lcom/android/server/fingerprint/FingerprintService$TokenWatcher;->token:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/IBinder;

    return-object v0
.end method