.class Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;
.super Ljava/lang/Object;
.source "LGBluetoothHandsfreeClient.java"

# interfaces
.implements Landroid/content/ServiceConnection;


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
    .line 212
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 3
    .param p1, "className"    # Landroid/content/ComponentName;
    .param p2, "service"    # Landroid/os/IBinder;

    .prologue
    .line 215
    const-string v0, "Proxy object connected"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    .line 216
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 217
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-static {p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    move-result-object v1

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    invoke-static {v0, v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$202(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    .line 223
    :goto_0
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$600(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothProfile$ServiceListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 224
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$600(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothProfile$ServiceListener;

    move-result-object v0

    const/16 v1, 0x14

    iget-object v2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-interface {v0, v1, v2}, Landroid/bluetooth/BluetoothProfile$ServiceListener;->onServiceConnected(ILandroid/bluetooth/BluetoothProfile;)V

    .line 226
    :cond_0
    return-void

    .line 218
    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 219
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-static {p2}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    move-result-object v1

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    invoke-static {v0, v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$302(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    goto :goto_0
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 2
    .param p1, "className"    # Landroid/content/ComponentName;

    .prologue
    const/4 v1, 0x0

    .line 229
    const-string v0, "Proxy object disconnected"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    .line 230
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    invoke-static {v0, v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$202(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    .line 231
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    invoke-static {v0, v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$302(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    .line 232
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$600(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothProfile$ServiceListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 233
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$2;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mServiceListener:Landroid/bluetooth/BluetoothProfile$ServiceListener;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$600(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothProfile$ServiceListener;

    move-result-object v0

    const/16 v1, 0x14

    invoke-interface {v0, v1}, Landroid/bluetooth/BluetoothProfile$ServiceListener;->onServiceDisconnected(I)V

    .line 235
    :cond_0
    return-void
.end method
