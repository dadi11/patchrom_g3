.class public Lcom/android/internal/telephony/WapPushOverSmsEx;
.super Lcom/android/internal/telephony/WapPushOverSms;
.source "WapPushOverSmsEx.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/WapPushOverSms;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method protected checkStateLockAndWipe(Ljava/lang/String;J)Z
    .locals 6
    .param p1, "mimeType"    # Ljava/lang/String;
    .param p2, "binaryContentType"    # J

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    if-nez p1, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/WapPushOverSmsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "OMADM_LOCK_STATE"

    invoke-static {v3, v4, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "dmLockState":I
    if-ne v0, v1, :cond_1

    long-to-int v3, p2

    const/16 v4, 0x45

    if-eq v3, v4, :cond_1

    long-to-int v3, p2

    const/16 v4, 0x44

    if-eq v3, v4, :cond_1

    const-string v2, "dispatchWapPdu: -Lock and Wipe - enabled -Block Inbound WAP push"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :goto_0
    return v1

    .end local v0    # "dmLockState":I
    :cond_0
    iget-object v3, p0, Lcom/android/internal/telephony/WapPushOverSmsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "OMADM_LOCK_STATE"

    invoke-static {v3, v4, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .restart local v0    # "dmLockState":I
    if-ne v0, v1, :cond_1

    const-string v2, "dispatchWapPdu: -Lock and Wipe - enabled -Block Inbound WAP push"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_0
.end method

.method protected checkWapPushWithSpam([BLandroid/content/BroadcastReceiver;ZIILjava/lang/String;)Z
    .locals 7
    .param p1, "pdu"    # [B
    .param p2, "receiver"    # Landroid/content/BroadcastReceiver;
    .param p3, "thisIsSpam"    # Z
    .param p4, "headerLength"    # I
    .param p5, "headerStartIndex"    # I
    .param p6, "mimeType"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mimeType = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    if-eqz p6, :cond_0

    const-string v5, "application/vnd.wap.mms-message"

    invoke-virtual {p6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    :cond_0
    :goto_0
    return v4

    :cond_1
    add-int v0, p5, p4

    .local v0, "dataIndex":I
    array-length v5, p1

    sub-int/2addr v5, v0

    new-array v3, v5, [B

    .local v3, "spamcheckdata":[B
    array-length v5, v3

    invoke-static {p1, v0, v3, v4, v5}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget-object v5, p0, Lcom/android/internal/telephony/WapPushOverSmsEx;->mContext:Landroid/content/Context;

    invoke-static {v3, v5, p2}, Lcom/android/internal/telephony/LGSmsTelephonyManager;->getOperatorSpamMessage([BLandroid/content/Context;Landroid/content/BroadcastReceiver;)Lcom/lge/telephony/SmsOperatorBasicMessage;

    move-result-object v2

    .local v2, "spamMessage":Lcom/lge/telephony/SmsOperatorBasicMessage;
    if-eqz v2, :cond_2

    invoke-interface {v2}, Lcom/lge/telephony/SmsOperatorBasicMessage;->getInformation()Landroid/os/Bundle;

    move-result-object v1

    .local v1, "info":Landroid/os/Bundle;
    if-eqz v1, :cond_2

    const-string v5, "spam_result"

    invoke-virtual {v1, v5, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p3

    .end local v1    # "info":Landroid/os/Bundle;
    :cond_2
    move v4, p3

    goto :goto_0
.end method

.method protected getContentLockAndWipe(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "mimeType"    # Ljava/lang/String;
    .param p2, "contentType"    # Ljava/lang/String;

    .prologue
    const-wide/16 v0, 0x45

    invoke-static {v0, v1}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "OMADM NIA - mimeType = application/vnd.syncml.notification"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const-string p1, "application/vnd.syncml.notification"

    :cond_0
    return-object p1
.end method

.method protected getValidWapPduIndex()I
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/WapPushOverSmsEx;->mContext:Landroid/content/Context;

    const-string v1, "support_sprint_lock_and_wipe"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "getValidWapPduIndex(),[SPR] get normal index"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v0, 0x4

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/WapPushOverSmsEx;->mContext:Landroid/content/Context;

    const-string v1, "kddi_cdma_wap_push"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    const-string v0, "dispatchWapPdu(),[KDDI] get normal index"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v0, 0x7

    goto :goto_0

    :cond_1
    const-string v0, "reparseValidWapPduIndex(), Received non-PUSH WAP PDU"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->w(Ljava/lang/String;)I

    const/4 v0, -0x1

    goto :goto_0
.end method
