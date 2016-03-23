.class public Landroid/telephony/LGSmsManagerImpl;
.super Ljava/lang/Object;
.source "LGSmsManagerImpl.java"

# interfaces
.implements Landroid/telephony/ILGSmsManager;


# static fields
.field private static final SMS_FORMAT_CSIM:I = 0x2


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private combineScaMsg([B[B)[B
    .locals 4
    .param p1, "encodedScAddress"    # [B
    .param p2, "encodedMessage"    # [B

    .prologue
    const/4 v3, 0x0

    array-length v1, p1

    array-length v2, p2

    add-int/2addr v1, v2

    new-array v0, v1, [B

    .local v0, "encodedMegWithSca":[B
    array-length v1, p1

    invoke-static {p1, v3, v0, v3, v1}, Ljava/lang/System;->arraycopy([BI[BII)V

    array-length v1, p1

    array-length v2, p2

    invoke-static {p2, v3, v0, v1, v2}, Ljava/lang/System;->arraycopy([BI[BII)V

    return-object v0
.end method

.method private static getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;
    .locals 1

    .prologue
    const-string v0, "isms"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/internal/telephony/ISmsEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    return-object v0
.end method

.method private makeParts(Ljava/util/ArrayList;)Ljava/util/ArrayList;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .local p1, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v4, 0x0

    .local v4, "newParts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    .local v0, "combinedString":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .local v5, "partString":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .end local v5    # "partString":Ljava/lang/String;
    :cond_0
    invoke-static {v0}, Landroid/telephony/SmsMessage;->fragmentTextEx(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v4

    if-nez v4, :cond_1

    new-instance v4, Ljava/util/ArrayList;

    .end local v4    # "newParts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .restart local v4    # "newParts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_1
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v7

    sub-int v1, v6, v7

    .local v1, "diff":I
    if-lez v1, :cond_2

    move v2, v1

    .local v2, "i":I
    :goto_1
    if-lez v2, :cond_3

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    add-int/lit8 v2, v2, -0x1

    goto :goto_1

    .end local v2    # "i":I
    :cond_2
    if-gez v1, :cond_3

    move v2, v1

    .restart local v2    # "i":I
    :goto_2
    if-gez v2, :cond_3

    const-string v6, " "

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .end local v2    # "i":I
    :cond_3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "makeParts(), parts = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "makeParts(), newParts = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    return-object v4
.end method


# virtual methods
.method public copySmsToIcc([B[BI)I
    .locals 6
    .param p1, "smsc"    # [B
    .param p2, "pdu"    # [B
    .param p3, "status"    # I

    .prologue
    const/4 v2, -0x1

    .local v2, "indexOnIcc":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "copySmsToIcc(), status = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    if-nez p2, :cond_0

    const-string v4, "copySmsToIcc(), pdu is NULL "

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move v3, v2

    .end local v2    # "indexOnIcc":I
    .local v3, "indexOnIcc":I
    :goto_0
    return v3

    .end local v3    # "indexOnIcc":I
    .restart local v2    # "indexOnIcc":I
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_1

    const-string v4, "copySmsToIcc(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    invoke-interface {v1, p3, p2, p1}, Lcom/lge/internal/telephony/ISmsEx;->copySmsToIccEf(I[B[B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_1
    :goto_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "copySmsToIcc(), indexOnIcc = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move v3, v2

    .end local v2    # "indexOnIcc":I
    .restart local v3    # "indexOnIcc":I
    goto :goto_0

    .end local v3    # "indexOnIcc":I
    .restart local v2    # "indexOnIcc":I
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v4, "copySmsToIcc(), RemoteException"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1
.end method

.method public copySmsToIccEfForSubscriber([B[BIJ)I
    .locals 8
    .param p1, "smsc"    # [B
    .param p2, "pdu"    # [B
    .param p3, "status"    # I
    .param p4, "subId"    # J

    .prologue
    const/4 v7, -0x1

    .local v7, "indexOnIcc":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "copySmsToIcc(), status = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    const-string v1, "copySmsToIcc(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    move v1, p3

    move-object v2, p2

    move-object v3, p1

    move-wide v4, p4

    invoke-interface/range {v0 .. v5}, Lcom/lge/internal/telephony/ISmsEx;->copySmsToIccEfForSubscriber(I[B[BJ)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v7

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "copySmsToIcc(), indexOnIcc = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    return v7

    :catch_0
    move-exception v6

    .local v6, "ex":Landroid/os/RemoteException;
    const-string v1, "copySmsToIcc(), RemoteException"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public copySmsToIccPrivate([B[BII)I
    .locals 4
    .param p1, "smsc"    # [B
    .param p2, "pdu"    # [B
    .param p3, "status"    # I
    .param p4, "sms_format"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "indexOnIcc":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copySmsToIccPrivate(), status = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  sms_format = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    invoke-interface {v0, p3, p2, p1, p4}, Lcom/lge/internal/telephony/ISmsEx;->copySmsToIccEfPrivate(I[B[BI)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copySmsToIccPrivate(), indexOnIcc = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    return v1

    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public deleteMessageFromIccMultiMode(II)Z
    .locals 5
    .param p1, "messageIndex"    # I
    .param p2, "smsformat"    # I

    .prologue
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "deleteMessageFromIccMultiMode(), messageIndex = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "deleteMessageFromIccMultiMode(), smsformat = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v2, 0x0

    .local v2, "success":Z
    const/4 v3, 0x2

    if-ne p2, v3, :cond_1

    const/16 v3, 0xfd

    new-array v1, v3, [B

    .local v1, "pdu":[B
    :goto_0
    const/4 v3, -0x1

    invoke-static {v1, v3}, Ljava/util/Arrays;->fill([BB)V

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    const/4 v3, 0x0

    invoke-interface {v0, p1, v3, v1, p2}, Lcom/lge/internal/telephony/ISmsEx;->updateMessageOnIccEfMultiMode(II[BI)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "deleteMessageFromIccMultiMode(), success = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    return v2

    .end local v1    # "pdu":[B
    :cond_1
    const/16 v3, 0xaf

    new-array v1, v3, [B

    .restart local v1    # "pdu":[B
    goto :goto_0

    :catch_0
    move-exception v3

    goto :goto_1
.end method

.method public disableGsmBroadcastRange(II)Z
    .locals 4
    .param p1, "startMessageId"    # I
    .param p2, "endMessageId"    # I

    .prologue
    const/4 v1, 0x0

    .local v1, "success":Z
    if-ge p2, p1, :cond_0

    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "endMessageId < startMessageId"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_1

    invoke-interface {v0, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->disableGsmBroadcastRange(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_1
    :goto_0
    return v1

    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public divideMessageEx(Ljava/lang/String;IZZ)Ljava/util/ArrayList;
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "dataCodingScheme"    # I
    .param p3, "bReplyAddress"    # Z
    .param p4, "bSafeSMS"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "IZZ)",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    invoke-static {p1, p2, p3, p4}, Landroid/telephony/SmsMessage;->fragmentTextEx(Ljava/lang/String;IZZ)Ljava/util/ArrayList;

    move-result-object v0

    return-object v0
.end method

.method public enableAutoDCDisconnect(I)V
    .locals 2
    .param p1, "timeOut"    # I

    .prologue
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    const-string v1, "enableAutoDCDisconnect(), enableAutoDCDisconnect"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->enableAutoDCDisconnect(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public enableGsmBroadcastRange(II)Z
    .locals 4
    .param p1, "startMessageId"    # I
    .param p2, "endMessageId"    # I

    .prologue
    const/4 v1, 0x0

    .local v1, "success":Z
    if-ge p2, p1, :cond_0

    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "endMessageId < startMessageId"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_1

    invoke-interface {v0, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->enableGsmBroadcastRange(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_1
    :goto_0
    return v1

    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public getMaxEfSms()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    .local v2, "maxSms":I
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    invoke-interface {v1}, Lcom/lge/internal/telephony/ISmsEx;->getMaxEfSms()I

    move-result v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getMaxEfSms(), maxSms"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getMaxEfSmsForSubscriber(J)I
    .locals 5
    .param p1, "subId"    # J

    .prologue
    const/4 v2, -0x1

    .local v2, "maxSms":I
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->getMaxEfSmsForSubscriber(J)I

    move-result v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getMaxEfSms(), maxSms"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getServiceCenterAddress()Ljava/lang/String;
    .locals 4

    .prologue
    const-string v2, ""

    .local v2, "scaddr":Ljava/lang/String;
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    invoke-interface {v1}, Lcom/lge/internal/telephony/ISmsEx;->getSmscenterAddress()Ljava/lang/String;

    move-result-object v2

    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "getServiceCenterAddress(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getSmsCenterAddressForSubscriber(J)Ljava/lang/String;
    .locals 5
    .param p1, "subId"    # J

    .prologue
    const-string v2, ""

    .local v2, "scaddr":Ljava/lang/String;
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->getSmscenterAddressForSubscriber(J)Ljava/lang/String;

    move-result-object v2

    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "getServiceCenterAddress(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getUiccType()I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .local v1, "uiccType":I
    const-string v2, "getUiccType(), start"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/lge/internal/telephony/ISmsEx;->getUiccType()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getUiccType(), uiccType: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    return v1

    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 4
    .param p1, "destUri"    # Landroid/net/Uri;
    .param p2, "values"    # Landroid/content/ContentValues;

    .prologue
    const/4 v2, 0x0

    .local v2, "insertedUri":Landroid/net/Uri;
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v3, "insertDBForLGMessage(),SmsManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "insertDBForLGMessage(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isFdnEnabled()Z
    .locals 3

    .prologue
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v2, "isFdnEnabled(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/lge/internal/telephony/ISmsEx;->isFdnEnabled()Z

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    .restart local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    const-string v2, "isFdnEnabled() function called. iccISmsEx is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "isFdnEnabled(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1
.end method

.method public isFdnEnabledOnSubscription(J)Z
    .locals 3
    .param p1, "subId"    # J

    .prologue
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v2, "isFdnEnabledOnSubscription(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->isFdnEnabledOnSubscription(J)Z

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    .restart local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    const-string v2, "isFdnEnabledOnSubscription() function called. iccISmsEx is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "isFdnEnabledOnSubscription(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1
.end method

.method public makeSimDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)[B
    .locals 13
    .param p1, "sca"    # Ljava/lang/String;
    .param p2, "oa"    # Ljava/lang/String;
    .param p3, "snippet"    # Ljava/lang/String;
    .param p4, "statusReport"    # Z
    .param p5, "time"    # J
    .param p7, "smsHeader"    # [B
    .param p8, "smsformat"    # I

    .prologue
    const/4 v3, 0x0

    const-string v4, "use_update_for_copy2sim"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    move-object v2, p1

    .local v2, "smscAddr":Ljava/lang/String;
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "makeSimDeliverPdu(), smscAddr = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "makeSimDeliverPdu(), address = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "makeSimDeliverPdu(), message body = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "makeSimDeliverPdu(), smsformat = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, p8

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-static {}, Landroid/telephony/SmsMessage;->getEncodingType()I

    move-result v9

    move-object v3, p2

    move-object/from16 v4, p3

    move/from16 v5, p4

    move-wide/from16 v6, p5

    move-object/from16 v8, p7

    move/from16 v10, p8

    invoke-static/range {v2 .. v10}, Landroid/telephony/SmsMessage;->getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BII)Landroid/telephony/SmsMessage$DeliverPdu;

    move-result-object v12

    .local v12, "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    if-eqz v12, :cond_1

    const-string v3, "makeSimDeliverPdu(), SmsMessage.DeliverPdu pdus is NOT NULL"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    iget-object v11, v12, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    :goto_1
    return-object v11

    .end local v2    # "smscAddr":Ljava/lang/String;
    .end local v12    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_0
    const/4 v2, 0x0

    .restart local v2    # "smscAddr":Ljava/lang/String;
    goto :goto_0

    .restart local v12    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_1
    const-string v3, "makeSimDeliverPdu(), SmsMessage.DeliverPdu pdus is NULL"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v11, 0x0

    goto :goto_1
.end method

.method public makeSimPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJII[B)[B
    .locals 3
    .param p1, "sca"    # Ljava/lang/String;
    .param p2, "oa"    # Ljava/lang/String;
    .param p3, "msg"    # Ljava/lang/String;
    .param p4, "statusReport"    # Z
    .param p5, "time"    # J
    .param p7, "pid"    # I
    .param p8, "dcs"    # I
    .param p9, "smsHeader"    # [B

    .prologue
    invoke-static/range {p1 .. p9}, Landroid/telephony/SmsMessage;->getStaticDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJII[B)Landroid/telephony/SmsMessage$DeliverPdu;

    move-result-object v0

    .local v0, "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    if-eqz v0, :cond_0

    iget-object v1, v0, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    if-nez v1, :cond_1

    :cond_0
    const-string v1, "makeSimPdu(), pdus = null"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_1
    iget-object v1, v0, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    goto :goto_0
.end method

.method public makeSimPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[B)[B
    .locals 11
    .param p1, "sca"    # Ljava/lang/String;
    .param p2, "oa"    # Ljava/lang/String;
    .param p3, "snippet"    # Ljava/lang/String;
    .param p4, "statusReport"    # Z
    .param p5, "time"    # J
    .param p7, "smsHeader"    # [B

    .prologue
    const/4 v1, 0x0

    const-string v2, "use_update_for_copy2sim"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    move-object v0, p1

    .local v0, "smscAddr":Ljava/lang/String;
    :goto_0
    invoke-static {}, Landroid/telephony/SmsMessage;->getEncodingType()I

    move-result v7

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move-wide/from16 v4, p5

    move-object/from16 v6, p7

    invoke-static/range {v0 .. v7}, Landroid/telephony/SmsMessage;->getDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)Landroid/telephony/SmsMessage$DeliverPdu;

    move-result-object v9

    .local v9, "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    if-eqz v9, :cond_5

    if-nez v0, :cond_2

    iget-object v8, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    :cond_0
    :goto_1
    return-object v8

    .end local v0    # "smscAddr":Ljava/lang/String;
    .end local v9    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "smscAddr":Ljava/lang/String;
    goto :goto_0

    .restart local v9    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_2
    iget-object v1, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedScAddress:[B

    if-eqz v1, :cond_3

    iget-object v1, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    if-nez v1, :cond_4

    :cond_3
    const/4 v8, 0x0

    goto :goto_1

    :cond_4
    iget-object v1, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedScAddress:[B

    iget-object v2, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    invoke-direct {p0, v1, v2}, Landroid/telephony/LGSmsManagerImpl;->combineScaMsg([B[B)[B

    move-result-object v8

    .local v8, "encodedPduWithSca":[B
    if-nez v8, :cond_0

    const-string v1, "makeSimPdu(), encodedPduWithSca is null"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    const/4 v8, 0x0

    goto :goto_1

    .end local v8    # "encodedPduWithSca":[B
    :cond_5
    const/4 v8, 0x0

    goto :goto_1
.end method

.method public makeSimSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJ[BI)[B
    .locals 9
    .param p1, "sca"    # Ljava/lang/String;
    .param p2, "da"    # Ljava/lang/String;
    .param p3, "snippet"    # Ljava/lang/String;
    .param p4, "statusReport"    # Z
    .param p5, "time"    # J
    .param p7, "smsHeader"    # [B
    .param p8, "smsformat"    # I

    .prologue
    const/4 v2, 0x0

    const-string v3, "use_update_for_copy2sim"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    move-object v1, p1

    .local v1, "smscAddr":Ljava/lang/String;
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "makeSimSubmitPdu(), smscAddr = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "makeSimSubmitPdu(), address = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "makeSimSubmitPdu(), message body = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "makeSimSubmitPdu(), smsformat = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p8

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move-object v2, p2

    move-object v3, p3

    move v4, p4

    move-object/from16 v5, p7

    move/from16 v6, p8

    invoke-static/range {v1 .. v6}, Landroid/telephony/SmsMessage;->uiccGetSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Landroid/telephony/SmsMessage$SubmitPdu;

    move-result-object v8

    .local v8, "pdus":Landroid/telephony/SmsMessage$SubmitPdu;
    if-eqz v8, :cond_1

    const-string v2, "makeSimSubmitPdu(), SmsMessage.SubmitPdu pdus is NOT NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    iget-object v7, v8, Landroid/telephony/SmsMessage$SubmitPdu;->encodedMessage:[B

    :goto_1
    return-object v7

    .end local v1    # "smscAddr":Ljava/lang/String;
    .end local v8    # "pdus":Landroid/telephony/SmsMessage$SubmitPdu;
    :cond_0
    const/4 v1, 0x0

    .restart local v1    # "smscAddr":Ljava/lang/String;
    goto :goto_0

    .restart local v8    # "pdus":Landroid/telephony/SmsMessage$SubmitPdu;
    :cond_1
    const-string v2, "makeSimSubmitPdu(), SmsMessage.SubmitPdu pdus is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v7, 0x0

    goto :goto_1
.end method

.method public notSendMsgInCall()V
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "notSendMsgInCall() | [KDDI], CALL = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "notSendMsgInCall() | [KDDI], not send msg : LGE_MODEL_KDDI_NOT_SEND_IN_CALL"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "NOW CALL Using"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method

.method public sendEmailoverMultipartTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;IZ)V
    .locals 11
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "scAddress"    # Ljava/lang/String;
    .param p6, "mSubmitPriority"    # I
    .param p7, "mSubmitIsRoaming"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;IZ)V"
        }
    .end annotation

    .prologue
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4, p4}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Ljava/util/ArrayList;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "sendEmailoverMultipartTextMessage(), Block Sending SMS in SMSManagerLGE5 by LGMDM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid destinationAddress"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-ge v3, v4, :cond_4

    :cond_3
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid message body"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_4
    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_5

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v2

    .local v2, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v2, :cond_0

    move/from16 v0, p6

    move/from16 v1, p7

    invoke-virtual {p0, v0, v1}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    invoke-static {}, Landroid/app/ActivityThread;->currentPackageName()Ljava/lang/String;

    move-result-object v3

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    move-object v7, p4

    move-object/from16 v8, p5

    invoke-interface/range {v2 .. v8}, Lcom/lge/internal/telephony/ISmsEx;->sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v2    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v3

    goto :goto_0

    :cond_5
    const/4 v7, 0x0

    .local v7, "sentIntent":Landroid/app/PendingIntent;
    const/4 v8, 0x0

    .local v8, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_6

    invoke-virtual {p4}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_6

    const/4 v3, 0x0

    invoke-virtual {p4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v7, Landroid/app/PendingIntent;

    .restart local v7    # "sentIntent":Landroid/app/PendingIntent;
    :cond_6
    if-eqz p5, :cond_7

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_7

    const/4 v3, 0x0

    move-object/from16 v0, p5

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    .end local v8    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v8, Landroid/app/PendingIntent;

    .restart local v8    # "deliveryIntent":Landroid/app/PendingIntent;
    :cond_7
    const/4 v3, 0x0

    invoke-virtual {p3, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move/from16 v9, p6

    move/from16 v10, p7

    invoke-virtual/range {v3 .. v10}, Landroid/telephony/LGSmsManagerImpl;->sendEmailoverTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;IZ)V

    goto :goto_0
.end method

.method public sendEmailoverTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;IZ)V
    .locals 7
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "scAddress"    # Ljava/lang/String;
    .param p3, "text"    # Ljava/lang/String;
    .param p4, "sentIntent"    # Landroid/app/PendingIntent;
    .param p5, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p6, "mSubmitPriority"    # I
    .param p7, "mSubmitIsRoaming"    # Z

    .prologue
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2, p4}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Landroid/app/PendingIntent;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "sendEmailoverTextMessage(), Block Sending SMS in SMSManager1 by LGMDM"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid destinationAddress"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_2
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid message body"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_3
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    invoke-virtual {p0, p6, p7}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    invoke-static {}, Landroid/app/ActivityThread;->currentPackageName()Ljava/lang/String;

    move-result-object v1

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-interface/range {v0 .. v6}, Lcom/lge/internal/telephony/ISmsEx;->sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public sendExceptionbySentIntent(Landroid/app/PendingIntent;I)V
    .locals 3
    .param p1, "sentIntent"    # Landroid/app/PendingIntent;
    .param p2, "failureCause"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "SendIntentFailure"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    const-string v1, "sendExceptionbySentIntent(), start"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    if-eqz p1, :cond_1

    :try_start_0
    invoke-virtual {p1, p2}, Landroid/app/PendingIntent;->send(I)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v1, "sendExceptionbySentIntent(), sentIntent null"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/app/PendingIntent$CanceledException;
    const-string v1, "sendExceptionbySentIntent(), CanceledException"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sendExceptionbySentIntent(Ljava/util/ArrayList;I)V
    .locals 2
    .param p2, "failureCause"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;I)V"
        }
    .end annotation

    .prologue
    .local p1, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    const/4 v0, 0x0

    .local v0, "sentIntent":Landroid/app/PendingIntent;
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_0

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v0, Landroid/app/PendingIntent;

    .restart local v0    # "sentIntent":Landroid/app/PendingIntent;
    :cond_0
    invoke-virtual {p0, v0, p2}, Landroid/telephony/LGSmsManagerImpl;->sendExceptionbySentIntent(Landroid/app/PendingIntent;I)V

    return-void
.end method

.method public sendMultipartTextMessageLge(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;IIIZ)V
    .locals 14
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "scAddress"    # Ljava/lang/String;
    .param p6, "replyAddress"    # Ljava/lang/String;
    .param p7, "confirmRead"    # I
    .param p8, "replyOption"    # I
    .param p9, "protocolId"    # I
    .param p10, "isExpectMore"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            "IIIZ)V"
        }
    .end annotation

    .prologue
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v2

    const/4 v3, 0x0

    move-object/from16 v0, p4

    invoke-interface {v2, v3, v0}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Ljava/util/ArrayList;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "sendMultipartTextMessageLge(), Block Sending SMS in SMSManagerMultiLGE by LGMDM"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid destinationAddress"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_1
    if-eqz p3, :cond_2

    invoke-virtual/range {p3 .. p3}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ge v2, v3, :cond_3

    :cond_2
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid message body"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_3
    const/4 v2, 0x0

    const-string v3, "MakePartsSendConcatMessage"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    move-object/from16 v0, p3

    invoke-direct {p0, v0}, Landroid/telephony/LGSmsManagerImpl;->makeParts(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    move-result-object p3

    :cond_4
    invoke-virtual/range {p3 .. p3}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-le v2, v3, :cond_6

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_5

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sendMultipartTextMessageLge(), sendMultipartTextMessageLge > sendMultipartTextLge(isExpectMore:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p10

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    invoke-static {}, Landroid/app/ActivityThread;->currentPackageName()Ljava/lang/String;

    move-result-object v2

    move-object v3, p1

    move-object/from16 v4, p2

    move-object/from16 v5, p3

    move-object/from16 v6, p4

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p9

    move/from16 v12, p10

    invoke-interface/range {v1 .. v12}, Lcom/lge/internal/telephony/ISmsEx;->sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;IIIZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v13

    .local v13, "ex":Landroid/os/RemoteException;
    const-string v2, "sendMultipartTextMessageLge(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .end local v13    # "ex":Landroid/os/RemoteException;
    .restart local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_5
    const/4 v2, 0x1

    :try_start_1
    move-object/from16 v0, p4

    invoke-virtual {p0, v0, v2}, Landroid/telephony/LGSmsManagerImpl;->sendExceptionbySentIntent(Ljava/util/ArrayList;I)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_6
    const/4 v6, 0x0

    .local v6, "sentIntent":Landroid/app/PendingIntent;
    const/4 v7, 0x0

    .local v7, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_7

    invoke-virtual/range {p4 .. p4}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_7

    const/4 v2, 0x0

    move-object/from16 v0, p4

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    .end local v6    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v6, Landroid/app/PendingIntent;

    .restart local v6    # "sentIntent":Landroid/app/PendingIntent;
    :cond_7
    if-eqz p5, :cond_8

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_8

    const/4 v2, 0x0

    move-object/from16 v0, p5

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v7, Landroid/app/PendingIntent;

    .restart local v7    # "deliveryIntent":Landroid/app/PendingIntent;
    :cond_8
    const-string v2, "sendMultipartTextMessageLge(), sendMultipartTextMessageLge > sendTextMessageLge"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    const/4 v2, 0x0

    move-object/from16 v0, p3

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    move-object v2, p0

    move-object v3, p1

    move-object/from16 v4, p2

    move-object/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p9

    move/from16 v12, p10

    invoke-virtual/range {v2 .. v12}, Landroid/telephony/LGSmsManagerImpl;->sendTextMessageLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V

    goto/16 :goto_0
.end method

.method public sendMultipartTextMessageWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;IZ)V
    .locals 12
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "scAddress"    # Ljava/lang/String;
    .param p6, "cbAddress"    # Ljava/lang/String;
    .param p7, "mSubmitPriority"    # I
    .param p8, "mSubmitIsRoaming"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            "IZ)V"
        }
    .end annotation

    .prologue
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    const/4 v4, 0x0

    move-object/from16 v0, p4

    invoke-interface {v3, v4, v0}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Ljava/util/ArrayList;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "SendMultipartTextMessage(), Block Sending SMS in SMSManager2-2 by LGMDM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid destinationAddress"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-ge v3, v4, :cond_4

    :cond_3
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid message body"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_4
    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_5

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v2

    .local v2, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v2, :cond_0

    move/from16 v0, p7

    move/from16 v1, p8

    invoke-virtual {p0, v0, v1}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    invoke-static {}, Landroid/app/ActivityThread;->currentPackageName()Ljava/lang/String;

    move-result-object v3

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    move-object/from16 v7, p4

    move-object/from16 v8, p5

    move-object/from16 v9, p6

    invoke-interface/range {v2 .. v9}, Lcom/lge/internal/telephony/ISmsEx;->sendMultipartTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v2    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v3

    goto :goto_0

    :cond_5
    const/4 v7, 0x0

    .local v7, "sentIntent":Landroid/app/PendingIntent;
    const/4 v8, 0x0

    .local v8, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_6

    invoke-virtual/range {p4 .. p4}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_6

    const/4 v3, 0x0

    move-object/from16 v0, p4

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v7, Landroid/app/PendingIntent;

    .restart local v7    # "sentIntent":Landroid/app/PendingIntent;
    :cond_6
    if-eqz p5, :cond_7

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_7

    const/4 v3, 0x0

    move-object/from16 v0, p5

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    .end local v8    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v8, Landroid/app/PendingIntent;

    .restart local v8    # "deliveryIntent":Landroid/app/PendingIntent;
    :cond_7
    const/4 v3, 0x0

    invoke-virtual {p3, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move-object/from16 v9, p6

    move/from16 v10, p7

    move/from16 v11, p8

    invoke-virtual/range {v3 .. v11}, Landroid/telephony/LGSmsManagerImpl;->sendTextMessageWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IZ)V

    goto :goto_0
.end method

.method public sendTextMessageLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V
    .locals 14
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "scAddress"    # Ljava/lang/String;
    .param p3, "text"    # Ljava/lang/String;
    .param p4, "sentIntent"    # Landroid/app/PendingIntent;
    .param p5, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p6, "replyAddr"    # Ljava/lang/String;
    .param p7, "confirmRead"    # I
    .param p8, "replyOption"    # I
    .param p9, "protocolId"    # I
    .param p10, "isExpectMore"    # Z

    .prologue
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v2

    const/4 v3, 0x0

    move-object/from16 v0, p4

    invoke-interface {v2, v3, v0}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Landroid/app/PendingIntent;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "sendTextMessageLge(), Block Sending SMS in SMSManagerLGE by LGMDM"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid destinationAddress"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_1
    invoke-static/range {p3 .. p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid message body"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_2
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sendTextMessageLge(), sendTextMessageLge > sendTextLge(isExpectMore:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p10

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    invoke-static {}, Landroid/app/ActivityThread;->currentPackageName()Ljava/lang/String;

    move-result-object v2

    move-object v3, p1

    move-object/from16 v4, p2

    move-object/from16 v5, p3

    move-object/from16 v6, p4

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p9

    move/from16 v12, p10

    invoke-interface/range {v1 .. v12}, Lcom/lge/internal/telephony/ISmsEx;->sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v13

    .local v13, "ex":Landroid/os/RemoteException;
    const-string v2, "sendTextMessageLge(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .end local v13    # "ex":Landroid/os/RemoteException;
    .restart local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_3
    const/4 v2, 0x1

    :try_start_1
    move-object/from16 v0, p4

    invoke-virtual {p0, v0, v2}, Landroid/telephony/LGSmsManagerImpl;->sendExceptionbySentIntent(Landroid/app/PendingIntent;I)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method public sendTextMessageWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IZ)V
    .locals 10
    .param p1, "destinationAddress"    # Ljava/lang/String;
    .param p2, "scAddress"    # Ljava/lang/String;
    .param p3, "text"    # Ljava/lang/String;
    .param p4, "sentIntent"    # Landroid/app/PendingIntent;
    .param p5, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p6, "cbAddress"    # Ljava/lang/String;
    .param p7, "mSubmitPriority"    # I
    .param p8, "mSubmitIsRoaming"    # Z

    .prologue
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4, p4}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Landroid/app/PendingIntent;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "SendTextMessage(), Block Sending SMS in SMSManager1-1 by LGMDM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid destinationAddress"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_2
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid message body"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_3
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v2

    .local v2, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v2, :cond_0

    move/from16 v0, p7

    move/from16 v1, p8

    invoke-virtual {p0, v0, v1}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    invoke-static {}, Landroid/app/ActivityThread;->currentPackageName()Ljava/lang/String;

    move-result-object v3

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    move-object v7, p4

    move-object v8, p5

    move-object/from16 v9, p6

    invoke-interface/range {v2 .. v9}, Lcom/lge/internal/telephony/ISmsEx;->sendTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v2    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method public setMultipartTextValidityPeriod(I)V
    .locals 1
    .param p1, "vp"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    if-lez p1, :cond_0

    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setMultipartTextValidityPeriod(I)V

    :cond_0
    return-void
.end method

.method public setMultipartTextValidityPeriodForSubscriber(IJ)V
    .locals 4
    .param p1, "validityperiod"    # I
    .param p2, "subId"    # J

    .prologue
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v2, "setMultipartTextValidityPeriodForSubscriber(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/internal/telephony/ISmsEx;->setMultipartTextValidityPeriodForSubscriber(IJ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "setMultipartTextValidityPeriodForSubscriber(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setOptionsBeforeSend(IIZ)V
    .locals 0
    .param p1, "vp"    # I
    .param p2, "mSubmitPriority"    # I
    .param p3, "mSubmitIsRoaming"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    invoke-virtual {p0, p1}, Landroid/telephony/LGSmsManagerImpl;->setMultipartTextValidityPeriod(I)V

    invoke-virtual {p0, p2, p3}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    return-void
.end method

.method public setOptionsBeforeSend(IZ)V
    .locals 2
    .param p1, "mSubmitPriority"    # I
    .param p2, "mSubmitIsRoaming"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    const-string v0, "cdma_priority_indicator"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0, p1}, Landroid/telephony/LGSmsManagerImpl;->setSmsPriority(I)V

    :cond_0
    const-string v0, "support_sprint_sms_roaming_guard"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0, p2}, Landroid/telephony/LGSmsManagerImpl;->setSmsIsRoaming(Z)V

    :cond_1
    return-void
.end method

.method public setServiceCenterAddress(Ljava/lang/String;)Z
    .locals 4
    .param p1, "smsc"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .local v2, "success":Z
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ISmsEx;->setSmscenterAddress(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "setServiceCenterAddress(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setSmsCenterAddressForSubscriber(Ljava/lang/String;J)Z
    .locals 4
    .param p1, "smsc"    # Ljava/lang/String;
    .param p2, "subId"    # J

    .prologue
    const/4 v2, 0x0

    .local v2, "success":Z
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3}, Lcom/lge/internal/telephony/ISmsEx;->setSmscenterAddressForSubscriber(Ljava/lang/String;J)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "setServiceCenterAddress(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setSmsIsRoaming(Z)V
    .locals 1
    .param p1, "mSubmitIsRoaming"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setSmsIsRoaming(Z)V

    :cond_0
    return-void
.end method

.method public setSmsPriority(I)V
    .locals 1
    .param p1, "mSubmitPriority"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setSmsPriority(I)V

    :cond_0
    return-void
.end method

.method public setUiccType(I)V
    .locals 3
    .param p1, "uiccType"    # I

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setUiccType(), uiccType: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setUiccType(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z
    .locals 5
    .param p1, "isOnOff"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .local v2, "retResult":Z
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LGSmsManagerImpl] smsReceptionBlockingforNIAPPolicy(), isOnOff = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ISmsEx;->smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "smsReceptionBlockingforNIAPPolicy(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public updateSmsOnSimReadStatus(IZ)Z
    .locals 3
    .param p1, "index"    # I
    .param p2, "read"    # Z

    .prologue
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v2, "updateSmsOnSimReadStatus(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->updateSmsOnSimReadStatus(IZ)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "updateSmsOnSimReadStatus(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .end local v0    # "ex":Landroid/os/RemoteException;
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public updateSmsOnSimReadStatusForSubscriber(IZJ)Z
    .locals 3
    .param p1, "index"    # I
    .param p2, "read"    # Z
    .param p3, "subId"    # J

    .prologue
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    const-string v2, "updateSmsOnSimReadStatus(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-interface {v1, p1, p2, p3, p4}, Lcom/lge/internal/telephony/ISmsEx;->updateSmsOnSimReadStatusForSubscriber(IZJ)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "updateSmsOnSimReadStatus(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .end local v0    # "ex":Landroid/os/RemoteException;
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method
