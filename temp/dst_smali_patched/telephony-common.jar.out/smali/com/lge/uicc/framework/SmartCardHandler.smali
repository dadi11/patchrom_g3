.class public Lcom/lge/uicc/framework/SmartCardHandler;
.super Landroid/os/Handler;
.source "SmartCardHandler.java"


# static fields
.field private static final EVENT_SMARTCARD_GET_ATR:I = 0x1

.field private static final EVENT_SMARTCARD_SETUP:I


# direct methods
.method protected constructor <init>()V
    .locals 3

    .prologue
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    const-string v0, "card_state"

    const/4 v1, 0x0

    const-string v2, "PRESENT"

    invoke-static {v0, p0, v1, v2}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    return-void
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SmartCardHandler] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SmartCardHandler] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected getATR()[B
    .locals 7

    .prologue
    const/4 v6, 0x0

    const-string v4, "atr"

    invoke-static {v4, v6}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "atr":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    invoke-static {v0}, Lcom/lge/uicc/EfUtils;->hexStringToBytes(Ljava/lang/String;)[B

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    invoke-static {v6}, Lcom/lge/uicc/framework/IccTools;->getRIL(I)Lcom/android/internal/telephony/RIL;

    move-result-object v3

    .local v3, "ril":Lcom/android/internal/telephony/RIL;
    if-nez v3, :cond_1

    const-string v4, "RIL==null"

    invoke-static {v4}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V

    const/4 v1, 0x0

    goto :goto_0

    :cond_1
    new-instance v2, Lcom/lge/uicc/framework/AsyncResultFetcher;

    invoke-direct {v2}, Lcom/lge/uicc/framework/AsyncResultFetcher;-><init>()V

    .local v2, "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    invoke-virtual {v2}, Lcom/lge/uicc/framework/AsyncResultFetcher;->obtainMessage()Landroid/os/Message;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/android/internal/telephony/RIL;->smartCardGetATR(Landroid/os/Message;)V

    invoke-virtual {v2}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse()Z

    invoke-virtual {v2}, Lcom/lge/uicc/framework/AsyncResultFetcher;->getResult()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [B

    move-object v1, v4

    check-cast v1, [B

    .local v1, "data":[B
    const-string v4, "atr"

    invoke-static {v1}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v6, v5}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    goto :goto_0
.end method

.method protected getAppTypes([B)[B
    .locals 12
    .param p1, "in"    # [B

    .prologue
    const/4 v9, 0x0

    const/4 v11, 0x0

    const/4 v8, -0x1

    .local v8, "slotId":I
    if-nez p1, :cond_0

    const-string v10, "no slot data, reguard slot 0"

    invoke-static {v10}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V

    const/4 v8, 0x0

    :cond_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v4

    .local v4, "p":Landroid/os/Parcel;
    array-length v10, p1

    invoke-virtual {v4, p1, v11, v10}, Landroid/os/Parcel;->unmarshall([BII)V

    invoke-virtual {v4, v11}, Landroid/os/Parcel;->setDataPosition(I)V

    invoke-virtual {v4}, Landroid/os/Parcel;->readInt()I

    move-result v8

    if-gez v8, :cond_1

    const/4 v8, 0x0

    :cond_1
    invoke-static {v8}, Lcom/lge/uicc/framework/IccTools;->getRIL(I)Lcom/android/internal/telephony/RIL;

    move-result-object v7

    .local v7, "ril":Lcom/android/internal/telephony/RIL;
    if-nez v7, :cond_2

    const-string v10, "RIL==null"

    invoke-static {v10}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V

    :goto_0
    return-object v9

    :cond_2
    invoke-static {v8}, Lcom/lge/uicc/framework/IccTools;->getUiccCard(I)Lcom/android/internal/telephony/uicc/UiccCard;

    move-result-object v2

    .local v2, "card":Lcom/android/internal/telephony/uicc/UiccCard;
    if-nez v2, :cond_3

    const-string v10, "UiccCard is not ready"

    invoke-static {v10}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    const/4 v1, 0x0

    .local v1, "appTypes":I
    sget-object v9, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;->APPTYPE_USIM:Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    invoke-virtual {v2, v9}, Lcom/android/internal/telephony/uicc/UiccCard;->isApplicationOnIcc(Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;)Z

    move-result v9

    if-eqz v9, :cond_8

    const/4 v9, 0x7

    new-array v0, v9, [B

    fill-array-data v0, :array_0

    .local v0, "SELECT_DF_GSM":[B
    new-instance v3, Lcom/lge/uicc/framework/AsyncResultFetcher;

    invoke-direct {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;-><init>()V

    .local v3, "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->obtainMessage()Landroid/os/Message;

    move-result-object v9

    invoke-virtual {v7, v0, v9}, Lcom/android/internal/telephony/RIL;->smartCardTransmit([BLandroid/os/Message;)V

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse()Z

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->getResult()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [B

    move-object v6, v9

    check-cast v6, [B

    .local v6, "return_bytes":[B
    if-eqz v6, :cond_6

    array-length v9, v6

    const/4 v10, 0x2

    if-ne v9, v10, :cond_7

    aget-byte v9, v6, v11

    const/16 v10, 0x90

    if-ne v9, v10, :cond_4

    const/4 v9, 0x1

    aget-byte v9, v6, v9

    if-eqz v9, :cond_5

    :cond_4
    aget-byte v9, v6, v11

    const/16 v10, 0x91

    if-ne v9, v10, :cond_7

    :cond_5
    const/4 v1, 0x3

    .end local v0    # "SELECT_DF_GSM":[B
    .end local v3    # "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    .end local v6    # "return_bytes":[B
    :cond_6
    :goto_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "appTypes="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v5

    .local v5, "reply":Landroid/os/Parcel;
    invoke-virtual {v5, v1}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v5}, Landroid/os/Parcel;->marshall()[B

    move-result-object v9

    goto :goto_0

    .end local v5    # "reply":Landroid/os/Parcel;
    .restart local v0    # "SELECT_DF_GSM":[B
    .restart local v3    # "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    .restart local v6    # "return_bytes":[B
    :cond_7
    const/4 v1, 0x2

    goto :goto_1

    .end local v0    # "SELECT_DF_GSM":[B
    .end local v3    # "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    .end local v6    # "return_bytes":[B
    :cond_8
    sget-object v9, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;->APPTYPE_SIM:Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    invoke-virtual {v2, v9}, Lcom/android/internal/telephony/uicc/UiccCard;->isApplicationOnIcc(Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;)Z

    move-result v9

    if-eqz v9, :cond_6

    const/4 v1, 0x1

    goto :goto_1

    :array_0
    .array-data 1
        0x0t
        -0x5ct
        0x8t
        0xct
        0x2t
        0x7ft
        0x20t
    .end array-data
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x0

    .local v2, "data":[B
    :try_start_0
    iget v5, p1, Landroid/os/Message;->what:I

    packed-switch v5, :pswitch_data_0

    const-string v5, "ERROR: unknown event received!"

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    const-string v5, "EVENT_SMARTCARD_GET_ATR"

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Landroid/os/AsyncResult;

    .local v1, "ar":Landroid/os/AsyncResult;
    iget-object v5, v1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v5, :cond_1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "exception in command : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v5, v1, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v1    # "ar":Landroid/os/AsyncResult;
    :catch_0
    move-exception v3

    .local v3, "exc":Ljava/lang/RuntimeException;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Exception in SmartCardHandler: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    goto :goto_0

    .end local v3    # "exc":Ljava/lang/RuntimeException;
    .restart local v1    # "ar":Landroid/os/AsyncResult;
    :cond_1
    :try_start_1
    const-string v5, "ATR loaded for setup."

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    iget-object v5, v1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [B

    move-object v0, v5

    check-cast v0, [B

    move-object v2, v0

    const-string v5, "atr"

    const/4 v6, 0x0

    invoke-static {v2}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v6, v7}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    goto :goto_0

    .end local v1    # "ar":Landroid/os/AsyncResult;
    :pswitch_1
    const-string v5, "card_state"

    const/4 v6, 0x0

    invoke-static {v5, v6}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v5

    const-string v6, "PRESENT"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "EVENT_SMARTCARD_SETUP"

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    const-string v5, "card_state"

    invoke-static {v5, p0}, Lcom/lge/uicc/framework/LGUICC;->unregisterForConfig(Ljava/lang/String;Landroid/os/Handler;)V

    const-string v5, "load ATR for setup..."

    invoke-static {v5}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    const/4 v5, 0x0

    invoke-static {v5}, Lcom/lge/uicc/framework/IccTools;->getRIL(I)Lcom/android/internal/telephony/RIL;

    move-result-object v4

    .local v4, "ril":Lcom/android/internal/telephony/RIL;
    if-eqz v4, :cond_0

    const/4 v5, 0x1

    const-string v6, "SETUP"

    invoke-virtual {p0, v5, v6}, Lcom/lge/uicc/framework/SmartCardHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/android/internal/telephony/RIL;->smartCardGetATR(Landroid/os/Message;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected declared-synchronized transmit([B)[B
    .locals 13
    .param p1, "command"    # [B

    .prologue
    const/4 v9, 0x0

    const/4 v12, 0x2

    monitor-enter p0

    if-nez p1, :cond_1

    :try_start_0
    const-string v8, "no inputs"

    invoke-static {v8}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v6, v9

    :cond_0
    :goto_0
    monitor-exit p0

    return-object v6

    :cond_1
    const/4 v8, 0x0

    :try_start_1
    invoke-static {v8}, Lcom/lge/uicc/framework/IccTools;->getRIL(I)Lcom/android/internal/telephony/RIL;

    move-result-object v7

    .local v7, "ril":Lcom/android/internal/telephony/RIL;
    if-nez v7, :cond_2

    const-string v8, "RIL==null"

    invoke-static {v8}, Lcom/lge/uicc/framework/SmartCardHandler;->loge(Ljava/lang/String;)V

    move-object v6, v9

    goto :goto_0

    :cond_2
    new-instance v3, Lcom/lge/uicc/framework/AsyncResultFetcher;

    invoke-direct {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;-><init>()V

    .local v3, "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    const/4 v6, 0x0

    .local v6, "return_bytes":[B
    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->obtainMessage()Landroid/os/Message;

    move-result-object v8

    invoke-virtual {v7, p1, v8}, Lcom/android/internal/telephony/RIL;->smartCardTransmit([BLandroid/os/Message;)V

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v10, 0x0

    const-string v11, "KT"

    aput-object v11, v8, v10

    invoke-static {v8}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    const-wide/16 v10, 0x2710

    invoke-virtual {v3, v10, v11}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse(J)Z

    move-result v8

    if-nez v8, :cond_3

    const/4 v8, 0x2

    new-array v6, v8, [B

    .end local v6    # "return_bytes":[B
    fill-array-data v6, :array_0

    .restart local v6    # "return_bytes":[B
    :goto_1
    if-nez v6, :cond_5

    move-object v6, v9

    goto :goto_0

    :cond_3
    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->getResult()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [B

    move-object v0, v8

    check-cast v0, [B

    move-object v6, v0

    goto :goto_1

    :cond_4
    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse()Z

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->getResult()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [B

    move-object v0, v8

    check-cast v0, [B

    move-object v6, v0

    goto :goto_1

    :cond_5
    const/4 v8, 0x0

    aget-byte v8, v6, v8

    const/16 v9, 0x6a

    if-ne v8, v9, :cond_6

    array-length v8, v6

    if-gt v8, v12, :cond_6

    const/4 v8, 0x5

    new-array v5, v8, [B

    fill-array-data v5, :array_1

    .local v5, "open_channel":[B
    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    const-string v10, "LGU"

    aput-object v10, v8, v9

    invoke-static {v8}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    invoke-static {p1, v5}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v8

    if-eqz v8, :cond_0

    const-string v8, "[LGU+] channel is already opened. so close channel 3"

    invoke-static {v8}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    const/4 v8, 0x4

    new-array v2, v8, [B

    fill-array-data v2, :array_2

    .local v2, "close_channel":[B
    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->obtainMessage()Landroid/os/Message;

    move-result-object v8

    invoke-virtual {v7, v2, v8}, Lcom/android/internal/telephony/RIL;->smartCardTransmit([BLandroid/os/Message;)V

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse()Z

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->obtainMessage()Landroid/os/Message;

    move-result-object v8

    invoke-virtual {v7, p1, v8}, Lcom/android/internal/telephony/RIL;->smartCardTransmit([BLandroid/os/Message;)V

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse()Z

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->getResult()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [B

    move-object v0, v8

    check-cast v0, [B

    move-object v6, v0

    goto/16 :goto_0

    .end local v2    # "close_channel":[B
    .end local v5    # "open_channel":[B
    :cond_6
    const/4 v8, 0x0

    aget-byte v8, v6, v8

    const/16 v9, 0x61

    if-ne v8, v9, :cond_0

    array-length v8, v6

    if-ne v8, v12, :cond_0

    const-string v8, "process get response command for 61xx status word"

    invoke-static {v8}, Lcom/lge/uicc/framework/SmartCardHandler;->logd(Ljava/lang/String;)V

    const/4 v8, 0x5

    new-array v4, v8, [B

    const/4 v8, 0x0

    const/4 v9, 0x0

    aget-byte v9, p1, v9

    aput-byte v9, v4, v8

    const/4 v8, 0x1

    const/16 v9, -0x40

    aput-byte v9, v4, v8

    const/4 v8, 0x2

    const/4 v9, 0x0

    aput-byte v9, v4, v8

    const/4 v8, 0x3

    const/4 v9, 0x0

    aput-byte v9, v4, v8

    const/4 v8, 0x4

    const/4 v9, 0x1

    aget-byte v9, v6, v9

    aput-byte v9, v4, v8

    .local v4, "get_response":[B
    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->obtainMessage()Landroid/os/Message;

    move-result-object v8

    invoke-virtual {v7, v4, v8}, Lcom/android/internal/telephony/RIL;->smartCardTransmit([BLandroid/os/Message;)V

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->waitResponse()Z

    invoke-virtual {v3}, Lcom/lge/uicc/framework/AsyncResultFetcher;->getResult()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [B

    move-object v0, v8

    check-cast v0, [B

    move-object v6, v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto/16 :goto_0

    .end local v3    # "fetcher":Lcom/lge/uicc/framework/AsyncResultFetcher;
    .end local v4    # "get_response":[B
    .end local v6    # "return_bytes":[B
    .end local v7    # "ril":Lcom/android/internal/telephony/RIL;
    :catchall_0
    move-exception v8

    monitor-exit p0

    throw v8

    :array_0
    .array-data 1
        -0x1t
        0x9t
    .end array-data

    nop

    :array_1
    .array-data 1
        0x1t
        0x70t
        0x0t
        0x0t
        0x0t
    .end array-data

    nop

    :array_2
    .array-data 1
        0x3t
        0x70t
        -0x80t
        0x3t
    .end array-data
.end method
