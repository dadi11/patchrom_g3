.class Lcom/lge/wfds/WfdsService$Scanner;
.super Landroid/os/Handler;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "Scanner"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wfds/WfdsService;


# direct methods
.method private constructor <init>(Lcom/lge/wfds/WfdsService;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$Scanner;->this$0:Lcom/lge/wfds/WfdsService;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsService$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/wfds/WfdsService;
    .param p2, "x1"    # Lcom/lge/wfds/WfdsService$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$Scanner;-><init>(Lcom/lge/wfds/WfdsService;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$Scanner;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$Scanner;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$Scanner;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/lge/wfds/WfdsNative;->p2pFind(I)Z

    :goto_0
    const/4 v0, 0x0

    const-wide/16 v2, 0x1388

    invoke-virtual {p0, v0, v2, v3}, Lcom/lge/wfds/WfdsService$Scanner;->sendEmptyMessageDelayed(IJ)Z

    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$Scanner;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/lge/wfds/WfdsNative;->p2pFind(Z)Z

    goto :goto_0
.end method

.method pause()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/wfds/WfdsService$Scanner;->removeMessages(I)V

    return-void
.end method

.method resume(I)V
    .locals 3
    .param p1, "interval"    # I

    .prologue
    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Lcom/lge/wfds/WfdsService$Scanner;->hasMessages(I)Z

    move-result v0

    if-nez v0, :cond_0

    int-to-long v0, p1

    invoke-virtual {p0, v2, v0, v1}, Lcom/lge/wfds/WfdsService$Scanner;->sendEmptyMessageDelayed(IJ)Z

    :cond_0
    return-void
.end method
