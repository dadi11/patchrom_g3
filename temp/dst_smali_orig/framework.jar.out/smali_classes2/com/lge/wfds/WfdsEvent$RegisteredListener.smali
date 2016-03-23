.class Lcom/lge/wfds/WfdsEvent$RegisteredListener;
.super Ljava/lang/Object;
.source "WfdsEvent.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsEvent;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "RegisteredListener"
.end annotation


# instance fields
.field eventListener:Lcom/lge/wfds/IWfdsEventListener;

.field eventListenerBinder:Landroid/os/IBinder;

.field listenerId:I

.field final synthetic this$0:Lcom/lge/wfds/WfdsEvent;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsEvent;Lcom/lge/wfds/IWfdsEventListener;)V
    .locals 1
    .param p2, "listener"    # Lcom/lge/wfds/IWfdsEventListener;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsEvent$RegisteredListener;->this$0:Lcom/lge/wfds/WfdsEvent;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/WfdsEvent$RegisteredListener;->listenerId:I

    iput-object p2, p0, Lcom/lge/wfds/WfdsEvent$RegisteredListener;->eventListener:Lcom/lge/wfds/IWfdsEventListener;

    invoke-interface {p2}, Lcom/lge/wfds/IWfdsEventListener;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wfds/WfdsEvent$RegisteredListener;->eventListenerBinder:Landroid/os/IBinder;

    return-void
.end method


# virtual methods
.method setlistenerId(I)V
    .locals 0
    .param p1, "id"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsEvent$RegisteredListener;->listenerId:I

    return-void
.end method
