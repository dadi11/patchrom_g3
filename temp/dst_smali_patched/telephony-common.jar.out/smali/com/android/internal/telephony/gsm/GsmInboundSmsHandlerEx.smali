.class public Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;
.super Lcom/android/internal/telephony/gsm/GsmInboundSmsHandler;
.source "GsmInboundSmsHandlerEx.java"


# static fields
.field private static _checkTaskMessage:Ljava/lang/reflect/Method;

.field private static _inst:Ljava/lang/Object;

.field private static volatile tryInit:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_inst:Ljava/lang/Object;

    sput-object v0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_checkTaskMessage:Ljava/lang/reflect/Method;

    const/4 v0, 0x0

    sput v0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->tryInit:I

    return-void
.end method

.method protected constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/SmsStorageMonitor;Lcom/android/internal/telephony/PhoneBase;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "storageMonitor"    # Lcom/android/internal/telephony/SmsStorageMonitor;
    .param p3, "phone"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandler;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/SmsStorageMonitor;Lcom/android/internal/telephony/PhoneBase;)V

    return-void
.end method

.method private checkCIQSms(Lcom/android/internal/telephony/gsm/SmsMessage;)I
    .locals 11
    .param p1, "sms"    # Lcom/android/internal/telephony/gsm/SmsMessage;

    .prologue
    const/4 v10, 0x0

    const/4 v9, 0x0

    const/4 v5, 0x1

    sget v4, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->tryInit:I

    if-nez v4, :cond_0

    sput v5, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->tryInit:I

    const-string v4, "LGDDM"

    const-string v6, "init reflection"

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    const-string v4, "com.carrieriq.iqagent.service.TaskingNotifier"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .local v1, "clazz":Ljava/lang/Class;
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v4

    sput-object v4, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_inst:Ljava/lang/Object;

    const-string v4, "checkTaskMessage"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Landroid/content/Context;

    aput-object v8, v6, v7

    const/4 v7, 0x1

    const-class v8, Ljava/lang/String;

    aput-object v8, v6, v7

    invoke-virtual {v1, v4, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    sput-object v4, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_checkTaskMessage:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "clazz":Ljava/lang/Class;
    :cond_0
    :goto_0
    sget-object v4, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_checkTaskMessage:Ljava/lang/reflect/Method;

    if-eqz v4, :cond_1

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .local v3, "ret":Ljava/lang/Boolean;
    :try_start_1
    sget-object v4, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_checkTaskMessage:Ljava/lang/reflect/Method;

    sget-object v6, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_inst:Ljava/lang/Object;

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    iget-object v9, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    aput-object v9, v7, v8

    const/4 v8, 0x1

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-virtual {v4, v6, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Ljava/lang/Boolean;

    move-object v3, v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :goto_1
    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-eqz v4, :cond_1

    move v4, v5

    .end local v3    # "ret":Ljava/lang/Boolean;
    :goto_2
    return v4

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/Exception;
    const-string v4, "LGDDM"

    const-string v6, "reflection failed"

    invoke-static {v4, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "LGDDM"

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    sput-object v10, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_checkTaskMessage:Ljava/lang/reflect/Method;

    sput-object v10, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->_inst:Ljava/lang/Object;

    goto :goto_0

    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v3    # "ret":Ljava/lang/Boolean;
    :catch_1
    move-exception v2

    .restart local v2    # "e":Ljava/lang/Exception;
    const-string v4, "LGDDM"

    const-string v6, "invoke failed"

    invoke-static {v4, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "LGDDM"

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .end local v2    # "e":Ljava/lang/Exception;
    .end local v3    # "ret":Ljava/lang/Boolean;
    :cond_1
    const/16 v4, 0xb

    goto :goto_2
.end method

.method private handleLGUOperatorMsg(Lcom/android/internal/telephony/gsm/SmsMessage;)I
    .locals 2
    .param p1, "sms"    # Lcom/android/internal/telephony/gsm/SmsMessage;

    .prologue
    const/4 v1, 0x1

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    iget-object v0, v0, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    iget-object v0, v0, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    iget v0, v0, Lcom/android/internal/telephony/SmsHeader$PortAddrs;->destPort:I

    invoke-static {v0}, Lcom/android/internal/telephony/LGUSmsUtils;->checkValidLmsMessage(I)Z

    move-result v0

    if-ne v1, v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->lgu:Lcom/android/internal/telephony/LGUSmsUtils;

    invoke-virtual {v0, p1, v1}, Lcom/android/internal/telephony/LGUSmsUtils;->handleLMSMessage(Lcom/android/internal/telephony/SmsMessageBase;Z)I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/16 v0, 0xb

    goto :goto_0
.end method

.method private handleMTClass2MemoryFull(Lcom/android/internal/telephony/gsm/SmsMessage;)I
    .locals 4
    .param p1, "sms"    # Lcom/android/internal/telephony/gsm/SmsMessage;

    .prologue
    const/4 v1, 0x3

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mStorageMonitor:Lcom/android/internal/telephony/SmsStorageMonitor;

    invoke-virtual {v2}, Lcom/android/internal/telephony/SmsStorageMonitor;->isStorageAvailable()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getMessageClass()Lcom/android/internal/telephony/SmsConstants$MessageClass;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/SmsConstants$MessageClass;->CLASS_0:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-eq v2, v3, :cond_0

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getMessageClass()Lcom/android/internal/telephony/SmsConstants$MessageClass;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/SmsConstants$MessageClass;->CLASS_2:Lcom/android/internal/telephony/SmsConstants$MessageClass;

    if-eq v2, v3, :cond_0

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    .local v0, "smsHeaderCompare":Lcom/android/internal/telephony/SmsHeader;
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "DCM_MEMFULL_SMSPUSH"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    if-eqz v0, :cond_2

    iget-object v2, v0, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    if-eqz v2, :cond_2

    iget-object v2, v0, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    iget v2, v2, Lcom/android/internal/telephony/SmsHeader$PortAddrs;->destPort:I

    const/16 v3, 0xb84

    if-ne v2, v3, :cond_2

    .end local v0    # "smsHeaderCompare":Lcom/android/internal/telephony/SmsHeader;
    :cond_0
    :goto_0
    const/16 v1, 0xb

    :cond_1
    :goto_1
    return v1

    .restart local v0    # "smsHeaderCompare":Lcom/android/internal/telephony/SmsHeader;
    :cond_2
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mStorageMonitor:Lcom/android/internal/telephony/SmsStorageMonitor;

    invoke-virtual {v2}, Lcom/android/internal/telephony/SmsStorageMonitor;->isStorageAvailable()Z

    move-result v2

    if-nez v2, :cond_4

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMWISetMessage()Z

    move-result v2

    if-nez v2, :cond_3

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMWIClearMessage()Z

    move-result v2

    if-eqz v2, :cond_4

    :cond_3
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "dcm_voicemail_receive_memoryfull"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string v1, "dispatchMessage(), KEY_SMS_DCM_VOICEMAIL_RECEIVE_MEMORYFULL"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "lgu_dispatch"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    iget-object v2, v2, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    if-eqz v2, :cond_1

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v2

    iget-object v2, v2, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    iget v2, v2, Lcom/android/internal/telephony/SmsHeader$PortAddrs;->destPort:I

    invoke-static {v2}, Lcom/android/internal/telephony/LGUSmsUtils;->isMessageProcessTid(I)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_1
.end method

.method private handleMWI(Lcom/android/internal/telephony/gsm/SmsMessage;)I
    .locals 5
    .param p1, "sms"    # Lcom/android/internal/telephony/gsm/SmsMessage;

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v0, 0x0

    .local v0, "handled":Z
    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMWISetMessage()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getNumOfVoicemails()I

    move-result v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->updateMessageWaitingIndicator(I)V

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMwiDontStore()Z

    move-result v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Received voice mail indicator set SMS shouldStore="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-nez v0, :cond_0

    move v1, v2

    :cond_0
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->log(Ljava/lang/String;)V

    :cond_1
    :goto_0
    if-eqz v0, :cond_5

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "mwi_only_notify"

    invoke-static {v1, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v2, :cond_2

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->handleMWInotify(Lcom/android/internal/telephony/gsm/SmsMessage;)V

    :cond_2
    :goto_1
    return v2

    :cond_3
    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMWIClearMessage()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->updateMessageWaitingIndicator(I)V

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMwiDontStore()Z

    move-result v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Received voice mail indicator clear SMS shouldStore="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-nez v0, :cond_4

    move v1, v2

    :cond_4
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    const/16 v2, 0xb

    goto :goto_1
.end method

.method private handleMWInotify(Lcom/android/internal/telephony/gsm/SmsMessage;)V
    .locals 5
    .param p1, "sms"    # Lcom/android/internal/telephony/gsm/SmsMessage;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    new-array v1, v3, [[B

    .local v1, "pdus":[[B
    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/SmsMessage;->getPdu()[B

    move-result-object v2

    aput-object v2, v1, v4

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.provider.Telephony.SMS_DELIVER"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v2, "pdus"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    const-string v2, "encoding"

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v2, "notionly"

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v2, "format"

    const-string v3, "3gpp"

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "SafeSMS"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    aget-object v2, v1, v4

    invoke-static {v0, v2}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->makeSafeSmsField(Landroid/content/Intent;[B)V

    :cond_0
    const-string v2, "android.permission.RECEIVE_SMS"

    invoke-virtual {p0, v0, v2}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->dispatchEx(Landroid/content/Intent;Ljava/lang/String;)V

    return-void
.end method

.method public static makeInboundSmsHandler(Landroid/content/Context;Lcom/android/internal/telephony/SmsStorageMonitor;Lcom/android/internal/telephony/PhoneBase;)Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "storageMonitor"    # Lcom/android/internal/telephony/SmsStorageMonitor;
    .param p2, "phone"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    new-instance v0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;

    invoke-direct {v0, p0, p1, p2}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/SmsStorageMonitor;Lcom/android/internal/telephony/PhoneBase;)V

    .local v0, "handler":Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;
    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->start()V

    return-object v0
.end method


# virtual methods
.method protected dispatchMessageRadioSpecific(Lcom/android/internal/telephony/SmsMessageBase;)I
    .locals 7
    .param p1, "smsb"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    const/4 v4, 0x3

    const/4 v3, 0x1

    move-object v1, p1

    check-cast v1, Lcom/android/internal/telephony/gsm/SmsMessage;

    .local v1, "sms":Lcom/android/internal/telephony/gsm/SmsMessage;
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v6, "lge_call_att"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->checkCIQSms(Lcom/android/internal/telephony/gsm/SmsMessage;)I

    move-result v5

    if-ne v5, v3, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v6, "SKTfindFriends"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isTypeZero()Z

    move-result v5

    if-eqz v5, :cond_2

    const-string v4, "Received short message type 0, Don\'t display or store it. Send Ack"

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v6, "support_sprint_vvm"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    const-string v5, "ro.chameleon.vvm"

    const-string v6, "1"

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "chameleon_VVM":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "GSM(), chameleon_VVM : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->log(Ljava/lang/String;)V

    const-string v5, "1"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMWISetMessage()Z

    move-result v5

    if-nez v5, :cond_3

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isMWIClearMessage()Z

    move-result v5

    if-eqz v5, :cond_4

    :cond_3
    const-string v4, "Received MWI, Don\'t display or store it. Send Ack"

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "chameleon_VVM":Ljava/lang/String;
    :cond_4
    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/SmsMessage;->isUsimDataDownload()Z

    move-result v5

    if-eqz v5, :cond_5

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getUsimServiceTable()Lcom/android/internal/telephony/uicc/UsimServiceTable;

    move-result-object v2

    .local v2, "ust":Lcom/android/internal/telephony/uicc/UsimServiceTable;
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mDataDownloadHandler:Lcom/android/internal/telephony/gsm/UsimDataDownloadHandler;

    invoke-virtual {v3, v2, v1}, Lcom/android/internal/telephony/gsm/UsimDataDownloadHandler;->handleUsimDataDownload(Lcom/android/internal/telephony/uicc/UsimServiceTable;Lcom/android/internal/telephony/gsm/SmsMessage;)I

    move-result v3

    goto :goto_0

    .end local v2    # "ust":Lcom/android/internal/telephony/uicc/UsimServiceTable;
    :cond_5
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->handleMWI(Lcom/android/internal/telephony/gsm/SmsMessage;)I

    move-result v5

    if-eq v5, v3, :cond_0

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->handleMTClass2MemoryFull(Lcom/android/internal/telephony/gsm/SmsMessage;)I

    move-result v5

    if-ne v5, v4, :cond_6

    move v3, v4

    goto :goto_0

    :cond_6
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "lgu_gsm_operator_message"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->handleLGUOperatorMsg(Lcom/android/internal/telephony/gsm/SmsMessage;)I

    move-result v4

    if-eq v4, v3, :cond_0

    :cond_7
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/gsm/GsmInboundSmsHandlerEx;->dispatchNormalMessage(Lcom/android/internal/telephony/SmsMessageBase;)I

    move-result v3

    goto/16 :goto_0
.end method
