.class Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;
.super Ljava/lang/Object;
.source "TmusCallStateBroadcaster.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$3;,
        Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$InstanceLock;
    }
.end annotation


# static fields
.field private static final ACTION_DETAILED_CALL_STATE:Ljava/lang/String; = "diagandroid.phone.detailedCallState"

.field private static final ACTION_TMUS_CFW_INFO:Ljava/lang/String; = "com.lge.phone.action.TMUS_CIQ_INFO"

.field private static final CALL_STATE_ENDED:Ljava/lang/String; = "ENDED"

.field static final DEBUG:Z

.field static final ENABLED:Z

.field private static final EXTRA_CALL_CODE:Ljava/lang/String; = "CallCode"

.field private static final EXTRA_CALL_NUMBER:Ljava/lang/String; = "CallNumber"

.field private static final EXTRA_CALL_STATE:Ljava/lang/String; = "CallState"

.field private static final PERMISSION_RECEIVE_DETAILED_CALL_STATE:Ljava/lang/String; = "diagandroid.phone.receiveDetailedCallState"

.field static final TAG:Ljava/lang/String; = "GsmCallState"

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

.field private static sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

.field private static sInstanceLocks:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Lcom/android/internal/telephony/gsm/GsmCallTracker;",
            "Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$InstanceLock;",
            ">;"
        }
    .end annotation
.end field

.field private static sNextConId:I

.field private static sStatusCodePerCall:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final sStatusCodes:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static sSyncConn:Ljava/lang/Object;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mReceiver:Landroid/content/BroadcastReceiver;


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
    sput-boolean v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    new-instance v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$1;

    invoke-direct {v0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$1;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodes:Ljava/util/HashMap;

    const-string v0, "persist.lgiqc.ext"

    const-string v3, "0"

    invoke-static {v0, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "1"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :goto_1
    sput-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    sput v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstanceLocks:Ljava/util/HashMap;

    return-void

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$2;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$2;-><init>(Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->mReceiver:Landroid/content/BroadcastReceiver;

    iput-object p1, p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->mContext:Landroid/content/Context;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->mReceiver:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "com.lge.phone.action.TMUS_CIQ_INFO"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0, v1, v3, v3}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    return-void
.end method

.method synthetic constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$1;)V
    .locals 0
    .param p1, "x0"    # Landroid/content/Context;
    .param p2, "x1"    # Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method private Broadcast(Landroid/content/Intent;)V
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->mContext:Landroid/content/Context;

    const-string v1, "diagandroid.phone.receiveDetailedCallState"

    invoke-virtual {v0, p1, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;Ljava/lang/String;)V

    return-void
.end method

.method private static CreateIntent(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    .locals 2
    .param p0, "callState"    # Ljava/lang/String;
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "diagandroid.phone.detailedCallState"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "CallState"

    invoke-virtual {v0, v1, p0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "CallNumber"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    return-object v0
.end method

.method private static GetStatus(I)Ljava/lang/String;
    .locals 3
    .param p0, "id"    # I

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v0, :cond_0

    const-string v0, "GsmCallState"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GetStatus - id : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static SendCallDisconnected(ILjava/lang/String;I)V
    .locals 2
    .param p0, "id"    # I
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "cause"    # I

    .prologue
    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p0, p1, v1}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallDisconnected(ILjava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private SendCallDisconnected(ILjava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "id"    # I
    .param p2, "number"    # Ljava/lang/String;
    .param p3, "cause"    # Ljava/lang/String;

    .prologue
    if-eqz p3, :cond_3

    invoke-static {p1}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->GetStatus(I)Ljava/lang/String;

    move-result-object v1

    .local v1, "preStatus":Ljava/lang/String;
    if-nez v1, :cond_1

    sget-boolean v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v2, :cond_0

    const-string v2, "GsmCallState"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "id : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", preStatus is null"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const-string v2, "ATTEMPTING"

    invoke-direct {p0, p1, p2, v2}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallStatus(ILjava/lang/String;Ljava/lang/String;)V

    :cond_1
    const-string v2, "ENDED"

    invoke-static {v2, p2}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->CreateIntent(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .local v0, "intent":Landroid/content/Intent;
    const-string v2, "CallCode"

    invoke-virtual {v0, v2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->Broadcast(Landroid/content/Intent;)V

    sget-boolean v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v2, :cond_2

    const-string v2, "GsmCallState"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SCallDisconnected : status = CALL_STATE_ENDED  cause = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "preStatus":Ljava/lang/String;
    :cond_3
    return-void
.end method

.method static SendCallStatus(ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V
    .locals 4
    .param p0, "id"    # I
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "status"    # Lcom/android/internal/telephony/Call$State;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_0

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SCallStatus : sInstance = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", id : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", number "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", status = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    if-eqz v1, :cond_1

    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodes:Ljava/util/HashMap;

    invoke-virtual {p2}, Lcom/android/internal/telephony/Call$State;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .local v0, "statusCode":Ljava/lang/String;
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    invoke-direct {v1, p0, p1, v0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallStatus(ILjava/lang/String;Ljava/lang/String;)V

    .end local v0    # "statusCode":Ljava/lang/String;
    :cond_1
    return-void
.end method

.method private SendCallStatus(ILjava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "id"    # I
    .param p2, "number"    # Ljava/lang/String;
    .param p3, "statusString"    # Ljava/lang/String;

    .prologue
    if-eqz p3, :cond_1

    invoke-static {p3, p2}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->CreateIntent(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .local v0, "intent":Landroid/content/Intent;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->Broadcast(Landroid/content/Intent;)V

    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_0

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SCallStatus :  id = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", status = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-static {p1, p3}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SetStatus(ILjava/lang/String;)V

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_1
    return-void
.end method

.method private static SetStatus(ILjava/lang/String;)V
    .locals 4
    .param p0, "id"    # I
    .param p1, "status"    # Ljava/lang/String;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_0

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SetStatus - id : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", status : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sStatusCodePerCall:Ljava/util/HashMap;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .local v0, "result":Ljava/lang/String;
    if-nez v0, :cond_1

    const-string v1, "ATTEMPTING"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "GsmCallState"

    const-string v2, "state is wrong"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "result":Ljava/lang/String;
    :cond_1
    return-void
.end method

.method static synthetic access$000()Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    return-object v0
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;)Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    .prologue
    sput-object p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstance:Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    return-object p0
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->dispose()V

    return-void
.end method

.method static synthetic access$300()Ljava/lang/Object;
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$400()I
    .locals 1

    .prologue
    sget v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    return v0
.end method

.method static synthetic access$402(I)I
    .locals 0
    .param p0, "x0"    # I

    .prologue
    sput p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    return p0
.end method

.method static synthetic access$408()I
    .locals 2

    .prologue
    sget v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    return v0
.end method

.method static addConnection(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;
    .locals 4
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-eqz v1, :cond_0

    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

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
    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v2

    :try_start_0
    sget v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    add-int/lit8 v3, v1, 0x1

    sput v3, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    iput v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    sget v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    const/16 v3, 0x3e8

    if-le v1, v3, :cond_2

    const/4 v1, 0x0

    sput v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sNextConId:I

    :cond_2
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

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

.method private dispose()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method

.method private static getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;
    .locals 5
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    if-eqz v2, :cond_0

    if-nez p0, :cond_1

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_1
    const/4 v1, 0x0

    .local v1, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    sget-object v3, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v3

    :try_start_0
    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

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

.method static prepare(Landroid/content/Context;Lcom/android/internal/telephony/gsm/GsmCallTracker;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callTracker"    # Lcom/android/internal/telephony/gsm/GsmCallTracker;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-eqz v1, :cond_0

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_2

    const-string v1, "GsmCallState"

    const-string v2, "prepare"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    new-instance v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$InstanceLock;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$InstanceLock;-><init>(Landroid/content/Context;)V

    .local v0, "instanceLock":Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$InstanceLock;
    if-eqz v0, :cond_3

    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v2

    :try_start_0
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstanceLocks:Ljava/util/HashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_3
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_0

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "prepare sInstanceLocks.size="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstanceLocks:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method static release(Lcom/android/internal/telephony/gsm/GsmCallTracker;)V
    .locals 3
    .param p0, "callTracker"    # Lcom/android/internal/telephony/gsm/GsmCallTracker;

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-boolean v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v0, :cond_2

    const-string v0, "GsmCallState"

    const-string v1, "release"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstanceLocks:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sget-boolean v0, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v0, :cond_0

    const-string v0, "GsmCallState"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "release sInstanceLocks.size="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sInstanceLocks:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private static removeConnection(Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/gsm/LgeConnectionState;)V
    .locals 3
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p1, "connState"    # Lcom/android/internal/telephony/gsm/LgeConnectionState;

    .prologue
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v2, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sSyncConn:Ljava/lang/Object;

    monitor-enter v2

    if-nez p1, :cond_2

    :try_start_0
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

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
    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->sConnections:Ljava/util/HashMap;

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

.method static sendCallDisconnected(Lcom/android/internal/telephony/gsm/GsmConnection;ILjava/lang/String;I)V
    .locals 4
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p1, "gsmIndex"    # I
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "cause"    # I

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-nez v1, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-static {p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v0

    .local v0, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-eqz v0, :cond_3

    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_1

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sCallDisconnected : fail cause="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    iget v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    invoke-static {v1, p2, p3}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallDisconnected(ILjava/lang/String;I)V

    :cond_2
    :goto_1
    invoke-static {p0, v0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->removeConnection(Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/gsm/LgeConnectionState;)V

    goto :goto_0

    :cond_3
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_2

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sCallDisconnected : not found, cause="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method static sendCallStatus(Lcom/android/internal/telephony/gsm/GsmConnection;ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V
    .locals 4
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p1, "gsmIndex"    # I
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "state"    # Lcom/android/internal/telephony/Call$State;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v0

    .local v0, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-eqz v0, :cond_0

    iput-object p3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_2

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sCallStatus : id="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", state="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    iget v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    iget-object v2, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    invoke-static {v1, p2, v2}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallStatus(ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V

    goto :goto_0
.end method

.method static sendFakeCallStatus(Lcom/android/internal/telephony/gsm/GsmConnection;ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V
    .locals 4
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p1, "gsmIndex"    # I
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "state"    # Lcom/android/internal/telephony/Call$State;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v0

    .local v0, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-eqz v0, :cond_0

    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_2

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sFakeCallStatus : state="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    iget v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    invoke-static {v1, p2, p3}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallStatus(ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V

    goto :goto_0
.end method

.method static updateCallStatus(Lcom/android/internal/telephony/gsm/GsmConnection;ILjava/lang/String;Lcom/android/internal/telephony/DriverCall$State;Z)V
    .locals 4
    .param p0, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p1, "gsmIndex"    # I
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "dcState"    # Lcom/android/internal/telephony/DriverCall$State;
    .param p4, "changed"    # Z

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->ENABLED:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p0}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->getLgeConnectionState(Lcom/android/internal/telephony/gsm/GsmConnection;)Lcom/android/internal/telephony/gsm/LgeConnectionState;

    move-result-object v0

    .local v0, "connState":Lcom/android/internal/telephony/gsm/LgeConnectionState;
    if-eqz v0, :cond_0

    invoke-static {v0, p2, p3, p4}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->updateCallStatusInternal(Lcom/android/internal/telephony/gsm/LgeConnectionState;Ljava/lang/String;Lcom/android/internal/telephony/DriverCall$State;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->DEBUG:Z

    if-eqz v1, :cond_2

    const-string v1, "GsmCallState"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "uCallStatus : dcState="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", state="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    iget v1, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    iget-object v2, v0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    invoke-static {v1, p2, v2}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallStatus(ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V

    goto :goto_0
.end method

.method private static updateCallStatusInternal(Lcom/android/internal/telephony/gsm/LgeConnectionState;Ljava/lang/String;Lcom/android/internal/telephony/DriverCall$State;Z)Z
    .locals 3
    .param p0, "connState"    # Lcom/android/internal/telephony/gsm/LgeConnectionState;
    .param p1, "address"    # Ljava/lang/String;
    .param p2, "dcState"    # Lcom/android/internal/telephony/DriverCall$State;
    .param p3, "changed"    # Z

    .prologue
    const/4 v0, 0x0

    sget-object v1, Lcom/android/internal/telephony/DriverCall$State;->DIALING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne p2, v1, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    sget-object v2, Lcom/android/internal/telephony/Call$State;->DIALING:Lcom/android/internal/telephony/Call$State;

    if-eq v1, v2, :cond_1

    sget-object v0, Lcom/android/internal/telephony/Call$State;->DIALING:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    :goto_0
    const/4 v0, 0x1

    :cond_0
    :goto_1
    return v0

    :cond_1
    sget-object v1, Lcom/android/internal/telephony/DriverCall$State;->INCOMING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne p2, v1, :cond_2

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    sget-object v2, Lcom/android/internal/telephony/Call$State;->INCOMING:Lcom/android/internal/telephony/Call$State;

    if-eq v1, v2, :cond_2

    sget-object v0, Lcom/android/internal/telephony/Call$State;->INCOMING:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    goto :goto_0

    :cond_2
    sget-object v1, Lcom/android/internal/telephony/DriverCall$State;->WAITING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne p2, v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    sget-object v2, Lcom/android/internal/telephony/Call$State;->WAITING:Lcom/android/internal/telephony/Call$State;

    if-eq v1, v2, :cond_3

    sget-object v0, Lcom/android/internal/telephony/Call$State;->WAITING:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    goto :goto_0

    :cond_3
    if-eqz p3, :cond_0

    sget-object v1, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster$3;->$SwitchMap$com$android$internal$telephony$DriverCall$State:[I

    invoke-virtual {p2}, Lcom/android/internal/telephony/DriverCall$State;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    sget-object v0, Lcom/android/internal/telephony/Call$State;->ALERTING:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    goto :goto_0

    :pswitch_1
    sget-object v0, Lcom/android/internal/telephony/Call$State;->WAITING:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    sget-object v1, Lcom/android/internal/telephony/Call$State;->IDLE:Lcom/android/internal/telephony/Call$State;

    if-ne v0, v1, :cond_4

    iget v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->conId:I

    sget-object v1, Lcom/android/internal/telephony/Call$State;->INCOMING:Lcom/android/internal/telephony/Call$State;

    invoke-static {v0, p1, v1}, Lcom/android/internal/telephony/gsm/TmusCallStateBroadcaster;->SendCallStatus(ILjava/lang/String;Lcom/android/internal/telephony/Call$State;)V

    :cond_4
    sget-object v0, Lcom/android/internal/telephony/Call$State;->ACTIVE:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    goto :goto_0

    :pswitch_3
    sget-object v0, Lcom/android/internal/telephony/Call$State;->HOLDING:Lcom/android/internal/telephony/Call$State;

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/LgeConnectionState;->state:Lcom/android/internal/telephony/Call$State;

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method
