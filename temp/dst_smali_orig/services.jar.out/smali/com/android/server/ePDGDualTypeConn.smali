.class public Lcom/android/server/ePDGDualTypeConn;
.super Lcom/android/server/ePDGConnection;
.source "ePDGDualTypeConn.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/ePDGDualTypeConn$1;,
        Lcom/android/server/ePDGDualTypeConn$DcDefaultState;,
        Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;,
        Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;,
        Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;,
        Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;,
        Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;,
        Lcom/android/server/ePDGDualTypeConn$DcReadyState;,
        Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    }
.end annotation


# instance fields
.field public isDCwaiting:Z

.field private mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

.field private mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

.field private mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

.field private mDtInitConnectingState:Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;

.field private mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

.field private mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

.field private mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;

.field private mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

.field mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;


# direct methods
.method protected constructor <init>(Ljava/lang/String;I)V
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "id"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1, p2}, Lcom/android/server/ePDGConnection;-><init>(Ljava/lang/String;I)V

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtInitConnectingState:Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcReadyState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    new-instance v0, Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    invoke-direct {v0, p0, v1}, Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;-><init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    iput-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->isDCwaiting:Z

    const-string v0, "Dual type ePDGConnection constructor E"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iput p2, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mGWList:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/server/ePDGFixedInfo;

    invoke-direct {v0, p2}, Lcom/android/server/ePDGFixedInfo;-><init>(I)V

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGDualTypeConn;->setDbg(Z)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtInitConnectingState:Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDefaultState:Lcom/android/server/ePDGDualTypeConn$DcDefaultState;

    invoke-virtual {p0, v0, v1}, Lcom/android/server/ePDGDualTypeConn;->addState(Lcom/android/internal/util/State;Lcom/android/internal/util/State;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->setInitialState(Lcom/android/internal/util/State;)V

    const-string v0, "Jphone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/ILGTelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ILGTelephony;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    const-string v0, "Dual type ePDGConnection constructor X"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtInitConnectingState:Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1600(Lcom/android/server/ePDGDualTypeConn;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->removeMessages(I)V

    return-void
.end method

.method static synthetic access$1700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1800(Lcom/android/server/ePDGDualTypeConn;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->removeMessages(I)V

    return-void
.end method

.method static synthetic access$1900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2000(Lcom/android/server/ePDGDualTypeConn;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->removeMessages(I)V

    return-void
.end method

.method static synthetic access$2100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2600(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$2900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3600(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    return-object v0
.end method

.method static synthetic access$3700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$3900(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$4000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4300(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    return-object v0
.end method

.method static synthetic access$4400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4500(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    return-object v0
.end method

.method static synthetic access$4600(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$4900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5100(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$5200(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$5300(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Landroid/os/Message;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    return-object v0
.end method

.method static synthetic access$5500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5600(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$5900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6600(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$6900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$7300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$800(Lcom/android/server/ePDGDualTypeConn;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p1, "x1"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGDualTypeConn;->removeMessages(I)V

    return-void
.end method

.method static synthetic access$900(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/ePDGDualTypeConn;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    return-object v0
.end method

.method static makePDGConnection(I)Lcom/android/server/ePDGDualTypeConn;
    .locals 3
    .param p0, "id"    # I

    .prologue
    new-instance v0, Lcom/android/server/ePDGDualTypeConn;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ePDGDualtypeDC-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1, p0}, Lcom/android/server/ePDGDualTypeConn;-><init>(Ljava/lang/String;I)V

    .local v0, "ePDGDc":Lcom/android/server/ePDGDualTypeConn;
    invoke-virtual {v0}, Lcom/android/server/ePDGDualTypeConn;->start()V

    return-object v0
.end method


# virtual methods
.method public changeSigLevel()V
    .locals 3

    .prologue
    const/4 v2, 0x2

    const/4 v1, 0x0

    iget v0, p0, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    if-nez v0, :cond_0

    const-string v0, "chLel wifi sig is good so we can Hand in!!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "chLel wifi sig is mid or bad so we can not Hand in, we set ePDG block!!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0
.end method

.method public checkNreason(II)V
    .locals 3
    .param p1, "nReason"    # I
    .param p2, "curpref"    # I

    .prologue
    const/4 v1, 0x1

    const/16 v2, 0x8

    sparse-switch p1, :sswitch_data_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "unknown fail cause = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " currt_Pref= "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :sswitch_0
    const-string v0, "QMI_WDS_CE_REASON_FADE, we will retry"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    const-string v0, "QMI_WDS_VERBOSE_CE_UNKNOWN_APN we will retry"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_2
    const/4 v0, 0x2

    if-ne p2, v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "IP Sec fail, we will block ePDG, and go to LTE, 5:auth fail, 6:timeout "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0

    :cond_0
    const-string v0, "IP Sec fail, in LTE what happen??"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_3
    const-string v0, "QMI_WDS_VERBOSE_CE_NO_SRV we will retry"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_4
    const-string v0, "QMI_WDS_VERBOSE_CE_CLIENT_END we will retry"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_5
    if-nez p2, :cond_1

    const-string v0, "INSUFFICIENT_RESOURCES we block LTE"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0

    :cond_1
    const-string v0, "INSUFFICIENT_RESOURCES fail in ePDG, check it !!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_6
    if-nez p2, :cond_2

    const-string v0, "ACTIVATION_REJECT_GGSN we block LTE"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0

    :cond_2
    const-string v0, "ACTIVATION_REJECT_GGSN fail in ePDG, check it !!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_7
    if-nez p2, :cond_3

    const-string v0, "ACTIVATION_REJECT_UNSPECIFIED we block LTE"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0

    :cond_3
    const-string v0, "ACTIVATION_REJECT_UNSPECIFIED fail in ePDG, check it !!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_0
        0x5 -> :sswitch_2
        0x6 -> :sswitch_2
        0x1a -> :sswitch_5
        0x1b -> :sswitch_1
        0x1e -> :sswitch_6
        0x1f -> :sswitch_7
        0x7d0 -> :sswitch_4
        0x7d1 -> :sswitch_3
    .end sparse-switch
.end method

.method public checkohterRATandDiscon()Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    iget-boolean v3, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v3}, Lcom/android/server/ePDGFixedInfo;->isLTEBlock()Z

    move-result v3

    if-nez v3, :cond_0

    move v0, v1

    .local v0, "isMobilepossible":Z
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "checkohterRATandDiscon "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " sig status : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v3, p0, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    const/4 v4, 0x2

    if-ne v3, v4, :cond_1

    if-nez v0, :cond_1

    iget v3, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {p0, v3, v4, v2}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    const/16 v2, 0x63

    iput v2, p0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    :goto_1
    return v1

    .end local v0    # "isMobilepossible":Z
    :cond_0
    move v0, v2

    goto :goto_0

    .restart local v0    # "isMobilepossible":Z
    :cond_1
    move v1, v2

    goto :goto_1
.end method

.method public checkwifidetailstatus()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x2

    invoke-virtual {p0}, Lcom/android/server/ePDGDualTypeConn;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    if-eq v0, v1, :cond_2

    iget v0, p0, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    if-nez v0, :cond_1

    const-string v0, " wifi sig is good so we can Hand in!!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v3, v2}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v0, " wifi sig is mid or bad so we can not Hand in, we set ePDG block!!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v3, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lcom/android/server/ePDGDualTypeConn;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    if-eq v0, v2, :cond_3

    const-string v0, " wifi sig is mid or good, so we keep ePDG"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v3, v2}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    goto :goto_0

    :cond_3
    const-string v0, " wifi sig is BAD!! so we will Hand out, and  we set ePDG block!!"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v0, v3, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    goto :goto_0
.end method

.method public determinePrefer()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x2

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-ne v1, v5, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/android/server/ePDGDualTypeConn;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn;->mDtInitConnectingState:Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;

    if-ne v1, v2, :cond_2

    const-string v1, "enviroment is changed , but now connecting so wait until connecting complete"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v1, :cond_3

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    if-ne v1, v3, :cond_3

    const-string v1, "WFC is disabled, so prefer change"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v4}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto :goto_0

    :cond_3
    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v1, :cond_4

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    if-eqz v1, :cond_0

    :cond_4
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-ne v1, v5, :cond_5

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    if-eq v1, v3, :cond_0

    const-string v1, "WiFi only perfer!! so change to IWLAN !!"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v3}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto :goto_0

    :cond_5
    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isRoaming:Z

    if-eqz v1, :cond_6

    const-string v1, "Romaing area just set IWANL Tech"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v3}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto :goto_0

    :cond_6
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1}, Lcom/android/server/ePDGFixedInfo;->isBlock()I

    move-result v0

    .local v0, "myBlockinfo":I
    if-nez v0, :cond_7

    const-string v1, "Now tech is fixed in the LTE"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v4}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto :goto_0

    :cond_7
    if-ne v0, v5, :cond_8

    const-string v1, "Now tech is fixed in the ePDG"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v3}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto :goto_0

    :cond_8
    if-ne v0, v3, :cond_9

    const-string v1, "Now tech is all blocked so just go back original priority "

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    :cond_9
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    if-nez v1, :cond_e

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-nez v1, :cond_b

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    if-eqz v1, :cond_a

    const-string v1, "WiFi connected so move to ePDG!!"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v3}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    :cond_a
    const-string v1, "WiFi perfer and no wifi area, just stay PREF_WWAN_TECH!!"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_b
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-ne v1, v3, :cond_d

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-nez v1, :cond_c

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    if-eqz v1, :cond_c

    const-string v1, "we shold move to IWLAN"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v3}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    :cond_c
    const-string v1, "IMS_CELL_PREF, just stay!! PREF_WWAN_TECH"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_d
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "what happen!!???? , WFC perfer= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_e
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    if-ne v1, v3, :cond_0

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-nez v1, :cond_11

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    if-nez v1, :cond_f

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-eqz v1, :cond_f

    const-string v1, "wifi is not available, and mobile is availble so move to WWAN"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v4}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    :cond_f
    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-nez v1, :cond_10

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    if-nez v1, :cond_10

    const-string v1, "All network is not available so move back to WWAN"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v4}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    :cond_10
    const-string v1, "WiFi perfer stay : PREF_IWLAN_TECH"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_11
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-ne v1, v3, :cond_13

    iget-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-eqz v1, :cond_12

    const-string v1, "mobile is available!! so move to WWAN"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1, v4}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    :cond_12
    const-string v1, "Cell prefer but no mobile area so stay : PREF_IWLAN_TECH"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_13
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "what happen!!???? , WFC perfer= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method public ePDGHandOverStatus(I)V
    .locals 4
    .param p1, "extendedRAT"    # I

    .prologue
    const v3, 0x40023

    const/4 v2, 0x0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ePDGHandOverStatus, extRat :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    sparse-switch p1, :sswitch_data_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "unknonwn handover message "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    const v0, 0x40022

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    :goto_0
    return-void

    :sswitch_0
    const v0, 0x40013

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_1
    const v0, 0x40012

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_2
    const v0, 0x4000c

    invoke-virtual {p0, v0, v2}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(II)V

    goto :goto_0

    :sswitch_3
    const v0, 0x40017

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_4
    const v0, 0x40018

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_5
    const v0, 0x40019

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_6
    const v0, 0x4001b

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_7
    const v0, 0x4001e

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    goto :goto_0

    :sswitch_8
    const/4 v0, 0x1

    invoke-virtual {p0, v3, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(II)V

    goto :goto_0

    :sswitch_9
    invoke-virtual {p0, v3, v2}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(II)V

    goto :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0xe -> :sswitch_1
        0x12 -> :sswitch_0
        0x64 -> :sswitch_2
        0x65 -> :sswitch_4
        0x66 -> :sswitch_3
        0x67 -> :sswitch_5
        0x68 -> :sswitch_8
        0x69 -> :sswitch_9
        0xc8 -> :sswitch_6
        0x12c -> :sswitch_6
        0x1f4 -> :sswitch_7
    .end sparse-switch
.end method

.method public ePDGteardown(Landroid/os/Message;)Z
    .locals 1
    .param p1, "onCompletedMsg"    # Landroid/os/Message;

    .prologue
    iput-object p1, p0, Lcom/android/server/ePDGDualTypeConn;->mCompletedMsg:Landroid/os/Message;

    const v0, 0x40009

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    const/4 v0, 0x1

    return v0
.end method

.method public getprefer()I
    .locals 5

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    const/4 v3, 0x2

    iget v4, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-nez v4, :cond_0

    const-string v1, "getPrefer IMS_TYPE"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    move v2, v3

    :goto_0
    return v2

    :cond_0
    iget v4, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-ne v4, v1, :cond_9

    iget-boolean v4, p0, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v4}, Lcom/android/server/ePDGFixedInfo;->isePDGBlock()Z

    move-result v4

    if-nez v4, :cond_1

    move v0, v1

    .local v0, "isUsingWiFi":Z
    :goto_1
    iget-boolean v4, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-nez v4, :cond_2

    if-nez v0, :cond_2

    const-string v1, "getPrefer No Network"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    move v2, v3

    goto :goto_0

    .end local v0    # "isUsingWiFi":Z
    :cond_1
    move v0, v2

    goto :goto_1

    .restart local v0    # "isUsingWiFi":Z
    :cond_2
    iget-boolean v4, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-eqz v4, :cond_3

    if-nez v0, :cond_3

    const-string v1, "getPrefer LTE only"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-eqz v0, :cond_5

    iget-boolean v4, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-nez v4, :cond_5

    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v2, :cond_4

    const-string v1, "getPrefer wifi only for no wfc settings"

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    move v2, v3

    goto :goto_0

    :cond_4
    const-string v2, "getPrefer wifi only so TMUS return"

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    move v2, v1

    goto :goto_0

    :cond_5
    iget v4, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-eq v4, v1, :cond_6

    iget v4, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-nez v4, :cond_7

    :cond_6
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPrefer WFC prefer= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    move v2, v1

    goto :goto_0

    :cond_7
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-ne v1, v3, :cond_8

    const-string v1, "getPrefer WFC prefer= Cell prefer so MMS "

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_8
    const-string v1, "getPrefer what happen!! "

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    move v2, v3

    goto :goto_0

    .end local v0    # "isUsingWiFi":Z
    :cond_9
    move v2, v3

    goto :goto_0
.end method

.method public isConnected()Z
    .locals 2

    .prologue
    invoke-virtual {p0}, Lcom/android/server/ePDGDualTypeConn;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    if-eq v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/android/server/ePDGDualTypeConn;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected onDisconnectTrigger()V
    .locals 4

    .prologue
    const/4 v1, 0x1

    iget v0, p0, Lcom/android/server/ePDGDualTypeConn;->myfeature:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn;->isIMSRegi:Z

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn;->isWaitingDereig:Z

    const v0, 0x4001c

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    const-wide/16 v2, 0x7d0

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/server/ePDGDualTypeConn;->sendMessageDelayed(Landroid/os/Message;J)V

    :goto_0
    return-void

    :cond_0
    iget v0, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v0

    iget v1, p0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    const/16 v0, 0x63

    iput v0, p0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V

    goto :goto_0
.end method

.method public onNetworkupdate(ZII)Z
    .locals 7
    .param p1, "isWiFi"    # Z
    .param p2, "mobileState"    # I
    .param p3, "mobileTech"    # I

    .prologue
    const/16 v6, 0xe

    const/4 v3, 0x1

    const/4 v4, 0x0

    iput p2, p0, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iput p3, p0, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    if-nez p2, :cond_2

    if-ne p3, v6, :cond_2

    move v2, v3

    :goto_0
    iput-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v2}, Lcom/android/server/ePDGFixedInfo;->resetLTENetworkBlock()V

    :cond_0
    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->isMobileavail:Z

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v2}, Lcom/android/server/ePDGFixedInfo;->isLTEBlock()Z

    move-result v2

    if-nez v2, :cond_3

    move v1, v3

    .local v1, "isMobilepossible":Z
    :goto_1
    if-eqz p1, :cond_4

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v2}, Lcom/android/server/ePDGFixedInfo;->isePDGBlock()Z

    move-result v2

    if-nez v2, :cond_4

    move v0, v3

    .local v0, "isEPDGPossible":Z
    :goto_2
    iget v2, p0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-ne v2, v3, :cond_6

    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v2, :cond_5

    :cond_1
    :goto_3
    return v4

    .end local v0    # "isEPDGPossible":Z
    .end local v1    # "isMobilepossible":Z
    :cond_2
    move v2, v4

    goto :goto_0

    :cond_3
    move v1, v4

    goto :goto_1

    .restart local v1    # "isMobilepossible":Z
    :cond_4
    move v0, v4

    goto :goto_2

    .restart local v0    # "isEPDGPossible":Z
    :cond_5
    move v4, v0

    goto :goto_3

    :cond_6
    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v2, :cond_7

    move v4, v1

    goto :goto_3

    :cond_7
    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-eqz v2, :cond_a

    iget v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    const/4 v5, 0x2

    if-ne v2, v5, :cond_a

    if-nez p2, :cond_8

    if-eq p3, v6, :cond_8

    const-string v2, "onNetworkupdate : it will be 2G/3G. So go to No Network State"

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_3

    :cond_8
    if-nez v1, :cond_9

    if-eqz v0, :cond_1

    :cond_9
    move v4, v3

    goto :goto_3

    :cond_a
    iget-boolean v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-eqz v2, :cond_b

    iget v2, p0, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    if-ne v2, v3, :cond_b

    move v4, v0

    goto :goto_3

    :cond_b
    if-nez v1, :cond_c

    if-eqz v0, :cond_1

    :cond_c
    move v4, v3

    goto :goto_3
.end method

.method public pcsch(Ljava/lang/String;)Z
    .locals 3
    .param p1, "type"    # Ljava/lang/String;

    .prologue
    if-eqz p1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    iget v2, p0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-interface {v1, v2, p1}, Lcom/android/internal/telephony/ILGTelephony;->getPcscfAddress(ILjava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 v1, 0x1

    :goto_1
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] setup data call RemoteException : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const/4 v1, 0x0

    goto :goto_1
.end method

.method protected setIMSRegistate(Z)V
    .locals 1
    .param p1, "Registate"    # Z

    .prologue
    iget-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn;->isIMSRegi:Z

    if-ne v0, p1, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn;->isWaitingDereig:Z

    if-eqz v0, :cond_1

    if-nez p1, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn;->isWaitingDereig:Z

    const v0, 0x4001d

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGDualTypeConn;->sendMessage(I)V

    :cond_1
    iput-boolean p1, p0, Lcom/android/server/ePDGDualTypeConn;->isIMSRegi:Z

    goto :goto_0
.end method
