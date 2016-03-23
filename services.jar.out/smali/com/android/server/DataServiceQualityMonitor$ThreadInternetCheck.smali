.class public Lcom/android/server/DataServiceQualityMonitor$ThreadInternetCheck;
.super Ljava/lang/Thread;
.source "DataServiceQualityMonitor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/DataServiceQualityMonitor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "ThreadInternetCheck"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/DataServiceQualityMonitor;


# direct methods
.method public constructor <init>(Lcom/android/server/DataServiceQualityMonitor;)V
    .locals 0

    .prologue
    .line 899
    iput-object p1, p0, Lcom/android/server/DataServiceQualityMonitor$ThreadInternetCheck;->this$0:Lcom/android/server/DataServiceQualityMonitor;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 901
    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v3, 0x1

    .line 905
    sget-boolean v2, Lcom/android/server/DataServiceQualityMonitor;->mInternetcheckProgress:Z

    if-ne v2, v3, :cond_0

    .line 906
    const-string v2, "internetcheck is progress"

    # invokes: Lcom/android/server/DataServiceQualityMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/server/DataServiceQualityMonitor;->access$000(Ljava/lang/String;)V

    .line 929
    :goto_0
    return-void

    .line 909
    :cond_0
    sput-boolean v3, Lcom/android/server/DataServiceQualityMonitor;->mInternetcheckProgress:Z

    .line 910
    new-instance v0, Lcom/android/server/DataServiceQualityMonitor$ThreadTCPConnectionCheck;

    iget-object v2, p0, Lcom/android/server/DataServiceQualityMonitor$ThreadInternetCheck;->this$0:Lcom/android/server/DataServiceQualityMonitor;

    invoke-direct {v0, v2}, Lcom/android/server/DataServiceQualityMonitor$ThreadTCPConnectionCheck;-><init>(Lcom/android/server/DataServiceQualityMonitor;)V

    .line 911
    .local v0, "checkthread":Lcom/android/server/DataServiceQualityMonitor$ThreadTCPConnectionCheck;
    invoke-virtual {v0}, Lcom/android/server/DataServiceQualityMonitor$ThreadTCPConnectionCheck;->start()V

    .line 913
    const-wide/16 v2, 0xfa0

    :try_start_0
    invoke-virtual {v0, v2, v3}, Lcom/android/server/DataServiceQualityMonitor$ThreadTCPConnectionCheck;->join(J)V

    .line 914
    invoke-virtual {v0}, Lcom/android/server/DataServiceQualityMonitor$ThreadTCPConnectionCheck;->getCheckResult()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 915
    const-string v2, "ThreadInternetCheck internet check OK "

    # invokes: Lcom/android/server/DataServiceQualityMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/server/DataServiceQualityMonitor;->access$000(Ljava/lang/String;)V

    .line 924
    :goto_1
    iget-object v2, p0, Lcom/android/server/DataServiceQualityMonitor$ThreadInternetCheck;->this$0:Lcom/android/server/DataServiceQualityMonitor;

    iget-object v3, p0, Lcom/android/server/DataServiceQualityMonitor$ThreadInternetCheck;->this$0:Lcom/android/server/DataServiceQualityMonitor;

    const/16 v4, 0x13c3

    invoke-virtual {v3, v4}, Lcom/android/server/DataServiceQualityMonitor;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    const-wide/16 v4, 0x3e8

    invoke-virtual {v2, v3, v4, v5}, Lcom/android/server/DataServiceQualityMonitor;->sendMessageDelayed(Landroid/os/Message;J)Z
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 926
    :catch_0
    move-exception v1

    .line 927
    .local v1, "e":Ljava/lang/InterruptedException;
    const-string v2, "checkthread.join interrupted"

    # invokes: Lcom/android/server/DataServiceQualityMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/server/DataServiceQualityMonitor;->access$000(Ljava/lang/String;)V

    goto :goto_0

    .line 917
    .end local v1    # "e":Ljava/lang/InterruptedException;
    :cond_1
    :try_start_1
    const-string v2, "ThreadInternetCheck internet check NOK "

    # invokes: Lcom/android/server/DataServiceQualityMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/server/DataServiceQualityMonitor;->access$000(Ljava/lang/String;)V

    .line 918
    sget-boolean v2, Lcom/android/server/DataServiceQualityMonitor;->mInternetcheckProgress:Z

    if-nez v2, :cond_2

    .line 919
    const-string v2, "InternetcheckProgress is not set don\'t send DS quality intent"

    # invokes: Lcom/android/server/DataServiceQualityMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2}, Lcom/android/server/DataServiceQualityMonitor;->access$000(Ljava/lang/String;)V

    goto :goto_1

    .line 921
    :cond_2
    iget-object v2, p0, Lcom/android/server/DataServiceQualityMonitor$ThreadInternetCheck;->this$0:Lcom/android/server/DataServiceQualityMonitor;

    const/4 v3, 0x0

    # invokes: Lcom/android/server/DataServiceQualityMonitor;->sendDSqualityIntent(I)V
    invoke-static {v2, v3}, Lcom/android/server/DataServiceQualityMonitor;->access$200(Lcom/android/server/DataServiceQualityMonitor;I)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method
