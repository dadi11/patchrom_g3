.class Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;
.super Landroid/os/Handler;
.source "KTRejectCause.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/telephony/KrRejectCause/KTRejectCause;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;


# direct methods
.method constructor <init>(Lcom/lge/telephony/KrRejectCause/KTRejectCause;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x1

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mDelayedTimeoutHandler Expired!!! : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    iget-object v2, v2, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->mDelayedTimeoutHandler:Landroid/os/Handler;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->log(Ljava/lang/String;)V

    # getter for: Lcom/lge/telephony/KrRejectCause/KTRejectCause;->delayedStatus:I
    invoke-static {}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->access$000()I

    move-result v0

    if-ne v0, v3, :cond_0

    const/4 v0, 0x2

    # setter for: Lcom/lge/telephony/KrRejectCause/KTRejectCause;->delayedStatus:I
    invoke-static {v0}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->access$002(I)I

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    iput-boolean v3, v0, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->canShowAlert:Z

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    iget-object v1, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    # getter for: Lcom/lge/telephony/KrRejectCause/KTRejectCause;->mStatusId:I
    invoke-static {v1}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->access$100(Lcom/lge/telephony/KrRejectCause/KTRejectCause;)I

    move-result v1

    # invokes: Lcom/lge/telephony/KrRejectCause/KTRejectCause;->sendIntentForOTA(I)V
    invoke-static {v0, v1}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->access$200(Lcom/lge/telephony/KrRejectCause/KTRejectCause;I)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    iget-object v1, p0, Lcom/lge/telephony/KrRejectCause/KTRejectCause$1;->this$0:Lcom/lge/telephony/KrRejectCause/KTRejectCause;

    # getter for: Lcom/lge/telephony/KrRejectCause/KTRejectCause;->mStatusId:I
    invoke-static {v1}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->access$100(Lcom/lge/telephony/KrRejectCause/KTRejectCause;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/lge/telephony/KrRejectCause/KTRejectCause;->processStatuId(I)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method
