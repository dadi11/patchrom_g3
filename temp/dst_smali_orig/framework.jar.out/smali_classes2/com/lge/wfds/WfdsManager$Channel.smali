.class public Lcom/lge/wfds/WfdsManager$Channel;
.super Ljava/lang/Object;
.source "WfdsManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Channel"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;
    }
.end annotation


# static fields
.field private static final INVALID_LISTENER_KEY:I


# instance fields
.field mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

.field mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

.field private mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

.field mContext:Landroid/content/Context;

.field private mEventListenerId:I

.field private mHandler:Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;

.field private mListenerKey:I

.field private mListenerMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private mListenerMapLock:Ljava/lang/Object;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/os/Looper;Lcom/lge/wfds/WfdsManager$WfdsChannelListener;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "looper"    # Landroid/os/Looper;
    .param p3, "l"    # Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerKey:I

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerMapLock:Ljava/lang/Object;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerMap:Ljava/util/HashMap;

    new-instance v0, Lcom/android/internal/util/AsyncChannel;

    invoke-direct {v0}, Lcom/android/internal/util/AsyncChannel;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannel:Lcom/android/internal/util/AsyncChannel;

    new-instance v0, Lcom/android/internal/util/AsyncChannel;

    invoke-direct {v0}, Lcom/android/internal/util/AsyncChannel;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mAsyncChannelSession:Lcom/android/internal/util/AsyncChannel;

    new-instance v0, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;

    invoke-direct {v0, p0, p2}, Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;-><init>(Lcom/lge/wfds/WfdsManager$Channel;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mHandler:Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;

    iput-object p3, p0, Lcom/lge/wfds/WfdsManager$Channel;->mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    iput-object p1, p0, Lcom/lge/wfds/WfdsManager$Channel;->mContext:Landroid/content/Context;

    return-void
.end method

.method static synthetic access$200(Lcom/lge/wfds/WfdsManager$Channel;I)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsManager$Channel;->getListener(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/wfds/WfdsManager$Channel;)Lcom/lge/wfds/WfdsManager$WfdsChannelListener;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsManager$Channel;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    return-object v0
.end method

.method static synthetic access$302(Lcom/lge/wfds/WfdsManager$Channel;Lcom/lge/wfds/WfdsManager$WfdsChannelListener;)Lcom/lge/wfds/WfdsManager$WfdsChannelListener;
    .locals 0
    .param p0, "x0"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p1, "x1"    # Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsManager$Channel;->mChannelListener:Lcom/lge/wfds/WfdsManager$WfdsChannelListener;

    return-object p1
.end method

.method static synthetic access$400(Lcom/lge/wfds/WfdsManager$Channel;)Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsManager$Channel;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mHandler:Lcom/lge/wfds/WfdsManager$Channel$WfdsHandler;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/wfds/WfdsManager$Channel;Ljava/lang/Object;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsManager$Channel;
    .param p1, "x1"    # Ljava/lang/Object;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsManager$Channel;->putListener(Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method private getListener(I)Ljava/lang/Object;
    .locals 3
    .param p1, "key"    # I

    .prologue
    if-nez p1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerMapLock:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private putListener(Ljava/lang/Object;)I
    .locals 4
    .param p1, "listener"    # Ljava/lang/Object;

    .prologue
    if-nez p1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v2, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerMapLock:Ljava/lang/Object;

    monitor-enter v2

    :cond_1
    :try_start_0
    iget v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerKey:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerKey:I

    .local v0, "key":I
    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/lge/wfds/WfdsManager$Channel;->mListenerMap:Ljava/util/HashMap;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    monitor-exit v2

    goto :goto_0

    .end local v0    # "key":I
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method


# virtual methods
.method public getEventListenerId()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wfds/WfdsManager$Channel;->mEventListenerId:I

    return v0
.end method

.method public setEventListenerId(I)V
    .locals 0
    .param p1, "id"    # I

    .prologue
    iput p1, p0, Lcom/lge/wfds/WfdsManager$Channel;->mEventListenerId:I

    return-void
.end method
