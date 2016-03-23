.class public Lcom/lge/hardware/FmRadioInterface;
.super Landroid/os/Handler;
.source "FmRadioInterface.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/hardware/FmRadioInterface$5;
    }
.end annotation


# static fields
.field private static final T:Ljava/lang/String; = "FMFRW_FmRadioInterface"

.field private static essentialObservers:Ljava/util/Collection;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Collection",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field chipsetHandler:Landroid/os/Handler;

.field currentFrequency:I

.field dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

.field dispatcher:Landroid/os/Messenger;

.field initialized:Z

.field isMockChipset:Z

.field isRDSOn:Z

.field isScanning:Z

.field mContext:Landroid/content/Context;

.field private mPreOperationListener:Lcom/lge/internal/hardware/fmradio/FMRadioCommand$OnPreExecuteListener;

.field private mPreOperationListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Lcom/lge/internal/hardware/fmradio/FMRadioCommand$OnPreExecuteListener;",
            ">;"
        }
    .end annotation
.end field

.field on:Z

.field paused:Z

.field private rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

.field statusMessenger:Landroid/os/Messenger;

.field switching:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/hardware/FmRadioInterface$4;

    invoke-direct {v0}, Lcom/lge/hardware/FmRadioInterface$4;-><init>()V

    sput-object v0, Lcom/lge/hardware/FmRadioInterface;->essentialObservers:Ljava/util/Collection;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "con"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->mContext:Landroid/content/Context;

    iput-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    iput-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    iput-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->dispatcher:Landroid/os/Messenger;

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->initialized:Z

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->on:Z

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->switching:Z

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->paused:Z

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isScanning:Z

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isMockChipset:Z

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isRDSOn:Z

    iput v0, p0, Lcom/lge/hardware/FmRadioInterface;->currentFrequency:I

    new-instance v0, Lcom/lge/hardware/FmRadioInterface$1;

    invoke-direct {v0, p0}, Lcom/lge/hardware/FmRadioInterface$1;-><init>(Lcom/lge/hardware/FmRadioInterface;)V

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

    new-instance v0, Landroid/os/Messenger;

    new-instance v1, Lcom/lge/hardware/FmRadioInterface$2;

    invoke-direct {v1, p0}, Lcom/lge/hardware/FmRadioInterface$2;-><init>(Lcom/lge/hardware/FmRadioInterface;)V

    invoke-direct {v0, v1}, Landroid/os/Messenger;-><init>(Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->statusMessenger:Landroid/os/Messenger;

    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mPreOperationListeners:Ljava/util/Set;

    new-instance v0, Lcom/lge/hardware/FmRadioInterface$3;

    invoke-direct {v0, p0}, Lcom/lge/hardware/FmRadioInterface$3;-><init>(Lcom/lge/hardware/FmRadioInterface;)V

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mPreOperationListener:Lcom/lge/internal/hardware/fmradio/FMRadioCommand$OnPreExecuteListener;

    iput-object p1, p0, Lcom/lge/hardware/FmRadioInterface;->mContext:Landroid/content/Context;

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/lge/internal/hardware/fmradio/ChipsetHandlerFactory;->createChipsetHandler(Landroid/content/Context;)Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    new-instance v0, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    const-string v1, "FmRadioInterfaceResult"

    invoke-direct {v0, v1}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    new-instance v0, Landroid/os/Messenger;

    iget-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-direct {v0, v1}, Landroid/os/Messenger;-><init>(Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatcher:Landroid/os/Messenger;

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    check-cast v0, Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;

    invoke-virtual {v0}, Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;->isMock()Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isMockChipset:Z

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->statusMessenger:Landroid/os/Messenger;

    invoke-virtual {v0, v1, v2}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;->addObserver(Ljava/lang/String;Landroid/os/Messenger;)V

    return-void
.end method

.method static synthetic access$000(Lcom/lge/hardware/FmRadioInterface;)Lcom/lge/internal/hardware/fmradio/RdsData;
    .locals 1
    .param p0, "x0"    # Lcom/lge/hardware/FmRadioInterface;

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/hardware/FmRadioInterface;)Ljava/util/Set;
    .locals 1
    .param p0, "x0"    # Lcom/lge/hardware/FmRadioInterface;

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mPreOperationListeners:Ljava/util/Set;

    return-object v0
.end method

.method private isServing()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    new-instance v0, Ljava/util/HashSet;

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-virtual {v2}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;->getObserverNames()Ljava/util/Collection;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .local v0, "set":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    sget-object v2, Lcom/lge/hardware/FmRadioInterface;->essentialObservers:Ljava/util/Collection;

    invoke-interface {v0, v2}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v2

    if-lez v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0
.end method

.method private sendToChipset(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    sget-object v0, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    iget v1, p1, Landroid/os/Message;->what:I

    invoke-static {v1}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->getFMRadioCommand(I)Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    move-result-object v1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

    :goto_0
    iput-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatcher:Landroid/os/Messenger;

    iput-object v0, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mPreOperationListener:Lcom/lge/internal/hardware/fmradio/FMRadioCommand$OnPreExecuteListener;

    goto :goto_0
.end method


# virtual methods
.method public addObserver(Ljava/lang/String;Landroid/os/Messenger;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "observer"    # Landroid/os/Messenger;

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-virtual {v0, p1, p2}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;->addObserver(Ljava/lang/String;Landroid/os/Messenger;)V

    return-void
.end method

.method public addPreExecuteListener(Ljava/lang/Object;)V
    .locals 2
    .param p1, "listener"    # Ljava/lang/Object;

    .prologue
    const-class v1, Lcom/lge/hardware/FmRadioInterface;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mPreOperationListeners:Ljava/util/Set;

    check-cast p1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand$OnPreExecuteListener;

    .end local p1    # "listener":Ljava/lang/Object;
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public currentFrequency()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/hardware/FmRadioInterface;->currentFrequency:I

    return v0
.end method

.method public currentProgramService()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

    invoke-virtual {v0}, Lcom/lge/internal/hardware/fmradio/RdsData;->getProgramService()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public currentProgramType()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

    invoke-virtual {v0}, Lcom/lge/internal/hardware/fmradio/RdsData;->getProgramType()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public currentRadioText()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->rdsListener:Lcom/lge/internal/hardware/fmradio/RdsData;

    invoke-virtual {v0}, Lcom/lge/internal/hardware/fmradio/RdsData;->getRadioText()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getServingList()Ljava/util/Set;
    .locals 2

    .prologue
    iget-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    if-nez v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/util/HashSet;

    iget-object v1, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-virtual {v1}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;->getObserverNames()Ljava/util/Collection;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .local v0, "set":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    sget-object v1, Lcom/lge/hardware/FmRadioInterface;->essentialObservers:Ljava/util/Collection;

    invoke-interface {v0, v1}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v5, 0x1

    const-string v2, "FMFRW_FmRadioInterface"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "FmRadio received "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p1}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->toStringFromMessage(Landroid/os/Message;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-static {v2}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->getFMRadioCommand(I)Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    move-result-object v1

    .local v1, "cmd":Lcom/lge/internal/hardware/fmradio/FMRadioCommand;
    sget-object v2, Lcom/lge/hardware/FmRadioInterface$5;->$SwitchMap$com$lge$internal$hardware$fmradio$FMRadioCommand:[I

    invoke-virtual {v1}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    :cond_0
    :goto_0
    invoke-static {p1}, Landroid/os/Message;->obtain(Landroid/os/Message;)Landroid/os/Message;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/lge/hardware/FmRadioInterface;->sendToChipset(Landroid/os/Message;)V

    return-void

    :pswitch_0
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v2

    const-string v3, "cause"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "cause":Ljava/lang/String;
    iget-boolean v2, p0, Lcom/lge/hardware/FmRadioInterface;->initialized:Z

    if-eqz v2, :cond_1

    if-eqz v0, :cond_0

    const-string v2, "restore_service"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    :cond_1
    iput-boolean v5, p0, Lcom/lge/hardware/FmRadioInterface;->initialized:Z

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    sget-object v3, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-virtual {v3}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->ordinal()I

    move-result v3

    invoke-static {v2, v3}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/lge/hardware/FmRadioInterface;->sendToChipset(Landroid/os/Message;)V

    goto :goto_0

    .end local v0    # "cause":Ljava/lang/String;
    :pswitch_1
    iput-boolean v5, p0, Lcom/lge/hardware/FmRadioInterface;->paused:Z

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    sget-object v3, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE_ANNOUNCED:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-virtual {v3}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->ordinal()I

    move-result v3

    invoke-static {v2, v3}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/lge/hardware/FmRadioInterface;->sendToObservers(Landroid/os/Message;)V

    goto :goto_0

    :pswitch_2
    iget-boolean v2, p0, Lcom/lge/hardware/FmRadioInterface;->initialized:Z

    if-nez v2, :cond_2

    iput-boolean v5, p0, Lcom/lge/hardware/FmRadioInterface;->initialized:Z

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    sget-object v3, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-virtual {v3}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->ordinal()I

    move-result v3

    invoke-static {v2, v3}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/lge/hardware/FmRadioInterface;->sendToChipset(Landroid/os/Message;)V

    :cond_2
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/lge/hardware/FmRadioInterface;->paused:Z

    iget-object v2, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    sget-object v3, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME_ANNOUNCED:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-virtual {v3}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->ordinal()I

    move-result v3

    invoke-static {v2, v3}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/lge/hardware/FmRadioInterface;->sendToObservers(Landroid/os/Message;)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public isInitialized()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->initialized:Z

    return v0
.end method

.method public isMock()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isMockChipset:Z

    return v0
.end method

.method public isOn()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->on:Z

    return v0
.end method

.method public isPause()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->paused:Z

    return v0
.end method

.method public isRDSOn()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isRDSOn:Z

    return v0
.end method

.method public isScanning()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isScanning:Z

    return v0
.end method

.method public isSwitching()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->switching:Z

    return v0
.end method

.method public removeObserver(Landroid/os/Messenger;)V
    .locals 1
    .param p1, "observer"    # Landroid/os/Messenger;

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-virtual {v0, p1}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;->removeObserver(Landroid/os/Messenger;)V

    invoke-virtual {p0}, Lcom/lge/hardware/FmRadioInterface;->terminateIfConditionMet()V

    return-void
.end method

.method public removePreExecuteListener(Ljava/lang/Object;)V
    .locals 2
    .param p1, "listener"    # Ljava/lang/Object;

    .prologue
    const-class v1, Lcom/lge/hardware/FmRadioInterface;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->mPreOperationListeners:Ljava/util/Set;

    check-cast p1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand$OnPreExecuteListener;

    .end local p1    # "listener":Ljava/lang/Object;
    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public sendToObservers(Landroid/os/Message;)V
    .locals 1
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->dispatchHandler:Lcom/lge/internal/hardware/fmradio/MultiDispatcher;

    invoke-virtual {v0, p1}, Lcom/lge/internal/hardware/fmradio/MultiDispatcher;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public setCurrentFrequency(I)V
    .locals 0
    .param p1, "currentFrequency"    # I

    .prologue
    iput p1, p0, Lcom/lge/hardware/FmRadioInterface;->currentFrequency:I

    return-void
.end method

.method public setScanning()V
    .locals 1

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->isScanning:Z

    return-void
.end method

.method public terminateIfConditionMet()V
    .locals 2

    .prologue
    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->on:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/lge/hardware/FmRadioInterface;->isSwitching()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/lge/hardware/FmRadioInterface;->isServing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/hardware/FmRadioInterface;->paused:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/hardware/FmRadioInterface;->chipsetHandler:Landroid/os/Handler;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-virtual {v1}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->ordinal()I

    move-result v1

    invoke-static {v0, v1}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/lge/hardware/FmRadioInterface;->sendToChipset(Landroid/os/Message;)V

    :cond_0
    return-void
.end method
