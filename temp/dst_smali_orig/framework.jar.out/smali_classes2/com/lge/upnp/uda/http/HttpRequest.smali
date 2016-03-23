.class public Lcom/lge/upnp/uda/http/HttpRequest;
.super Lcom/lge/upnp/uda/http/IHttpRequest;
.source "HttpRequest.java"


# instance fields
.field private mInstantiated:Z

.field private m_ObjId:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/http/IHttpRequest;-><init>()V

    invoke-static {}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->createNativeInstance()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->mInstantiated:Z

    return-void
.end method

.method public constructor <init>(J)V
    .locals 1
    .param p1, "ObjId"    # J

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/http/IHttpRequest;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->mInstantiated:Z

    return-void
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "i"    # Ljava/lang/String;
    .param p2, "val"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1, p1, p2}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->AddHeader(JLjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public destroy()V
    .locals 2

    .prologue
    iget-boolean v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->mInstantiated:Z

    if-eqz v0, :cond_0

    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->destroy(J)V

    :cond_0
    return-void
.end method

.method public getAllHeaders()[Lcom/lge/upnp/uda/http/IHttpHeader;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetAllHeaders(J)[Lcom/lge/upnp/uda/http/IHttpHeader;

    move-result-object v0

    return-object v0
.end method

.method public getContent()[B
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetContent(J)[B

    move-result-object v0

    return-object v0
.end method

.method public getContentLength()J
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetContentLength(J)J

    move-result-wide v0

    return-wide v0
.end method

.method public getHeaderValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "HttpHeader"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetHeaderValue(JLjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getHttpVersion()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetHttpVersion(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getObjectId()J
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    return-wide v0
.end method

.method public getRequestMethod()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetRequestMethod(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getRequestURI()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->GetRequestURI(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setContent(Ljava/lang/String;)V
    .locals 4
    .param p1, "conent"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .local v0, "contentBuffer":[B
    if-eqz v0, :cond_0

    iget-wide v2, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v2, v3, v0}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->SetContent(J[B)V

    :cond_0
    return-void
.end method

.method public setContent([B)V
    .locals 2
    .param p1, "contentBuffer"    # [B

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->SetContent(J[B)V

    return-void
.end method

.method public setContentLength(J)Z
    .locals 3
    .param p1, "length"    # J

    .prologue
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-ltz v0, :cond_0

    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1, p1, p2}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->SetContentLength(JJ)V

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setHttpPayloadListner(Lcom/lge/upnp/uda/http/IHttpPayloadListener;)V
    .locals 2
    .param p1, "payloadlistner"    # Lcom/lge/upnp/uda/http/IHttpPayloadListener;

    .prologue
    if-nez p1, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->setHttpPayloadListner(JLcom/lge/upnp/uda/http/IHttpPayloadListener;)V

    goto :goto_0
.end method

.method public setRequestMethod(Lcom/lge/upnp/uda/http/IHttpRequest$HTTP_REQUEST_METHODS;)V
    .locals 3
    .param p1, "req"    # Lcom/lge/upnp/uda/http/IHttpRequest$HTTP_REQUEST_METHODS;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-virtual {p1}, Lcom/lge/upnp/uda/http/IHttpRequest$HTTP_REQUEST_METHODS;->getVal()I

    move-result v2

    invoke-static {v0, v1, v2}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->SetRequestMethod(JI)V

    return-void
.end method

.method public setRequestURI(Ljava/lang/String;)V
    .locals 2
    .param p1, "requestUri"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpRequest;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpRequest;->SetRequestURI(JLjava/lang/String;)V

    return-void
.end method
