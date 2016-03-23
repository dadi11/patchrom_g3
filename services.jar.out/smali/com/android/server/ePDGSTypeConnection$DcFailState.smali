.class Lcom/android/server/ePDGSTypeConnection$DcFailState;
.super Lcom/android/internal/util/State;
.source "ePDGSTypeConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGSTypeConnection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcFailState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/ePDGSTypeConnection;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGSTypeConnection;)V
    .locals 0

    .prologue
    .line 164
    iput-object p1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGSTypeConnection;Lcom/android/server/ePDGSTypeConnection$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGSTypeConnection;
    .param p2, "x1"    # Lcom/android/server/ePDGSTypeConnection$1;

    .prologue
    .line 164
    invoke-direct {p0, p1}, Lcom/android/server/ePDGSTypeConnection$DcFailState;-><init>(Lcom/android/server/ePDGSTypeConnection;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 3

    .prologue
    .line 171
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcFailState state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 173
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    const/16 v1, 0x138b

    if-ne v0, v1, :cond_1

    .line 198
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v2, v2, Lcom/android/server/ePDGSTypeConnection;->mLastNetworkReason:I

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 214
    :cond_0
    :goto_0
    return-void

    .line 203
    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    const/16 v1, 0x138a

    if-ne v0, v1, :cond_2

    .line 206
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v1, 0x3e8

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    goto :goto_0

    .line 208
    :cond_2
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    const/16 v1, 0x138c

    if-eq v0, v1, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    const/16 v1, 0x138d

    if-ne v0, v1, :cond_0

    .line 210
    :cond_3
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/4 v1, 0x3

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v2, v2, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    goto :goto_0
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 220
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcFailState state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 223
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v7, 0x138e

    const/16 v3, 0x12

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x0

    .line 230
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 342
    :pswitch_0
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcFailState nothandled msg.what=0x"

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

    .line 345
    const/4 v0, 0x0

    .line 348
    .local v0, "retVal":Z
    :cond_0
    :goto_0
    return v0

    .line 233
    .end local v0    # "retVal":Z
    :pswitch_1
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState: Fail aleady checked!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 234
    const/4 v0, 0x1

    .line 235
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 238
    .end local v0    # "retVal":Z
    :pswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcFailState: EVENT_DISCONNECTED, it should be IMS!! mFid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 239
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-boolean v1, v1, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    if-eqz v1, :cond_1

    .line 240
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v2, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v1, v5, v2}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 247
    :goto_1
    const/4 v0, 0x1

    .line 248
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 244
    .end local v0    # "retVal":Z
    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-virtual {v1, v6, v7}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 245
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mNonetworkState:Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$1000(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_1

    .line 251
    :pswitch_3
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_2

    .line 253
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-virtual {v1, v4, v4}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 254
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : [ePDG] Connected Msg from RIL "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 255
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mConnectedState:Lcom/android/server/ePDGSTypeConnection$DcConnectedState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1100(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcConnectedState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$1200(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 257
    :cond_2
    const/4 v0, 0x1

    .line 258
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 261
    .end local v0    # "retVal":Z
    :pswitch_4
    const/4 v0, 0x1

    .line 262
    .restart local v0    # "retVal":Z
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_0

    .line 265
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mExtendedRat:I

    if-ne v1, v3, :cond_3

    .line 267
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : just wait until wifi disconnect or handover to LTE complete "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 268
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    .line 274
    :cond_3
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-boolean v1, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    if-eqz v1, :cond_4

    .line 276
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : user disconnect in ePDG status & good packet go ready"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 277
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mReadyState:Lcom/android/server/ePDGSTypeConnection$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1300(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$1400(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    .line 281
    :cond_4
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : user disconnect in ePDG status & bad packet go ready"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 282
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mReadyState:Lcom/android/server/ePDGSTypeConnection$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1300(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$1500(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    .line 291
    .end local v0    # "retVal":Z
    :pswitch_5
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_6

    .line 293
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-boolean v1, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    if-eqz v1, :cond_5

    .line 295
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : User req so send change prefmode to modem -> IWLAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 296
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v5}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 297
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mConnectingState:Lcom/android/server/ePDGSTypeConnection$DcConnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1600(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcConnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$1700(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 310
    :goto_2
    const/4 v0, 0x1

    .line 311
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 301
    .end local v0    # "retVal":Z
    :cond_5
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : User is now bad packet status so just stay Fail!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    goto :goto_2

    .line 308
    :cond_6
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mConnectingState:Lcom/android/server/ePDGSTypeConnection$DcConnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1600(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcConnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$1800(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_2

    .line 318
    :pswitch_6
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcFailState : msg.what=EVENT_WIFI_DISCONNECT"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 319
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    .line 322
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mExtendedRat:I

    if-ne v1, v3, :cond_7

    .line 324
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 325
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mDisconnectingState:Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$1900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$2000(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 332
    :goto_3
    const/4 v0, 0x1

    .line 333
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 329
    .end local v0    # "retVal":Z
    :cond_7
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-virtual {v1, v6, v7}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 330
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mNonetworkState:Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$2100(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_3

    .line 336
    :pswitch_7
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcFailState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    .line 337
    const/4 v0, 0x1

    .line 338
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 230
    nop

    :pswitch_data_0
    .packed-switch 0x40001
        :pswitch_6
        :pswitch_5
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_4
        :pswitch_0
        :pswitch_7
        :pswitch_1
    .end packed-switch
.end method
