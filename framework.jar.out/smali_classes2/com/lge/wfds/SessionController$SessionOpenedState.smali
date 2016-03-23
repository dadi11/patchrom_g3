.class Lcom/lge/wfds/SessionController$SessionOpenedState;
.super Lcom/android/internal/util/State;
.source "SessionController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/SessionController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SessionOpenedState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wfds/SessionController;


# direct methods
.method constructor <init>(Lcom/lge/wfds/SessionController;)V
    .locals 0

    .prologue
    .line 771
    iput-object p1, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method private sendPortStatus(Lcom/lge/wfds/session/AspSession;I)V
    .locals 8
    .param p1, "session"    # Lcom/lge/wfds/session/AspSession;
    .param p2, "status"    # I

    .prologue
    .line 926
    if-eqz p1, :cond_0

    iget-object v0, p1, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;
    invoke-static {v0}, Lcom/lge/wfds/SessionController;->access$4000(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/WfdsEvent;

    move-result-object v0

    if-nez v0, :cond_1

    .line 938
    :cond_0
    :goto_0
    return-void

    .line 930
    :cond_1
    iget v2, p1, Lcom/lge/wfds/session/AspSession;->session_id:I

    .line 931
    .local v2, "sessionId":I
    iget-object v1, p1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    .line 932
    .local v1, "sessionMac":Ljava/lang/String;
    iget-object v3, p1, Lcom/lge/wfds/session/AspSession;->ip_address:Ljava/lang/String;

    .line 933
    .local v3, "ip":Ljava/lang/String;
    iget-object v0, p1, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    const/4 v6, 0x0

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/wfds/session/AspServicePort;

    .line 934
    .local v7, "port_":Lcom/lge/wfds/session/AspServicePort;
    iget v4, v7, Lcom/lge/wfds/session/AspServicePort;->port:I

    .line 935
    .local v4, "port":I
    iget v5, v7, Lcom/lge/wfds/session/AspServicePort;->proto:I

    .line 937
    .local v5, "proto":I
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;
    invoke-static {v0}, Lcom/lge/wfds/SessionController;->access$4000(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/WfdsEvent;

    move-result-object v0

    move v6, p2

    invoke-virtual/range {v0 .. v6}, Lcom/lge/wfds/WfdsEvent;->notifyPortStatusToService(Ljava/lang/String;ILjava/lang/String;III)V

    goto :goto_0
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    .line 774
    const-string v0, "WfdsSession:Controller"

    const-string v1, "STATE : SessionOpenedState - enter"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 776
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    const/4 v1, 0x0

    # setter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v0, v1}, Lcom/lge/wfds/SessionController;->access$302(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;)Lcom/lge/wfds/session/AspSession;

    .line 778
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->stopSessionReadyTimeouts()V
    invoke-static {v0}, Lcom/lge/wfds/SessionController;->access$400(Lcom/lge/wfds/SessionController;)V

    .line 780
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    const v1, 0x90105b

    # invokes: Lcom/lge/wfds/SessionController;->removeMessages(I)V
    invoke-static {v0, v1}, Lcom/lge/wfds/SessionController;->access$5200(Lcom/lge/wfds/SessionController;I)V

    .line 782
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->printSessionListInfo()V
    invoke-static {v0}, Lcom/lge/wfds/SessionController;->access$800(Lcom/lge/wfds/SessionController;)V

    .line 783
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 942
    const-string v0, "WfdsSession:Controller"

    const-string v1, "STATE : SessionOpenedState - exit"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 943
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 9
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const v8, 0x900020

    const/4 v3, 0x1

    const/4 v6, 0x0

    const/4 v7, 0x3

    const/4 v2, 0x0

    .line 787
    const/4 v1, 0x0

    .line 789
    .local v1, "session":Lcom/lge/wfds/session/AspSession;
    iget v4, p1, Landroid/os/Message;->what:I

    sparse-switch v4, :sswitch_data_0

    .line 922
    :goto_0
    return v2

    .line 792
    :sswitch_0
    const-string v4, "WfdsSession:Controller"

    const-string v5, "REMOVE_SESSION"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 793
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    const-class v5, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 794
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v6}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    .end local v1    # "session":Lcom/lge/wfds/session/AspSession;
    check-cast v1, Lcom/lge/wfds/session/AspSession;

    .line 795
    .restart local v1    # "session":Lcom/lge/wfds/session/AspSession;
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->startAspSessionRequest(ILcom/lge/wfds/session/AspSession;)Z
    invoke-static {v4, v7, v1}, Lcom/lge/wfds/SessionController;->access$1800(Lcom/lge/wfds/SessionController;ILcom/lge/wfds/session/AspSession;)Z

    move-result v4

    if-ne v4, v3, :cond_0

    .line 796
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    # invokes: Lcom/lge/wfds/SessionController;->removePortIsolation(Ljava/lang/String;Ljava/lang/Integer;)V
    invoke-static {v4, v5, v6}, Lcom/lge/wfds/SessionController;->access$1900(Lcom/lge/wfds/SessionController;Ljava/lang/String;Ljava/lang/Integer;)V

    .line 799
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v4

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-virtual {v4, v5, v6, v7}, Lcom/lge/wfds/session/AspSessionList;->setSessionState(Ljava/lang/String;II)V

    .line 801
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->sendSessionStatus(Lcom/lge/wfds/session/AspSession;II)V
    invoke-static {v4, v1, v7, v2}, Lcom/lge/wfds/SessionController;->access$2000(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;II)V

    .line 805
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->printSessionListInfo()V
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$800(Lcom/lge/wfds/SessionController;)V

    .line 807
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    invoke-virtual {v2}, Lcom/lge/wfds/SessionController;->hasOpenedSession()Z

    move-result v2

    if-nez v2, :cond_0

    .line 808
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$2100(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionReadyState;

    move-result-object v4

    # invokes: Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v2, v4}, Lcom/lge/wfds/SessionController;->access$5300(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V

    .line 811
    :cond_0
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v2, p1, v8}, Lcom/lge/wfds/SessionController;->access$100(Lcom/lge/wfds/SessionController;Landroid/os/Message;I)V

    :cond_1
    :goto_1
    move v2, v3

    .line 922
    goto :goto_0

    .line 815
    :sswitch_1
    const-string v4, "WfdsSession:Controller"

    const-string v5, "BOUND_PORT"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 816
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    const-class v5, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 817
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v6}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    .end local v1    # "session":Lcom/lge/wfds/session/AspSession;
    check-cast v1, Lcom/lge/wfds/session/AspSession;

    .line 818
    .restart local v1    # "session":Lcom/lge/wfds/session/AspSession;
    if-eqz v1, :cond_4

    .line 819
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v4

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v4

    if-eqz v4, :cond_3

    iget-object v4, v1, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    if-eqz v4, :cond_3

    .line 821
    iget-object v4, v1, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/AspServicePort;

    .line 822
    .local v0, "servicePort":Lcom/lge/wfds/session/AspServicePort;
    const-string v4, "WfdsSession:Controller"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "BOUND_PORT [Port:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v0, Lcom/lge/wfds/session/AspServicePort;->port:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", proto:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v0, Lcom/lge/wfds/session/AspServicePort;->proto:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 825
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v4

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v4, v5, v6, v0}, Lcom/lge/wfds/session/AspSessionList;->addSessionPort(Ljava/lang/String;Ljava/lang/Integer;Lcom/lge/wfds/session/AspServicePort;)Z

    .line 827
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$600(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/PortIsolation;

    move-result-object v4

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v4, v5, v6, v0}, Lcom/lge/wfds/session/PortIsolation;->addPort(Ljava/lang/String;Ljava/lang/Integer;Lcom/lge/wfds/session/AspServicePort;)Z

    .line 829
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    const/4 v5, 0x4

    # invokes: Lcom/lge/wfds/SessionController;->startAspSessionRequest(ILcom/lge/wfds/session/AspSession;)Z
    invoke-static {v4, v5, v1}, Lcom/lge/wfds/SessionController;->access$1800(Lcom/lge/wfds/SessionController;ILcom/lge/wfds/session/AspSession;)Z

    move-result v4

    if-ne v4, v3, :cond_2

    .line 830
    invoke-direct {p0, v1, v2}, Lcom/lge/wfds/SessionController$SessionOpenedState;->sendPortStatus(Lcom/lge/wfds/session/AspSession;I)V

    .line 833
    :cond_2
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v2, p1, v8}, Lcom/lge/wfds/SessionController;->access$100(Lcom/lge/wfds/SessionController;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 835
    .end local v0    # "servicePort":Lcom/lge/wfds/session/AspServicePort;
    :cond_3
    const-string v2, "WfdsSession:Controller"

    const-string v4, "BOUNT_PORT fail : ports is null"

    invoke-static {v2, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 836
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    const v4, 0x90001f

    # invokes: Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v2, p1, v4}, Lcom/lge/wfds/SessionController;->access$100(Lcom/lge/wfds/SessionController;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 839
    :cond_4
    const-string v2, "WfdsSession:Controller"

    const-string v4, "BOUNT_PORT fail : AspSession is null"

    invoke-static {v2, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 840
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    const v4, 0x90001f

    # invokes: Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v2, p1, v4}, Lcom/lge/wfds/SessionController;->access$100(Lcom/lge/wfds/SessionController;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 846
    :sswitch_2
    const-string v4, "WfdsSession:Controller"

    const-string v5, "RELEASE_PORT"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 847
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    const-class v5, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 848
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v6}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    .end local v1    # "session":Lcom/lge/wfds/session/AspSession;
    check-cast v1, Lcom/lge/wfds/session/AspSession;

    .line 850
    .restart local v1    # "session":Lcom/lge/wfds/session/AspSession;
    if-eqz v1, :cond_1

    .line 851
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v4

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, v1, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    if-eqz v4, :cond_1

    .line 854
    iget-object v4, v1, Lcom/lge/wfds/session/AspSession;->ports:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/AspServicePort;

    .line 855
    .restart local v0    # "servicePort":Lcom/lge/wfds/session/AspServicePort;
    const-string v2, "WfdsSession:Controller"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "RELEASE_PORT [Port:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, v0, Lcom/lge/wfds/session/AspServicePort;->port:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", proto:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, v0, Lcom/lge/wfds/session/AspServicePort;->proto:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 857
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$600(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/PortIsolation;

    move-result-object v2

    iget-object v4, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v5, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v2, v4, v5, v0}, Lcom/lge/wfds/session/PortIsolation;->removePort(Ljava/lang/String;Ljava/lang/Integer;Lcom/lge/wfds/session/AspServicePort;)V

    .line 861
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v2, p1, v8}, Lcom/lge/wfds/SessionController;->access$100(Lcom/lge/wfds/SessionController;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 868
    .end local v0    # "servicePort":Lcom/lge/wfds/session/AspServicePort;
    :sswitch_3
    const-string v4, "WfdsSession:Controller"

    const-string v5, "REMOVE_SESSION_RECEIVED"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 869
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    const-class v5, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v5}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 870
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v4

    invoke-virtual {v4, v6}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    .end local v1    # "session":Lcom/lge/wfds/session/AspSession;
    check-cast v1, Lcom/lge/wfds/session/AspSession;

    .line 873
    .restart local v1    # "session":Lcom/lge/wfds/session/AspSession;
    if-eqz v1, :cond_1

    .line 874
    const-string v4, "WfdsSession:Controller"

    iget-object v5, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->sessionToString(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;
    invoke-static {v5, v1}, Lcom/lge/wfds/SessionController;->access$2900(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 876
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    # invokes: Lcom/lge/wfds/SessionController;->removePortIsolation(Ljava/lang/String;Ljava/lang/Integer;)V
    invoke-static {v4, v5, v6}, Lcom/lge/wfds/SessionController;->access$1900(Lcom/lge/wfds/SessionController;Ljava/lang/String;Ljava/lang/Integer;)V

    .line 879
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v4

    iget-object v5, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget v6, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-virtual {v4, v5, v6, v7}, Lcom/lge/wfds/session/AspSessionList;->setSessionState(Ljava/lang/String;II)V

    .line 881
    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->sendSessionStatus(Lcom/lge/wfds/session/AspSession;II)V
    invoke-static {v4, v1, v7, v2}, Lcom/lge/wfds/SessionController;->access$2000(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;II)V

    .line 885
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->printSessionListInfo()V
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$800(Lcom/lge/wfds/SessionController;)V

    .line 887
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    invoke-virtual {v2}, Lcom/lge/wfds/SessionController;->hasOpenedSession()Z

    move-result v2

    if-nez v2, :cond_1

    .line 888
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionReadyState:Lcom/lge/wfds/SessionController$SessionReadyState;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$2100(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/SessionController$SessionReadyState;

    move-result-object v4

    # invokes: Lcom/lge/wfds/SessionController;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v2, v4}, Lcom/lge/wfds/SessionController;->access$5400(Lcom/lge/wfds/SessionController;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 894
    :sswitch_4
    const-string v2, "WfdsSession:Controller"

    const-string v4, "ALLOWED_PORT_RECEIVED"

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 895
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const-class v4, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {v4}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 896
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v2, v6}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    .end local v1    # "session":Lcom/lge/wfds/session/AspSession;
    check-cast v1, Lcom/lge/wfds/session/AspSession;

    .line 898
    .restart local v1    # "session":Lcom/lge/wfds/session/AspSession;
    if-eqz v1, :cond_1

    .line 899
    const-string v2, "WfdsSession:Controller"

    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpenedState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->sessionToString(Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;
    invoke-static {v4, v1}, Lcom/lge/wfds/SessionController;->access$2900(Lcom/lge/wfds/SessionController;Lcom/lge/wfds/session/AspSession;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 906
    invoke-direct {p0, v1, v7}, Lcom/lge/wfds/SessionController$SessionOpenedState;->sendPortStatus(Lcom/lge/wfds/session/AspSession;I)V

    goto/16 :goto_1

    .line 789
    nop

    :sswitch_data_0
    .sparse-switch
        0x900007 -> :sswitch_0
        0x900008 -> :sswitch_1
        0x900009 -> :sswitch_2
        0x901060 -> :sswitch_3
        0x901061 -> :sswitch_4
    .end sparse-switch
.end method
