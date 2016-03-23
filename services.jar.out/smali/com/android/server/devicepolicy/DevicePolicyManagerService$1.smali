.class Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;
.super Landroid/content/BroadcastReceiver;
.source "DevicePolicyManagerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/devicepolicy/DevicePolicyManagerService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;


# direct methods
.method constructor <init>(Lcom/android/server/devicepolicy/DevicePolicyManagerService;)V
    .locals 0

    .prologue
    .line 297
    iput-object p1, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v8, 0x1

    .line 300
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 301
    .local v0, "action":Ljava/lang/String;
    const-string v5, "android.intent.extra.user_handle"

    invoke-virtual {p0}, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->getSendingUserId()I

    move-result v6

    invoke-virtual {p2, v5, v6}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v4

    .line 303
    .local v4, "userHandle":I
    const-string v5, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    const-string v5, "com.android.server.ACTION_EXPIRED_PASSWORD_NOTIFICATION"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 307
    :cond_0
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    iget-object v5, v5, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->mHandler:Landroid/os/Handler;

    new-instance v6, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1$1;

    invoke-direct {v6, p0, v4}, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1$1;-><init>(Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;I)V

    invoke-virtual {v5, v6}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 313
    :cond_1
    const-string v5, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    const-string v5, "android.security.STORAGE_CHANGED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 315
    :cond_2
    new-instance v5, Lcom/android/server/devicepolicy/DevicePolicyManagerService$MonitoringCertNotificationTask;

    iget-object v6, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    const/4 v7, 0x0

    invoke-direct {v5, v6, v7}, Lcom/android/server/devicepolicy/DevicePolicyManagerService$MonitoringCertNotificationTask;-><init>(Lcom/android/server/devicepolicy/DevicePolicyManagerService;Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;)V

    new-array v6, v8, [Landroid/content/Intent;

    const/4 v7, 0x0

    aput-object p2, v6, v7

    invoke-virtual {v5, v6}, Lcom/android/server/devicepolicy/DevicePolicyManagerService$MonitoringCertNotificationTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 317
    :cond_3
    const-string v5, "android.intent.action.USER_REMOVED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 318
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    invoke-virtual {v5, v4}, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->removeUserData(I)V

    .line 335
    :cond_4
    :goto_0
    const-string v5, "ro.build.target_operator"

    const-string v6, "OPEN"

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "SPR"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 336
    new-instance v2, Landroid/content/ComponentName;

    const-string v5, "com.sprint.extension"

    const-string v6, "com.sprint.extension.admin.SprintExtensionDeviceAdminReceiver"

    invoke-direct {v2, v5, v6}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 339
    .local v2, "admin":Landroid/content/ComponentName;
    :try_start_0
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    invoke-virtual {v5, v2, v4}, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->findAdmin(Landroid/content/ComponentName;I)Landroid/app/admin/DeviceAdminInfo;

    move-result-object v5

    if-nez v5, :cond_9

    .line 340
    const-string v5, "DevicePolicyManagerService"

    const-string v6, "There is no Sprint Extension DeviceAdmin"

    invoke-static {v5, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 353
    .end local v2    # "admin":Landroid/content/ComponentName;
    :cond_5
    :goto_1
    return-void

    .line 319
    :cond_6
    const-string v5, "android.intent.action.USER_STARTED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    const-string v5, "android.intent.action.PACKAGE_CHANGED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    const-string v5, "android.intent.action.PACKAGE_REMOVED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    const-string v5, "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 324
    :cond_7
    const-string v5, "android.intent.action.USER_STARTED"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_8

    .line 326
    iget-object v6, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    monitor-enter v6

    .line 327
    :try_start_1
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    iget-object v5, v5, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->mUserData:Landroid/util/SparseArray;

    invoke-virtual {v5, v4}, Landroid/util/SparseArray;->remove(I)V

    .line 328
    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 331
    :cond_8
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    # invokes: Lcom/android/server/devicepolicy/DevicePolicyManagerService;->handlePackagesChanged(I)V
    invoke-static {v5, v4}, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->access$200(Lcom/android/server/devicepolicy/DevicePolicyManagerService;I)V

    goto :goto_0

    .line 328
    :catchall_0
    move-exception v5

    :try_start_2
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v5

    .line 343
    .restart local v2    # "admin":Landroid/content/ComponentName;
    :catch_0
    move-exception v3

    .line 344
    .local v3, "e":Ljava/lang/Exception;
    const-string v5, "DevicePolicyManagerService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "There is some error to get Sprint Extension DeviceAdmin"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 348
    .end local v3    # "e":Ljava/lang/Exception;
    :cond_9
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    invoke-virtual {v5, v4}, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->getActiveAdmins(I)Ljava/util/List;

    move-result-object v1

    .line 349
    .local v1, "activeAdminList":Ljava/util/List;, "Ljava/util/List<Landroid/content/ComponentName;>;"
    if-eqz v1, :cond_a

    invoke-interface {v1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    .line 350
    :cond_a
    iget-object v5, p0, Lcom/android/server/devicepolicy/DevicePolicyManagerService$1;->this$0:Lcom/android/server/devicepolicy/DevicePolicyManagerService;

    invoke-virtual {v5, v2, v8, v4}, Lcom/android/server/devicepolicy/DevicePolicyManagerService;->setActiveAdmin(Landroid/content/ComponentName;ZI)V

    goto :goto_1
.end method
