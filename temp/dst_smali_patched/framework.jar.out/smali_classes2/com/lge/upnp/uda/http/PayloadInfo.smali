.class public Lcom/lge/upnp/uda/http/PayloadInfo;
.super Ljava/lang/Object;
.source "PayloadInfo.java"


# instance fields
.field public mBuffer:[B

.field public mIsCompleted:Z

.field public mStartPos:J

.field public mTotalLength:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const-wide/16 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide v0, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mStartPos:J

    iput-wide v0, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mTotalLength:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mIsCompleted:Z

    return-void
.end method

.method public constructor <init>([BJJZ)V
    .locals 0
    .param p1, "buffer"    # [B
    .param p2, "totalLength"    # J
    .param p4, "startPos"    # J
    .param p6, "isCompleted"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mBuffer:[B

    iput-wide p2, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mTotalLength:J

    iput-wide p4, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mStartPos:J

    iput-boolean p6, p0, Lcom/lge/upnp/uda/http/PayloadInfo;->mIsCompleted:Z

    return-void
.end method
