.class final Lcom/lge/wfds/WfdsManager$1;
.super Ljava/lang/Object;
.source "WfdsManager.java"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/wfds/WfdsManager;->getInstance()Lcom/lge/wfds/WfdsManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public binderDied()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const-string v0, "WfdsManager"

    const-string v1, "binderDied()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    # setter for: Lcom/lge/wfds/WfdsManager;->mWfdsService:Lcom/lge/wfds/IWfdsManager;
    invoke-static {v2}, Lcom/lge/wfds/WfdsManager;->access$002(Lcom/lge/wfds/IWfdsManager;)Lcom/lge/wfds/IWfdsManager;

    # setter for: Lcom/lge/wfds/WfdsManager;->mWfdsManager:Lcom/lge/wfds/WfdsManager;
    invoke-static {v2}, Lcom/lge/wfds/WfdsManager;->access$102(Lcom/lge/wfds/WfdsManager;)Lcom/lge/wfds/WfdsManager;

    return-void
.end method
