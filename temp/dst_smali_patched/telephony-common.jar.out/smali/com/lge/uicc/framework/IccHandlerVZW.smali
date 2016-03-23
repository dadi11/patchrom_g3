.class public Lcom/lge/uicc/framework/IccHandlerVZW;
.super Lcom/lge/uicc/framework/IccHandler;
.source "IccHandlerVZW.java"


# static fields
.field private static final EVENT_HPLMNWACT_LOADED:I = 0x2

.field private static final EVENT_IMSI_M_LOADED:I = 0x1

.field private static mInstance:Lcom/lge/uicc/framework/IccHandlerVZW;


# direct methods
.method private constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/uicc/framework/IccHandler;-><init>()V

    const-string v0, "imsi_m"

    const/4 v1, 0x1

    invoke-static {v0, p0, v1, v2}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "hplmnwact"

    const/4 v1, 0x2

    invoke-static {v0, p0, v1, v2}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    return-void
.end method

.method protected static setup()V
    .locals 3

    .prologue
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "VZW"

    aput-object v2, v0, v1

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget-object v0, Lcom/lge/uicc/framework/IccHandlerVZW;->mInstance:Lcom/lge/uicc/framework/IccHandlerVZW;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/IccHandlerVZW;

    invoke-direct {v0}, Lcom/lge/uicc/framework/IccHandlerVZW;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IccHandlerVZW;->mInstance:Lcom/lge/uicc/framework/IccHandlerVZW;

    goto :goto_0
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v1, 0x0

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    invoke-super {p0, p1}, Lcom/lge/uicc/framework/IccHandler;->handleMessage(Landroid/os/Message;)V

    :goto_0
    return-void

    :pswitch_0
    const-string v0, "EVENT_IMSI_M_LOADED"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerVZW;->logd(Ljava/lang/String;)V

    const-string v0, "imsi_m"

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Error: imsi_m is not valid"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerVZW;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v0, "IMSI_M"

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/IccTools;->broadcastIccStateChangedIntent(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :pswitch_1
    const-string v0, "EVENT_HPLMNWACT_LOADED"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerVZW;->logd(Ljava/lang/String;)V

    const-string v0, "hplmnwact"

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "Error: hplmnwact is not valid"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccHandlerVZW;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const-string v0, "HPLMN_SIMTYPE"

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/IccTools;->broadcastIccStateChangedIntent(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
