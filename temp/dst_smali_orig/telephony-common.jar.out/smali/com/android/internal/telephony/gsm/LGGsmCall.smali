.class public Lcom/android/internal/telephony/gsm/LGGsmCall;
.super Ljava/lang/Object;
.source "LGGsmCall.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "LGGsmCall"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static hangupAllCalls(Lcom/android/internal/telephony/Call;)V
    .locals 12
    .param p0, "call"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x0

    .local v7, "hungUp":Z
    :try_start_0
    instance-of v9, p0, Lcom/android/internal/telephony/gsm/GsmCall;

    if-eqz v9, :cond_4

    move-object v0, p0

    check-cast v0, Lcom/android/internal/telephony/gsm/GsmCall;

    move-object v4, v0

    .local v4, "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    invoke-virtual {v4}, Lcom/android/internal/telephony/gsm/GsmCall;->getPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/gsm/GSMPhone;

    .local v6, "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v5

    check-cast v5, Lcom/android/internal/telephony/gsm/GsmCallTracker;

    .local v5, "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getRingingCall()Lcom/android/internal/telephony/Call;

    move-result-object v8

    check-cast v8, Lcom/android/internal/telephony/gsm/GsmCall;

    .local v8, "ringingCall":Lcom/android/internal/telephony/gsm/GsmCall;
    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getForegroundCall()Lcom/android/internal/telephony/gsm/GsmCall;

    move-result-object v3

    .local v3, "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getBackgroundCall()Lcom/android/internal/telephony/gsm/GsmCall;

    move-result-object v1

    .local v1, "backgroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    invoke-virtual {v8}, Lcom/android/internal/telephony/gsm/GsmCall;->isIdle()Z

    move-result v9

    if-nez v9, :cond_0

    invoke-virtual {v8}, Lcom/android/internal/telephony/gsm/GsmCall;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v9

    sget-object v10, Lcom/android/internal/telephony/Call$State;->WAITING:Lcom/android/internal/telephony/Call$State;

    if-eq v9, v10, :cond_0

    const-string v9, "hangupAllCalls: hang up ringing call"

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmCall;->log(Ljava/lang/String;)V

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->hangupWaitingOrBackground()V

    invoke-virtual {v8}, Lcom/android/internal/telephony/gsm/GsmCall;->onHangupLocal()V

    const/4 v7, 0x1

    :cond_0
    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->isIdle()Z

    move-result v9

    if-nez v9, :cond_1

    const-string v9, "hangupAllCalls: hang up active call"

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmCall;->log(Ljava/lang/String;)V

    invoke-virtual {v5, v3}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->hangupAllConnections(Lcom/android/internal/telephony/gsm/GsmCall;)V

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->onHangupLocal()V

    const/4 v7, 0x1

    :cond_1
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GsmCall;->isIdle()Z

    move-result v9

    if-nez v9, :cond_2

    const-string v9, "hangupAllCalls: hang up held call"

    invoke-static {v9}, Lcom/android/internal/telephony/gsm/LGGsmCall;->log(Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->hangupAllConnections(Lcom/android/internal/telephony/gsm/GsmCall;)V

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GsmCall;->onHangupLocal()V

    const/4 v7, 0x1

    :cond_2
    if-eqz v7, :cond_3

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->notifyPreciseCallStateChanged()V

    .end local v1    # "backgroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v3    # "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v4    # "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v5    # "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    .end local v6    # "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    .end local v8    # "ringingCall":Lcom/android/internal/telephony/gsm/GsmCall;
    :goto_0
    return-void

    .restart local v1    # "backgroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .restart local v3    # "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .restart local v4    # "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    .restart local v5    # "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    .restart local v6    # "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    .restart local v8    # "ringingCall":Lcom/android/internal/telephony/gsm/GsmCall;
    :cond_3
    new-instance v9, Lcom/android/internal/telephony/CallStateException;

    const-string v10, "no active connections to hangup"

    invoke-direct {v9, v10}, Lcom/android/internal/telephony/CallStateException;-><init>(Ljava/lang/String;)V

    throw v9
    :try_end_0
    .catch Lcom/android/internal/telephony/CallStateException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "backgroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v3    # "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v4    # "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v5    # "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    .end local v6    # "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    .end local v8    # "ringingCall":Lcom/android/internal/telephony/gsm/GsmCall;
    :catch_0
    move-exception v2

    .local v2, "ex":Lcom/android/internal/telephony/CallStateException;
    const-string v9, "LGGsmCall"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "hangup all calls: caught "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "ex":Lcom/android/internal/telephony/CallStateException;
    :cond_4
    :try_start_1
    new-instance v9, Lcom/android/internal/telephony/CallStateException;

    const-string v10, "hangupAllCalls: Unsupported Action"

    invoke-direct {v9, v10}, Lcom/android/internal/telephony/CallStateException;-><init>(Ljava/lang/String;)V

    throw v9
    :try_end_1
    .catch Lcom/android/internal/telephony/CallStateException; {:try_start_1 .. :try_end_1} :catch_0
.end method

.method public static hangupNotResume(Lcom/android/internal/telephony/Call;)V
    .locals 9
    .param p0, "call"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    :try_start_0
    instance-of v6, p0, Lcom/android/internal/telephony/gsm/GsmCall;

    if-eqz v6, :cond_3

    move-object v0, p0

    check-cast v0, Lcom/android/internal/telephony/gsm/GsmCall;

    move-object v3, v0

    .local v3, "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->getPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v5

    check-cast v5, Lcom/android/internal/telephony/gsm/GSMPhone;

    .local v5, "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v4

    check-cast v4, Lcom/android/internal/telephony/gsm/GsmCallTracker;

    .local v4, "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getForegroundCall()Lcom/android/internal/telephony/gsm/GsmCall;

    move-result-object v2

    .local v2, "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->getConnections()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    if-nez v6, :cond_0

    new-instance v6, Lcom/android/internal/telephony/CallStateException;

    const-string v7, "no connections in call"

    invoke-direct {v6, v7}, Lcom/android/internal/telephony/CallStateException;-><init>(Ljava/lang/String;)V

    throw v6
    :try_end_0
    .catch Lcom/android/internal/telephony/CallStateException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v3    # "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v4    # "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    .end local v5    # "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    :catch_0
    move-exception v1

    .local v1, "ex":Lcom/android/internal/telephony/CallStateException;
    const-string v6, "LGGsmCall"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "hangupNotResume: caught "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v1    # "ex":Lcom/android/internal/telephony/CallStateException;
    :goto_0
    return-void

    .restart local v2    # "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .restart local v3    # "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    .restart local v4    # "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    .restart local v5    # "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    :cond_0
    if-ne v3, v2, :cond_2

    :try_start_1
    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->isDialingOrAlerting()Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v6, "(foregnd) hangupNotResume dialing or alerting..."

    invoke-static {v6}, Lcom/android/internal/telephony/gsm/LGGsmCall;->log(Ljava/lang/String;)V

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->getConnections()Ljava/util/List;

    move-result-object v6

    const/4 v7, 0x0

    invoke-interface {v6, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/gsm/GsmConnection;

    check-cast v6, Lcom/android/internal/telephony/gsm/GsmConnection;

    invoke-virtual {v4, v6}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->hangup(Lcom/android/internal/telephony/gsm/GsmConnection;)V

    :goto_1
    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->onHangupLocal()V

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->notifyPreciseCallStateChanged()V

    goto :goto_0

    :cond_1
    invoke-virtual {v4, v3}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->hangupAllConnections(Lcom/android/internal/telephony/gsm/GsmCall;)V

    goto :goto_1

    :cond_2
    new-instance v6, Ljava/lang/RuntimeException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "GsmCall "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "does not belong to GsmCallTracker "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v6

    .end local v2    # "foregroundCall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v3    # "gsmcall":Lcom/android/internal/telephony/gsm/GsmCall;
    .end local v4    # "gsmcalltracker":Lcom/android/internal/telephony/gsm/GsmCallTracker;
    .end local v5    # "gsmphone":Lcom/android/internal/telephony/gsm/GSMPhone;
    :cond_3
    new-instance v6, Lcom/android/internal/telephony/CallStateException;

    const-string v7, "hangupNotResume: Unsupported Action"

    invoke-direct {v6, v7}, Lcom/android/internal/telephony/CallStateException;-><init>(Ljava/lang/String;)V

    throw v6
    :try_end_1
    .catch Lcom/android/internal/telephony/CallStateException; {:try_start_1 .. :try_end_1} :catch_0
.end method

.method protected static isSrvccConnection(Lcom/android/internal/telephony/Connection;)Z
    .locals 6
    .param p0, "conn"    # Lcom/android/internal/telephony/Connection;

    .prologue
    const/4 v5, 0x0

    if-nez p0, :cond_0

    move v4, v5

    :goto_0
    return v4

    :cond_0
    instance-of v4, p0, Lcom/android/internal/telephony/gsm/GsmConnection;

    if-nez v4, :cond_1

    move v4, v5

    goto :goto_0

    :cond_1
    move-object v4, p0

    check-cast v4, Lcom/android/internal/telephony/gsm/GsmConnection;

    iget v4, v4, Lcom/android/internal/telephony/gsm/GsmConnection;->mIndex:I

    if-eqz v4, :cond_2

    move v4, v5

    goto :goto_0

    :cond_2
    move-object v4, p0

    check-cast v4, Lcom/android/internal/telephony/gsm/GsmConnection;

    invoke-virtual {v4}, Lcom/android/internal/telephony/gsm/GsmConnection;->getCall()Lcom/android/internal/telephony/gsm/GsmCall;

    move-result-object v3

    .local v3, "parent":Lcom/android/internal/telephony/gsm/GsmCall;
    if-nez v3, :cond_3

    move v4, v5

    goto :goto_0

    :cond_3
    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmCall;->getConnections()Ljava/util/List;

    move-result-object v1

    .local v1, "conns":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/Connection;>;"
    if-nez v1, :cond_4

    move v4, v5

    goto :goto_0

    :cond_4
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_5
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/Connection;

    .local v0, "c":Lcom/android/internal/telephony/Connection;
    if-eq v0, p0, :cond_5

    check-cast v0, Lcom/android/internal/telephony/gsm/GsmConnection;

    .end local v0    # "c":Lcom/android/internal/telephony/Connection;
    iget v4, v0, Lcom/android/internal/telephony/gsm/GsmConnection;->mIndex:I

    if-nez v4, :cond_5

    const/4 v4, 0x1

    goto :goto_0

    :cond_6
    move v4, v5

    goto :goto_0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGGsmCall"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
