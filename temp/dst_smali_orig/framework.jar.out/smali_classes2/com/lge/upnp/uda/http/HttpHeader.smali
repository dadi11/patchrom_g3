.class public Lcom/lge/upnp/uda/http/HttpHeader;
.super Lcom/lge/upnp/uda/http/IHttpHeader;
.source "HttpHeader.java"


# instance fields
.field public m_header:Ljava/lang/String;

.field public m_value:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "header"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/http/IHttpHeader;-><init>()V

    iput-object p1, p0, Lcom/lge/upnp/uda/http/HttpHeader;->m_header:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/upnp/uda/http/HttpHeader;->m_value:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getHeader()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/http/HttpHeader;->m_header:Ljava/lang/String;

    return-object v0
.end method

.method public getValue()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/http/HttpHeader;->m_value:Ljava/lang/String;

    return-object v0
.end method

.method public setHeader(Ljava/lang/String;)V
    .locals 0
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/upnp/uda/http/HttpHeader;->m_header:Ljava/lang/String;

    return-void
.end method

.method public setValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/upnp/uda/http/HttpHeader;->m_value:Ljava/lang/String;

    return-void
.end method
