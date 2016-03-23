.class Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;
.super Landroid/bluetooth/IBluetoothStateChangeCallback$Stub;
.source "LGBluetoothHandsfreeClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;


# direct methods
.method constructor <init>(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-direct {p0}, Landroid/bluetooth/IBluetoothStateChangeCallback$Stub;-><init>()V

    return-void
.end method


# virtual methods
.method public onBluetoothStateChange(Z)V
    .locals 4
    .param p1, "up"    # Z

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onBluetoothStateChange: up = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    if-nez p1, :cond_1

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$100(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/ServiceConnection;

    move-result-object v2

    monitor-enter v2

    :try_start_0
    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    const/4 v3, 0x0

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    invoke-static {v1, v3}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$202(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    const/4 v3, 0x0

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    invoke-static {v1, v3}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$302(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$400(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/Context;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$400(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/Context;

    move-result-object v1

    iget-object v3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;
    invoke-static {v3}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$100(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/ServiceConnection;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :goto_0
    :try_start_1
    monitor-exit v2

    :goto_1
    return-void

    :catch_0
    move-exception v0

    .local v0, "re":Ljava/lang/Exception;
    const-string v1, "LGBluetoothHandsfreeClient"

    const-string v3, ""

    invoke-static {v1, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "re":Ljava/lang/Exception;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1

    :cond_1
    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mConnection:Landroid/content/ServiceConnection;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$100(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/content/ServiceConnection;

    move-result-object v2

    monitor-enter v2

    :try_start_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$200(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    move-result-object v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->doBind()V
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$500(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V

    :cond_2
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$300(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    move-result-object v1

    if-nez v1, :cond_3

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$1;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->doBind()V
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$500(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :cond_3
    :goto_2
    :try_start_3
    monitor-exit v2

    goto :goto_1

    :catchall_1
    move-exception v1

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v1

    :catch_1
    move-exception v0

    .restart local v0    # "re":Ljava/lang/Exception;
    :try_start_4
    const-string v1, "LGBluetoothHandsfreeClient"

    const-string v3, ""

    invoke-static {v1, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_2
.end method
