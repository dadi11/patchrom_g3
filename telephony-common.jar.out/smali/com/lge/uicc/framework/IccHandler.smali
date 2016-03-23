.class public abstract Lcom/lge/uicc/framework/IccHandler;
.super Landroid/os/Handler;
.source "IccHandler.java"

# interfaces
.implements Lcom/lge/uicc/LGUiccConstants;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/IccHandler$RecordUpdated;,
        Lcom/lge/uicc/framework/IccHandler$RecordLoaded;
    }
.end annotation


# static fields
.field protected static final APP_FAM_3GPP:I = 0x1

.field protected static final APP_FAM_3GPP2:I = 0x2

.field protected static final APP_FAM_IMS:I = 0x3

.field protected static final EVENT_LOAD_ICC_RECORD_DONE:I = 0xf4241

.field protected static final EVENT_UPDATE_ICC_RECORD_DONE:I = 0xf4242


# instance fields
.field private final LOGNAME:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 26
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 28
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/uicc/framework/IccHandler;->LOGNAME:Ljava/lang/String;

    .line 43
    return-void
.end method

.method private sendExceptionForMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 58
    if-eqz p1, :cond_0

    .line 59
    const/4 v1, 0x2

    invoke-static {v1}, Lcom/android/internal/telephony/CommandException;->fromRilErrno(I)Lcom/android/internal/telephony/CommandException;

    move-result-object v0

    .line 60
    .local v0, "exception":Lcom/android/internal/telephony/CommandException;
    const/4 v1, 0x0

    invoke-static {p1, v1, v0}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    .line 61
    invoke-virtual {p1}, Landroid/os/Message;->sendToTarget()V

    .line 63
    .end local v0    # "exception":Lcom/android/internal/telephony/CommandException;
    :cond_0
    return-void
.end method


# virtual methods
.method protected getEFLinearRecordSize(IIILandroid/os/Message;)V
    .locals 1
    .param p1, "slot"    # I
    .param p2, "family"    # I
    .param p3, "fileid"    # I
    .param p4, "onLoaded"    # Landroid/os/Message;

    .prologue
    .line 66
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccTools;->getFileHandler(II)Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 67
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 68
    invoke-direct {p0, p4}, Lcom/lge/uicc/framework/IccHandler;->sendExceptionForMessage(Landroid/os/Message;)V

    .line 72
    :goto_0
    return-void

    .line 70
    :cond_0
    invoke-virtual {v0, p3, p4}, Lcom/android/internal/telephony/uicc/IccFileHandler;->getEFLinearRecordSize(ILandroid/os/Message;)V

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 123
    iget v4, p1, Landroid/os/Message;->what:I

    packed-switch v4, :pswitch_data_0

    .line 170
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 173
    :cond_0
    :goto_0
    return-void

    .line 126
    :pswitch_0
    :try_start_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 127
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v2, Lcom/lge/uicc/framework/IccHandler$RecordLoaded;

    .line 128
    .local v2, "loaded":Lcom/lge/uicc/framework/IccHandler$RecordLoaded;
    if-eqz v2, :cond_1

    .line 129
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Record Load Done : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->logd(Ljava/lang/String;)V

    .line 130
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v4, :cond_2

    .line 131
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Record Load Exception: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->loge(Ljava/lang/String;)V

    .line 132
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v2, v4}, Lcom/lge/uicc/framework/IccHandler$RecordLoaded;->onLoadException(Ljava/lang/Throwable;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 144
    :cond_1
    :goto_1
    invoke-virtual {p0}, Lcom/lge/uicc/framework/IccHandler;->onRecordLoaded()V

    goto :goto_0

    .line 133
    :cond_2
    :try_start_1
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v4, :cond_3

    .line 134
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    invoke-virtual {v2, v4}, Lcom/lge/uicc/framework/IccHandler$RecordLoaded;->onLoadCompleted(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 139
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v2    # "loaded":Lcom/lge/uicc/framework/IccHandler$RecordLoaded;
    :catch_0
    move-exception v1

    .line 141
    .local v1, "exc":Ljava/lang/RuntimeException;
    :try_start_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception parsing record: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->loge(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 144
    invoke-virtual {p0}, Lcom/lge/uicc/framework/IccHandler;->onRecordLoaded()V

    goto :goto_0

    .line 136
    .end local v1    # "exc":Ljava/lang/RuntimeException;
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    .restart local v2    # "loaded":Lcom/lge/uicc/framework/IccHandler$RecordLoaded;
    :cond_3
    :try_start_3
    const-string v4, "Invalid state"

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->loge(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 144
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v2    # "loaded":Lcom/lge/uicc/framework/IccHandler$RecordLoaded;
    :catchall_0
    move-exception v4

    invoke-virtual {p0}, Lcom/lge/uicc/framework/IccHandler;->onRecordLoaded()V

    throw v4

    .line 150
    :pswitch_1
    :try_start_4
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 151
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v3, Lcom/lge/uicc/framework/IccHandler$RecordUpdated;

    .line 152
    .local v3, "updated":Lcom/lge/uicc/framework/IccHandler$RecordUpdated;
    if-eqz v3, :cond_0

    .line 153
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Record Update Done : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->logd(Ljava/lang/String;)V

    .line 154
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v4, :cond_4

    .line 155
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Record Update Exception: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->loge(Ljava/lang/String;)V

    .line 156
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v3, v4}, Lcom/lge/uicc/framework/IccHandler$RecordUpdated;->onUpdateException(Ljava/lang/Throwable;)V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_1

    goto/16 :goto_0

    .line 163
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v3    # "updated":Lcom/lge/uicc/framework/IccHandler$RecordUpdated;
    :catch_1
    move-exception v1

    .line 165
    .restart local v1    # "exc":Ljava/lang/RuntimeException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception updating record: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->loge(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 157
    .end local v1    # "exc":Ljava/lang/RuntimeException;
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    .restart local v3    # "updated":Lcom/lge/uicc/framework/IccHandler$RecordUpdated;
    :cond_4
    :try_start_5
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v4, :cond_5

    .line 158
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, Lcom/android/internal/telephony/uicc/IccIoResult;

    invoke-virtual {v3, v4}, Lcom/lge/uicc/framework/IccHandler$RecordUpdated;->onUpdateCompleted(Lcom/android/internal/telephony/uicc/IccIoResult;)V

    goto/16 :goto_0

    .line 160
    :cond_5
    const-string v4, "Invalid state"

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccHandler;->loge(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_1

    goto/16 :goto_0

    .line 123
    :pswitch_data_0
    .packed-switch 0xf4241
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected loadEFLinearFixed(IIIILandroid/os/Message;)V
    .locals 1
    .param p1, "slot"    # I
    .param p2, "family"    # I
    .param p3, "fileid"    # I
    .param p4, "recordNum"    # I
    .param p5, "onLoaded"    # Landroid/os/Message;

    .prologue
    .line 75
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccTools;->getFileHandler(II)Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 76
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 77
    invoke-direct {p0, p5}, Lcom/lge/uicc/framework/IccHandler;->sendExceptionForMessage(Landroid/os/Message;)V

    .line 81
    :goto_0
    return-void

    .line 79
    :cond_0
    invoke-virtual {v0, p3, p4, p5}, Lcom/android/internal/telephony/uicc/IccFileHandler;->loadEFLinearFixed(IILandroid/os/Message;)V

    goto :goto_0
.end method

.method protected loadEFLinearFixedAll(IIILandroid/os/Message;)V
    .locals 1
    .param p1, "slot"    # I
    .param p2, "family"    # I
    .param p3, "fileid"    # I
    .param p4, "onLoaded"    # Landroid/os/Message;

    .prologue
    .line 84
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccTools;->getFileHandler(II)Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 85
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 86
    invoke-direct {p0, p4}, Lcom/lge/uicc/framework/IccHandler;->sendExceptionForMessage(Landroid/os/Message;)V

    .line 90
    :goto_0
    return-void

    .line 88
    :cond_0
    invoke-virtual {v0, p3, p4}, Lcom/android/internal/telephony/uicc/IccFileHandler;->loadEFLinearFixedAll(ILandroid/os/Message;)V

    goto :goto_0
.end method

.method protected loadEFTransparent(IIILandroid/os/Message;)V
    .locals 1
    .param p1, "slot"    # I
    .param p2, "family"    # I
    .param p3, "fileid"    # I
    .param p4, "onLoaded"    # Landroid/os/Message;

    .prologue
    .line 93
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccTools;->getFileHandler(II)Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 94
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 95
    invoke-direct {p0, p4}, Lcom/lge/uicc/framework/IccHandler;->sendExceptionForMessage(Landroid/os/Message;)V

    .line 99
    :goto_0
    return-void

    .line 97
    :cond_0
    invoke-virtual {v0, p3, p4}, Lcom/android/internal/telephony/uicc/IccFileHandler;->loadEFTransparent(ILandroid/os/Message;)V

    goto :goto_0
.end method

.method protected logd(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 184
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/lge/uicc/framework/IccHandler;->LOGNAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    .line 185
    return-void
.end method

.method protected loge(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 180
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/lge/uicc/framework/IccHandler;->LOGNAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    .line 181
    return-void
.end method

.method protected logp(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 188
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/lge/uicc/framework/IccHandler;->LOGNAME:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logp(Ljava/lang/String;)V

    .line 189
    return-void
.end method

.method protected obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;
    .locals 1
    .param p1, "loaded"    # Lcom/lge/uicc/framework/IccHandler$RecordLoaded;

    .prologue
    .line 50
    const v0, 0xf4241

    invoke-virtual {p0, v0, p1}, Lcom/lge/uicc/framework/IccHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method protected obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordUpdated;)Landroid/os/Message;
    .locals 1
    .param p1, "updated"    # Lcom/lge/uicc/framework/IccHandler$RecordUpdated;

    .prologue
    .line 54
    const v0, 0xf4242

    invoke-virtual {p0, v0, p1}, Lcom/lge/uicc/framework/IccHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method protected onRecordLoaded()V
    .locals 0

    .prologue
    .line 177
    return-void
.end method

.method protected updateEFLinearFixed(IIII[BLjava/lang/String;Landroid/os/Message;)V
    .locals 6
    .param p1, "slot"    # I
    .param p2, "family"    # I
    .param p3, "fileid"    # I
    .param p4, "recordNum"    # I
    .param p5, "data"    # [B
    .param p6, "pin2"    # Ljava/lang/String;
    .param p7, "onUpdated"    # Landroid/os/Message;

    .prologue
    .line 103
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccTools;->getFileHandler(II)Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 104
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 105
    invoke-direct {p0, p7}, Lcom/lge/uicc/framework/IccHandler;->sendExceptionForMessage(Landroid/os/Message;)V

    .line 109
    :goto_0
    return-void

    :cond_0
    move v1, p3

    move v2, p4

    move-object v3, p5

    move-object v4, p6

    move-object v5, p7

    .line 107
    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/uicc/IccFileHandler;->updateEFLinearFixed(II[BLjava/lang/String;Landroid/os/Message;)V

    goto :goto_0
.end method

.method protected updateEFTransparent(III[BLandroid/os/Message;)V
    .locals 1
    .param p1, "slot"    # I
    .param p2, "family"    # I
    .param p3, "fileid"    # I
    .param p4, "data"    # [B
    .param p5, "onUpdated"    # Landroid/os/Message;

    .prologue
    .line 112
    invoke-static {p1, p2}, Lcom/lge/uicc/framework/IccTools;->getFileHandler(II)Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v0

    .line 113
    .local v0, "fh":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-nez v0, :cond_0

    .line 114
    invoke-direct {p0, p5}, Lcom/lge/uicc/framework/IccHandler;->sendExceptionForMessage(Landroid/os/Message;)V

    .line 118
    :goto_0
    return-void

    .line 116
    :cond_0
    invoke-virtual {v0, p3, p4, p5}, Lcom/android/internal/telephony/uicc/IccFileHandler;->updateEFTransparent(I[BLandroid/os/Message;)V

    goto :goto_0
.end method