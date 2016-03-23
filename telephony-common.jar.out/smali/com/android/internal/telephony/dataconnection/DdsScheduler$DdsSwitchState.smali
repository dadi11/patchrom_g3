.class Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;
.super Lcom/android/internal/util/State;
.source "DdsScheduler.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DdsScheduler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DdsSwitchState"
.end annotation


# static fields
.field static final TAG:Ljava/lang/String; = "DdsScheduler[DdsSwitchState]"


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)V
    .locals 0

    .prologue
    .line 515
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/telephony/dataconnection/DdsScheduler$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/telephony/dataconnection/DdsScheduler;
    .param p2, "x1"    # Lcom/android/internal/telephony/dataconnection/DdsScheduler$1;

    .prologue
    .line 515
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;-><init>(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 3

    .prologue
    .line 519
    const-string v1, "DdsScheduler[DdsSwitchState]"

    const-string v2, "Enter"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 520
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getFirstWaitingRequest()Landroid/net/NetworkRequest;

    move-result-object v0

    .line 521
    .local v0, "nr":Landroid/net/NetworkRequest;
    if-eqz v0, :cond_0

    .line 522
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->triggerSwitch(Landroid/net/NetworkRequest;)V

    .line 526
    :goto_0
    return-void

    .line 524
    :cond_0
    const-string v1, "DdsScheduler[DdsSwitchState]"

    const-string v2, "Error"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 530
    const-string v0, "DdsScheduler[DdsSwitchState]"

    const-string v1, "Exit"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 531
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 5
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x1

    .line 535
    iget v3, p1, Landroid/os/Message;->what:I

    packed-switch v3, :pswitch_data_0

    .line 568
    const-string v2, "DdsScheduler[DdsSwitchState]"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unknown msg = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 569
    const/4 v2, 0x0

    :goto_0
    return v2

    .line 537
    :pswitch_0
    const-string v3, "DdsScheduler[DdsSwitchState]"

    const-string v4, "REQ_DDS_ALLOCATION"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 542
    :pswitch_1
    const-string v3, "DdsScheduler[DdsSwitchState]"

    const-string v4, "REQ_DDS_FREE"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 548
    :pswitch_2
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 549
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, Landroid/net/NetworkRequest;

    .line 550
    .local v1, "n":Landroid/net/NetworkRequest;
    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v3, :cond_1

    .line 551
    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v3, v1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->updateCurrentDds(Landroid/net/NetworkRequest;)V

    .line 553
    iget v3, p1, Landroid/os/Message;->what:I

    const v4, 0x84003

    if-ne v3, v4, :cond_0

    .line 554
    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    iget-object v4, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    # getter for: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->mPsAttachReservedState:Lcom/android/internal/telephony/dataconnection/DdsScheduler$PsAttachReservedState;
    invoke-static {v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$2100(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)Lcom/android/internal/telephony/dataconnection/DdsScheduler$PsAttachReservedState;

    move-result-object v4

    # invokes: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v3, v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$2200(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 556
    :cond_0
    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    iget-object v4, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    # getter for: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->mDdsReservedState:Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;
    invoke-static {v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$600(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;

    move-result-object v4

    # invokes: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v3, v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$2300(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 559
    :cond_1
    const-string v3, "DdsScheduler[DdsSwitchState]"

    const-string v4, "Switch failed, move back to idle state"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 561
    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v3, v1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->removeRequest(Landroid/net/NetworkRequest;)V

    .line 562
    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    iget-object v4, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    # getter for: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->mDdsIdleState:Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsIdleState;
    invoke-static {v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$1600(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsIdleState;

    move-result-object v4

    # invokes: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v3, v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$2400(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 535
    :pswitch_data_0
    .packed-switch 0x84000
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method
