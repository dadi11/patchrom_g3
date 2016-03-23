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
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    return-void
.end method

.method private combineScaMsg([B[B)[B
    .locals 4
    .param p1, "encodedScAddress"    # [B
    .param p2, "encodedMessage"    # [B

    .prologue
    const/4 v3, 0x0

    .line 712
    array-length v1, p1

    array-length v2, p2

    add-int/2addr v1, v2

    new-array v0, v1, [B

    .line 713
    .local v0, "encodedMegWithSca":[B
    array-length v1, p1

    invoke-static {p1, v3, v0, v3, v1}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 714
    array-length v1, p1

    array-length v2, p2

    invoke-static {p2, v3, v0, v1, v2}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 715
    return-object v0
.end method

.method private static getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;
    .locals 1

    .prologue
    .line 613
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
    .line 550
    .local p1, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v4, 0x0

    .line 551
    .local v4, "newParts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    .line 552
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

    .line 553
    .local v5, "partString":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 554
    goto :goto_0

    .line 556
    .end local v5    # "partString":Ljava/lang/String;
    :cond_0
    invoke-static {v0}, Landroid/telephony/SmsMessage;->fragmentTextEx(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v4

    .line 557
    if-nez v4, :cond_1

    .line 558
    new-instance v4, Ljava/util/ArrayList;

    .end local v4    # "newParts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 561
    .restart local v4    # "newParts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_1
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v7

    sub-int v1, v6, v7

    .line 562
    .local v1, "diff":I
    if-lez v1, :cond_2

    .line 563
    move v2, v1

    .local v2, "i":I
    :goto_1
    if-lez v2, :cond_3

    .line 564
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 563
    add-int/lit8 v2, v2, -0x1

    goto :goto_1

    .line 566
    .end local v2    # "i":I
    :cond_2
    if-gez v1, :cond_3

    .line 567
    move v2, v1

    .restart local v2    # "i":I
    :goto_2
    if-gez v2, :cond_3

    .line 568
    const-string v6, " "

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 567
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 571
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

    .line 572
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

    .line 573
    return-object v4
.end method


# virtual methods
.method public copySmsToIcc([B[BI)I
    .locals 6
    .param p1, "smsc"    # [B
    .param p2, "pdu"    # [B
    .param p3, "status"    # I

    .prologue
    .line 488
    const/4 v2, -0x1

    .line 490
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

    .line 492
    if-nez p2, :cond_0

    .line 493
    const-string v4, "copySmsToIcc(), pdu is NULL "

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move v3, v2

    .line 510
    .end local v2    # "indexOnIcc":I
    .local v3, "indexOnIcc":I
    :goto_0
    return v3

    .line 498
    .end local v3    # "indexOnIcc":I
    .restart local v2    # "indexOnIcc":I
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 499
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_1

    .line 500
    const-string v4, "copySmsToIcc(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 502
    invoke-interface {v1, p3, p2, p1}, Lcom/lge/internal/telephony/ISmsEx;->copySmsToIccEf(I[B[B)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 508
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

    .line 510
    .end local v2    # "indexOnIcc":I
    .restart local v3    # "indexOnIcc":I
    goto :goto_0

    .line 504
    .end local v3    # "indexOnIcc":I
    .restart local v2    # "indexOnIcc":I
    :catch_0
    move-exception v0

    .line 505
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
    .line 844
    const/4 v7, -0x1

    .line 846
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

    .line 849
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 850
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 851
    const-string v1, "copySmsToIcc(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    move v1, p3

    move-object v2, p2

    move-object v3, p1

    move-wide v4, p4

    .line 852
    invoke-interface/range {v0 .. v5}, Lcom/lge/internal/telephony/ISmsEx;->copySmsToIccEfForSubscriber(I[B[BJ)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v7

    .line 858
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

    .line 860
    return v7

    .line 854
    :catch_0
    move-exception v6

    .line 855
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
    .line 350
    const/4 v1, -0x1

    .line 351
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

    .line 353
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 354
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 355
    invoke-interface {v0, p3, p2, p1, p4}, Lcom/lge/internal/telephony/ISmsEx;->copySmsToIccEfPrivate(I[B[BI)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 360
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

    .line 361
    return v1

    .line 357
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public deleteMessageFromIccMultiMode(II)Z
    .locals 5
    .param p1, "messageIndex"    # I
    .param p2, "smsformat"    # I

    .prologue
    .line 396
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

    .line 397
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

    .line 398
    const/4 v2, 0x0

    .line 400
    .local v2, "success":Z
    const/4 v3, 0x2

    if-ne p2, v3, :cond_1

    .line 401
    const/16 v3, 0xfd

    new-array v1, v3, [B

    .line 405
    .local v1, "pdu":[B
    :goto_0
    const/4 v3, -0x1

    invoke-static {v1, v3}, Ljava/util/Arrays;->fill([BB)V

    .line 408
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 409
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 410
    const/4 v3, 0x0

    invoke-interface {v0, p1, v3, v1, p2}, Lcom/lge/internal/telephony/ISmsEx;->updateMessageOnIccEfMultiMode(II[BI)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 415
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

    .line 416
    return v2

    .line 403
    .end local v1    # "pdu":[B
    :cond_1
    const/16 v3, 0xaf

    new-array v1, v3, [B

    .restart local v1    # "pdu":[B
    goto :goto_0

    .line 412
    :catch_0
    move-exception v3

    goto :goto_1
.end method

.method public disableGsmBroadcastRange(II)Z
    .locals 4
    .param p1, "startMessageId"    # I
    .param p2, "endMessageId"    # I

    .prologue
    .line 64
    const/4 v1, 0x0

    .line 66
    .local v1, "success":Z
    if-ge p2, p1, :cond_0

    .line 67
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "endMessageId < startMessageId"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 70
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 71
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_1

    .line 72
    invoke-interface {v0, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->disableGsmBroadcastRange(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 78
    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_1
    :goto_0
    return v1

    .line 74
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
    .line 838
    invoke-static {p1, p2, p3, p4}, Landroid/telephony/SmsMessage;->fragmentTextEx(Ljava/lang/String;IZZ)Ljava/util/ArrayList;

    move-result-object v0

    return-object v0
.end method

.method public enableAutoDCDisconnect(I)V
    .locals 2
    .param p1, "timeOut"    # I

    .prologue
    .line 518
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 519
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 520
    const-string v1, "enableAutoDCDisconnect(), enableAutoDCDisconnect"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    .line 521
    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->enableAutoDCDisconnect(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 527
    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-void

    .line 523
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public enableGsmBroadcastRange(II)Z
    .locals 4
    .param p1, "startMessageId"    # I
    .param p2, "endMessageId"    # I

    .prologue
    .line 45
    const/4 v1, 0x0

    .line 47
    .local v1, "success":Z
    if-ge p2, p1, :cond_0

    .line 48
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "endMessageId < startMessageId"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 51
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 52
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_1

    .line 53
    invoke-interface {v0, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->enableGsmBroadcastRange(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 59
    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_1
    :goto_0
    return v1

    .line 55
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public getMaxEfSms()I
    .locals 5

    .prologue
    .line 456
    const/4 v2, -0x1

    .line 459
    .local v2, "maxSms":I
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 460
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 461
    invoke-interface {v1}, Lcom/lge/internal/telephony/ISmsEx;->getMaxEfSms()I

    move-result v2

    .line 462
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

    .line 468
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    .line 464
    :catch_0
    move-exception v0

    .line 465
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getMaxEfSmsForSubscriber(J)I
    .locals 5
    .param p1, "subId"    # J

    .prologue
    .line 864
    const/4 v2, -0x1

    .line 867
    .local v2, "maxSms":I
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 868
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 869
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->getMaxEfSmsForSubscriber(J)I

    move-result v2

    .line 870
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

    .line 876
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    .line 872
    :catch_0
    move-exception v0

    .line 873
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getServiceCenterAddress()Ljava/lang/String;
    .locals 4

    .prologue
    .line 423
    const-string v2, ""

    .line 425
    .local v2, "scaddr":Ljava/lang/String;
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 426
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 427
    invoke-interface {v1}, Lcom/lge/internal/telephony/ISmsEx;->getSmscenterAddress()Ljava/lang/String;

    move-result-object v2

    .line 428
    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 434
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-object v2

    .line 430
    :catch_0
    move-exception v0

    .line 431
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "getServiceCenterAddress(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getSmsCenterAddressForSubscriber(J)Ljava/lang/String;
    .locals 5
    .param p1, "subId"    # J

    .prologue
    .line 894
    const-string v2, ""

    .line 896
    .local v2, "scaddr":Ljava/lang/String;
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 897
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 898
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->getSmscenterAddressForSubscriber(J)Ljava/lang/String;

    move-result-object v2

    .line 899
    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 905
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-object v2

    .line 901
    :catch_0
    move-exception v0

    .line 902
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "getServiceCenterAddress(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getUiccType()I
    .locals 4

    .prologue
    .line 380
    const/4 v1, -0x1

    .line 381
    .local v1, "uiccType":I
    const-string v2, "getUiccType(), start"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 383
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 384
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 385
    invoke-interface {v0}, Lcom/lge/internal/telephony/ISmsEx;->getUiccType()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 390
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

    .line 391
    return v1

    .line 387
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 4
    .param p1, "destUri"    # Landroid/net/Uri;
    .param p2, "values"    # Landroid/content/ContentValues;

    .prologue
    .line 580
    const/4 v2, 0x0

    .line 582
    .local v2, "insertedUri":Landroid/net/Uri;
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 583
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 584
    const-string v3, "insertDBForLGMessage(),SmsManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 585
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 590
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-object v2

    .line 587
    :catch_0
    move-exception v0

    .line 588
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "insertDBForLGMessage(), RemoteException"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isFdnEnabled()Z
    .locals 3

    .prologue
    .line 534
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 535
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 536
    const-string v2, "isFdnEnabled(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 537
    invoke-interface {v1}, Lcom/lge/internal/telephony/ISmsEx;->isFdnEnabled()Z

    move-result v2

    .line 543
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    .line 539
    .restart local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    const-string v2, "isFdnEnabled() function called. iccISmsEx is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 543
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    .line 540
    :catch_0
    move-exception v0

    .line 541
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "isFdnEnabled(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1
.end method

.method public isFdnEnabledOnSubscription(J)Z
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 924
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 925
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 926
    const-string v2, "isFdnEnabledOnSubscription(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 927
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->isFdnEnabledOnSubscription(J)Z

    move-result v2

    .line 933
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    .line 929
    .restart local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    const-string v2, "isFdnEnabledOnSubscription() function called. iccISmsEx is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 933
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    .line 930
    :catch_0
    move-exception v0

    .line 931
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
    .line 739
    const/4 v3, 0x0

    const-string v4, "use_update_for_copy2sim"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 740
    move-object v2, p1

    .line 744
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

    .line 745
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

    .line 746
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

    .line 747
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

    .line 748
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

    .line 757
    .local v12, "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    if-eqz v12, :cond_1

    .line 758
    const-string v3, "makeSimDeliverPdu(), SmsMessage.DeliverPdu pdus is NOT NULL"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 759
    iget-object v11, v12, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    .line 764
    :goto_1
    return-object v11

    .line 742
    .end local v2    # "smscAddr":Ljava/lang/String;
    .end local v12    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_0
    const/4 v2, 0x0

    .restart local v2    # "smscAddr":Ljava/lang/String;
    goto :goto_0

    .line 761
    .restart local v12    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_1
    const-string v3, "makeSimDeliverPdu(), SmsMessage.DeliverPdu pdus is NULL"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 762
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
    .line 722
    invoke-static/range {p1 .. p9}, Landroid/telephony/SmsMessage;->getStaticDeliverPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZJII[B)Landroid/telephony/SmsMessage$DeliverPdu;

    move-result-object v0

    .line 725
    .local v0, "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    if-eqz v0, :cond_0

    iget-object v1, v0, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    if-nez v1, :cond_1

    .line 726
    :cond_0
    const-string v1, "makeSimPdu(), pdus = null"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 727
    const/4 v1, 0x0

    .line 729
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
    .line 677
    const/4 v1, 0x0

    const-string v2, "use_update_for_copy2sim"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 678
    move-object v0, p1

    .line 682
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

    .line 690
    .local v9, "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    if-eqz v9, :cond_5

    .line 691
    if-nez v0, :cond_2

    .line 692
    iget-object v8, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    .line 708
    :cond_0
    :goto_1
    return-object v8

    .line 680
    .end local v0    # "smscAddr":Ljava/lang/String;
    .end local v9    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "smscAddr":Ljava/lang/String;
    goto :goto_0

    .line 694
    .restart local v9    # "pdus":Landroid/telephony/SmsMessage$DeliverPdu;
    :cond_2
    iget-object v1, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedScAddress:[B

    if-eqz v1, :cond_3

    iget-object v1, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    if-nez v1, :cond_4

    .line 696
    :cond_3
    const/4 v8, 0x0

    goto :goto_1

    .line 698
    :cond_4
    iget-object v1, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedScAddress:[B

    iget-object v2, v9, Landroid/telephony/SmsMessage$DeliverPdu;->encodedMessage:[B

    invoke-direct {p0, v1, v2}, Landroid/telephony/LGSmsManagerImpl;->combineScaMsg([B[B)[B

    move-result-object v8

    .line 699
    .local v8, "encodedPduWithSca":[B
    if-nez v8, :cond_0

    .line 700
    const-string v1, "makeSimPdu(), encodedPduWithSca is null"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 701
    const/4 v8, 0x0

    goto :goto_1

    .line 706
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
    .line 771
    const/4 v2, 0x0

    const-string v3, "use_update_for_copy2sim"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 772
    move-object v1, p1

    .line 776
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

    .line 777
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

    .line 778
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

    .line 779
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

    .line 780
    invoke-static/range {v1 .. v6}, Landroid/telephony/SmsMessage;->uiccGetSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z[BI)Landroid/telephony/SmsMessage$SubmitPdu;

    move-result-object v8

    .line 787
    .local v8, "pdus":Landroid/telephony/SmsMessage$SubmitPdu;
    if-eqz v8, :cond_1

    .line 788
    const-string v2, "makeSimSubmitPdu(), SmsMessage.SubmitPdu pdus is NOT NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 789
    iget-object v7, v8, Landroid/telephony/SmsMessage$SubmitPdu;->encodedMessage:[B

    .line 794
    :goto_1
    return-object v7

    .line 774
    .end local v1    # "smscAddr":Ljava/lang/String;
    .end local v8    # "pdus":Landroid/telephony/SmsMessage$SubmitPdu;
    :cond_0
    const/4 v1, 0x0

    .restart local v1    # "smscAddr":Ljava/lang/String;
    goto :goto_0

    .line 791
    .restart local v8    # "pdus":Landroid/telephony/SmsMessage$SubmitPdu;
    :cond_1
    const-string v2, "makeSimSubmitPdu(), SmsMessage.SubmitPdu pdus is NULL"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 792
    const/4 v7, 0x0

    goto :goto_1
.end method

.method public notSendMsgInCall()V
    .locals 2

    .prologue
    .line 665
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

    .line 666
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v0

    if-eqz v0, :cond_0

    .line 667
    const-string v0, "notSendMsgInCall() | [KDDI], not send msg : LGE_MODEL_KDDI_NOT_SEND_IN_CALL"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 668
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "NOW CALL Using"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 670
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
    .line 304
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

    .line 306
    const-string v3, "sendEmailoverMultipartTextMessage(), Block Sending SMS in SMSManagerLGE5 by LGMDM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 344
    :cond_0
    :goto_0
    return-void

    .line 312
    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 313
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid destinationAddress"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 315
    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-ge v3, v4, :cond_4

    .line 316
    :cond_3
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid message body"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 319
    :cond_4
    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_5

    .line 321
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v2

    .line 322
    .local v2, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v2, :cond_0

    .line 323
    move/from16 v0, p6

    move/from16 v1, p7

    invoke-virtual {p0, v0, v1}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    .line 325
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

    .line 328
    .end local v2    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v3

    goto :goto_0

    .line 332
    :cond_5
    const/4 v7, 0x0

    .line 333
    .local v7, "sentIntent":Landroid/app/PendingIntent;
    const/4 v8, 0x0

    .line 334
    .local v8, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_6

    invoke-virtual {p4}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_6

    .line 335
    const/4 v3, 0x0

    invoke-virtual {p4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v7, Landroid/app/PendingIntent;

    .line 337
    .restart local v7    # "sentIntent":Landroid/app/PendingIntent;
    :cond_6
    if-eqz p5, :cond_7

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_7

    .line 338
    const/4 v3, 0x0

    move-object/from16 v0, p5

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    .end local v8    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v8, Landroid/app/PendingIntent;

    .line 340
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
    .line 121
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2, p4}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Landroid/app/PendingIntent;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 123
    const-string v1, "sendEmailoverTextMessage(), Block Sending SMS in SMSManager1 by LGMDM"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 146
    :cond_0
    :goto_0
    return-void

    .line 128
    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 129
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid destinationAddress"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 132
    :cond_2
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 133
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid message body"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 137
    :cond_3
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 138
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 139
    invoke-virtual {p0, p6, p7}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    .line 140
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

    .line 142
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
    .line 808
    const/4 v1, 0x0

    const-string v2, "SendIntentFailure"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 809
    const-string v1, "sendExceptionbySentIntent(), start"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 811
    if-eqz p1, :cond_1

    .line 812
    :try_start_0
    invoke-virtual {p1, p2}, Landroid/app/PendingIntent;->send(I)V

    .line 820
    :cond_0
    :goto_0
    return-void

    .line 814
    :cond_1
    const-string v1, "sendExceptionbySentIntent(), sentIntent null"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 816
    :catch_0
    move-exception v0

    .line 817
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
    .line 800
    .local p1, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    const/4 v0, 0x0

    .line 801
    .local v0, "sentIntent":Landroid/app/PendingIntent;
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 802
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v0, Landroid/app/PendingIntent;

    .line 804
    .restart local v0    # "sentIntent":Landroid/app/PendingIntent;
    :cond_0
    invoke-virtual {p0, v0, p2}, Landroid/telephony/LGSmsManagerImpl;->sendExceptionbySentIntent(Landroid/app/PendingIntent;I)V

    .line 805
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
    .line 193
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

    .line 195
    const-string v2, "sendMultipartTextMessageLge(), Block Sending SMS in SMSManagerMultiLGE by LGMDM"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 246
    :goto_0
    return-void

    .line 200
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 201
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid destinationAddress"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 203
    :cond_1
    if-eqz p3, :cond_2

    invoke-virtual/range {p3 .. p3}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ge v2, v3, :cond_3

    .line 204
    :cond_2
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid message body"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 208
    :cond_3
    const/4 v2, 0x0

    const-string v3, "MakePartsSendConcatMessage"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 209
    move-object/from16 v0, p3

    invoke-direct {p0, v0}, Landroid/telephony/LGSmsManagerImpl;->makeParts(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    move-result-object p3

    .line 213
    :cond_4
    invoke-virtual/range {p3 .. p3}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-le v2, v3, :cond_6

    .line 215
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 216
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_5

    .line 217
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

    .line 218
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

    .line 225
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v13

    .line 228
    .local v13, "ex":Landroid/os/RemoteException;
    const-string v2, "sendMultipartTextMessageLge(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .line 222
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

    .line 234
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_6
    const/4 v6, 0x0

    .line 235
    .local v6, "sentIntent":Landroid/app/PendingIntent;
    const/4 v7, 0x0

    .line 236
    .local v7, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_7

    invoke-virtual/range {p4 .. p4}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_7

    .line 237
    const/4 v2, 0x0

    move-object/from16 v0, p4

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    .end local v6    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v6, Landroid/app/PendingIntent;

    .line 239
    .restart local v6    # "sentIntent":Landroid/app/PendingIntent;
    :cond_7
    if-eqz p5, :cond_8

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_8

    .line 240
    const/4 v2, 0x0

    move-object/from16 v0, p5

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v7, Landroid/app/PendingIntent;

    .line 242
    .restart local v7    # "deliveryIntent":Landroid/app/PendingIntent;
    :cond_8
    const-string v2, "sendMultipartTextMessageLge(), sendMultipartTextMessageLge > sendTextMessageLge"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 243
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
    .line 257
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

    .line 259
    const-string v3, "SendMultipartTextMessage(), Block Sending SMS in SMSManager2-2 by LGMDM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 294
    :cond_0
    :goto_0
    return-void

    .line 264
    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 265
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid destinationAddress"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 267
    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-ge v3, v4, :cond_4

    .line 268
    :cond_3
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid message body"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 270
    :cond_4
    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_5

    .line 272
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v2

    .line 273
    .local v2, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v2, :cond_0

    .line 274
    move/from16 v0, p7

    move/from16 v1, p8

    invoke-virtual {p0, v0, v1}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    .line 276
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

    .line 279
    .end local v2    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v3

    goto :goto_0

    .line 283
    :cond_5
    const/4 v7, 0x0

    .line 284
    .local v7, "sentIntent":Landroid/app/PendingIntent;
    const/4 v8, 0x0

    .line 285
    .local v8, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_6

    invoke-virtual/range {p4 .. p4}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_6

    .line 286
    const/4 v3, 0x0

    move-object/from16 v0, p4

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v7, Landroid/app/PendingIntent;

    .line 288
    .restart local v7    # "sentIntent":Landroid/app/PendingIntent;
    :cond_6
    if-eqz p5, :cond_7

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_7

    .line 289
    const/4 v3, 0x0

    move-object/from16 v0, p5

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    .end local v8    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v8, Landroid/app/PendingIntent;

    .line 291
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
    .line 156
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

    .line 158
    const-string v2, "sendTextMessageLge(), Block Sending SMS in SMSManagerLGE by LGMDM"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 188
    :goto_0
    return-void

    .line 163
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 164
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid destinationAddress"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 167
    :cond_1
    invoke-static/range {p3 .. p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 168
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Invalid message body"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 171
    :cond_2
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 172
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_3

    .line 173
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

    .line 174
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

    .line 181
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :catch_0
    move-exception v13

    .line 184
    .local v13, "ex":Landroid/os/RemoteException;
    const-string v2, "sendTextMessageLge(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .line 178
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
    .line 87
    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4, p4}, Lcom/lge/cappuccino/IMdm;->isAllowSendMessage(Landroid/content/ComponentName;Landroid/app/PendingIntent;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 89
    const-string v3, "SendTextMessage(), Block Sending SMS in SMSManager1-1 by LGMDM"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 112
    :cond_0
    :goto_0
    return-void

    .line 93
    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 94
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid destinationAddress"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 97
    :cond_2
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 98
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Invalid message body"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 102
    :cond_3
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v2

    .line 103
    .local v2, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v2, :cond_0

    .line 104
    move/from16 v0, p7

    move/from16 v1, p8

    invoke-virtual {p0, v0, v1}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    .line 106
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

    .line 108
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
    .line 617
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 618
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 619
    if-lez p1, :cond_0

    .line 620
    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setMultipartTextValidityPeriod(I)V

    .line 624
    :cond_0
    return-void
.end method

.method public setMultipartTextValidityPeriodForSubscriber(IJ)V
    .locals 4
    .param p1, "validityperiod"    # I
    .param p2, "subId"    # J

    .prologue
    .line 940
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 941
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 942
    const-string v2, "setMultipartTextValidityPeriodForSubscriber(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->f(Ljava/lang/String;)I

    .line 943
    invoke-interface {v1, p1, p2, p3}, Lcom/lge/internal/telephony/ISmsEx;->setMultipartTextValidityPeriodForSubscriber(IJ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 948
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-void

    .line 945
    :catch_0
    move-exception v0

    .line 946
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
    .line 642
    invoke-virtual {p0, p1}, Landroid/telephony/LGSmsManagerImpl;->setMultipartTextValidityPeriod(I)V

    .line 645
    invoke-virtual {p0, p2, p3}, Landroid/telephony/LGSmsManagerImpl;->setOptionsBeforeSend(IZ)V

    .line 647
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

    .line 650
    const-string v0, "cdma_priority_indicator"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 651
    invoke-virtual {p0, p1}, Landroid/telephony/LGSmsManagerImpl;->setSmsPriority(I)V

    .line 656
    :cond_0
    const-string v0, "support_sprint_sms_roaming_guard"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 657
    invoke-virtual {p0, p2}, Landroid/telephony/LGSmsManagerImpl;->setSmsIsRoaming(Z)V

    .line 660
    :cond_1
    return-void
.end method

.method public setServiceCenterAddress(Ljava/lang/String;)Z
    .locals 4
    .param p1, "smsc"    # Ljava/lang/String;

    .prologue
    .line 439
    const/4 v2, 0x0

    .line 441
    .local v2, "success":Z
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 442
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 443
    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 444
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ISmsEx;->setSmscenterAddress(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 449
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    .line 446
    :catch_0
    move-exception v0

    .line 447
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
    .line 909
    const/4 v2, 0x0

    .line 911
    .local v2, "success":Z
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 912
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 913
    const-string v3, "getServiceCenterAddress(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 914
    invoke-interface {v1, p1, p2, p3}, Lcom/lge/internal/telephony/ISmsEx;->setSmscenterAddressForSubscriber(Ljava/lang/String;J)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 919
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    .line 916
    :catch_0
    move-exception v0

    .line 917
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
    .line 634
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 635
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 636
    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setSmsIsRoaming(Z)V

    .line 638
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
    .line 627
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 628
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 629
    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setSmsPriority(I)V

    .line 631
    :cond_0
    return-void
.end method

.method public setUiccType(I)V
    .locals 3
    .param p1, "uiccType"    # I

    .prologue
    .line 366
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

    .line 368
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v0

    .line 369
    .local v0, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v0, :cond_0

    .line 370
    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ISmsEx;->setUiccType(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 376
    .end local v0    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return-void

    .line 372
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z
    .locals 5
    .param p1, "isOnOff"    # Ljava/lang/String;

    .prologue
    .line 597
    const/4 v2, 0x0

    .line 599
    .local v2, "retResult":Z
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 600
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 601
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

    .line 602
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ISmsEx;->smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 607
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :cond_0
    :goto_0
    return v2

    .line 604
    :catch_0
    move-exception v0

    .line 605
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
    .line 474
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 475
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 476
    const-string v2, "updateSmsOnSimReadStatus(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 477
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ISmsEx;->updateSmsOnSimReadStatus(IZ)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 483
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    .line 479
    :catch_0
    move-exception v0

    .line 480
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "updateSmsOnSimReadStatus(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 483
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
    .line 881
    :try_start_0
    invoke-static {}, Landroid/telephony/LGSmsManagerImpl;->getSmsInterface()Lcom/lge/internal/telephony/ISmsEx;

    move-result-object v1

    .line 882
    .local v1, "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    if-eqz v1, :cond_0

    .line 883
    const-string v2, "updateSmsOnSimReadStatus(), SmsManager --> IccSmsInterfaceManager"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 884
    invoke-interface {v1, p1, p2, p3, p4}, Lcom/lge/internal/telephony/ISmsEx;->updateSmsOnSimReadStatusForSubscriber(IZJ)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 890
    .end local v1    # "iccISmsEx":Lcom/lge/internal/telephony/ISmsEx;
    :goto_0
    return v2

    .line 886
    :catch_0
    move-exception v0

    .line 887
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v2, "updateSmsOnSimReadStatus(), RemoteException"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 890
    .end local v0    # "ex":Landroid/os/RemoteException;
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method
