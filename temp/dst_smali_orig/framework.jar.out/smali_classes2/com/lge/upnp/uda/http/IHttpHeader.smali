.class public abstract Lcom/lge/upnp/uda/http/IHttpHeader;
.super Ljava/lang/Object;
.source "IHttpHeader.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract getHeader()Ljava/lang/String;
.end method

.method public abstract getValue()Ljava/lang/String;
.end method

.method public abstract setHeader(Ljava/lang/String;)V
.end method

.method public abstract setValue(Ljava/lang/String;)V
.end method
