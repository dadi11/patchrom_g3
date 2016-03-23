.class Lcom/android/server/ePDGSTypeConnection$DcDefaultState;
.super Lcom/android/internal/util/State;
.source "ePDGSTypeConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGSTypeConnection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcDefaultState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/ePDGSTypeConnection;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGSTypeConnection;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGSTypeConnection;Lcom/android/server/ePDGSTypeConnection$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGSTypeConnection;
    .param p2, "x1"    # Lcom/android/server/ePDGSTypeConnection$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;-><init>(Lcom/android/server/ePDGSTypeConnection;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "Defatult state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "Defatult state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState: shouldn\'t happen but ignore msg.what=0x"

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

    :cond_0
    :goto_0
    return v5

    :sswitch_0
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v2, 0x138d

    iput v2, v1, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGSTypeConnection;->mLastNetworkReason:I

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState state : we get HandoverFail!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$5400(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_0

    :sswitch_1
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v5, v1, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v5, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    goto :goto_0

    :sswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState state : we get packet loss, so go to fail!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v2, 0x138c

    iput v2, v1, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$5500(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto :goto_0

    :sswitch_3
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState: msg.what=EVENT_WIFI_DISCONNECT"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState : Wifi Disconnected so prefmode  -> WWAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mNonetworkState:Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$5600(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    :sswitch_4
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState: MEN BONG SMi?!! WHO make manger stop!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v4, v1, Lcom/android/server/ePDGSTypeConnection;->isManager:Z

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mNonetworkState:Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;
    invoke-static {v2}, Lcom/android/server/ePDGSTypeConnection;->access$900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->access$5700(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    :sswitch_5
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, v1, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState : user disconnect so prefmode to modem -> WWAN"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    :sswitch_6
    iget v0, p1, Landroid/os/Message;->arg1:I

    .local v0, "tech":I
    if-ne v0, v5, :cond_2

    const/4 v0, 0x2

    :cond_2
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState: EVENT_PDN_PRI_CH , "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    .end local v0    # "tech":I
    :sswitch_7
    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcDefaultState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcDefaultState : EVENT_EPDG_TIME "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x40000 -> :sswitch_1
        0x40001 -> :sswitch_3
        0x40003 -> :sswitch_4
        0x40009 -> :sswitch_5
        0x4000b -> :sswitch_2
        0x4000c -> :sswitch_0
        0x40010 -> :sswitch_6
        0x4001f -> :sswitch_7
    .end sparse-switch
.end method
