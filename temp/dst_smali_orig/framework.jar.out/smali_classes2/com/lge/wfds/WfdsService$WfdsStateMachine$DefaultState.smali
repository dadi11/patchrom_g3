.class Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;
.super Lcom/android/internal/util/State;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService$WfdsStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "DefaultState"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    const-string v0, "WfdsService"

    const-string v1, "STATE : DefaultState - enter"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public exit()V
    .locals 0

    .prologue
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 8
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const v7, 0x900022

    const v6, 0x900021

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x2

    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DefaultState - msg ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] is not handled"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v5

    :sswitch_0
    const-string v1, "WfdsService"

    const-string v2, "DefaultState - WFDS_ENABLE(DISABLE)"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :sswitch_1
    const-string v1, "WfdsService"

    const-string v2, "DefaultState - WIFI_SUPPLICANT_CONNECTED"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsMonitorConnected:Z
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1600(Lcom/lge/wfds/WfdsService;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setWfdsMonitor(Z)V
    invoke-static {v1, v5}, Lcom/lge/wfds/WfdsService;->access$1700(Lcom/lge/wfds/WfdsService;Z)V

    const-string v1, "WfdsService"

    const-string v2, "WiFi: Supplicant connection re-established"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mSuppDisconnectCount:I
    invoke-static {v1, v4}, Lcom/lge/wfds/WfdsService;->access$1802(Lcom/lge/wfds/WfdsService;I)I

    goto :goto_0

    :sswitch_2
    const-string v1, "WfdsService"

    const-string v2, "DefaultState - WIFI_SUPPLICANT_DISCONNECTED"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setWfdsMonitor(ZZ)V
    invoke-static {v1, v4, v5}, Lcom/lge/wfds/WfdsService;->access$1900(Lcom/lge/wfds/WfdsService;ZZ)V

    goto :goto_0

    :sswitch_3
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v6, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_0

    :sswitch_4
    const-string v1, "WfdsService"

    const-string v2, "DefaultState - SEEK_SERVICE is received"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v6, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_0

    :sswitch_5
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v2, 0x90001f

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_0

    :sswitch_6
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v2, 0x900025

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_0

    :sswitch_7
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getDeviceAddress()Ljava/lang/String;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2100(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v0

    .local v0, "deviceAddr":Ljava/lang/String;
    if-eqz v0, :cond_1

    const-string v1, "ff:ff:ff:ff:ff:ff"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    :cond_1
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v2, 0x900023

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v2, v4}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v2, 0x900024

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;ILjava/lang/String;)V
    invoke-static {v1, p1, v2, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;ILjava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "deviceAddr":Ljava/lang/String;
    :sswitch_8
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getPreferredScanChannel()I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2300(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v7, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_0

    :sswitch_9
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget v2, p1, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsService;->setScanOnlyChannel(I)V
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$2400(Lcom/lge/wfds/WfdsService;I)V

    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SET_LISTEN_CHANNEL : mScanOnlyOneChannel = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v2, 0x900020

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v1, p1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    goto/16 :goto_0

    :sswitch_a
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget v2, p1, Landroid/os/Message;->arg1:I

    # invokes: Lcom/lge/wfds/WfdsService;->confirmScanOnlyChannel(I)I
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$2700(Lcom/lge/wfds/WfdsService;I)I

    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CONFIRM_LISTEN_CHANNEL : requested Channel = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v1, p1, v7, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x900001 -> :sswitch_3
        0x900002 -> :sswitch_5
        0x900004 -> :sswitch_4
        0x900005 -> :sswitch_6
        0x90005b -> :sswitch_7
        0x90005c -> :sswitch_8
        0x90005d -> :sswitch_9
        0x90005e -> :sswitch_a
        0x901001 -> :sswitch_0
        0x901002 -> :sswitch_0
        0x901003 -> :sswitch_1
        0x901004 -> :sswitch_2
    .end sparse-switch
.end method
