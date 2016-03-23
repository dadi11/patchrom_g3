.class Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;
.super Ljava/lang/Object;
.source "NetworkMonitor.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/connectivity/NetworkMonitor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DNSResolver"
.end annotation


# instance fields
.field private domain:Ljava/lang/String;

.field private inetAddr:Ljava/net/InetAddress;

.field private final mNetworkAgentInfo:Lcom/android/server/connectivity/NetworkAgentInfo;

.field final synthetic this$0:Lcom/android/server/connectivity/NetworkMonitor;


# direct methods
.method public constructor <init>(Lcom/android/server/connectivity/NetworkMonitor;Ljava/lang/String;Lcom/android/server/connectivity/NetworkAgentInfo;)V
    .locals 0
    .param p2, "domain"    # Ljava/lang/String;
    .param p3, "nai"    # Lcom/android/server/connectivity/NetworkAgentInfo;

    .prologue
    iput-object p1, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->this$0:Lcom/android/server/connectivity/NetworkMonitor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->domain:Ljava/lang/String;

    iput-object p3, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->mNetworkAgentInfo:Lcom/android/server/connectivity/NetworkAgentInfo;

    return-void
.end method


# virtual methods
.method public declared-synchronized get()Ljava/net/InetAddress;
    .locals 1

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->inetAddr:Ljava/net/InetAddress;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public run()V
    .locals 5

    .prologue
    :try_start_0
    iget-object v2, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->this$0:Lcom/android/server/connectivity/NetworkMonitor;

    const-string v3, "[ELGLWD] DNSResolver start dns"

    # invokes: Lcom/android/server/connectivity/NetworkMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2, v3}, Lcom/android/server/connectivity/NetworkMonitor;->access$7600(Lcom/android/server/connectivity/NetworkMonitor;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->mNetworkAgentInfo:Lcom/android/server/connectivity/NetworkAgentInfo;

    iget-object v2, v2, Lcom/android/server/connectivity/NetworkAgentInfo;->network:Landroid/net/Network;

    iget-object v3, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->domain:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/net/Network;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    .local v0, "addr":Ljava/net/InetAddress;
    invoke-virtual {p0, v0}, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->set(Ljava/net/InetAddress;)V

    iget-object v2, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->this$0:Lcom/android/server/connectivity/NetworkMonitor;

    const-string v3, "[ELGLWD] DNSResolver end dns"

    # invokes: Lcom/android/server/connectivity/NetworkMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2, v3}, Lcom/android/server/connectivity/NetworkMonitor;->access$7700(Lcom/android/server/connectivity/NetworkMonitor;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "addr":Ljava/net/InetAddress;
    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/net/UnknownHostException;
    iget-object v2, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->this$0:Lcom/android/server/connectivity/NetworkMonitor;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[ELGLWD] DNSResolver UnknownHostException ignore this : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    # invokes: Lcom/android/server/connectivity/NetworkMonitor;->log(Ljava/lang/String;)V
    invoke-static {v2, v3}, Lcom/android/server/connectivity/NetworkMonitor;->access$7800(Lcom/android/server/connectivity/NetworkMonitor;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public declared-synchronized set(Ljava/net/InetAddress;)V
    .locals 1
    .param p1, "inetAddr"    # Ljava/net/InetAddress;

    .prologue
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/android/server/connectivity/NetworkMonitor$DNSResolver;->inetAddr:Ljava/net/InetAddress;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
