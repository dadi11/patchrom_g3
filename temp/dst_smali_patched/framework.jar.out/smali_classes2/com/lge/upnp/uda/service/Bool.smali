.class public Lcom/lge/upnp/uda/service/Bool;
.super Ljava/lang/Object;
.source "Bool.java"


# instance fields
.field private mBool:Z


# direct methods
.method public constructor <init>(Z)V
    .locals 0
    .param p1, "bool"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Lcom/lge/upnp/uda/service/Bool;->mBool:Z

    return-void
.end method


# virtual methods
.method public getBoolValue()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/upnp/uda/service/Bool;->mBool:Z

    return v0
.end method

.method public setBoolValue(Z)V
    .locals 0
    .param p1, "bool"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/upnp/uda/service/Bool;->mBool:Z

    return-void
.end method
