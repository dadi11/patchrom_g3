.class Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;
.super Landroid/os/Handler;
.source "WfdsManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsManager$Channel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "WfdsHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wfds/WfdsManager$Channel;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsManager$Channel;Landroid/os/Looper;)V
    .locals 0
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    .line 297
    iput-object p1, p0, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;->this$0:Lcom/lge/wfds/WfdsManager$Channel;

    .line 298
    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 299
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 9
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const/4 v8, 0x0

    const/high16 v7, 0x900000

    .line 303
    iget-object v4, p0, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;->this$0:Lcom/lge/wfds/WfdsManager$Channel;

    iget v5, p1, Landroid/os/Message;->arg2:I

    # invokes: Lcom/lge/wfds/WfdsManager$Channel;->getListener(I)Ljava/lang/Object;
    invoke-static {v4, v5}, Lcom/lge/wfds/WfdsManager$Channel;->access$200(Lcom/lge/wfds/WfdsManager$Channel;I)Ljava/lang/Object;

    move-result-object v1

    .line 305
    .local v1, "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->what:I

    sparse-switch v4, :sswitch_data_0

    .line 431
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : Ignored "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 434
    .end local v1    # "listener":Ljava/lang/Object;
    :cond_0
    :goto_0
    return-void

    .line 310
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_0
    iget-object v4, p0, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;->this$0:Lcom/lge/wfds/WfdsManager$Channel;

    # getter for: Lcom/lge/wfds/WfdsManager$Channel;->mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;
    invoke-static {v4}, Lcom/lge/wfds/WfdsManager$Channel;->access$300(Lcom/lge/wfds/WfdsManager$Channel;)Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    move-result-object v4

    if-eqz v4, :cond_0

    .line 311
    iget-object v4, p0, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;->this$0:Lcom/lge/wfds/WfdsManager$Channel;

    # getter for: Lcom/lge/wfds/WfdsManager$Channel;->mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;
    invoke-static {v4}, Lcom/lge/wfds/WfdsManager$Channel;->access$300(Lcom/lge/wfds/WfdsManager$Channel;)Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    move-result-object v4

    invoke-interface {v4}, Lcom/lge/wfds/WfdsManager$WfdsChannelListener;->onChannelDisconnected()V

    .line 312
    iget-object v4, p0, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;->this$0:Lcom/lge/wfds/WfdsManager$Channel;

    # setter for: Lcom/lge/wfds/WfdsManager$Channel;->mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;
    invoke-static {v4, v8}, Lcom/lge/wfds/WfdsManager$Channel;->access$302(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsChannelListener;)Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    goto :goto_0

    .line 320
    :sswitch_1
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsActionListener.onSuccess for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    if-eqz v1, :cond_0

    .line 323
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .end local v1    # "listener":Ljava/lang/Object;
    invoke-interface {v1}, Lcom/lge/wfds/WfdsManager$WfdsActionListener;->onSuccess()V

    goto :goto_0

    .line 331
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_2
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsActionListener.onFailure for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 333
    if-eqz v1, :cond_0

    .line 334
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsActionListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4}, Lcom/lge/wfds/WfdsManager$WfdsActionListener;->onFailure(I)V

    goto :goto_0

    .line 342
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_3
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsIntListener.onSuccess for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 344
    if-eqz v1, :cond_0

    .line 345
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4}, Lcom/lge/wfds/WfdsManager$WfdsIntListener;->onSuccess(I)V

    goto/16 :goto_0

    .line 353
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_4
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsIntListener.onFailure for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 355
    if-eqz v1, :cond_0

    .line 356
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsIntListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4}, Lcom/lge/wfds/WfdsManager$WfdsIntListener;->onFailure(I)V

    goto/16 :goto_0

    .line 364
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_5
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsStrListener.onSuccess for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 366
    if-eqz v1, :cond_0

    .line 367
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v8, v8}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 368
    .local v3, "sValue":Ljava/lang/String;
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsStrListener;

    .end local v1    # "listener":Ljava/lang/Object;
    invoke-interface {v1, v3}, Lcom/lge/wfds/WfdsManager$WfdsStrListener;->onSuccess(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 376
    .end local v3    # "sValue":Ljava/lang/String;
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_6
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsStrListener.onFailure for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 378
    if-eqz v1, :cond_0

    .line 379
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsStrListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4}, Lcom/lge/wfds/WfdsManager$WfdsStrListener;->onFailure(I)V

    goto/16 :goto_0

    .line 387
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_7
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsIntStrListener.onSuccess for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 389
    if-eqz v1, :cond_0

    .line 390
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v8, v8}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 391
    .local v2, "mac":Ljava/lang/String;
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsIntStrListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4, v2}, Lcom/lge/wfds/WfdsManager$WfdsIntStrListener;->onSuccess(ILjava/lang/String;)V

    goto/16 :goto_0

    .line 399
    .end local v2    # "mac":Ljava/lang/String;
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_8
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsIntStrListener.onFailure for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 401
    if-eqz v1, :cond_0

    .line 402
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsIntStrListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4}, Lcom/lge/wfds/WfdsManager$WfdsIntStrListener;->onFailure(I)V

    goto/16 :goto_0

    .line 410
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_9
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsAspSessionListener.onSuccess for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 412
    if-eqz v1, :cond_0

    .line 413
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    const-class v5, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 414
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v8}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/AspSession;

    .line 415
    .local v0, "aspSession":Lcom/lge/wfds/session/AspSession;
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsAspSessionListener;

    .end local v1    # "listener":Ljava/lang/Object;
    invoke-interface {v1, v0}, Lcom/lge/wfds/WfdsManager$WfdsAspSessionListener;->onSuccess(Lcom/lge/wfds/session/AspSession;)V

    goto/16 :goto_0

    .line 423
    .end local v0    # "aspSession":Lcom/lge/wfds/session/AspSession;
    .restart local v1    # "listener":Ljava/lang/Object;
    :sswitch_a
    const-string v4, "WfdsManager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "WfdsHandler : WfdsAspSessionListener.onFailure for ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p1, Landroid/os/Message;->what:I

    sub-int/2addr v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 425
    if-eqz v1, :cond_0

    .line 426
    check-cast v1, Lcom/lge/wfds/WfdsManager$WfdsAspSessionListener;

    .end local v1    # "listener":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-interface {v1, v4}, Lcom/lge/wfds/WfdsManager$WfdsAspSessionListener;->onFailure(I)V

    goto/16 :goto_0

    .line 305
    :sswitch_data_0
    .sparse-switch
        0x11004 -> :sswitch_0
        0x90001f -> :sswitch_2
        0x900020 -> :sswitch_1
        0x900021 -> :sswitch_4
        0x900022 -> :sswitch_3
        0x900023 -> :sswitch_6
        0x900024 -> :sswitch_5
        0x900025 -> :sswitch_8
        0x900026 -> :sswitch_7
        0x900027 -> :sswitch_a
        0x900028 -> :sswitch_9
    .end sparse-switch
.end method
