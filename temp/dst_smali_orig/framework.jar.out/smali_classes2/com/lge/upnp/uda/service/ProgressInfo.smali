.class public Lcom/lge/upnp/uda/service/ProgressInfo;
.super Ljava/lang/Object;
.source "ProgressInfo.java"


# instance fields
.field public mIsCompleted:Z

.field public mTotalLength:J

.field public mTotalReceivedBytes:J

.field public mTotalSentBytes:J

.field public mUrl:Ljava/lang/String;

.field public merror:Lcom/lge/upnp/uda/service/EError;


# direct methods
.method public constructor <init>(JJZLcom/lge/upnp/uda/service/EError;JLjava/lang/String;)V
    .locals 1
    .param p1, "totalLength"    # J
    .param p3, "totalSentBytes"    # J
    .param p5, "isCompleted"    # Z
    .param p6, "error"    # Lcom/lge/upnp/uda/service/EError;
    .param p7, "totalReceivedBytes"    # J
    .param p9, "url"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/service/ProgressInfo;->mTotalLength:J

    iput-wide p3, p0, Lcom/lge/upnp/uda/service/ProgressInfo;->mTotalSentBytes:J

    iput-boolean p5, p0, Lcom/lge/upnp/uda/service/ProgressInfo;->mIsCompleted:Z

    iput-object p6, p0, Lcom/lge/upnp/uda/service/ProgressInfo;->merror:Lcom/lge/upnp/uda/service/EError;

    iput-wide p7, p0, Lcom/lge/upnp/uda/service/ProgressInfo;->mTotalReceivedBytes:J

    iput-object p9, p0, Lcom/lge/upnp/uda/service/ProgressInfo;->mUrl:Ljava/lang/String;

    return-void
.end method
