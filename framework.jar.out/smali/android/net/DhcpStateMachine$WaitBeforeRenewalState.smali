.class Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;
.super Lcom/android/internal/util/State;
.source "DhcpStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/net/DhcpStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "WaitBeforeRenewalState"
.end annotation


# instance fields
.field final synthetic this$0:Landroid/net/DhcpStateMachine;


# direct methods
.method constructor <init>(Landroid/net/DhcpStateMachine;)V
    .locals 0

    .prologue
    .line 373
    iput-object p1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 3

    .prologue
    .line 376
    const-string v0, "DhcpStateMachine"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 377
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 418
    iget-object v0, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mDhcpRenewWakeLock:Landroid/os/PowerManager$WakeLock;
    invoke-static {v0}, Landroid/net/DhcpStateMachine;->access$100(Landroid/net/DhcpStateMachine;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 419
    const-string v0, "DhcpStateMachine"

    const-string v1, "DHCP Renew wake lock is released."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 420
    iget-object v0, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mDhcpRenewWakeLock:Landroid/os/PowerManager$WakeLock;
    invoke-static {v0}, Landroid/net/DhcpStateMachine;->access$100(Landroid/net/DhcpStateMachine;)Landroid/os/PowerManager$WakeLock;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 422
    :cond_0
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 4
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    .line 381
    const/4 v0, 0x1

    .line 382
    .local v0, "retValue":Z
    const-string v1, "DhcpStateMachine"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/os/Message;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 383
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 410
    const/4 v0, 0x0

    .line 413
    :goto_0
    :sswitch_0
    return v0

    .line 385
    :sswitch_1
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mAlarmManager:Landroid/app/AlarmManager;
    invoke-static {v1}, Landroid/net/DhcpStateMachine;->access$1800(Landroid/net/DhcpStateMachine;)Landroid/app/AlarmManager;

    move-result-object v1

    iget-object v2, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mDhcpRenewalIntent:Landroid/app/PendingIntent;
    invoke-static {v2}, Landroid/net/DhcpStateMachine;->access$1700(Landroid/net/DhcpStateMachine;)Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 386
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mIsDhcpV6:Z
    invoke-static {v1}, Landroid/net/DhcpStateMachine;->access$000(Landroid/net/DhcpStateMachine;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 387
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mInterfaceName:Ljava/lang/String;
    invoke-static {v1}, Landroid/net/DhcpStateMachine;->access$400(Landroid/net/DhcpStateMachine;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/NetworkUtils;->stopDhcp(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 388
    const-string v1, "DhcpStateMachine"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to stop Dhcp on "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mInterfaceName:Ljava/lang/String;
    invoke-static {v3}, Landroid/net/DhcpStateMachine;->access$400(Landroid/net/DhcpStateMachine;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 397
    :cond_0
    :goto_1
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    iget-object v2, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mStoppedState:Lcom/android/internal/util/State;
    invoke-static {v2}, Landroid/net/DhcpStateMachine;->access$1400(Landroid/net/DhcpStateMachine;)Lcom/android/internal/util/State;

    move-result-object v2

    # invokes: Landroid/net/DhcpStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Landroid/net/DhcpStateMachine;->access$2300(Landroid/net/DhcpStateMachine;Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 392
    :cond_1
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mInterfaceName:Ljava/lang/String;
    invoke-static {v1}, Landroid/net/DhcpStateMachine;->access$400(Landroid/net/DhcpStateMachine;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/NetworkUtils;->stopDhcpv6(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 393
    const-string v1, "DhcpStateMachine"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to stop Dhcpv6 on "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mInterfaceName:Ljava/lang/String;
    invoke-static {v3}, Landroid/net/DhcpStateMachine;->access$400(Landroid/net/DhcpStateMachine;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 400
    :sswitch_2
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    sget-object v2, Landroid/net/DhcpStateMachine$DhcpAction;->RENEW:Landroid/net/DhcpStateMachine$DhcpAction;

    # invokes: Landroid/net/DhcpStateMachine;->runDhcp(Landroid/net/DhcpStateMachine$DhcpAction;)Z
    invoke-static {v1, v2}, Landroid/net/DhcpStateMachine;->access$1000(Landroid/net/DhcpStateMachine;Landroid/net/DhcpStateMachine$DhcpAction;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 401
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    iget-object v2, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mRunningState:Lcom/android/internal/util/State;
    invoke-static {v2}, Landroid/net/DhcpStateMachine;->access$1100(Landroid/net/DhcpStateMachine;)Lcom/android/internal/util/State;

    move-result-object v2

    # invokes: Landroid/net/DhcpStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Landroid/net/DhcpStateMachine;->access$2400(Landroid/net/DhcpStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    .line 403
    :cond_2
    iget-object v1, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    iget-object v2, p0, Landroid/net/DhcpStateMachine$WaitBeforeRenewalState;->this$0:Landroid/net/DhcpStateMachine;

    # getter for: Landroid/net/DhcpStateMachine;->mStoppedState:Lcom/android/internal/util/State;
    invoke-static {v2}, Landroid/net/DhcpStateMachine;->access$1400(Landroid/net/DhcpStateMachine;)Lcom/android/internal/util/State;

    move-result-object v2

    # invokes: Landroid/net/DhcpStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Landroid/net/DhcpStateMachine;->access$2500(Landroid/net/DhcpStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    .line 383
    :sswitch_data_0
    .sparse-switch
        0x30001 -> :sswitch_0
        0x30002 -> :sswitch_1
        0x30007 -> :sswitch_2
    .end sparse-switch
.end method
