.class public Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;
.super Landroid/os/Handler;
.source "DefaultCommandHandler.java"


# direct methods
.method protected constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "commander"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;
    .locals 1
    .param p0, "commander"    # Landroid/content/Context;

    .prologue
    new-instance v0, Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;

    invoke-direct {v0, p0}, Lcom/lge/internal/hardware/fmradio/DefaultCommandHandler;-><init>(Landroid/content/Context;)V

    return-object v0
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 0
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    return-void
.end method

.method public isMock()Z
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method
