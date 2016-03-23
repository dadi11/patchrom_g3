.class public Lcom/lge/uicc/framework/IccHandlerLGU;
.super Lcom/lge/uicc/framework/IccHandler;
.source "IccHandlerLGU.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/IccHandlerLGU$ChangeToSponIMSI;,
        Lcom/lge/uicc/framework/IccHandlerLGU$ChangeToHomeIMSI;,
        Lcom/lge/uicc/framework/IccHandlerLGU$UpdatePLMN;,
        Lcom/lge/uicc/framework/IccHandlerLGU$StartOTA;
    }
.end annotation


# static fields
.field private static final EVENT_CHECK_STARTOTA:I = 0x1

.field private static final EVENT_ICCID_LOADED:I = 0x2

.field private static final EVENT_SIM_STATE_READY:I = 0x3

.field private static mInstance:Lcom/lge/uicc/framework/IccHandlerLGU;


# instance fields
.field private recordsToLoad:I


# direct methods
.method private constructor <init>()V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    invoke-direct {p0}, Lcom/lge/uicc/framework/IccHandler;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    const-string v0, "card_operator"

    invoke-static {v0, p0, v1, v3}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "card_provisioned"

    invoke-static {v0, p0, v1, v3}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "proxy.sim_state"

    const/4 v1, 0x3

    const-string v2, "READY"

    invoke-static {v0, p0, v1, v2}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "iccid"

    const/4 v1, 0x2

    invoke-static {v0, p0, v1, v3}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "StartOTA"

    new-instance v1, Lcom/lge/uicc/framework/IccHandlerLGU$StartOTA;

    invoke-direct {v1, p0, v3}, Lcom/lge/uicc/framework/IccHandlerLGU$StartOTA;-><init>(Lcom/lge/uicc/framework/IccHandlerLGU;Lcom/lge/uicc/framework/IccHandlerLGU$1;)V

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/IccFileIO;->registerEnvelope(Ljava/lang/String;Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;)Z

    const-string v0, "UpdatePLMN"

    new-instance v1, Lcom/lge/uicc/framework/IccHandlerLGU$UpdatePLMN;

    invoke-direct {v1, p0, v3}, Lcom/lge/uicc/framework/IccHandlerLGU$UpdatePLMN;-><init>(Lcom/lge/uicc/framework/IccHandlerLGU;Lcom/lge/uicc/framework/IccHandlerLGU$1;)V

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/IccFileIO;->registerEnvelope(Ljava/lang/String;Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;)Z

    const-string v0, "ChangeToHomeIMSI"

    new-instance v1, Lcom/lge/uicc/framework/IccHandlerLGU$ChangeToHomeIMSI;

    invoke-direct {v1, p0, v3}, Lcom/lge/uicc/framework/IccHandlerLGU$ChangeToHomeIMSI;-><init>(Lcom/lge/uicc/framework/IccHandlerLGU;Lcom/lge/uicc/framework/IccHandlerLGU$1;)V

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/IccFileIO;->registerEnvelope(Ljava/lang/String;Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;)Z

    const-string v0, "ChangeToSponIMSI"

    new-instance v1, Lcom/lge/uicc/framework/IccHandlerLGU$ChangeToSponIMSI;

    invoke-direct {v1, p0, v3}, Lcom/lge/uicc/framework/IccHandlerLGU$ChangeToSponIMSI;-><init>(Lcom/lge/uicc/framework/IccHandlerLGU;Lcom/lge/uicc/framework/IccHandlerLGU$1;)V

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/IccFileIO;->registerEnvelope(Ljava/lang/String;Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;)Z

    return-void
.end method

.method private fetchRecords()V
    .locals 6

    .prologue
    const-string v0, "fetch EF_CSIM_MDN"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerLGU;->logd(Ljava/lang/String;)V

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/16 v3, 0x6f44

    const/4 v4, 0x1

    new-instance v0, Lcom/lge/uicc/framework/IccHandlerLGU$1;

    invoke-direct {v0, p0}, Lcom/lge/uicc/framework/IccHandlerLGU$1;-><init>(Lcom/lge/uicc/framework/IccHandlerLGU;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerLGU;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v5

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/lge/uicc/framework/IccHandlerLGU;->loadEFLinearFixed(IIIILandroid/os/Message;)V

    iget v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    return-void
.end method

.method protected static setup()V
    .locals 3

    .prologue
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "LGU"

    aput-object v2, v0, v1

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v0, Lcom/lge/uicc/framework/IccHandlerLGU;->mInstance:Lcom/lge/uicc/framework/IccHandlerLGU;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/IccHandlerLGU;

    invoke-direct {v0}, Lcom/lge/uicc/framework/IccHandlerLGU;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IccHandlerLGU;->mInstance:Lcom/lge/uicc/framework/IccHandlerLGU;

    goto :goto_0
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 12
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v11, 0xc

    const/4 v10, 0x6

    iget v9, p1, Landroid/os/Message;->what:I

    invoke-virtual {p0, v9}, Lcom/lge/uicc/framework/IccHandlerLGU;->removeMessages(I)V

    iget v9, p1, Landroid/os/Message;->what:I

    packed-switch v9, :pswitch_data_0

    invoke-super {p0, p1}, Lcom/lge/uicc/framework/IccHandler;->handleMessage(Landroid/os/Message;)V

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    const-string v9, "card_provisioned"

    invoke-static {v9}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .local v8, "provisioned":Ljava/lang/String;
    const-string v9, "card_operator"

    invoke-static {v9}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "card_operator":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-nez v9, :cond_0

    invoke-virtual {v8}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-nez v9, :cond_0

    const-string v9, "EVENT_CHECK_STARTOTA"

    invoke-virtual {p0, v9}, Lcom/lge/uicc/framework/IccHandlerLGU;->logd(Ljava/lang/String;)V

    const-string v9, "LGU"

    invoke-virtual {v2, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    const-string v9, "no"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    const-string v7, "com.lge.ota"

    .local v7, "packageName":Ljava/lang/String;
    const-string v3, "com.lge.ota.LGTNoUSIMActivityForLockScreen"

    .local v3, "className":Ljava/lang/String;
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .local v0, "LGTota":Landroid/content/Intent;
    invoke-virtual {v0, v7, v3}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v9, 0x10000000

    invoke-virtual {v0, v9}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getContext()Landroid/content/Context;

    move-result-object v1

    .local v1, "c":Landroid/content/Context;
    if-nez v1, :cond_1

    const-string v9, "fails to getContext"

    invoke-virtual {p0, v9}, Lcom/lge/uicc/framework/IccHandlerLGU;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "StartOTA - "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/lge/uicc/framework/IccHandlerLGU;->logd(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .end local v0    # "LGTota":Landroid/content/Intent;
    .end local v1    # "c":Landroid/content/Context;
    .end local v3    # "className":Ljava/lang/String;
    .end local v7    # "packageName":Ljava/lang/String;
    :cond_2
    const-string v9, "card_provisioned"

    invoke-static {v9, p0}, Lcom/lge/uicc/framework/LGUICC;->unregisterForConfig(Ljava/lang/String;Landroid/os/Handler;)V

    const-string v9, "card_operator"

    invoke-static {v9, p0}, Lcom/lge/uicc/framework/LGUICC;->unregisterForConfig(Ljava/lang/String;Landroid/os/Handler;)V

    goto :goto_0

    .end local v2    # "card_operator":Ljava/lang/String;
    .end local v8    # "provisioned":Ljava/lang/String;
    :pswitch_1
    const-string v9, "iccid"

    invoke-static {v9}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .local v5, "iccid":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-nez v9, :cond_4

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    if-le v9, v11, :cond_4

    const/4 v9, 0x0

    invoke-virtual {v5, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .local v4, "head":Ljava/lang/String;
    invoke-virtual {v5, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    .local v6, "issuer":Ljava/lang/String;
    const-string v9, "898206"

    invoke-virtual {v4, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    const-string v9, "851109"

    invoke-virtual {v6, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_3

    const-string v9, "751108"

    invoke-virtual {v6, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    :cond_3
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "!!DO NOT USE THIS USIM CARD!! This is not for official test : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/lge/uicc/framework/IccHandlerLGU;->loge(Ljava/lang/String;)V

    .end local v4    # "head":Ljava/lang/String;
    .end local v6    # "issuer":Ljava/lang/String;
    :cond_4
    const-string v9, "iccid"

    invoke-static {v9, p0}, Lcom/lge/uicc/framework/LGUICC;->unregisterForConfig(Ljava/lang/String;Landroid/os/Handler;)V

    goto/16 :goto_0

    .end local v5    # "iccid":Ljava/lang/String;
    :pswitch_2
    const-string v9, "proxy.sim_state"

    invoke-static {v9}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "READY"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_0

    const-string v9, "start loading records..."

    invoke-virtual {p0, v9}, Lcom/lge/uicc/framework/IccHandlerLGU;->logd(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/uicc/framework/IccHandlerLGU;->fetchRecords()V

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method protected onRecordLoaded()V
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    iget v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    if-gez v0, :cond_0

    const-string v0, "recordsToLoad < 0, programmer error suspected"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerLGU;->loge(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/uicc/framework/IccHandlerLGU;->recordsToLoad:I

    :cond_0
    return-void
.end method
