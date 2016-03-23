.class Lcom/lge/wfds/WfdsService$WfdsStateMachine;
.super Lcom/android/internal/util/StateMachine;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "WfdsStateMachine"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;,
        Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;
    }
.end annotation


# instance fields
.field private mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

.field private mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

.field private mConnectionCompleteState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;

.field private mDefaultState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;

.field private mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

.field private mIpObtainingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;

.field private mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

.field private mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

.field private mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

.field private mWfdsDisabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

.field private mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

.field private mWifiP2pConnectedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;

.field final synthetic this$0:Lcom/lge/wfds/WfdsService;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V
    .locals 2
    .param p2, "name"    # Ljava/lang/String;

    .prologue
    .line 490
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    .line 491
    invoke-direct {p0, p2}, Lcom/android/internal/util/StateMachine;-><init>(Ljava/lang/String;)V

    .line 477
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mDefaultState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;

    .line 478
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsDisabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

    .line 479
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    .line 480
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWifiP2pConnectedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;

    .line 481
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    .line 482
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    .line 483
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    .line 484
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    .line 485
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    .line 486
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mIpObtainingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;

    .line 487
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    .line 488
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;

    invoke-direct {v0, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectionCompleteState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;

    .line 493
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mDefaultState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;

    invoke-virtual {p0, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;)V

    .line 494
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsDisabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mDefaultState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 495
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mDefaultState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$DefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 496
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWifiP2pConnectedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 497
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 498
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 499
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 500
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 501
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 502
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mIpObtainingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 503
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 504
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectionCompleteState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mGroupExistedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;

    invoke-virtual {p0, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    .line 505
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsDisabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

    invoke-virtual {p0, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setInitialState(Lcom/android/internal/util/State;)V

    .line 506
    return-void
.end method

.method static synthetic access$10000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscTimeout()V

    return-void
.end method

.method static synthetic access$10100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$10200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->dismissAllDialog()V

    return-void
.end method

.method static synthetic access$10300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$10400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->procPeerConnUserAccept(Landroid/os/Message;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$10500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$10600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->procPeerConnUserReject()V

    return-void
.end method

.method static synthetic access$10700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$10800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$10900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mIpObtainingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;

    return-object v0
.end method

.method static synthetic access$11600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$11800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->cancelConnect()V

    return-void
.end method

.method static synthetic access$11900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$12100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDefaultPinWithinGroup()V

    return-void
.end method

.method static synthetic access$12200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    return-object v0
.end method

.method static synthetic access$12300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$12400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$12500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$12700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$12800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$13000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->deletePersistentGroup(I)V

    return-void
.end method

.method static synthetic access$13100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$13300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectionCompleteState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectionCompleteState;

    return-object v0
.end method

.method static synthetic access$13400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$13500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$13600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$13700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$13800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$13900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$14000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$14100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)Ljava/net/InetAddress;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->getIpAddrOfClient(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$14200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$14300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$14400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$14500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$14600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I
    .param p3, "x3"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    return-void
.end method

.method static synthetic access$2200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;ILjava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I
    .param p3, "x3"    # Ljava/lang/String;

    .prologue
    .line 476
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;ILjava/lang/String;)V

    return-void
.end method

.method static synthetic access$2600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    return-object v0
.end method

.method static synthetic access$3400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsDisabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

    return-object v0
.end method

.method static synthetic access$4100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p3, "x3"    # Z

    .prologue
    .line 476
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->enableAdvertiseService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V

    return-void
.end method

.method static synthetic access$4600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->cancelAdvertiseService(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$4700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;ILcom/lge/wfds/WfdsDiscoveryMethod;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I
    .param p3, "x3"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p4, "x4"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->changeServiceStatus(Landroid/os/Message;ILcom/lge/wfds/WfdsDiscoveryMethod;I)V

    return-void
.end method

.method static synthetic access$4800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p3, "x3"    # Z

    .prologue
    .line 476
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->enableSeekService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V

    return-void
.end method

.method static synthetic access$4900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->cancelSeekService(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$5000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # Lcom/lge/wfds/WfdsPdMethod;
    .param p3, "x3"    # Z

    .prologue
    .line 476
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->connectSession(Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    return-object v0
.end method

.method static synthetic access$5200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDefaultPin(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$5800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    return-object v0
.end method

.method static synthetic access$5900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    return-object v0
.end method

.method static synthetic access$6100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;Z)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Z

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDisplay(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method static synthetic access$6400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    return-object v0
.end method

.method static synthetic access$6700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscFailure(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$7200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processPersistentUnknown(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$7300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processP2pGroupFormationFailure()V

    return-void
.end method

.method static synthetic access$7400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWifiP2pConnectedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;

    return-object v0
.end method

.method static synthetic access$7600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setConnectCapa(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$7800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    .line 476
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->getConnectCapa(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$7900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setConfigMethod(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$8000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;
    .param p2, "x2"    # I

    .prologue
    .line 476
    invoke-direct {p0, p1, p2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setListenChannelForTest(Landroid/os/Message;I)V

    return-void
.end method

.method static synthetic access$8200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$8300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$8400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$8500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    .prologue
    .line 476
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->removeGroup()V

    return-void
.end method

.method static synthetic access$8600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$8700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/net/wifi/p2p/WifiP2pConfigEx;Ljava/lang/String;IILjava/lang/String;I)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Landroid/net/wifi/p2p/WifiP2pConfigEx;
    .param p2, "x2"    # Ljava/lang/String;
    .param p3, "x3"    # I
    .param p4, "x4"    # I
    .param p5, "x5"    # Ljava/lang/String;
    .param p6, "x6"    # I

    .prologue
    .line 476
    invoke-direct/range {p0 .. p6}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->requestP2pConnection(Landroid/net/wifi/p2p/WifiP2pConfigEx;Ljava/lang/String;IILjava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method static synthetic access$8900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$9100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$9200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$9300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$9500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$9700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$9900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsService$WfdsStateMachine;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 476
    invoke-virtual {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method private attachIgnoreAtEventString(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 2710
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ignore"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private cancelAdvertiseService(Landroid/os/Message;I)V
    .locals 5
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "id"    # I

    .prologue
    const/4 v4, 0x0

    .line 2058
    const-string v1, "0x%08x"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 2059
    .local v0, "strId":Ljava/lang/String;
    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Receive the CANCEL_ADVERTISE Method: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2061
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2062
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 2063
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 2066
    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v1

    invoke-virtual {v1, p2}, Lcom/lge/wfds/WfdsDiscoveryStore;->removeAdvertise(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2067
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryStore;->hasAdvertisement()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryStore;->hasSearch()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 2069
    :cond_1
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 2070
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v1

    const/16 v2, 0x1388

    invoke-virtual {v1, v2}, Lcom/lge/wfds/WfdsService$Scanner;->resume(I)V

    .line 2076
    :cond_2
    :goto_0
    const v1, 0x900020

    invoke-direct {p0, p1, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    .line 2077
    return-void

    .line 2073
    :cond_3
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setScanOnlyChannel(I)V
    invoke-static {v1, v4}, Lcom/lge/wfds/WfdsService;->access$2400(Lcom/lge/wfds/WfdsService;I)V

    goto :goto_0
.end method

.method private cancelConnect()V
    .locals 3

    .prologue
    .line 2472
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 2473
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    new-instance v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine$3;

    invoke-direct {v2, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$3;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->cancelConnect(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 2484
    :cond_0
    return-void
.end method

.method private cancelSeekService(Landroid/os/Message;I)V
    .locals 2
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "id"    # I

    .prologue
    .line 2145
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2146
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 2147
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 2150
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/lge/wfds/WfdsDiscoveryStore;->removeSearch(I)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 2151
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryStore;->hasAdvertisement()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryStore;->hasSearch()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 2153
    :cond_1
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 2154
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    const/16 v1, 0x1388

    invoke-virtual {v0, v1}, Lcom/lge/wfds/WfdsService$Scanner;->resume(I)V

    .line 2160
    :cond_2
    :goto_0
    const v0, 0x900020

    invoke-direct {p0, p1, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    .line 2161
    return-void

    .line 2157
    :cond_3
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v1, 0x0

    # invokes: Lcom/lge/wfds/WfdsService;->setScanOnlyChannel(I)V
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$2400(Lcom/lge/wfds/WfdsService;I)V

    goto :goto_0
.end method

.method private changeServiceStatus(Landroid/os/Message;ILcom/lge/wfds/WfdsDiscoveryMethod;I)V
    .locals 2
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "id"    # I
    .param p3, "method"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p4, "forcedChannel"    # I

    .prologue
    .line 2081
    if-nez p3, :cond_0

    .line 2082
    const-string v0, "WfdsService"

    const-string v1, "SERVICE_STATUS_CHANGE failed because method is null"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2095
    :goto_0
    return-void

    .line 2086
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 2087
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v0

    iget-object v1, p3, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->getServiceStatus()I

    move-result v1

    invoke-virtual {v0, p2, v1, p4}, Lcom/lge/wfds/WfdsDiscoveryStore;->changeServiceStatus(III)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2089
    const v0, 0x900020

    invoke-direct {p0, p1, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    .line 2094
    :goto_1
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    const/16 v1, 0x1388

    invoke-virtual {v0, v1}, Lcom/lge/wfds/WfdsService$Scanner;->resume(I)V

    goto :goto_0

    .line 2091
    :cond_1
    const v0, 0x90001f

    const/4 v1, 0x2

    invoke-direct {p0, p1, v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    goto :goto_1
.end method

.method private connectSession(Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z
    .locals 10
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "pdMethod"    # Lcom/lge/wfds/WfdsPdMethod;
    .param p3, "isConnectedState"    # Z

    .prologue
    .line 2384
    if-nez p2, :cond_0

    .line 2385
    const/4 v0, 0x0

    .line 2468
    :goto_0
    return v0

    .line 2390
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v1

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getPeerAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v1

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    .line 2392
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    if-nez v0, :cond_2

    .line 2393
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 2396
    :cond_2
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getAdvertiseId()I

    move-result v1

    iput v1, v0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    .line 2397
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getSessionInfo()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    .line 2398
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getGoRole()I

    move-result v1

    iput v1, v0, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    .line 2402
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v0, Lcom/lge/wfds/session/AspSession;

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getPeerAddress()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3800(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, -0x1

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getAdvertiseId()I

    move-result v4

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getSessionInfo()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getNetworkConfig()I

    move-result v6

    invoke-direct/range {v0 .. v6}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;I)V

    # setter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v9, v0}, Lcom/lge/wfds/WfdsService;->access$5302(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;)Lcom/lge/wfds/session/AspSession;

    .line 2408
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/session/AspSession;->generateSessionId()I

    .line 2413
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v1, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v1}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 2414
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    iput-object v1, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    .line 2415
    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getNetworkConfig()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->selectWpsConfig(I)I

    move-result v8

    .line 2416
    .local v8, "wpsConfig":I
    const/4 v0, 0x4

    if-ne v8, v0, :cond_3

    .line 2417
    const/4 v0, 0x0

    goto/16 :goto_0

    .line 2419
    :cond_3
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iput v8, v0, Landroid/net/wifi/WpsInfo;->setup:I

    .line 2421
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 2422
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 2425
    :cond_4
    if-nez p3, :cond_5

    .line 2426
    const v0, 0x900026

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    iget v1, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    iget-object v2, v2, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;IILjava/lang/String;)V

    .line 2428
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/lge/wfds/WfdsNative;->setUpdateConfig(Z)Z

    .line 2468
    :goto_1
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 2430
    :cond_5
    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getPeerAddress()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->isPostAssociation(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 2431
    const/4 v7, 0x0

    .line 2432
    .local v7, "ipAddr":Ljava/net/InetAddress;
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 2433
    invoke-virtual {p2}, Lcom/lge/wfds/WfdsPdMethod;->getPeerAddress()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->getIpAddrOfClient(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v7

    .line 2434
    if-eqz v7, :cond_7

    .line 2435
    const-string v0, "WfdsService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GO - Client IP : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v7}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2445
    :goto_2
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    invoke-virtual {v7}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/wfds/session/AspSession;->setIpAddress(Ljava/lang/String;)V

    .line 2447
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v0

    const v1, 0x901047

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/lge/wfds/SessionController;->sendMessage(ILjava/lang/Object;)V

    .line 2464
    .end local v7    # "ipAddr":Ljava/net/InetAddress;
    :cond_6
    const v0, 0x900026

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    iget v1, v1, Lcom/lge/wfds/session/AspSession;->session_id:I

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    iget-object v2, v2, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;IILjava/lang/String;)V

    goto :goto_1

    .line 2437
    .restart local v7    # "ipAddr":Ljava/net/InetAddress;
    :cond_7
    const-string v0, "WfdsService"

    const-string v1, "GO - Client IP : Not Available!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 2438
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->removeGroup()V

    .line 2439
    const/4 v0, 0x0

    goto/16 :goto_0

    .line 2442
    :cond_8
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$000(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pInfo;

    move-result-object v0

    iget-object v7, v0, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    .line 2443
    const-string v0, "WfdsService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Client - GO IP : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v7}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 2449
    .end local v7    # "ipAddr":Ljava/net/InetAddress;
    :cond_9
    const/4 v6, 0x1

    .line 2451
    .local v6, "connectionCapa":I
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v0

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisP2pDevice:Landroid/net/wifi/p2p/WifiP2pDevice;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$600(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v1

    iget-object v1, v1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 2453
    const/4 v6, 0x4

    .line 2456
    :cond_a
    const-string v0, "WfdsService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Connection Capability is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "0x%02x"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2458
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    iget-object v2, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget v3, v0, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    iget v4, v0, Lcom/lge/wfds/session/AspSession;->session_id:I

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget-object v5, v0, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->requestP2pConnection(Landroid/net/wifi/p2p/WifiP2pConfigEx;Ljava/lang/String;IILjava/lang/String;I)Z

    move-result v0

    if-nez v0, :cond_6

    .line 2461
    const/4 v0, 0x0

    goto/16 :goto_0
.end method

.method private deletePersistentGroup(I)V
    .locals 3
    .param p1, "netId"    # I

    .prologue
    .line 2632
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    if-nez v0, :cond_0

    .line 2645
    :goto_0
    return-void

    .line 2635
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    new-instance v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine$5;

    invoke-direct {v2, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$5;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    invoke-virtual {v0, v1, p1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->deletePersistentGroup(Landroid/net/wifi/p2p/WifiP2pManager$Channel;ILandroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    goto :goto_0
.end method

.method private dismissAllDialog()V
    .locals 1

    .prologue
    .line 2269
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDialog;->dismissUserInputDialog()V

    .line 2270
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDialog;->dismissShowPinDialog()V

    .line 2271
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDialog;->dismissEnterPinDialog()V

    .line 2272
    return-void
.end method

.method private enableAdvertiseService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    .locals 6
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "advMethod"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p3, "isConnectedState"    # Z

    .prologue
    const v5, 0x900021

    const/4 v4, 0x2

    .line 2016
    const/4 v0, 0x0

    .line 2017
    .local v0, "channel":I
    if-eqz p2, :cond_0

    iget-object v2, p2, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    if-nez v2, :cond_2

    .line 2018
    :cond_0
    invoke-direct {p0, p1, v5, v4}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    .line 2054
    :cond_1
    :goto_0
    return-void

    .line 2023
    :cond_2
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v2

    if-eqz v2, :cond_6

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/SessionController;->hasOpenedSession()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 2024
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2028
    :goto_1
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    if-eqz v2, :cond_3

    .line 2029
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 2032
    :cond_3
    if-eqz p3, :cond_4

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v2

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v2

    if-nez v2, :cond_4

    .line 2034
    iget-object v2, p2, Lcom/lge/wfds/WfdsDiscoveryMethod;->mAdvertiseMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/lge/wfds/WfdsDiscoveryMethod$AdvertiseMethod;->setServiceStatus(I)V

    .line 2038
    :cond_4
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    if-eqz v2, :cond_7

    .line 2039
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v0

    .line 2043
    :cond_5
    :goto_2
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v2

    invoke-virtual {v2, p2, v0}, Lcom/lge/wfds/WfdsDiscoveryStore;->requestAdvertise(Lcom/lge/wfds/WfdsDiscoveryMethod;I)I

    move-result v1

    .line 2044
    .local v1, "id":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_8

    .line 2045
    const v2, 0x900022

    invoke-direct {p0, p1, v2, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    .line 2046
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 2047
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    const/16 v3, 0x1388

    invoke-virtual {v2, v3}, Lcom/lge/wfds/WfdsService$Scanner;->resume(I)V

    goto :goto_0

    .line 2026
    .end local v1    # "id":I
    :cond_6
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsNative;->p2pFlush()Z

    goto :goto_1

    .line 2040
    :cond_7
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mListenChannelForTest:I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$14700(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    if-eqz v2, :cond_5

    .line 2041
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mListenChannelForTest:I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$14700(Lcom/lge/wfds/WfdsService;)I

    move-result v0

    goto :goto_2

    .line 2050
    .restart local v1    # "id":I
    :cond_8
    invoke-direct {p0, p1, v5, v4}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    goto/16 :goto_0
.end method

.method private enableSeekService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    .locals 5
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "seekMethod"    # Lcom/lge/wfds/WfdsDiscoveryMethod;
    .param p3, "isConnectedState"    # Z

    .prologue
    const/4 v4, 0x2

    const v3, 0x900021

    .line 2100
    const/4 v0, 0x0

    .line 2101
    .local v0, "channel":I
    if-eqz p2, :cond_0

    iget-object v2, p2, Lcom/lge/wfds/WfdsDiscoveryMethod;->mSeekMethod:Lcom/lge/wfds/WfdsDiscoveryMethod$SeekMethod;

    if-nez v2, :cond_2

    .line 2102
    :cond_0
    invoke-direct {p0, p1, v3, v4}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->searchTerminated(Landroid/os/Message;II)V

    .line 2141
    :cond_1
    :goto_0
    return-void

    .line 2108
    :cond_2
    if-eqz p3, :cond_3

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v2

    if-nez v2, :cond_3

    .line 2109
    const/4 v2, 0x6

    invoke-direct {p0, p1, v3, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->searchTerminated(Landroid/os/Message;II)V

    goto :goto_0

    .line 2114
    :cond_3
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    if-eqz v2, :cond_4

    .line 2115
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 2118
    :cond_4
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/SessionController;->hasOpenedSession()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 2119
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2124
    :goto_1
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    if-eqz v2, :cond_6

    .line 2125
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v0

    .line 2131
    :goto_2
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v2

    invoke-virtual {v2, p2, v0}, Lcom/lge/wfds/WfdsDiscoveryStore;->requestSearch(Lcom/lge/wfds/WfdsDiscoveryMethod;I)I

    move-result v1

    .line 2132
    .local v1, "id":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_8

    .line 2133
    const v2, 0x900022

    invoke-direct {p0, p1, v2, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    .line 2134
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 2135
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v2

    const/16 v3, 0x1388

    invoke-virtual {v2, v3}, Lcom/lge/wfds/WfdsService$Scanner;->resume(I)V

    goto :goto_0

    .line 2121
    .end local v1    # "id":I
    :cond_5
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsNative;->p2pFlush()Z

    goto :goto_1

    .line 2126
    :cond_6
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mListenChannelForTest:I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$14700(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    if-eqz v2, :cond_7

    .line 2127
    const/4 v0, 0x0

    goto :goto_2

    .line 2129
    :cond_7
    const/4 v0, 0x6

    goto :goto_2

    .line 2138
    .restart local v1    # "id":I
    :cond_8
    invoke-direct {p0, p1, v3, v4}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    goto/16 :goto_0
.end method

.method private getConnectCapa(Landroid/os/Message;)V
    .locals 3
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    .line 2282
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 2283
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 2284
    const/4 v0, 0x1

    .line 2288
    .local v0, "id":I
    :goto_0
    const v1, 0x900022

    invoke-direct {p0, p1, v1, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    .line 2292
    .end local v0    # "id":I
    :goto_1
    return-void

    .line 2286
    :cond_0
    const/4 v0, 0x0

    .restart local v0    # "id":I
    goto :goto_0

    .line 2290
    .end local v0    # "id":I
    :cond_1
    const v1, 0x900021

    const/4 v2, -0x1

    invoke-direct {p0, p1, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    goto :goto_1
.end method

.method private getIpAddrOfClient(Ljava/lang/String;)Ljava/net/InetAddress;
    .locals 3
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    .line 2714
    const/4 v0, 0x0

    .line 2715
    .local v0, "ipAddr":Ljava/net/InetAddress;
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2717
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v1

    if-nez v1, :cond_0

    .line 2718
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v2

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    .line 2720
    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 2721
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    if-eqz v1, :cond_1

    .line 2722
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mDhcpFileObserver:Lcom/lge/wfds/DhcpFileObserver;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$13200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/DhcpFileObserver;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 2723
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mDhcpFileObserver:Lcom/lge/wfds/DhcpFileObserver;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$13200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/DhcpFileObserver;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v2

    iget-object v2, v2, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget-object v2, v2, Lcom/lge/wfds/WfdsInfo;->mWfdsInterfaceAddress:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/lge/wfds/DhcpFileObserver;->getPeerIpAddress(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    .line 2728
    :cond_1
    return-object v0
.end method

.method private handleProvDiscFailure(Landroid/os/Message;)V
    .locals 4
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    .line 2224
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2225
    new-instance v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-direct {v0, p0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)V

    .line 2226
    .local v0, "wfdsPdFail":Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;
    if-eqz v0, :cond_0

    iget v1, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;->reason:I

    if-gez v1, :cond_1

    .line 2246
    :cond_0
    :goto_0
    return-void

    .line 2229
    :cond_1
    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "WFDS_PROV_DISC_FAIL_EVENT: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;->peerAddr:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;->reason:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2231
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v2, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    .line 2232
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->clearPdInformation()Ljava/lang/String;

    .line 2233
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->p2pFlush()Z

    .line 2234
    iget v1, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;->reason:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_2

    .line 2236
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionDeferredTimeout()V
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$9600(Lcom/lge/wfds/WfdsService;)V

    .line 2237
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    const/4 v3, 0x4

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v1, v2, v3}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto :goto_0

    .line 2238
    :cond_2
    iget v1, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsProvDiscFailData;->reason:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_3

    .line 2240
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 2241
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->removeGroup()V

    goto :goto_0

    .line 2244
    :cond_3
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    const/4 v3, 0x7

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v1, v2, v3}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto :goto_0
.end method

.method private handleProvDiscTimeout()V
    .locals 4

    .prologue
    .line 2249
    invoke-virtual {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    .line 2250
    .local v0, "currentState":Lcom/android/internal/util/IState;
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    iget-object v1, v1, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 2266
    :cond_0
    :goto_0
    return-void

    .line 2255
    :cond_1
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3800(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    if-ne v0, v1, :cond_2

    .line 2257
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v2

    iget-object v2, v2, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/lge/wfds/WfdsNative;->provisionTimeoutOccurred(Ljava/lang/String;)Z

    .line 2261
    :goto_1
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v2, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    .line 2262
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->clearPdInformation()Ljava/lang/String;

    .line 2263
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->p2pFlush()Z

    .line 2264
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    const/4 v3, 0x5

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v1, v2, v3}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto :goto_0

    .line 2259
    :cond_2
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->dismissAllDialog()V

    goto :goto_1
.end method

.method private isPostAssociation(Ljava/lang/String;)Z
    .locals 4
    .param p1, "addr"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 2339
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    if-eqz v3, :cond_3

    if-eqz p1, :cond_3

    .line 2340
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 2341
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->getClientList()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 2342
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Landroid/net/wifi/p2p/WifiP2pDevice;>;"
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 2343
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 2344
    .local v0, "d":Landroid/net/wifi/p2p/WifiP2pDevice;
    iget-object v3, v0, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-ne v3, v2, :cond_0

    .line 2355
    .end local v0    # "d":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Landroid/net/wifi/p2p/WifiP2pDevice;>;"
    :cond_1
    :goto_0
    return v2

    .line 2349
    :cond_2
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v3

    iget-object v3, v3, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eq v3, v2, :cond_1

    .line 2355
    :cond_3
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private obtainMessage(Landroid/os/Message;)Landroid/os/Message;
    .locals 2
    .param p1, "srcMsg"    # Landroid/os/Message;

    .prologue
    .line 2704
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .line 2705
    .local v0, "msg":Landroid/os/Message;
    iget v1, p1, Landroid/os/Message;->arg2:I

    iput v1, v0, Landroid/os/Message;->arg2:I

    .line 2706
    return-object v0
.end method

.method private procPeerConnUserAccept(Landroid/os/Message;)Z
    .locals 7
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const/4 v6, 0x1

    .line 2164
    const/4 v0, 0x0

    .line 2165
    .local v0, "changeState":Z
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionDeferredTimeout()V
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$9600(Lcom/lge/wfds/WfdsService;)V

    .line 2167
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    if-nez v3, :cond_0

    move v1, v0

    .line 2205
    .end local v0    # "changeState":Z
    .local v1, "changeState":I
    :goto_0
    return v1

    .line 2171
    .end local v1    # "changeState":I
    .restart local v0    # "changeState":Z
    :cond_0
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v3, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v3, v3, Landroid/net/wifi/WpsInfo;->setup:I

    const/4 v4, 0x5

    if-ne v3, v4, :cond_3

    .line 2172
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setProvisionReceivedTimeout()V
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$8800(Lcom/lge/wfds/WfdsService;)V

    .line 2173
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v5, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v5}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v5

    iget-object v5, v5, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v5, v5, Landroid/net/wifi/WpsInfo;->setup:I

    invoke-virtual {v3, v6, v4, v5}, Lcom/lge/wfds/WfdsNative;->confirmService(ZLjava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 2175
    const-string v3, "WfdsService"

    const-string v4, "ConfirmService (User Accept) is succeeded"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2204
    :cond_1
    :goto_1
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->dismissAllDialog()V

    move v1, v0

    .line 2205
    .restart local v1    # "changeState":I
    goto :goto_0

    .line 2177
    .end local v1    # "changeState":I
    :cond_2
    const-string v3, "WfdsService"

    const-string v4, "ConfirmService (User Accept) is failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 2179
    :cond_3
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v3, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v3, v3, Landroid/net/wifi/WpsInfo;->setup:I

    const/4 v4, 0x2

    if-ne v3, v4, :cond_1

    .line 2180
    iget-object v3, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    if-eqz v3, :cond_4

    .line 2181
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v4, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v3, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    iput-object v3, v4, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    .line 2184
    :cond_4
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mKeypadEventString:Ljava/lang/String;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$9400(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_5

    .line 2187
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/lge/wfds/WfdsNative;->deviceAuth(Landroid/net/wifi/p2p/WifiP2pConfigEx;)Ljava/lang/String;

    .line 2188
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mKeypadEventString:Ljava/lang/String;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$9400(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v4, v4, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 2189
    .local v2, "eventString":Ljava/lang/String;
    const-string v3, "WfdsService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "User input the pin: Event: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2190
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v3, v2}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    .line 2191
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v4, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mKeypadEventString:Ljava/lang/String;
    invoke-static {v3, v4}, Lcom/lge/wfds/WfdsService;->access$9402(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)Ljava/lang/String;

    .line 2192
    const/4 v0, 0x1

    .line 2193
    goto/16 :goto_1

    .line 2194
    .end local v2    # "eventString":Ljava/lang/String;
    :cond_5
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setProvisionReceivedTimeout()V
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$8800(Lcom/lge/wfds/WfdsService;)V

    .line 2195
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v5, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v5}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v5

    iget-object v5, v5, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v5, v5, Landroid/net/wifi/WpsInfo;->setup:I

    invoke-virtual {v3, v6, v4, v5}, Lcom/lge/wfds/WfdsNative;->confirmService(ZLjava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 2197
    const-string v3, "WfdsService"

    const-string v4, "ConfirmService is succeeded"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .line 2199
    :cond_6
    const-string v3, "WfdsService"

    const-string v4, "ConfirmService is failed"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1
.end method

.method private procPeerConnUserReject()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 2209
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionDeferredTimeout()V
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$9600(Lcom/lge/wfds/WfdsService;)V

    .line 2210
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    if-nez v0, :cond_0

    .line 2221
    :goto_0
    return-void

    .line 2214
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    iget-object v1, v1, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v2

    iget-object v2, v2, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v2, v2, Landroid/net/wifi/WpsInfo;->setup:I

    invoke-virtual {v0, v3, v1, v2}, Lcom/lge/wfds/WfdsNative;->confirmService(ZLjava/lang/String;I)Z

    .line 2215
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsNative;->clearPdInformation()Ljava/lang/String;

    .line 2216
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsNative;->p2pFlush()Z

    .line 2217
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    invoke-virtual {v0, v3}, Lcom/lge/wfds/WfdsNative;->p2pFind(Z)Z

    .line 2218
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    const/4 v2, 0x4

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    .line 2220
    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->dismissAllDialog()V

    goto :goto_0
.end method

.method private processP2pGroupFormationFailure()V
    .locals 4

    .prologue
    .line 2603
    const-string v1, "WfdsService"

    const-string v2, "GO Negotiation / Group Formation Failed"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2604
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->clearPdInformation()Ljava/lang/String;

    move-result-object v0

    .line 2605
    .local v0, "peerAddr":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 2606
    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Group Formation failure with "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2607
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2608
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    const/4 v3, 0x7

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v1, v2, v3}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    .line 2613
    :cond_0
    :goto_0
    return-void

    .line 2610
    :cond_1
    const-string v1, "WfdsService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "peerAddr is not equals with ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private processPersistentUnknown(Ljava/lang/String;)V
    .locals 3
    .param p1, "eventStr"    # Ljava/lang/String;

    .prologue
    .line 2585
    if-nez p1, :cond_1

    .line 2600
    :cond_0
    :goto_0
    return-void

    .line 2589
    :cond_1
    const-string v1, " "

    invoke-virtual {p1, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 2590
    .local v0, "strTokens":[Ljava/lang/String;
    array-length v1, v0

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    .line 2594
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    if-nez v1, :cond_2

    .line 2595
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v2, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v2}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 2596
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    const/4 v2, 0x1

    aget-object v2, v0, v2

    iput-object v2, v1, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    .line 2599
    :cond_2
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsPersistentUnknownGroupBroadcast(Ljava/lang/String;)V
    invoke-static {v1, p1}, Lcom/lge/wfds/WfdsService;->access$14800(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private processProvDiscDefaultPin(Ljava/lang/String;)V
    .locals 8
    .param p1, "eventStr"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 2487
    invoke-virtual {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    .line 2488
    .local v0, "currentState":Lcom/android/internal/util/IState;
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    if-eq v0, v3, :cond_0

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    if-eq v0, v3, :cond_0

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    if-eq v0, v3, :cond_0

    .line 2491
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    .line 2494
    :cond_0
    const-string v3, "WfdsService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "processProvDiscDefaultPin currentState:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v0}, Lcom/android/internal/util/IState;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2496
    new-instance v2, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;

    invoke-direct {v2, p1}, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;-><init>(Ljava/lang/String;)V

    .line 2498
    .local v2, "provDisc":Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;
    iget-boolean v3, v2, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->go:Z

    if-eqz v3, :cond_4

    .line 2499
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v3

    iget-object v3, v3, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisP2pDevice:Landroid/net/wifi/p2p/WifiP2pDevice;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$600(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v4

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 2501
    :cond_1
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static {v3, v7}, Lcom/lge/wfds/WfdsService;->access$5602(Lcom/lge/wfds/WfdsService;Z)Z

    .line 2502
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    if-ne v0, v3, :cond_3

    .line 2503
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->attachIgnoreAtEventString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 2504
    .local v1, "ignoreEventStr":Ljava/lang/String;
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v3, v1}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    .line 2540
    .end local v1    # "ignoreEventStr":Ljava/lang/String;
    :cond_2
    :goto_0
    return-void

    .line 2508
    :cond_3
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    goto :goto_0

    .line 2509
    :cond_4
    iget-boolean v3, v2, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->join:Z

    if-eqz v3, :cond_5

    .line 2510
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static {v3, v6}, Lcom/lge/wfds/WfdsService;->access$5602(Lcom/lge/wfds/WfdsService;Z)Z

    .line 2511
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2512
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v3, p1}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    goto :goto_0

    .line 2514
    :cond_5
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    if-nez v3, :cond_6

    .line 2515
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v4}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3, v4}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 2517
    :cond_6
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v4, v2, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->device:Landroid/net/wifi/p2p/WifiP2pDevice;

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iput-object v4, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    .line 2518
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v3, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    const/4 v4, 0x5

    iput v4, v3, Landroid/net/wifi/WpsInfo;->setup:I

    .line 2519
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v3, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    const-string v4, "12345670"

    iput-object v4, v3, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    .line 2520
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static {v3, v6}, Lcom/lge/wfds/WfdsService;->access$5602(Lcom/lge/wfds/WfdsService;Z)Z

    .line 2522
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    if-eq v0, v3, :cond_7

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    if-ne v0, v3, :cond_8

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3500(Lcom/lge/wfds/WfdsService;)Z

    move-result v3

    if-ne v3, v7, :cond_8

    .line 2528
    :cond_7
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v3, v6}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    .line 2530
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->attachIgnoreAtEventString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 2531
    .restart local v1    # "ignoreEventStr":Ljava/lang/String;
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v3, v1}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    goto :goto_0

    .line 2532
    .end local v1    # "ignoreEventStr":Ljava/lang/String;
    :cond_8
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    if-eq v0, v3, :cond_9

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    if-ne v0, v3, :cond_2

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3500(Lcom/lge/wfds/WfdsService;)Z

    move-result v3

    if-eq v3, v7, :cond_2

    .line 2534
    :cond_9
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    invoke-virtual {v3}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    .line 2535
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/lge/wfds/WfdsNative;->deviceAuth(Landroid/net/wifi/p2p/WifiP2pConfigEx;)Ljava/lang/String;

    .line 2536
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v3, p1}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private processProvDiscDefaultPinWithinGroup()V
    .locals 3

    .prologue
    .line 2544
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    if-nez v1, :cond_0

    .line 2553
    :goto_0
    return-void

    .line 2547
    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3800(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 2549
    .local v0, "isSeeker":Z
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3500(Lcom/lge/wfds/WfdsService;)Z

    move-result v1

    if-nez v1, :cond_1

    if-nez v0, :cond_2

    :cond_1
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3500(Lcom/lge/wfds/WfdsService;)Z

    move-result v1

    if-eqz v1, :cond_3

    if-nez v0, :cond_3

    .line 2550
    :cond_2
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    .line 2552
    :cond_3
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->p2pStopFind()Z

    goto :goto_0
.end method

.method private processProvDiscDisplay(Ljava/lang/String;Z)Z
    .locals 7
    .param p1, "eventStr"    # Ljava/lang/String;
    .param p2, "needShowDialog"    # Z

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 2556
    new-instance v1, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;

    invoke-direct {v1, p1}, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;-><init>(Ljava/lang/String;)V

    .line 2558
    .local v1, "provDisc":Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    if-nez v4, :cond_0

    .line 2559
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v5, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v5}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4, v5}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 2561
    :cond_0
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    iget-object v5, v1, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->device:Landroid/net/wifi/p2p/WifiP2pDevice;

    iget-object v5, v5, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iput-object v5, v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    .line 2562
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iput v3, v4, Landroid/net/wifi/WpsInfo;->setup:I

    .line 2563
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v4

    iget-object v4, v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v5, v1, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->pin:Ljava/lang/String;

    iput-object v5, v4, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    .line 2566
    :try_start_0
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v5, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v5}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v5

    iget-object v5, v5, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v5, v5, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    # setter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v4, v5}, Lcom/lge/wfds/WfdsService;->access$3602(Lcom/lge/wfds/WfdsService;I)I

    .line 2567
    const-string v4, "WfdsService"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Display Pin Number: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v6}, Lcom/lge/wfds/WfdsService;->access$3600(Lcom/lge/wfds/WfdsService;)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2573
    :goto_0
    if-eqz p2, :cond_1

    if-eqz p2, :cond_2

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v5}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v5

    iget-object v5, v5, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v6, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v6}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v6

    iget-object v6, v6, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v6, v6, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lcom/lge/wfds/WfdsDialog;->showProvDiscShowPinDialog(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 2577
    :cond_1
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v2, p1}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    move v2, v3

    .line 2581
    :cond_2
    return v2

    .line 2568
    :catch_0
    move-exception v0

    .line 2569
    .local v0, "e":Ljava/lang/NumberFormatException;
    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v4, v2}, Lcom/lge/wfds/WfdsService;->access$3602(Lcom/lge/wfds/WfdsService;I)I

    .line 2570
    const-string v4, "WfdsService"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "NumberFormatException: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private removeGroup()V
    .locals 3

    .prologue
    .line 2616
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    if-nez v0, :cond_0

    .line 2629
    :goto_0
    return-void

    .line 2619
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    new-instance v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine$4;

    invoke-direct {v2, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$4;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->removeGroup(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    goto :goto_0
.end method

.method private replyToMessage(Landroid/os/Message;I)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "what"    # I

    .prologue
    .line 2652
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    if-nez v1, :cond_0

    .line 2658
    :goto_0
    return-void

    .line 2655
    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->obtainMessage(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    .line 2656
    .local v0, "dstMsg":Landroid/os/Message;
    iput p2, v0, Landroid/os/Message;->what:I

    .line 2657
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$14900(Lcom/lge/wfds/WfdsService;)Lcom/android/internal/util/AsyncChannel;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;Landroid/os/Message;)V

    goto :goto_0
.end method

.method private replyToMessage(Landroid/os/Message;II)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "what"    # I
    .param p3, "arg1"    # I

    .prologue
    .line 2661
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    if-nez v1, :cond_0

    .line 2668
    :goto_0
    return-void

    .line 2664
    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->obtainMessage(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    .line 2665
    .local v0, "dstMsg":Landroid/os/Message;
    iput p2, v0, Landroid/os/Message;->what:I

    .line 2666
    iput p3, v0, Landroid/os/Message;->arg1:I

    .line 2667
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$14900(Lcom/lge/wfds/WfdsService;)Lcom/android/internal/util/AsyncChannel;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;Landroid/os/Message;)V

    goto :goto_0
.end method

.method private replyToMessage(Landroid/os/Message;IILjava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "what"    # I
    .param p3, "arg1"    # I
    .param p4, "mac"    # Ljava/lang/String;

    .prologue
    .line 2683
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    if-nez v1, :cond_0

    .line 2691
    :goto_0
    return-void

    .line 2686
    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->obtainMessage(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    .line 2687
    .local v0, "dstMsg":Landroid/os/Message;
    iput p2, v0, Landroid/os/Message;->what:I

    .line 2688
    iput p3, v0, Landroid/os/Message;->arg1:I

    .line 2689
    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 2690
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$14900(Lcom/lge/wfds/WfdsService;)Lcom/android/internal/util/AsyncChannel;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;Landroid/os/Message;)V

    goto :goto_0
.end method

.method private replyToMessage(Landroid/os/Message;ILjava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "what"    # I
    .param p3, "sValue"    # Ljava/lang/String;

    .prologue
    .line 2694
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    if-nez v1, :cond_0

    .line 2701
    :goto_0
    return-void

    .line 2697
    :cond_0
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->obtainMessage(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    .line 2698
    .local v0, "dstMsg":Landroid/os/Message;
    iput p2, v0, Landroid/os/Message;->what:I

    .line 2699
    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 2700
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mReplyChannel:Lcom/android/internal/util/AsyncChannel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$14900(Lcom/lge/wfds/WfdsService;)Lcom/android/internal/util/AsyncChannel;

    move-result-object v1

    invoke-virtual {v1, p1, v0}, Lcom/android/internal/util/AsyncChannel;->replyToMessage(Landroid/os/Message;Landroid/os/Message;)V

    goto :goto_0
.end method

.method private requestP2pConnection(Landroid/net/wifi/p2p/WifiP2pConfigEx;Ljava/lang/String;IILjava/lang/String;I)Z
    .locals 6
    .param p1, "peerConfigEx"    # Landroid/net/wifi/p2p/WifiP2pConfigEx;
    .param p2, "deviceAddr"    # Ljava/lang/String;
    .param p3, "advId"    # I
    .param p4, "sessionId"    # I
    .param p5, "sessionInfo"    # Ljava/lang/String;
    .param p6, "capa"    # I

    .prologue
    .line 2318
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    move-object v1, p2

    move v2, p3

    move v3, p4

    move-object v4, p5

    move v5, p6

    invoke-virtual/range {v0 .. v5}, Lcom/lge/wfds/WfdsNative;->requestService(Ljava/lang/String;IILjava/lang/String;I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2319
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    new-instance v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine$2;

    invoke-direct {v2, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$2;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    invoke-virtual {v0, v1, p1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->connect(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pConfig;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 2335
    const/4 v0, 0x1

    :goto_0
    return v0

    .line 2333
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private searchTerminated(Landroid/os/Message;II)V
    .locals 0
    .param p1, "msg"    # Landroid/os/Message;
    .param p2, "event"    # I
    .param p3, "reason"    # I

    .prologue
    .line 2648
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V

    .line 2649
    return-void
.end method

.method private selectWpsConfig(I)I
    .locals 6
    .param p1, "networkConfig"    # I

    .prologue
    const/4 v5, 0x2

    .line 2359
    const/4 v1, 0x4

    .line 2361
    .local v1, "wpsConfig":I
    const-string v2, "WfdsService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "createPeerConfigEx: Network Config value = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2363
    if-ne p1, v5, :cond_2

    .line 2364
    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsNative;->getConfigMethod()I

    move-result v0

    .line 2365
    .local v0, "configMethod":I
    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    .line 2366
    const/4 v1, 0x1

    .line 2377
    .end local v0    # "configMethod":I
    :goto_0
    const-string v2, "WfdsService"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Config Method: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2379
    return v1

    .line 2367
    .restart local v0    # "configMethod":I
    :cond_0
    if-ne v0, v5, :cond_1

    .line 2368
    const/4 v1, 0x2

    goto :goto_0

    .line 2371
    :cond_1
    const-string v2, "WfdsService"

    const-string v3, "Config Method: INVALID"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 2374
    .end local v0    # "configMethod":I
    :cond_2
    const/4 v1, 0x5

    goto :goto_0
.end method

.method private setConfigMethod(Landroid/os/Message;I)V
    .locals 1
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "configMethod"    # I

    .prologue
    .line 2295
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/lge/wfds/WfdsNative;->setConfigMethod(I)Z

    .line 2296
    const v0, 0x900020

    invoke-direct {p0, p1, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    .line 2297
    return-void
.end method

.method private setConnectCapa(Landroid/os/Message;I)V
    .locals 1
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "id"    # I

    .prologue
    .line 2275
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/lge/wfds/WfdsNative;->setConnectionCapability(I)Z

    .line 2276
    const v0, 0x900020

    invoke-direct {p0, p1, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    .line 2277
    return-void
.end method

.method private setListenChannelForTest(Landroid/os/Message;I)V
    .locals 5
    .param p1, "message"    # Landroid/os/Message;
    .param p2, "listenChn"    # I

    .prologue
    .line 2300
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mListenChannelForTest:I
    invoke-static {v0, p2}, Lcom/lge/wfds/WfdsService;->access$14702(Lcom/lge/wfds/WfdsService;I)I

    .line 2301
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pManager:Landroid/net/wifi/p2p/WifiP2pManager;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$1100(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$1200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mListenChannelForTest:I
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$14700(Lcom/lge/wfds/WfdsService;)I

    move-result v2

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mListenChannelForTest:I
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$14700(Lcom/lge/wfds/WfdsService;)I

    move-result v3

    new-instance v4, Lcom/lge/wfds/WfdsService$WfdsStateMachine$1;

    invoke-direct {v4, p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$1;-><init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/net/wifi/p2p/WifiP2pManager;->setWifiP2pChannels(Landroid/net/wifi/p2p/WifiP2pManager$Channel;IILandroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 2312
    const v0, 0x900020

    invoke-direct {p0, p1, v0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V

    .line 2313
    return-void
.end method