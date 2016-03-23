.class public Lcom/lge/os/LGNetworkManager;
.super Ljava/lang/Object;
.source "LGNetworkManager.java"


# instance fields
.field private mNetworkManagementServiceProxy:Lcom/lge/internal/telephony/NetworkManagementServiceProxy;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;

    invoke-direct {v0}, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;-><init>()V

    iput-object v0, p0, Lcom/lge/os/LGNetworkManager;->mNetworkManagementServiceProxy:Lcom/lge/internal/telephony/NetworkManagementServiceProxy;

    return-void
.end method


# virtual methods
.method public registerObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V
    .locals 1
    .param p1, "observer"    # Landroid/net/INetworkManagementEventObserverEx;

    .prologue
    iget-object v0, p0, Lcom/lge/os/LGNetworkManager;->mNetworkManagementServiceProxy:Lcom/lge/internal/telephony/NetworkManagementServiceProxy;

    invoke-virtual {v0, p1}, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->registerObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V

    return-void
.end method

.method public runSetPortRedirectRule(Ljava/lang/String;I)V
    .locals 0
    .param p1, "iptablescmd"    # Ljava/lang/String;
    .param p2, "addORdel"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    return-void
.end method

.method public runShellCommand(Ljava/lang/String;)V
    .locals 1
    .param p1, "cmd"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/os/LGNetworkManager;->mNetworkManagementServiceProxy:Lcom/lge/internal/telephony/NetworkManagementServiceProxy;

    invoke-virtual {v0, p1}, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->runShellCommand(Ljava/lang/String;)V

    return-void
.end method

.method public setMdmIptables(Ljava/lang/String;)V
    .locals 1
    .param p1, "command"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/os/LGNetworkManager;->mNetworkManagementServiceProxy:Lcom/lge/internal/telephony/NetworkManagementServiceProxy;

    invoke-virtual {v0, p1}, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptables(Ljava/lang/String;)V

    return-void
.end method

.method public unregisterObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V
    .locals 1
    .param p1, "observer"    # Landroid/net/INetworkManagementEventObserverEx;

    .prologue
    iget-object v0, p0, Lcom/lge/os/LGNetworkManager;->mNetworkManagementServiceProxy:Lcom/lge/internal/telephony/NetworkManagementServiceProxy;

    invoke-virtual {v0, p1}, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->unregisterObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V

    return-void
.end method
