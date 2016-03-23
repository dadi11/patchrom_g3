.class final Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;
.super Lcom/lge/internal/telephony/ISmsEx$Stub;
.source "UiccSmsControllerEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/UiccSmsControllerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "ExtendedBinderInternal"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/UiccSmsControllerEx;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-direct {p0}, Lcom/lge/internal/telephony/ISmsEx$Stub;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/telephony/UiccSmsControllerEx;Lcom/android/internal/telephony/UiccSmsControllerEx$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/telephony/UiccSmsControllerEx;
    .param p2, "x1"    # Lcom/android/internal/telephony/UiccSmsControllerEx$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;-><init>(Lcom/android/internal/telephony/UiccSmsControllerEx;)V

    return-void
.end method

.method private getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    .locals 7
    .param p1, "subId"    # J

    .prologue
    const/4 v3, 0x0

    invoke-static {}, Lcom/android/internal/telephony/SubscriptionController;->getInstance()Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v2

    invoke-virtual {v2, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getPhoneId(J)I

    move-result v1

    .local v1, "phoneId":I
    invoke-static {v1}, Landroid/telephony/SubscriptionManager;->isValidPhoneId(I)Z

    move-result v2

    if-eqz v2, :cond_0

    const v2, 0x7fffffff

    if-ne v1, v2, :cond_1

    :cond_0
    const/4 v1, 0x0

    :cond_1
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/UiccSmsControllerEx;->mPhone:[Lcom/android/internal/telephony/Phone;

    aget-object v2, v2, v1

    check-cast v2, Lcom/android/internal/telephony/PhoneProxy;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneProxy;->getIccSmsInterfaceManager()Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v2, "RIL_UiccSmsControllerEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception is :"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/NullPointerException;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " For subscription :"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    move-object v2, v3

    goto :goto_0

    .end local v0    # "e":Ljava/lang/NullPointerException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/ArrayIndexOutOfBoundsException;
    const-string v2, "RIL_UiccSmsControllerEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception is :"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/ArrayIndexOutOfBoundsException;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " For subscription :"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Ljava/lang/ArrayIndexOutOfBoundsException;->printStackTrace()V

    move-object v2, v3

    goto :goto_0
.end method


# virtual methods
.method public copySmsToIccEf(I[B[B)I
    .locals 4
    .param p1, "status"    # I
    .param p2, "pdu"    # [B
    .param p3, "smsc"    # [B

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->copySmsToIccEf(I[B[B)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "copySmsToIccEf iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public copySmsToIccEfForSubscriber(I[B[BJ)I
    .locals 4
    .param p1, "status"    # I
    .param p2, "pdu"    # [B
    .param p3, "smsc"    # [B
    .param p4, "subId"    # J

    .prologue
    invoke-direct {p0, p4, p5}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->copySmsToIccEf(I[B[B)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "copySmsToIccEf iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public copySmsToIccEfPrivate(I[B[BI)I
    .locals 4
    .param p1, "status"    # I
    .param p2, "pdu"    # [B
    .param p3, "smsc"    # [B
    .param p4, "sms_format"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->copySmsToIccEfPrivate(I[B[BI)I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "copySmsToIccEfPrivate iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, -0x1

    goto :goto_0
.end method

.method public disableGsmBroadcastRange(II)Z
    .locals 4
    .param p1, "startMessageId"    # I
    .param p2, "endMessageId"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->disableGsmBroadcastRange(II)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "disableGsmBroadcastRange iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public enableAutoDCDisconnect(I)V
    .locals 4
    .param p1, "timeOut"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enableAutoDCDisconnect(I)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "enableAutoDCDisconnect iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public enableGsmBroadcastRange(II)Z
    .locals 4
    .param p1, "startMessageId"    # I
    .param p2, "endMessageId"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->enableGsmBroadcastRange(II)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "enableGsmBroadcastRange iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getMaxEfSms()I
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getMaxEfSms()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "getMaxEfSms iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getMaxEfSmsForSubscriber(J)I
    .locals 3
    .param p1, "subId"    # J

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getMaxEfSms()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "getMaxEfSms iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getSmscenterAddress()Ljava/lang/String;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getSmscenterAddress()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "getSmscenterAddress iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getSmscenterAddressForSubscriber(J)Ljava/lang/String;
    .locals 3
    .param p1, "subId"    # J

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getSmscenterAddress()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "getSmscenterAddress iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getUiccType()I
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->getUiccType()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "getUiccType iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 4
    .param p1, "destUri"    # Landroid/net/Uri;
    .param p2, "values"    # Landroid/content/ContentValues;

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->insertDBForLGMessage(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "insertDBForLGMessage iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isFdnEnabled()Z
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->isFdnEnabled()Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "isFdnEnabled iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isFdnEnabledOnSubscription(J)Z
    .locals 3
    .param p1, "subscription"    # J

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->isFdnEnabled()Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "isFdnEnabled iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;)V
    .locals 7
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p4, "parts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p5, "sentIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .local p6, "deliveryIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "sendEmailoverMultipartText iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    .locals 7
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "sentIntent"    # Landroid/app/PendingIntent;
    .param p6, "deliveryIntent"    # Landroid/app/PendingIntent;

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "sendEmailoverText iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;IIIZ)V
    .locals 12
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p7, "replyAddr"    # Ljava/lang/String;
    .param p8, "confirmRead"    # I
    .param p9, "replyOption"    # I
    .param p10, "protocolId"    # I
    .param p11, "isExpectMore"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            "IIIZ)V"
        }
    .end annotation

    .prologue
    .local p4, "parts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p5, "sentIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .local p6, "deliveryIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    invoke-virtual/range {v0 .. v11}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;IIIZ)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "sendMultipartTextLge iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sendMultipartTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V
    .locals 8
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p7, "cbAddress"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/List",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .local p4, "parts":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p5, "sentIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    .local p6, "deliveryIntents":Ljava/util/List;, "Ljava/util/List<Landroid/app/PendingIntent;>;"
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    move-object v7, p7

    invoke-virtual/range {v0 .. v7}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->sendMultipartTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "sendMultipartTextWithCbAddress iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V
    .locals 12
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "sentIntent"    # Landroid/app/PendingIntent;
    .param p6, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p7, "replyAddr"    # Ljava/lang/String;
    .param p8, "confirmRead"    # I
    .param p9, "replyOption"    # I
    .param p10, "protocolId"    # I
    .param p11, "isExpectMore"    # Z

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    invoke-virtual/range {v0 .. v11}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;IIIZ)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "sendTextLge iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sendTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V
    .locals 8
    .param p1, "callingPackage"    # Ljava/lang/String;
    .param p2, "destAddr"    # Ljava/lang/String;
    .param p3, "scAddr"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "sentIntent"    # Landroid/app/PendingIntent;
    .param p6, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p7, "cbAddress"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    move-object v7, p7

    invoke-virtual/range {v0 .. v7}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->sendTextWithCbAddress(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "sendTextWithCbAddress iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setMultipartTextValidityPeriod(I)V
    .locals 4
    .param p1, "validityperiod"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setMultipartTextValidityPeriod(I)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setMultipartTextValidityPeriod iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setMultipartTextValidityPeriodForSubscriber(IJ)V
    .locals 4
    .param p1, "validityperiod"    # I
    .param p2, "subscription"    # J

    .prologue
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setMultipartTextValidityPeriod(I)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setMultipartTextValidityPeriod is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setSmsIsRoaming(Z)V
    .locals 4
    .param p1, "isRoaming"    # Z

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setSmsIsRoaming(Z)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setSmsIsRoaming iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setSmsPriority(I)V
    .locals 4
    .param p1, "priority"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setSmsPriority(I)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setSmsPriority iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setSmscenterAddress(Ljava/lang/String;)Z
    .locals 4
    .param p1, "smsc"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setSmscenterAddress(Ljava/lang/String;)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setSmscenterAddress iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setSmscenterAddressForSubscriber(Ljava/lang/String;J)Z
    .locals 4
    .param p1, "smsc"    # Ljava/lang/String;
    .param p2, "subId"    # J

    .prologue
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setSmscenterAddress(Ljava/lang/String;)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setSmscenterAddress iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setUiccType(I)V
    .locals 4
    .param p1, "uiccType"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->setUiccType(I)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "setUiccType iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z
    .locals 4
    .param p1, "isOnOff"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "smsReceptionBlockingforNIAPPolicy iccSmsIntMgr is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public updateMessageOnIccEfMultiMode(II[BI)Z
    .locals 4
    .param p1, "index"    # I
    .param p2, "status"    # I
    .param p3, "pdu"    # [B
    .param p4, "smsformat"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->updateMessageOnIccEfMultiMode(II[BI)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "updateMessageOnIccEfMultiMode iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public updateSmsOnSimReadStatus(IZ)Z
    .locals 4
    .param p1, "index"    # I
    .param p2, "read"    # Z

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->this$0:Lcom/android/internal/telephony/UiccSmsControllerEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/UiccSmsControllerEx;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->updateSmsOnSimReadStatus(IZ)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "updateSmsOnSimReadStatus iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public updateSmsOnSimReadStatusForSubscriber(IZJ)Z
    .locals 3
    .param p1, "index"    # I
    .param p2, "read"    # Z
    .param p3, "subId"    # J

    .prologue
    invoke-direct {p0, p3, p4}, Lcom/android/internal/telephony/UiccSmsControllerEx$ExtendedBinderInternal;->getIccSmsInterfaceManagerEx(J)Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;

    move-result-object v0

    .local v0, "iccSmsIntMgrEx":Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/IccSmsInterfaceManagerEx;->updateSmsOnSimReadStatus(IZ)Z

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v1, "RIL_UiccSmsControllerEx"

    const-string v2, "updateSmsOnSimReadStatus iccSmsIntMgrEx is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method
