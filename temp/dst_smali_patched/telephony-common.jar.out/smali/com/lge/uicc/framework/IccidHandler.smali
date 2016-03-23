.class public Lcom/lge/uicc/framework/IccidHandler;
.super Landroid/os/Handler;
.source "IccidHandler.java"


# static fields
.field private static final EVENT_CARD_REMOVED:I = 0x5

.field private static final EVENT_ICCID_LOADED:I = 0x1

.field private static final EVENT_OMADM_LOCK_DONE:I = 0x4

.field private static final EVENT_SET_OMADM_LOCK:I = 0x3

.field private static final EVENT_SIM_LOADED:I = 0x2

.field private static mInstance:Lcom/lge/uicc/framework/IccidHandler;


# instance fields
.field private iccid_loaded_mask:I

.field private mSimNodeHandler:Lcom/lge/uicc/framework/SimNodeHandlerSPR;

.field private simchange_intent_mask:I


# direct methods
.method private constructor <init>()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput v3, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    iput v3, p0, Lcom/lge/uicc/framework/IccidHandler;->simchange_intent_mask:I

    iput-object v4, p0, Lcom/lge/uicc/framework/IccidHandler;->mSimNodeHandler:Lcom/lge/uicc/framework/SimNodeHandlerSPR;

    const-string v0, "iccid"

    invoke-static {v0, p0, v5, v4}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "card_state"

    const/4 v1, 0x5

    const-string v2, "REMOVED"

    invoke-static {v0, p0, v1, v2}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    iget-object v0, p0, Lcom/lge/uicc/framework/IccidHandler;->mSimNodeHandler:Lcom/lge/uicc/framework/SimNodeHandlerSPR;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/lge/uicc/framework/IccidHandler;->mSimNodeHandler:Lcom/lge/uicc/framework/SimNodeHandlerSPR;

    :cond_0
    new-array v0, v5, [Ljava/lang/String;

    const-string v1, "SPR"

    aput-object v1, v0, v3

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "spr.omadm_lock"

    const/4 v1, 0x3

    invoke-static {v0, p0, v1, v4}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    :cond_1
    return-void
.end method

.method private handleForSimLock(Ljava/lang/String;)Z
    .locals 6
    .param p1, "iccid"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    new-array v4, v3, [Ljava/lang/String;

    const-string v5, "SPR"

    aput-object v5, v4, v2

    invoke-static {v4}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    :cond_0
    :goto_0
    return v2

    :cond_1
    iget-object v4, p0, Lcom/lge/uicc/framework/IccidHandler;->mSimNodeHandler:Lcom/lge/uicc/framework/SimNodeHandlerSPR;

    const/16 v5, 0x12d

    invoke-virtual {v4, v5}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->getNodeValue(I)Ljava/lang/String;

    move-result-object v0

    .local v0, "SIMLock":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/uicc/framework/IccidHandler;->mSimNodeHandler:Lcom/lge/uicc/framework/SimNodeHandlerSPR;

    const/16 v5, 0x12e

    invoke-virtual {v4, v5}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->getNodeValue(I)Ljava/lang/String;

    move-result-object v1

    .local v1, "SIMUICCID":Ljava/lang/String;
    const-string v4, "0"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "0"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v2, "SIMLock is activated by ICCID. SIM state is changed to ABSENT."

    invoke-static {v2}, Lcom/lge/uicc/framework/IccidHandler;->loge(Ljava/lang/String;)V

    const-string v2, "spr.omadm_lock"

    const-string v4, "yes"

    invoke-static {v2, v4}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move v2, v3

    goto :goto_0
.end method

.method public static handleGetIccidDone(Ljava/lang/String;I)Ljava/lang/String;
    .locals 1
    .param p0, "iccid"    # Ljava/lang/String;
    .param p1, "slot"    # I

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccidHandler;->mInstance:Lcom/lge/uicc/framework/IccidHandler;

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .end local p0    # "iccid":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object p0

    .restart local p0    # "iccid":Ljava/lang/String;
    :cond_1
    sget-object v0, Lcom/lge/uicc/framework/IccidHandler;->mInstance:Lcom/lge/uicc/framework/IccidHandler;

    invoke-direct {v0, p0}, Lcom/lge/uicc/framework/IccidHandler;->handleForSimLock(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 p0, 0x0

    goto :goto_0

    :cond_2
    const-string v0, "iccid"

    invoke-static {v0, p1, p0}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    goto :goto_0
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[IccidHandler] "

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

    const-string v1, "[IccidHandler] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method private static logp(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[IccidHandler] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logp(Ljava/lang/String;)V

    return-void
.end method

.method protected static setup()V
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccidHandler;->mInstance:Lcom/lge/uicc/framework/IccidHandler;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/IccidHandler;

    invoke-direct {v0}, Lcom/lge/uicc/framework/IccidHandler;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IccidHandler;->mInstance:Lcom/lge/uicc/framework/IccidHandler;

    :cond_0
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 13
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v12, 0x1

    const/4 v8, -0x1

    .local v8, "slotId":I
    iget v10, p1, Landroid/os/Message;->what:I

    packed-switch v10, :pswitch_data_0

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v10, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v10, :cond_0

    iget-object v10, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v10, Ljava/lang/Integer;

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-ltz v8, :cond_0

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    shl-int v11, v12, v8

    and-int/2addr v10, v11

    if-nez v10, :cond_0

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "EVENT_ICCID_LOADED : slot="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logd(Ljava/lang/String;)V

    const-string v10, "iccid"

    invoke-static {v10, v8}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    .local v2, "iccid":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_0

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    shl-int v11, v12, v8

    or-int/2addr v10, v11

    iput v10, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "last_iccid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, ""

    invoke-static {v10, v11}, Lcom/lge/uicc/framework/LGUICC;->getPreference(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .local v6, "last_iccid":Ljava/lang/String;
    const-string v4, "persist.radio.iccid-changed"

    .local v4, "iccid_statusprop":Ljava/lang/String;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "last_iccid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ": "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logp(Ljava/lang/String;)V

    const-string v1, "no"

    .local v1, "changed":Ljava/lang/String;
    if-lez v8, :cond_1

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    add-int/lit8 v11, v8, 0x1

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    :cond_1
    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_2

    const-string v10, "0"

    invoke-static {v4, v10}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "iccid_changed["

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "]: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logd(Ljava/lang/String;)V

    const-string v10, "iccid_changed"

    invoke-static {v10, v8, v1}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    goto/16 :goto_0

    :cond_2
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_3

    const-string v10, "2"

    invoke-static {v4, v10}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "first"

    :goto_2
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "last_iccid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v2}, Lcom/lge/uicc/framework/LGUICC;->setPreference(Ljava/lang/String;Ljava/lang/String;)V

    const-string v10, "proxy.sim_state.intent"

    const/4 v11, 0x2

    const-string v12, "LOADED"

    invoke-static {v10, p0, v11, v12}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    goto :goto_1

    :cond_3
    const-string v10, "1"

    invoke-static {v4, v10}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "actual"

    goto :goto_2

    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "changed":Ljava/lang/String;
    .end local v2    # "iccid":Ljava/lang/String;
    .end local v4    # "iccid_statusprop":Ljava/lang/String;
    .end local v6    # "last_iccid":Ljava/lang/String;
    :pswitch_1
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v10, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v10, :cond_0

    iget-object v10, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v10, Ljava/lang/Integer;

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v8

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "EVENT_SIM_LOADED : slot="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logd(Ljava/lang/String;)V

    const-string v10, "iccid_changed"

    const-string v11, "no"

    invoke-static {v10, v8, v11}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "iccid_changed":Ljava/lang/String;
    const-string v10, "no"

    invoke-virtual {v3, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_0

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->simchange_intent_mask:I

    shl-int v11, v12, v8

    and-int/2addr v10, v11

    if-nez v10, :cond_0

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->simchange_intent_mask:I

    shl-int v11, v12, v8

    or-int/2addr v10, v11

    iput v10, p0, Lcom/lge/uicc/framework/IccidHandler;->simchange_intent_mask:I

    new-instance v5, Landroid/content/Intent;

    const-string v10, "com.lge.intent.action.SIM_CHANGED_INFO"

    invoke-direct {v5, v10}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v5, "intent_sim_changed":Landroid/content/Intent;
    const-string v10, "reason"

    invoke-virtual {v5, v10, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v10, "SLOT_ID"

    invoke-virtual {v5, v10, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-static {v5}, Lcom/lge/uicc/framework/IccTools;->broadcastIntent(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v3    # "iccid_changed":Ljava/lang/String;
    .end local v5    # "intent_sim_changed":Landroid/content/Intent;
    :pswitch_2
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v10, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v10, :cond_0

    iget-object v10, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v10, Ljava/lang/Integer;

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v8

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    shl-int v11, v12, v8

    and-int/2addr v10, v11

    if-eqz v10, :cond_0

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "clear iccid_loaed_mask for slot "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logd(Ljava/lang/String;)V

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    shl-int v11, v12, v8

    xor-int/lit8 v11, v11, -0x1

    and-int/2addr v10, v11

    iput v10, p0, Lcom/lge/uicc/framework/IccidHandler;->iccid_loaded_mask:I

    iget v10, p0, Lcom/lge/uicc/framework/IccidHandler;->simchange_intent_mask:I

    shl-int v11, v12, v8

    xor-int/lit8 v11, v11, -0x1

    and-int/2addr v10, v11

    iput v10, p0, Lcom/lge/uicc/framework/IccidHandler;->simchange_intent_mask:I

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_3
    const-string v10, "EVENT_SET_OMADM_LOCK"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logd(Ljava/lang/String;)V

    const-string v10, "spr.omadm_lock"

    invoke-static {v10, p0}, Lcom/lge/uicc/framework/LGUICC;->unregisterForConfig(Ljava/lang/String;Landroid/os/Handler;)V

    sget-object v10, Lcom/android/internal/telephony/IccCardConstants$State;->CARD_IO_ERROR:Lcom/android/internal/telephony/IccCardConstants$State;

    invoke-virtual {v10}, Lcom/android/internal/telephony/IccCardConstants$State;->toString()Ljava/lang/String;

    move-result-object v9

    .local v9, "value":Ljava/lang/String;
    const-string v10, "gsm.sim.state"

    invoke-static {v10, v9}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v10, "proxy.sim_state"

    invoke-static {v10, v8, v9}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    const-string v10, "proxy.sim_state.intent"

    invoke-static {v10, v8, v9}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    const/4 v10, 0x0

    invoke-static {v10}, Lcom/lge/uicc/framework/IccTools;->getRIL(I)Lcom/android/internal/telephony/RIL;

    move-result-object v7

    .local v7, "ril":Lcom/android/internal/telephony/RIL;
    if-nez v7, :cond_4

    const-string v10, "fails to get RIL"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->loge(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_4
    const/4 v10, 0x4

    invoke-virtual {p0, v10}, Lcom/lge/uicc/framework/IccidHandler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v10

    invoke-virtual {v7, v10}, Lcom/android/internal/telephony/RIL;->UIMPowerdownrequest(Landroid/os/Message;)V

    const/4 v10, 0x0

    invoke-static {v9, v10}, Lcom/lge/uicc/framework/IccTools;->broadcastIccStateChangedIntent(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v7    # "ril":Lcom/android/internal/telephony/RIL;
    .end local v9    # "value":Ljava/lang/String;
    :pswitch_4
    const-string v10, "EVENT_OMADM_LOCK_DONE"

    invoke-static {v10}, Lcom/lge/uicc/framework/IccidHandler;->logd(Ljava/lang/String;)V

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_3
        :pswitch_4
        :pswitch_2
    .end packed-switch
.end method
