.class Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;
.super Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;
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
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    invoke-direct {p0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientCallback$Stub;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStateChange(II)V
    .locals 1
    .param p1, "newState"    # I
    .param p2, "prevState"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "onAudioStateChange : callback to app"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;->onAudioStateChange(II)V

    :cond_0
    return-void
.end method

.method public onCallStateChange(IIIIILjava/lang/String;IZ)V
    .locals 10
    .param p1, "callId"    # I
    .param p2, "errState"    # I
    .param p3, "callState"    # I
    .param p4, "numActive"    # I
    .param p5, "numHeld"    # I
    .param p6, "number"    # Ljava/lang/String;
    .param p7, "addrType"    # I
    .param p8, "outgoing"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isQCTSolution()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$200(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v0, 0x7

    if-eq p3, v0, :cond_0

    const-string v0, "onCallStateChange : getCLCC"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    :try_start_0
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mQService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$200(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mDevice:Landroid/bluetooth/BluetoothDevice;
    invoke-static {v1}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$800(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientQcom;->getCurrentCalls(Landroid/bluetooth/BluetoothDevice;)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    const-string v0, "onCallStateChange : callback to app"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    move-result-object v0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move-object/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    invoke-interface/range {v0 .. v8}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;->onCallStateChange(IIIIILjava/lang/String;IZ)V

    :cond_1
    invoke-static {}, Lcom/lge/bluetooth/LGBluetoothFeatureConfig;->isBRCMSolution()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$300(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    move-result-object v0

    if-eqz v0, :cond_3

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->updateCallState:Z
    invoke-static {}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$900()Z

    move-result v0

    if-nez v0, :cond_4

    if-nez p4, :cond_2

    const/4 v0, 0x6

    if-eq p3, v0, :cond_4

    :cond_2
    const-string v0, "onCallStateChange : getCLCC"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    :try_start_1
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mBService:Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$300(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/bluetooth/hfpclient/ILGBluetoothHandsfreeClientBrcm;->getCLCC()Z

    const/4 v0, 0x1

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->updateCallState:Z
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$902(Z)Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    :cond_3
    :goto_1
    return-void

    :catch_0
    move-exception v9

    .local v9, "e":Landroid/os/RemoteException;
    const-string v0, "LGBluetoothHandsfreeClient"

    new-instance v1, Ljava/lang/Throwable;

    invoke-direct {v1}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v9    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v9

    .restart local v9    # "e":Landroid/os/RemoteException;
    const-string v0, "LGBluetoothHandsfreeClient"

    new-instance v1, Ljava/lang/Throwable;

    invoke-direct {v1}, Ljava/lang/Throwable;-><init>()V

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .end local v9    # "e":Landroid/os/RemoteException;
    :cond_4
    const/4 v0, 0x0

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->updateCallState:Z
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$902(Z)Z

    const-string v0, "onCallStateChange : callback to app"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public onConnectionStateChange(ILandroid/bluetooth/BluetoothDevice;IIII)V
    .locals 1
    .param p1, "errCode"    # I
    .param p2, "remoteDevice"    # Landroid/bluetooth/BluetoothDevice;
    .param p3, "newState"    # I
    .param p4, "prevState"    # I
    .param p5, "peerFeatures"    # I
    .param p6, "localFeatures"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "onConnectionStateChange : callback to app"

    # invokes: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->log(Ljava/lang/String;)V
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$000(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # setter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mDevice:Landroid/bluetooth/BluetoothDevice;
    invoke-static {v0, p2}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$802(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;Landroid/bluetooth/BluetoothDevice;)Landroid/bluetooth/BluetoothDevice;

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient$3;->this$0:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;

    # getter for: Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->mCallback:Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;
    invoke-static {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;->access$700(Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClient;)Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientEventHandler;->onConnectionStateChange(ILandroid/bluetooth/BluetoothDevice;II)V

    :cond_0
    return-void
.end method
