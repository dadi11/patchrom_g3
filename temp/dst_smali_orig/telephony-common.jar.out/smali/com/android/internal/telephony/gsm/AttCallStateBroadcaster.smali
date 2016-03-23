.class public Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;
.super Ljava/lang/Object;
.source "AttCallStateBroadcaster.java"


# static fields
.field private static final ACTION_DDM_CSC:Ljava/lang/String; = "diagandroid.ddm.csc"

.field private static final CSC_ATTR_ORIGINATED:B = 0x0t

.field private static final CSC_ATTR_TERMINATED:B = 0x1t

.field private static final CSC_STATE_ATTEMPTING:B = 0x3t

.field private static final CSC_STATE_CONNECTED:B = 0x5t

.field private static final CSC_STATE_DISCONNECTING:B = 0x6t

.field private static final CSC_STATE_ESTABLISHED:B = 0x4t

.field private static final CSC_STATE_FAILED:B = 0x7t

.field private static final CSC_STATE_HELD:B = 0x8t

.field private static final CSC_STATE_IDLE:B = 0x1t

.field private static final CSC_STATE_UNKNOWN:B = 0x0t

.field static final DEBUG:Z

.field private static final EXTRA_DDM_CSC_ATTR:Ljava/lang/String; = "DdmCscAttr"

.field private static final EXTRA_DDM_CSC_CID:Ljava/lang/String; = "DdmCscCID"

.field private static final EXTRA_DDM_CSC_ERROR:Ljava/lang/String; = "DdmCscError"

.field private static final EXTRA_DDM_CSC_MID:Ljava/lang/String; = "DdmCscMID"

.field private static final EXTRA_DDM_CSC_NUMBER:Ljava/lang/String; = "DdmCscNumber"

.field private static final EXTRA_DDM_CSC_STATE:Ljava/lang/String; = "DdmCscState"

.field private static final EXTRA_DDM_CSC_TERM:Ljava/lang/String; = "DdmCscTerm"

.field private static final LOG_TAG:Ljava/lang/String; = "LGDDM-CSC"

.field private static mRilAnswered:Z

.field static mVersion:I

.field private static sConnections:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Lcom/android/internal/telephony/gsm/GsmConnection;",
            "Lcom/android/internal/telephony/gsm/LgeConnectionState;",
            ">;"
        }
    .end annotation
.end field

.field private static sNextConId:I

.field private static sSyncConn:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    const-string v0, "ro.debuggable"

    const-string v3, "0"

    invoke-static {v0, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "1"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->DEBUG:Z

    sput v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->mVersion:I

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    sput v2, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sNextConId:I

    sput-boolean v2, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->mRilAnswered:Z

    return-void

    :cond_0
    move v0, v2

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addConnection(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;
    .locals 4
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    sget-object v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;

    invoke-direct {v0}, Lcom/android/internal/telephony/gsm/LgeConnectionState;-><init>()V

    .local v0, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    sget-object v2, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v2

    :try_start_0
    sget v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sNextConId:I

    add-int/lit8 v3, v1, 0x1

    sput v3, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sNextConId:I

    iput v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    sget v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sNextConId:I

    const/16 v3, 0x3e8

    if-le v1, v3, :cond_2

    const/4 v1, 0x0

    sput v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sNextConId:I

    :cond_2
    sget-object v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    invoke-virtual {v1, p0, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v2

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method static explicitCallTransfer(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/gsm/GsmConnection;)V
    .locals 0
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "fgConn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "bgConn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    return-void
.end method

.method private static getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;
    .locals 5
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    sget-object v2, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    if-eqz v2, :cond_0

    if-nez p0, :cond_1

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_1
    const/4 v1, 0x0

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    sget-object v3, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v3

    :try_start_0
    sget-object v2, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    invoke-virtual {v2, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    move-object v0, v2

    check-cast v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-object v1, v0

    if-eqz v1, :cond_2

    iget v2, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    const/4 v4, -0x1

    if-ne v2, v4, :cond_2

    const/4 v1, 0x0

    :cond_2
    monitor-exit v3

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method

.method private static getMetricId(Ljava/lang/String;)I
    .locals 2
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v0, v1, 0x18

    .local v0, "id":I
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    or-int/2addr v0, v1

    const/4 v1, 0x2

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    const/4 v1, 0x3

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    return v0
.end method

.method private static getRilAnswered()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->mRilAnswered:Z

    return v0
.end method

.method static initiateMoCiqConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;)V
    .locals 0
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    invoke-static {p0, p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->initiateMoLgeConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;)V

    return-void
.end method

.method static initiateMoLgeConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;)V
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->addConnection(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v1

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v1, :cond_1

    const-string v4, "LGDDM-CSC"

    const-string v5, "initiateMo cannot add connection"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/GsmConnection;->getOrigDialString()Ljava/lang/String;

    move-result-object v2

    .local v2, "dialString":Ljava/lang/String;
    iget v0, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    .local v0, "conid":I
    if-eqz v2, :cond_2

    move-object v3, v2

    .local v3, "number":Ljava/lang/String;
    :goto_1
    const/4 v4, 0x0

    const/4 v5, 0x1

    invoke-static {p0, v0, v4, v5, v3}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStart(Landroid/content/Context;IBBLjava/lang/String;)V

    const/4 v4, 0x3

    invoke-static {p0, v0, v4}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStateTransition(Landroid/content/Context;IB)V

    goto :goto_0

    .end local v3    # "number":Ljava/lang/String;
    :cond_2
    const-string v3, "Private Number"

    goto :goto_1
.end method

.method static initiateMtCiqConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)V
    .locals 0
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;

    .prologue
    invoke-static {p0, p1, p2}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->initiateMtLgeConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)V

    return-void
.end method

.method static initiateMtLgeConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)V
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;

    .prologue
    const/4 v6, 0x1

    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->addConnection(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v1

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v1, :cond_1

    const-string v4, "LGDDM-CSC"

    const-string v5, "initiateMt cannot add connection"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    iget v0, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    .local v0, "conid":I
    iget-object v4, p2, Lcom/android/internal/telephony/DriverCall;->number:Ljava/lang/String;

    if-eqz v4, :cond_3

    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->number:Ljava/lang/String;

    .local v3, "number":Ljava/lang/String;
    :goto_1
    iget-object v4, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v5, Lcom/android/internal/telephony/DriverCall$State;->ACTIVE:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v4, v5, :cond_4

    const/4 v2, 0x1

    .local v2, "direction":B
    iget-boolean v4, p2, Lcom/android/internal/telephony/DriverCall;->isMT:Z

    if-nez v4, :cond_2

    const/4 v2, 0x0

    :cond_2
    invoke-static {p0, v0, v2, v6, v3}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStart(Landroid/content/Context;IBBLjava/lang/String;)V

    const/4 v4, 0x5

    invoke-static {p0, v0, v4}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStateTransition(Landroid/content/Context;IB)V

    goto :goto_0

    .end local v2    # "direction":B
    .end local v3    # "number":Ljava/lang/String;
    :cond_3
    const-string v3, "Private Number"

    goto :goto_1

    .restart local v3    # "number":Ljava/lang/String;
    :cond_4
    invoke-static {p0, v0, v6, v6, v3}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStart(Landroid/content/Context;IBBLjava/lang/String;)V

    const/4 v4, 0x4

    invoke-static {p0, v0, v4}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStateTransition(Landroid/content/Context;IB)V

    goto :goto_0
.end method

.method static isCiqEnabled()Z
    .locals 2

    .prologue
    const-string v0, "1"

    const-string v1, "service.iq.active"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method static onDisconnect(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;I)V
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "cause"    # I

    .prologue
    const/4 v7, 0x7

    const/4 v6, 0x6

    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v1

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v1, :cond_1

    const-string v5, "LGDDM-CSC"

    const-string v6, "onDisconnect cannot find connection"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    iget v0, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    .local v0, "conid":I
    iget-short v4, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->termCode:S

    .local v4, "termCode":S
    iget v3, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->systemCode:I

    .local v3, "systemCode":I
    const/4 v2, 0x0

    .local v2, "state":B
    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getRilAnswered()Z

    move-result v5

    if-eqz v5, :cond_3

    const/4 v5, 0x1

    if-ne p2, v5, :cond_3

    const/4 v5, 0x0

    invoke-static {v5}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->setRilAnswered(Z)V

    const/4 v4, 0x1

    :cond_2
    :goto_1
    iput-short v4, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->termCode:S

    iput v3, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->systemCode:I

    const/4 v5, -0x1

    invoke-static {p0, v0, v5, v4}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscCallEnd(Landroid/content/Context;IIS)V

    invoke-static {p1, v1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->removeConnection(Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/gsm/LgeConnectionState;)V

    goto :goto_0

    :cond_3
    iget-byte v5, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->cState:B

    if-eq v5, v6, :cond_4

    if-eq v2, v6, :cond_4

    const/16 v5, 0x100

    if-eq v4, v5, :cond_4

    const/16 v5, 0x3e9

    if-ne v4, v5, :cond_5

    :cond_4
    const/4 v4, 0x1

    goto :goto_1

    :cond_5
    iget-byte v5, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->cState:B

    if-eq v5, v7, :cond_6

    if-eq v2, v7, :cond_6

    const/16 v5, 0x158

    if-eq v4, v5, :cond_6

    const/16 v5, 0x164

    if-eq v4, v5, :cond_6

    const/16 v5, 0x81

    if-ne v4, v5, :cond_2

    :cond_6
    const/16 v4, 0x202

    goto :goto_1

    .end local v0    # "conid":I
    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    .end local v2    # "state":B
    .end local v3    # "systemCode":I
    .end local v4    # "termCode":S
    :cond_7
    sget-object v5, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    const-string v5, "LGDDM-CSC"

    const-string v6, "onDisconnect clear sConnections"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->clear()V

    goto :goto_0
.end method

.method static onFakeHoldBeforeDial(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v1

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v1, :cond_1

    const-string v2, "LGDDM-CSC"

    const-string v3, "fakeHoldBeforeDial cannot find connection"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    iget v0, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    .local v0, "conid":I
    const/16 v2, 0x8

    invoke-static {p0, v0, v2}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStateTransition(Landroid/content/Context;IB)V

    goto :goto_0
.end method

.method static onRemoteDisconnect(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;I)V
    .locals 11
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "causeCode"    # I

    .prologue
    const/16 v10, 0x3e9

    const/16 v9, 0x164

    const/16 v8, 0x158

    const/16 v7, 0x100

    const/16 v6, 0x81

    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v0

    .local v0, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v0, :cond_1

    const-string v3, "LGDDM-CSC"

    const-string v4, "onRemoteDisconnect cannot find connection"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v0    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    const/4 v3, 0x0

    iput-byte v3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->cState:B

    iget-short v2, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->termCode:S

    .local v2, "termCode":S
    move v1, p2

    .local v1, "systemCode":I
    const-string v3, "LGDDM-CSC"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onRemoteDisconnect, systemCode1 -"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const v3, 0xffff

    if-ne v1, v3, :cond_2

    const/16 v1, 0x81

    :cond_2
    const/16 v3, 0x7f

    if-ge v1, v3, :cond_3

    int-to-short v2, v1

    const/4 v1, 0x0

    :cond_3
    if-eq v1, v8, :cond_4

    if-eq v1, v7, :cond_4

    if-eq v1, v9, :cond_4

    if-eq v1, v6, :cond_4

    if-ne v1, v10, :cond_5

    :cond_4
    int-to-short v2, v1

    const/4 v1, 0x0

    :cond_5
    const-string v3, "LGDDM-CSC"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onRemoteDisconnect, systemCode2 -"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "LGDDM-CSC"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onRemoteDisconnect, termCode -"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-short v2, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->termCode:S

    iput v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->systemCode:I

    const/16 v3, 0x10

    if-eq v2, v3, :cond_0

    if-eq v2, v8, :cond_6

    if-eq v2, v9, :cond_6

    if-eq v2, v6, :cond_6

    if-ne v2, v10, :cond_7

    :cond_6
    const/4 v3, 0x7

    iput-byte v3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->cState:B

    goto :goto_0

    :cond_7
    if-ne v2, v7, :cond_0

    const/4 v3, 0x6

    iput-byte v3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->cState:B

    goto/16 :goto_0
.end method

.method static onUpdate(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;Z)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;
    .param p3, "changed"    # Z

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    if-eqz p3, :cond_0

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v1

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v1, :cond_1

    const-string v3, "LGDDM-CSC"

    const-string v4, "update cannot find connection"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    iget v0, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    .local v0, "conid":I
    const/4 v2, 0x0

    .local v2, "state":B
    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v4, Lcom/android/internal/telephony/DriverCall$State;->DIALING:Lcom/android/internal/telephony/DriverCall$State;

    if-eq v3, v4, :cond_2

    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v4, Lcom/android/internal/telephony/DriverCall$State;->INCOMING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v3, v4, :cond_4

    :cond_2
    const/4 v2, 0x3

    :cond_3
    :goto_1
    invoke-static {p0, v0, v2}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStateTransition(Landroid/content/Context;IB)V

    goto :goto_0

    :cond_4
    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v4, Lcom/android/internal/telephony/DriverCall$State;->ALERTING:Lcom/android/internal/telephony/DriverCall$State;

    if-eq v3, v4, :cond_5

    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v4, Lcom/android/internal/telephony/DriverCall$State;->WAITING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v3, v4, :cond_6

    :cond_5
    const/4 v2, 0x4

    goto :goto_1

    :cond_6
    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v4, Lcom/android/internal/telephony/DriverCall$State;->ACTIVE:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v3, v4, :cond_7

    const/4 v2, 0x5

    goto :goto_1

    :cond_7
    iget-object v3, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v4, Lcom/android/internal/telephony/DriverCall$State;->HOLDING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v3, v4, :cond_3

    const/16 v2, 0x8

    goto :goto_1
.end method

.method private static removeConnection(Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/gsm/LgeConnectionState;)V
    .locals 3
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p1, "connState"    # Lcom/android/internal/telephony/gsm/LgeConnectionState;

    .prologue
    sget-object v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v2, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v2

    if-nez p1, :cond_2

    :try_start_0
    sget-object v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    invoke-virtual {v1, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    move-object v0, v1

    check-cast v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-object p1, v0

    :cond_2
    if-eqz p1, :cond_3

    const/4 v1, -0x1

    iput v1, p1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    :cond_3
    sget-object v1, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    invoke-virtual {v1, p0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v2

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method static setRilAnswered(Z)V
    .locals 0
    .param p0, "answered"    # Z

    .prologue
    sput-boolean p0, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->mRilAnswered:Z

    return-void
.end method

.method static setVersion(I)V
    .locals 0
    .param p0, "version"    # I

    .prologue
    sput p0, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->mVersion:I

    return-void
.end method

.method private static submitCscCallEnd(Landroid/content/Context;IIS)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callId"    # I
    .param p2, "errCode"    # I
    .param p3, "termCode"    # S

    .prologue
    if-nez p0, :cond_0

    const-string v3, "LGDDM-CSC"

    const-string v4, "context is null"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-string v3, "diagandroid.ddm.csc"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    const-string v3, "GS03"

    invoke-static {v3}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getMetricId(Ljava/lang/String;)I

    move-result v2

    .local v2, "metricID":I
    const-string v3, "DdmCscMID"

    invoke-virtual {v1, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscCID"

    invoke-virtual {v1, v3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscError"

    invoke-virtual {v1, v3, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscTerm"

    invoke-virtual {v1, v3, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    sget-boolean v3, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->DEBUG:Z

    if-eqz v3, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v3, 0x80

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v0, "b":Ljava/lang/StringBuilder;
    const-string v3, "Broadcast CSC State Transition"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "\nID : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nCallId : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nErrCode : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nTermCode : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "LGDDM-CSC"

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "b":Ljava/lang/StringBuilder;
    :cond_1
    invoke-virtual {p0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private static submitCscStart(Landroid/content/Context;IBBLjava/lang/String;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callId"    # I
    .param p2, "attr"    # B
    .param p3, "state"    # B
    .param p4, "number"    # Ljava/lang/String;

    .prologue
    if-nez p0, :cond_0

    const-string v3, "LGDDM-CSC"

    const-string v4, "context is null"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-string v3, "diagandroid.ddm.csc"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    const-string v3, "GS01"

    invoke-static {v3}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getMetricId(Ljava/lang/String;)I

    move-result v2

    .local v2, "metricID":I
    const-string v3, "DdmCscMID"

    invoke-virtual {v1, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscCID"

    invoke-virtual {v1, v3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscAttr"

    invoke-virtual {v1, v3, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;B)Landroid/content/Intent;

    const-string v3, "DdmCscState"

    invoke-virtual {v1, v3, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;B)Landroid/content/Intent;

    const-string v3, "DdmCscNumber"

    invoke-virtual {v1, v3, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    sget-boolean v3, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->DEBUG:Z

    if-eqz v3, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v3, 0x80

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v0, "b":Ljava/lang/StringBuilder;
    const-string v3, "Broadcast CSC Start"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "\nID : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nCallId : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nCallAttr : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nCallState : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nNumber : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "LGDDM-CSC"

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "b":Ljava/lang/StringBuilder;
    :cond_1
    invoke-virtual {p0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private static submitCscStateTransition(Landroid/content/Context;IB)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callId"    # I
    .param p2, "state"    # B

    .prologue
    if-nez p0, :cond_0

    const-string v3, "LGDDM-CSC"

    const-string v4, "context is null"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-string v3, "diagandroid.ddm.csc"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    const-string v3, "GS02"

    invoke-static {v3}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getMetricId(Ljava/lang/String;)I

    move-result v2

    .local v2, "metricID":I
    const-string v3, "DdmCscMID"

    invoke-virtual {v1, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscCID"

    invoke-virtual {v1, v3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "DdmCscState"

    invoke-virtual {v1, v3, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;B)Landroid/content/Intent;

    sget-boolean v3, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->DEBUG:Z

    if-eqz v3, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v3, 0x80

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v0, "b":Ljava/lang/StringBuilder;
    const-string v3, "Broadcast CSC State Transition"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "\nID : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nCallId : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "\nCallState : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "LGDDM-CSC"

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "b":Ljava/lang/StringBuilder;
    :cond_1
    invoke-virtual {p0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method static updateCiqConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)V
    .locals 0
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;

    .prologue
    invoke-static {p0, p1, p2}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->updateLgeConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)V

    return-void
.end method

.method static updateLgeConnectionState(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->isCiqEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/GsmConnection;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/Call$State;->DIALING:Lcom/android/internal/telephony/Call$State;

    if-ne v2, v3, :cond_0

    iget-object v2, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v3, Lcom/android/internal/telephony/DriverCall$State;->ACTIVE:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v2, v3, :cond_0

    const/4 v0, 0x0

    .local v0, "conid":I
    invoke-static {p1}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v1

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-nez v1, :cond_1

    const-string v2, "LGDDM-CSC"

    const-string v3, "updateLgeConnectionState cannot find connection"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "conid":I
    .end local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_0
    :goto_0
    return-void

    .restart local v0    # "conid":I
    .restart local v1    # "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    :cond_1
    iget v0, v1, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    const/4 v2, 0x4

    invoke-static {p0, v0, v2}, Lcom/android/internal/telephony/gsm/AttCallStateBroadcaster;->submitCscStateTransition(Landroid/content/Context;IB)V

    goto :goto_0
.end method
