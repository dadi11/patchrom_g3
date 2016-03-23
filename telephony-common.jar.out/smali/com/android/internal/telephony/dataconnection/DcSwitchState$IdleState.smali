.class Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;
.super Lcom/android/internal/util/State;
.source "DcSwitchState.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DcSwitchState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "IdleState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)V
    .locals 0

    .prologue
    .line 147
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/telephony/dataconnection/DcSwitchState;Lcom/android/internal/telephony/dataconnection/DcSwitchState$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/telephony/dataconnection/DcSwitchState;
    .param p2, "x1"    # Lcom/android/internal/telephony/dataconnection/DcSwitchState$1;

    .prologue
    .line 147
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;-><init>(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 1

    .prologue
    .line 150
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->mIdleRegistrants:Landroid/os/RegistrantList;
    invoke-static {v0}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$500(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)Landroid/os/RegistrantList;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 151
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 157
    iget v7, p1, Landroid/os/Message;->what:I

    sparse-switch v7, :sswitch_data_0

    .line 211
    const/4 v2, 0x0

    .line 214
    .local v2, "retVal":Z
    :goto_0
    return v2

    .line 160
    .end local v2    # "retVal":Z
    :sswitch_0
    iget-object v6, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v6, Ljava/lang/String;

    .line 162
    .local v6, "type":Ljava/lang/String;
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "IdleState: REQ_CONNECT/EVENT_CONNECT("

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget v9, p1, Landroid/os/Message;->what:I

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ") type="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->log(Ljava/lang/String;)V

    .line 166
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v7}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$600(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)Lcom/android/internal/telephony/Phone;

    move-result-object v7

    check-cast v7, Lcom/android/internal/telephony/PhoneProxy;

    invoke-virtual {v7}, Lcom/android/internal/telephony/PhoneProxy;->getActivePhone()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/PhoneBase;

    .line 167
    .local v0, "pb":Lcom/android/internal/telephony/PhoneBase;
    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getSubId()J

    move-result-wide v4

    .line 168
    .local v4, "subId":J
    invoke-static {}, Lcom/android/internal/telephony/SubscriptionController;->getInstance()Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v3

    .line 170
    .local v3, "subscriptionController":Lcom/android/internal/telephony/SubscriptionController;
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Setting default DDS on "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->log(Ljava/lang/String;)V

    .line 171
    invoke-virtual {v3, v4, v5}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultDataSubId(J)V

    .line 173
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # invokes: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->setupConnection(Ljava/lang/String;)I
    invoke-static {v7, v6}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$700(Lcom/android/internal/telephony/dataconnection/DcSwitchState;Ljava/lang/String;)I

    move-result v1

    .line 174
    .local v1, "result":I
    iget v7, p1, Landroid/os/Message;->what:I

    const v8, 0x44000

    if-ne v7, v8, :cond_0

    .line 175
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->mAc:Lcom/android/internal/util/AsyncChannel;
    invoke-static {v7}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$800(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)Lcom/android/internal/util/AsyncChannel;

    move-result-object v7

    const v8, 0x44001

    invoke-virtual {v7, p1, v8, v1}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;II)V

    .line 177
    :cond_0
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->mActingState:Lcom/android/internal/telephony/dataconnection/DcSwitchState$ActingState;
    invoke-static {v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$900(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)Lcom/android/internal/telephony/dataconnection/DcSwitchState$ActingState;

    move-result-object v8

    # invokes: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$1000(Lcom/android/internal/telephony/dataconnection/DcSwitchState;Lcom/android/internal/util/IState;)V

    .line 178
    const/4 v2, 0x1

    .line 179
    .restart local v2    # "retVal":Z
    goto :goto_0

    .line 182
    .end local v0    # "pb":Lcom/android/internal/telephony/PhoneBase;
    .end local v1    # "result":I
    .end local v2    # "retVal":Z
    .end local v3    # "subscriptionController":Lcom/android/internal/telephony/SubscriptionController;
    .end local v4    # "subId":J
    .end local v6    # "type":Ljava/lang/String;
    :sswitch_1
    iget-object v6, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v6, Ljava/lang/String;

    .line 184
    .restart local v6    # "type":Ljava/lang/String;
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "IdleState: DcSwitchAsyncChannel.REQ_DISCONNECT type="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->log(Ljava/lang/String;)V

    .line 186
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->mAc:Lcom/android/internal/util/AsyncChannel;
    invoke-static {v7}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$800(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)Lcom/android/internal/util/AsyncChannel;

    move-result-object v7

    const v8, 0x44003

    const/4 v9, 0x4

    invoke-virtual {v7, p1, v8, v9}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;II)V

    .line 188
    const/4 v2, 0x1

    .line 189
    .restart local v2    # "retVal":Z
    goto/16 :goto_0

    .line 193
    .end local v2    # "retVal":Z
    .end local v6    # "type":Ljava/lang/String;
    :sswitch_2
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    const-string v8, "IdleState: EVENT_CLEANUP_ALL"

    invoke-virtual {v7, v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->log(Ljava/lang/String;)V

    .line 195
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    # invokes: Lcom/android/internal/telephony/dataconnection/DcSwitchState;->requestDataIdle()V
    invoke-static {v7}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->access$1100(Lcom/android/internal/telephony/dataconnection/DcSwitchState;)V

    .line 196
    const/4 v2, 0x1

    .line 197
    .restart local v2    # "retVal":Z
    goto/16 :goto_0

    .line 201
    .end local v2    # "retVal":Z
    :sswitch_3
    iget-object v7, p0, Lcom/android/internal/telephony/dataconnection/DcSwitchState$IdleState;->this$0:Lcom/android/internal/telephony/dataconnection/DcSwitchState;

    const-string v8, "IdleState: Receive invalid event EVENT_CONNECTED!"

    invoke-virtual {v7, v8}, Lcom/android/internal/telephony/dataconnection/DcSwitchState;->log(Ljava/lang/String;)V

    .line 203
    const/4 v2, 0x1

    .line 204
    .restart local v2    # "retVal":Z
    goto/16 :goto_0

    .line 157
    nop

    :sswitch_data_0
    .sparse-switch
        0x43000 -> :sswitch_0
        0x43002 -> :sswitch_2
        0x43003 -> :sswitch_3
        0x44000 -> :sswitch_0
        0x44002 -> :sswitch_1
    .end sparse-switch
.end method
