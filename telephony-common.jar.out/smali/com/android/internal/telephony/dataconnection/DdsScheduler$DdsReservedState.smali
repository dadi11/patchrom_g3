.class Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;
.super Lcom/android/internal/util/State;
.source "DdsScheduler.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DdsScheduler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DdsReservedState"
.end annotation


# static fields
.field static final TAG:Ljava/lang/String; = "DdsScheduler[DdsReservedState]"


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)V
    .locals 0

    .prologue
    .line 375
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/telephony/dataconnection/DdsScheduler$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/telephony/dataconnection/DdsScheduler;
    .param p2, "x1"    # Lcom/android/internal/telephony/dataconnection/DdsScheduler$1;

    .prologue
    .line 375
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;-><init>(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)V

    return-void
.end method

.method private handleOtherSubRequests()V
    .locals 6

    .prologue
    .line 379
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getFirstWaitingRequest()Landroid/net/NetworkRequest;

    move-result-object v0

    .line 380
    .local v0, "nr":Landroid/net/NetworkRequest;
    if-nez v0, :cond_0

    .line 381
    const-string v1, "DdsScheduler[DdsReservedState]"

    const-string v2, "No more requests to accept"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 382
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    # getter for: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->mDdsAutoRevertState:Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsAutoRevertState;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$1200(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsAutoRevertState;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$1300(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/util/IState;)V

    .line 391
    :goto_0
    return-void

    .line 383
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getSubIdFromNetworkRequest(Landroid/net/NetworkRequest;)J

    move-result-wide v2

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getCurrentDds()J

    move-result-wide v4

    cmp-long v1, v2, v4

    if-eqz v1, :cond_1

    .line 384
    const-string v1, "DdsScheduler[DdsReservedState]"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Switch required for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 385
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    # getter for: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->mDdsSwitchState:Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$800(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsSwitchState;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$1400(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 387
    :cond_1
    const-string v1, "DdsScheduler[DdsReservedState]"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "This request failed to get accepted. nr = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 389
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    # getter for: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->mDdsAutoRevertState:Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsAutoRevertState;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$1200(Lcom/android/internal/telephony/dataconnection/DdsScheduler;)Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsAutoRevertState;

    move-result-object v2

    # invokes: Lcom/android/internal/telephony/dataconnection/DdsScheduler;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->access$1500(Lcom/android/internal/telephony/dataconnection/DdsScheduler;Lcom/android/internal/util/IState;)V

    goto :goto_0
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    .line 395
    const-string v0, "DdsScheduler[DdsReservedState]"

    const-string v1, "Enter"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 396
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->acceptWaitingRequest()Z

    move-result v0

    if-nez v0, :cond_0

    .line 397
    invoke-direct {p0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->handleOtherSubRequests()V

    .line 399
    :cond_0
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 403
    const-string v0, "DdsScheduler[DdsReservedState]"

    const-string v1, "Exit"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 404
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v1, 0x1

    .line 408
    iget v2, p1, Landroid/os/Message;->what:I

    packed-switch v2, :pswitch_data_0

    .line 434
    const-string v1, "DdsScheduler[DdsReservedState]"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unknown msg = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 435
    const/4 v1, 0x0

    :cond_0
    :goto_0
    return v1

    .line 410
    :pswitch_0
    const-string v2, "DdsScheduler[DdsReservedState]"

    const-string v3, "REQ_DDS_ALLOCATION"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 411
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/net/NetworkRequest;

    .line 413
    .local v0, "n":Landroid/net/NetworkRequest;
    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v2, v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getSubIdFromNetworkRequest(Landroid/net/NetworkRequest;)J

    move-result-wide v2

    iget-object v4, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v4}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getCurrentDds()J

    move-result-wide v4

    cmp-long v2, v2, v4

    if-nez v2, :cond_0

    .line 414
    const-string v2, "DdsScheduler[DdsReservedState]"

    const-string v3, "Accepting simultaneous request for current sub"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 416
    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v2, v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->notifyRequestAccepted(Landroid/net/NetworkRequest;)V

    goto :goto_0

    .line 422
    .end local v0    # "n":Landroid/net/NetworkRequest;
    :pswitch_1
    const-string v2, "DdsScheduler[DdsReservedState]"

    const-string v3, "REQ_DDS_FREE"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 424
    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->this$0:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v2}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->acceptWaitingRequest()Z

    move-result v2

    if-nez v2, :cond_1

    .line 425
    const-string v2, "DdsScheduler[DdsReservedState]"

    const-string v3, "Can\'t process next in this DDS"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 426
    invoke-direct {p0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler$DdsReservedState;->handleOtherSubRequests()V

    goto :goto_0

    .line 428
    :cond_1
    const-string v2, "DdsScheduler[DdsReservedState]"

    const-string v3, "Processing next in same DDS"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 408
    :pswitch_data_0
    .packed-switch 0x84000
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
