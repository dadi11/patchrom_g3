.class Lcom/lge/upnp/uda/http/HttpResponse;
.super Lcom/lge/upnp/uda/http/IHttpResponse;
.source "HttpResponse.java"


# instance fields
.field m_ObjId:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/http/IHttpResponse;-><init>()V

    return-void
.end method

.method public constructor <init>(J)V
    .locals 1
    .param p1, "ObjId"    # J

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/http/IHttpResponse;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    return-void
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "httpHeader"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1, p2}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->AddHeader(JLjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public getAllHeaders()[Lcom/lge/upnp/uda/http/IHttpHeader;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetAllHeaders(J)[Lcom/lge/upnp/uda/http/IHttpHeader;

    move-result-object v0

    return-object v0
.end method

.method public getContent()[B
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetContent(J)[B

    move-result-object v0

    return-object v0
.end method

.method public getContentFilePath()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetContentFilePath(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getContentLength()J
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetContentLength(J)J

    move-result-wide v0

    return-wide v0
.end method

.method public getHeaderValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "httpHeader"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetHeaderValue(JLjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getQos()I
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetQos(J)I

    move-result v0

    return v0
.end method

.method public getReasonPhrase()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetReasonPhrase(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getResponseStatus()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->GetResponseStatus(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public removeHeader(Ljava/lang/String;)V
    .locals 2
    .param p1, "httpHeader"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->RemoveHeader(JLjava/lang/String;)V

    return-void
.end method

.method public setContent(Ljava/lang/String;)V
    .locals 4
    .param p1, "content"    # Ljava/lang/String;

    .prologue
    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .local v0, "contentBuffer":[B
    if-eqz v0, :cond_0

    iget-wide v2, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v2, v3, v0}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContent(J[B)V

    goto :goto_0
.end method

.method public setContent([B)V
    .locals 2
    .param p1, "contentBuffer"    # [B

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContent(J[B)V

    return-void
.end method

.method public setContentFilePath(Ljava/lang/String;)V
    .locals 2
    .param p1, "filePath"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContentFilePath(JLjava/lang/String;)V

    return-void
.end method

.method public setContentLength(J)Z
    .locals 3
    .param p1, "length"    # J

    .prologue
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-ltz v0, :cond_0

    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1, p2}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContentLength(JJ)V

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setContentType(Ljava/lang/String;)V
    .locals 2
    .param p1, "contentType"    # Ljava/lang/String;

    .prologue
    if-nez p1, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContentType(JLjava/lang/String;)V

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
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->setHttpPayloadListner(JLcom/lge/upnp/uda/http/IHttpPayloadListener;)V

    goto :goto_0
.end method

.method public setPartialContent(Ljava/lang/String;J)V
    .locals 4
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "length"    # J

    .prologue
    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .local v0, "contentBuffer":[B
    if-eqz v0, :cond_0

    iget-wide v2, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v2, v3, v0}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContent(J[B)V

    iget-wide v2, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v2, v3, p2, p3}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContentLength(JJ)V

    goto :goto_0
.end method

.method public setPartialContent([BJ)V
    .locals 2
    .param p1, "contentBuffer"    # [B
    .param p2, "length"    # J

    .prologue
    if-eqz p1, :cond_0

    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContent(J[B)V

    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p2, p3}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetContentLength(JJ)V

    :cond_0
    return-void
.end method

.method public setQos(I)V
    .locals 2
    .param p1, "qos"    # I

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetQos(JI)V

    return-void
.end method

.method public setResponseCode(Lcom/lge/upnp/uda/http/IHttpResponse$HTTP_RESPONSES;)V
    .locals 3
    .param p1, "response"    # Lcom/lge/upnp/uda/http/IHttpResponse$HTTP_RESPONSES;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/http/HttpResponse;->m_ObjId:J

    invoke-virtual {p1}, Lcom/lge/upnp/uda/http/IHttpResponse$HTTP_RESPONSES;->GetVal()I

    move-result v2

    invoke-static {v0, v1, v2}, Lcom/lge/upnp/uda/http/JNIHttpResponse;->SetResponseCode(JI)V

    return-void
.end method
