.class public Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;
.super Ljava/lang/Object;
.source "LgDcTrackerMsg.java"


# instance fields
.field private final DBG:Z

.field private final LOG_TAG:Ljava/lang/String;

.field public apntype_n:I

.field public cause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

.field public enable:I

.field public reason:Ljava/lang/String;

.field public success:Z

.field public tag:I

.field public type:Ljava/lang/String;

.field public valid:Z

.field public what:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->DBG:Z

    const-string v0, "LGDataconenctionTrackerMsg"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->LOG_TAG:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->success:Z

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->enable:I

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->tag:I

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->apntype_n:I

    const-string v0, ""

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->type:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->reason:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->valid:Z

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->what:I

    return-void
.end method
