.class Lcom/android/server/ePDGSTypeConnection$DcConnectedState;
.super Lcom/android/internal/util/State;
.source "ePDGSTypeConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGSTypeConnection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcConnectedState"
.end annotation


# instance fields
.field public mTimecount:I

.field final synthetic this$0:Lcom/android/server/ePDGSTypeConnection;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGSTypeConnection;)V
    .locals 1

    .prologue
    .line 435
    iput-object p1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    .line 438
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGSTypeConnection;Lcom/android/server/ePDGSTypeConnection$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGSTypeConnection;
    .param p2, "x1"    # Lcom/android/server/ePDGSTypeConnection$1;

    .prologue
    .line 435
    invoke-direct {p0, p1}, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;-><init>(Lcom/android/server/ePDGSTypeConnection;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 4

    .prologue
    .line 443
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcConnectedState state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 446
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const v2, 0x4001f

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/ePDGSTypeConnection;->sendMessageDelayed(Landroid/os/Message;J)V

    .line 448
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 454
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcConnectedState state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 457
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    .line 458
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v7, 0x138d

    const/16 v6, 0x138c

    const/16 v5, 0x63

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 465
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 594
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcConnectedState nothandled msg.what=0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 597
    const/4 v0, 0x0

    .line 600
    .local v0, "retVal":Z
    :goto_0
    return v0

    .line 468
    .end local v0    # "retVal":Z
    :sswitch_0
    iget v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    .line 469
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcConnectedState : EVENT_EPDG_TIME "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 471
    iget v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    const/4 v2, 0x2

    if-ge v1, v2, :cond_0

    .line 473
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const v3, 0x4001f

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    const-wide/16 v4, 0xbb8

    invoke-virtual {v1, v2, v4, v5}, Lcom/android/server/ePDGSTypeConnection;->sendMessageDelayed(Landroid/os/Message;J)V

    .line 474
    const/4 v0, 0x1

    .line 475
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 478
    .end local v0    # "retVal":Z
    :cond_0
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-boolean v1, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    if-nez v1, :cond_1

    .line 480
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : it\'s not good packet condition, so send change prefmode to modem -> WWAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 481
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 482
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput v6, v1, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    .line 483
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$2800(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 489
    :goto_1
    const/4 v0, 0x1

    .line 490
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 487
    .end local v0    # "retVal":Z
    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const v3, 0x4001f

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    const-wide/16 v4, 0xbb8

    invoke-virtual {v1, v2, v4, v5}, Lcom/android/server/ePDGSTypeConnection;->sendMessageDelayed(Landroid/os/Message;J)V

    goto :goto_1

    .line 494
    :sswitch_1
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    .line 495
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : we get packet loss, so go to fail!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 496
    iget v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    if-le v1, v3, :cond_2

    .line 498
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : send change prefmode to modem -> WWAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 499
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 500
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput v6, v1, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    .line 501
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$2900(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 507
    :goto_2
    const/4 v0, 0x1

    .line 508
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 505
    .end local v0    # "retVal":Z
    :cond_2
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcConnectedState : we get packet loss, but we wait more mTimecount= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->mTimecount:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    goto :goto_2

    .line 511
    :sswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : we get Handover Fail!! it should not happen!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 512
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput v7, v1, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    .line 513
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3000(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 514
    const/4 v0, 0x1

    .line 515
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 520
    .end local v0    # "retVal":Z
    :sswitch_3
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_3

    .line 523
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput v7, v1, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    .line 524
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3100(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 541
    :goto_3
    const/4 v0, 0x1

    .line 544
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 528
    .end local v0    # "retVal":Z
    :cond_3
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput v5, v1, Lcom/android/server/ePDGSTypeConnection;->cid:I

    .line 529
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/4 v2, 0x3

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v1, v2, v3}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 531
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-boolean v1, v1, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    if-eqz v1, :cond_4

    .line 533
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mReadyState:Lcom/android/server/ePDGSTypeConnection$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1300(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3200(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_3

    .line 537
    :cond_4
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mNonetworkState:Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3300(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_3

    .line 550
    :sswitch_4
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_5

    .line 552
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : send change prefmode to modem -> WWAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 553
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 554
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mDisconnectingState:Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3400(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 555
    const/4 v0, 0x1

    .line 556
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 559
    .end local v0    # "retVal":Z
    :cond_5
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-ne v1, v3, :cond_6

    .line 560
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->cid:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGSTypeConnection;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 561
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : ePDGDeactivateDataCall - VZWAPP"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 562
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput v5, v1, Lcom/android/server/ePDGSTypeConnection;->cid:I

    .line 563
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mReadyState:Lcom/android/server/ePDGSTypeConnection$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1300(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3500(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 564
    const/4 v0, 0x1

    .line 565
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 567
    .end local v0    # "retVal":Z
    :cond_6
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mDisconnectingState:Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3600(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 568
    const/4 v0, 0x1

    .line 569
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 576
    .end local v0    # "retVal":Z
    :sswitch_5
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : msg.what=EVENT_WIFI_DISCONNECT"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 577
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    .line 580
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_7

    .line 582
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectedState : Wifi Disconnected so prefmode -> WWAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 583
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 585
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectedState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mDisconnectingState:Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$3700(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 590
    :cond_7
    const/4 v0, 0x1

    .line 591
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 465
    :sswitch_data_0
    .sparse-switch
        0x40001 -> :sswitch_5
        0x40006 -> :sswitch_3
        0x40009 -> :sswitch_4
        0x4000b -> :sswitch_1
        0x4000c -> :sswitch_2
        0x4001f -> :sswitch_0
    .end sparse-switch
.end method
